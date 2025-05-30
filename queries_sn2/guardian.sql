-- residual_check
-- guardian | guardian_child_relation
SELECT ch.birth_certificate, gu.*,gcr.* 
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.guardian_child_relation gcr ON gcr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.guardian gu ON gu.id = gcr.fk_guardian
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- guardian | guardian_child_relation
WITH retained AS (
  SELECT 
    ch.birth_certificate, 
    ch.id AS ch_id, 
    gu.id AS gu_id,
    gcr.id AS gcr_id, 
    gu.identification_no, 
    gu.created_by, 
    gu.updated_at
  FROM {ARCHIVED_SN2_DB}.child ch
  INNER JOIN {ARCHIVED_SN2_DB}.guardian_child_relation gcr 
      ON gcr.fk_child = ch.id
  INNER JOIN {ARCHIVED_SN2_DB}.guardian gu 
      ON gu.id = gcr.fk_guardian
  WHERE gu.active = 1 AND gcr.active = 1
)
SELECT 
  ROW_NUMBER() OVER (ORDER BY gcr_id) AS row_num, 
  retained.*
FROM retained
ORDER BY gcr_id ASC;


-- expected_count_for_retention
-- guardian | guardian_child_relation
WITH expected AS (
  SELECT ch.birth_certificate, ch.id AS ch_id, gu.id AS gu_id, gcr.id AS gcr_id, gu.identification_no, gu.created_by, gu.updated_at
  FROM {SOURCE_SN2_DB}.child ch
  INNER JOIN {SOURCE_SN2_DB}.guardian_child_relation gcr ON gcr.fk_child = ch.id
  INNER JOIN {SOURCE_SN2_DB}.guardian gu ON gu.id = gcr.fk_guardian
  WHERE gu.identification_no IN (
     SELECT gu2.identification_no
     FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
     INNER JOIN {SOURCE_SN2_DB}.guardian_child_relation gcr2 ON gcr2.fk_child = darch.fk_child
     INNER JOIN {SOURCE_SN2_DB}.guardian gu2 ON gu2.id = gcr2.fk_guardian
  )
  AND gcr.active = 1 AND gu.active = 1
  AND ch.birth_certificate NOT IN (
      SELECT darch.birth_certificate
      FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
      WHERE ch.birth_certificate = darch.birth_certificate
  )
  UNION
  SELECT ch.birth_certificate, ch.id AS ch_id, gu.id AS gu_id,gcr.id AS gcr_id, gu.identification_no, gu.created_by, gu.updated_at
  FROM {SOURCE_SN2_DB}.child ch
  INNER JOIN {SOURCE_SN2_DB}.guardian_child_relation gcr ON gcr.fk_child = ch.id
  INNER JOIN {SOURCE_SN2_DB}.guardian gu ON gu.id = gcr.fk_guardian
  WHERE gu.identification_no NOT IN (
     SELECT DISTINCT gu2.identification_no
     FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
     INNER JOIN {SOURCE_SN2_DB}.guardian_child_relation gcr2 ON gcr2.fk_child = darch.fk_child
     INNER JOIN {SOURCE_SN2_DB}.guardian gu2 ON gu2.id = gcr2.fk_guardian
     )
  AND gcr.active = 1 AND gu.active = 1
)
SELECT 
  ROW_NUMBER() OVER (ORDER BY gcr_id) AS row_num, 
  expected.*
FROM expected
ORDER BY gcr_id ASC;
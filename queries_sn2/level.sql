-- residual_check
-- level | child_level
SELECT ch.birth_certificate, le.*,cl.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_level cl ON ch.id = cl.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.level le ON le.id = cl.fk_level
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- level | child_level 
SELECT ch.birth_certificate, le.*,cl.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_level cl ON ch.id = cl.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.level le ON le.id = cl.fk_level;

-- expected_count_for_retention
-- level | child_level
SELECT ch.birth_certificate, le.*,cl.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_level cl ON ch.id = cl.fk_child
INNER JOIN {SOURCE_SN2_DB}.level le ON le.id = cl.fk_level
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
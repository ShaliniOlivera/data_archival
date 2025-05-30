-- residual_check 
-- class_activity | class_activity_access_scope | class_activity_image on fk_class
SELECT caas.fk_child, caas.fk_class, count(caas.fk_class)
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = caas.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ccla.fk_child
left JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image cai ON cai.fk_class_activity = ca.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
)
group by caas.fk_child, caas.fk_class;

-- retained_count
-- class_activity | class_activity_access_scope | class_activity_image on fk_class
WITH base_activity AS (
  SELECT ca.id AS activity_id,ca.title,ca.description,caas.fk_child,caas.fk_class
  FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca
  INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
),
child_info AS (
  SELECT ch.id AS child_id,ch.birth_certificate,ccla.fk_class
  FROM {ARCHIVED_SN2_DB}.child_class ccla
  INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ccla.fk_child
)
SELECT
count(*) 
FROM base_activity ba
JOIN child_info ci ON ba.fk_class = ci.fk_class AND ba.fk_child = ci.child_id
LEFT JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image cai ON cai.fk_class_activity = ba.activity_id;

-- expected_count_for_retention
-- class_activity | class_activity_access_scope | class_activity_image on fk_class
WITH base_activity AS (
  SELECT 
    ca.id AS activity_id, ca.title,ca.description,caas.fk_child,caas.fk_class
  FROM {SOURCE_MS_CLASSOPS_DB}.class_activity ca
  INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
),
child_info AS (
  SELECT 
    ch.id AS child_id,ch.birth_certificate,ccla.fk_class
  FROM {SOURCE_SN2_DB}.child_class ccla
  INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ccla.fk_child
),
archived_birth_certs AS (
  SELECT birth_certificate
  FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map
)
SELECT
count(*) 
FROM base_activity ba
JOIN child_info ci ON ba.fk_class = ci.fk_class AND ba.fk_child = ci.child_id
LEFT JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_image cai ON cai.fk_class_activity = ba.activity_id
WHERE ci.birth_certificate NOT IN (
  SELECT birth_certificate FROM archived_birth_certs
);

-- residual_check 
-- class_activity_migrated | class_activity_access_scope_migrated | class_activity_image_migrated on fk_class
SELECT ch.birth_certificate, ca.title, ca.description, caas.fk_child, caas.fk_class
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity_migrated ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope_migrated caas ON caas.fk_class_activity_migrated = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = caas.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ccla.fk_child
LEFT JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image_migrated cai ON cai.fk_class_activity_migrated = ca.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- class_activity_migrated | class_activity_access_scope_migrated | class_activity_image_migrated on fk_class
WITH base_activity AS (
  SELECT ca.id AS activity_id,ca.title,ca.description,caas.fk_child,caas.fk_class
  FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity_migrated ca
  INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope_migrated caas ON caas.fk_class_activity_migrated = ca.id
),
child_info AS (
  SELECT ch.id AS child_id,ch.birth_certificate,ccla.fk_class
  FROM {ARCHIVED_SN2_DB}.child_class ccla
  INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ccla.fk_child
)
SELECT 
  ci.birth_certificate,ba.title,ba.description,ba.fk_child,ba.fk_class,cai.id AS image_id,cai.url
FROM base_activity ba
JOIN child_info ci ON ba.fk_class = ci.fk_class AND ba.fk_child = ci.child_id
LEFT JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image_migrated cai ON cai.fk_class_activity_migrated = ba.activity_id;

-- expected_count_for_retention
-- class_activity_migrated | class_activity_access_scope_migrated | class_activity_image_migrated on fk_class
WITH base_activity AS (
  SELECT 
    ca.id AS activity_id, ca.title,ca.description,caas.fk_child,caas.fk_class
  FROM {SOURCE_MS_CLASSOPS_DB}.class_activity_migrated ca
  INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope_migrated caas ON caas.fk_class_activity_migrated = ca.id
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
  ci.birth_certificate,ba.title,ba.description,ba.fk_child,ba.fk_class,cai.id AS image_id,cai.url
FROM base_activity ba
JOIN child_info ci ON ba.fk_class = ci.fk_class AND ba.fk_child = ci.child_id
LEFT JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_image_migrated cai ON cai.fk_class_activity_migrated = ba.activity_id
WHERE ci.birth_certificate NOT IN (
  SELECT birth_certificate FROM archived_birth_certs
);

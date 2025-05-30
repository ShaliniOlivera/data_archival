-- residual_count
-- class_activity_migrated | class_activity_access_scope_migrated | class_activity_image_migrated on fk_child
SELECT ch.birth_certificate, ca.title, ca.description,caas.fk_child, caas.fk_class, caim.id, caim.url
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity_migrated ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope_migrated caas ON caas.fk_class_activity_migrated = ca.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image_migrated caim ON caim.fk_class_activity_migrated = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- class_activity_migrated | class_activity_access_scope_migrated | class_activity_image_migrated on fk_child
SELECT ch.id, ch.birth_certificate,ca.title, count(ch.birth_certificate)
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity_migrated ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope_migrated caas ON caas.fk_class_activity_migrated = ca.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image_migrated caim ON caim.fk_class_activity_migrated = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
GROUP BY ch.id, ch.birth_certificate,ca.title;

-- expected_count_for_retention
-- class_activity_migrated | class_activity_access_scope_migrated | class_activity_image_migrated on fk_child
SELECT ch.id, ch.birth_certificate,ca.title, count(ch.birth_certificate)
FROM {SOURCE_MS_CLASSOPS_DB}.class_activity_migrated ca 
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope_migrated caas ON caas.fk_class_activity_migrated = ca.id
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_image_migrated caim ON caim.fk_class_activity_migrated = ca.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = caas.fk_child
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate,ca.title;
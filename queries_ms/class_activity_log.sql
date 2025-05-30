-- residual_count
-- class_activity_log
SELECT ch.birth_certificate, ca.title, ca.description,caas.fk_child, caas.fk_class, cai.id AS cai_id, cai.updated_at AS cai_updated, cai.created_at AS ca_created
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_log cai ON cai.fk_class_activity = ca.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);


-- retained_count
-- class_activity_log
SELECT ca.id, caas.fk_child, count(caas.fk_child)
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_log cai ON cai.fk_class_activity = ca.id
GROUP BY ca.id, caas.fk_child;


-- expected_count_for_retention
-- class_activity_log
SELECT ca.id, caas.fk_child, count(caas.fk_child)
FROM {SOURCE_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = caas.fk_child
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_log cai ON cai.fk_class_activity = ca.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ca.id, caas.fk_child;
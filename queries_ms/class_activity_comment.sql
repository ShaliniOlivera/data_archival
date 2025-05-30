-- residual_count
-- class_activity_comment
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity_comment crm
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca ON ca.id = crm.fk_class_activity
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
WHERE caas.fk_child IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE caas.fk_child = darch.fk_child
);

-- retained_count
-- class_activity_comment
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity_comment crm
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca ON ca.id = crm.fk_class_activity
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id;

-- expected_count_for_retention
-- class_activity_comment
SELECT *
FROM {SOURCE_MS_CLASSOPS_DB}.class_activity_comment crm
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity ca ON ca.id = crm.fk_class_activity
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
WHERE caas.fk_child NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE caas.fk_child = darch.fk_child
);
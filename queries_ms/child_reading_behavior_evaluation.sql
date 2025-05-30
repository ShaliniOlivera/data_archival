-- residual_count
-- child_reading_behavior_evaluation
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.child_reading_behavior_evaluation crm
WHERE crm.fk_child IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE crm.fk_child = darch.fk_child
);

-- retained_count
-- child_reading_behavior_evaluation
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.child_reading_behavior_evaluation crm;

-- expected_count_for_retention
-- child_reading_behavior_evaluation
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.child_reading_behavior_evaluation crm
WHERE crm.fk_child NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE crm.fk_child = darch.fk_child
);
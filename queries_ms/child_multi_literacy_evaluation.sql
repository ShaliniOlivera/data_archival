-- residual_count
-- child_multi_literacy_evaluation
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.child_multi_literacy_evaluation crm
WHERE crm.fk_child IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE crm.fk_child = darch.fk_child
);

-- retained_count
-- child_multi_literacy_evaluation
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.child_multi_literacy_evaluation crm;

-- expected_count_for_retention
-- child_multi_literacy_evaluation
SELECT *
FROM {ARCHIVED_MS_CLASSOPS_DB}.child_multi_literacy_evaluation crm
WHERE crm.fk_child NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE crm.fk_child = darch.fk_child
);
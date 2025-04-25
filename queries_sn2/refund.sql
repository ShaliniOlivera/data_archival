-- residual_check
-- refund
SELECT * FROM {ARCHIVED_SN2_DB}.refund re
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = re.fk_child
WHERE ch.id IN (
SELECT dar.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map dar
);

-- retained_count
-- refund
SELECT * FROM {ARCHIVED_SN2_DB}.refund;

-- expected_count_for_retention
-- refund
SELECT * FROM {SOURCE_SN2_DB}.refund re
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = re.fk_child
WHERE ch.id NOT IN (
SELECT dar.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map dar
);
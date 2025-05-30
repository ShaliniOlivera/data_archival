-- residual_check
-- pim_audit_log
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_centre_category pim
WHERE pim.created_at <= "2022-12-31";

-- retained_count
-- pim_audit_log
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_centre_category pim;

-- expected_count_for_retention
-- pim_audit_log
SELECT * FROM {SOURCE_MS_PIM_DB}.pim_centre_category pim
WHERE pim.created_at >= "2022-12-31";
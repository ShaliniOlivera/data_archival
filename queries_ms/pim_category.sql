-- residual_check
-- pim_category
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_category pim
WHERE pim.created_at <= "2022-12-31";

-- retained_count
-- pim_category
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_category pim;

-- expected_count_for_retention
-- pim_category
SELECT * FROM {SOURCE_MS_PIM_DB}.pim_category pim
WHERE pim.created_at >= "2022-12-31";
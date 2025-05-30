-- residual_check
-- pim_centre_category_role
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_centre_category_role pim
WHERE pim.created_at <= "2022-12-31";

-- retained_count
-- pim_centre_category_role
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_centre_category_role pim;

-- expected_count_for_retention
-- pim_centre_category_role
SELECT * FROM {SOURCE_MS_PIM_DB}.pim_centre_category_role pim
WHERE pim.created_at >= "2022-12-31";
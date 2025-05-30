-- residual_check
-- pim_centre
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_centre pim
WHERE pim.created_at <= "2022-12-31";

-- retained_count
-- pim_centre
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_centre pim;

-- expected_count_for_retention
-- pim_centre
SELECT * FROM {SOURCE_MS_PIM_DB}.pim_centre pim
WHERE pim.created_at >= "2022-12-31";
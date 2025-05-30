-- residual_check
-- pim_enquiry
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_enquiry pim
WHERE pim.created_at <= "2022-12-31";

-- retained_count
-- pim_enquiry
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_enquiry pim;

-- expected_count_for_retention
-- pim_enquiry
SELECT * FROM {SOURCE_MS_PIM_DB}.pim_enquiry pim
WHERE pim.created_at >= "2022-12-31";
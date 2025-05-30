-- residual_check
-- pim_enquiry_sendbird
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_enquiry_sendbird pim
WHERE pim.created_at <= "2022-12-31";

-- retained_count
-- pim_enquiry_sendbird
SELECT * FROM {ARCHIVED_MS_PIM_DB}.pim_enquiry_sendbird pim;

-- expected_count_for_retention
-- pim_enquiry_sendbird
SELECT * FROM {SOURCE_MS_PIM_DB}.pim_enquiry_sendbird pim
WHERE pim.created_at >= "2022-12-31";
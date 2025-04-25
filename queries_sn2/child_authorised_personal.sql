-- residual_check
-- child_authorised_personal
SELECT * FROM {SOURCE_SN2_DB}.child_authorised_personal cap
WHERE cap.fk_child NOT IN (
SELECT cap2.fk_child FROM {ARCHIVED_SN2_DB}.child_authorised_personal cap2
);

-- retained_count
-- child_authorised_personal
SELECT * FROM {SOURCE_SN2_DB}.child_authorised_personal;

-- expected_count_for_retention
-- child_authorised_personal
SELECT * FROM {ARCHIVED_SN2_DB}.child_authorised_personal;
-- residual_check
-- leave
SELECT * FROM {SOURCE_SN2_DB}.leave 
WHERE id IN (
SELECT id FROM {ARCHIVED_SN2_DB}.leave);

-- retained_count
-- leave
SELECT * FROM {SOURCE_SN2_DB}.leave;

-- expected_count_for_retention
-- leave
SELECT * FROM {ARCHIVED_SN2_DB}.leave;
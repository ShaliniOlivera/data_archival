-- residual_check
-- leave_document
SELECT * FROM {SOURCE_SN2_DB}.leave_document 
WHERE id IN (
SELECT id FROM {ARCHIVED_SN2_DB}.leave_document);

-- retained_count
-- leave_document
SELECT * FROM {SOURCE_SN2_DB}.leave_document;

-- expected_count_for_retention
-- leave_document
SELECT * FROM {ARCHIVED_SN2_DB}.leave_document;
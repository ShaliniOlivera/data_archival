-- residual_check
-- leave_audit_log
SELECT * FROM {SOURCE_SN2_DB}.leave_audit_log 
WHERE id IN (
SELECT id FROM {ARCHIVED_SN2_DB}.leave_audit_log);

-- retained_count
-- leave_audit_log
SELECT * FROM {SOURCE_SN2_DB}.leave_audit_log;

-- expected_count_for_retention
-- leave_audit_log
SELECT * FROM {ARCHIVED_SN2_DB}.leave_audit_log;
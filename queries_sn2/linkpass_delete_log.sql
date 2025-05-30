-- residual_check
-- linkpass_delete_log
SELECT * FROM {ARCHIVED_SN2_DB}.linkpass_delete_log ldl
WHERE ldl.fk_user IN (
SELECT darp.fk_user FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darp);

-- retained_count
-- linkpass_delete_log
SELECT * FROM {ARCHIVED_SN2_DB}.linkpass_delete_log;

-- expected_count_for_retention
-- linkpass_delete_log
SELECT * FROM {SOURCE_SN2_DB}.linkpass_delete_log ldl
WHERE ldl.fk_user NOT IN (
SELECT darp.fk_user FROM {ARCHIVED_SN2_DB}.dar_parent_user_archival_map darp);

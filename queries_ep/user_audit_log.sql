-- residual_check
-- user_audit_log
SELECT ch.birth_certificate, uac.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {ARCHIVED_SN2_DB}.user_audit_log uac ON uac.user_id = u.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- user_audit_log
SELECT u.email AS archive_email, count(u.email)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {ARCHIVED_SN2_DB}.user_audit_log uac ON uac.user_id = u.id
GROUP BY u.email;

-- expected_count_for_retention
-- user_audit_log
SELECT u.email AS source_email, count(u.email)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {SOURCE_SN2_DB}.user_audit_log uac ON uac.user_id = u.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child)
GROUP BY u.email;

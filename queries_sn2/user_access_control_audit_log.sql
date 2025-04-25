-- residual_check
-- user_access_control_audit_log
SELECT ch.birth_certificate, uacal.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {ARCHIVED_SN2_DB}.user_access_control uac ON uac.fk_user = u.id
INNER JOIN {ARCHIVED_SN2_DB}.user_access_control_audit_log uacal ON uacal.user_access_control_id = uac.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- user_access_control_audit_log
SELECT ch.birth_certificate, uacal.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {ARCHIVED_SN2_DB}.user_access_control uac ON uac.fk_user = u.id
INNER JOIN {ARCHIVED_SN2_DB}.user_access_control_audit_log uacal ON uacal.user_access_control_id = uac.id;

-- expected_count_for_retention
-- user_access_control_audit_log
SELECT ch.birth_certificate, uacal.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {SOURCE_SN2_DB}.user_access_control uac ON uac.fk_user = u.id
INNER JOIN {SOURCE_SN2_DB}.user_access_control_audit_log uacal ON uacal.user_access_control_id = uac.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
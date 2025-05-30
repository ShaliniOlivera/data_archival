-- residual_check
-- user_role_relation
SELECT ch.birth_certificate, uac.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {ARCHIVED_SN2_DB}.user_role_relation uac ON uac.fk_user = u.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- user_role_relation
SELECT u.email AS archive_email, count(u.email)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {ARCHIVED_SN2_DB}.user_role_relation uac ON uac.fk_user = u.id
GROUP BY u.email;

-- expected_count_for_retention
-- user_role_relation
SELECT u.email AS source_email, count(u.email)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.user u ON u.email = pa.email
INNER JOIN {SOURCE_SN2_DB}.user_role_relation uac ON uac.fk_user = u.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate)
GROUP BY u.email;

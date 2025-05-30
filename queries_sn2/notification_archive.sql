-- residual_check
-- notification_archive
SELECT * FROM {ARCHIVED_SN2_DB}.notification_archive noti
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cr.fk_child
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- notification_archive
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.notification_archive noti
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cr.fk_child
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- notification_archive
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.notification_archive noti
INNER JOIN {SOURCE_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cr.fk_child
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate;
-- residual_check
-- notification_archive
SELECT * FROM {ARCHIVED_SN2_DB}.notification_archive noti
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cr.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);

-- retained_count
-- notification_archive
SELECT * FROM {ARCHIVED_SN2_DB}.notification_archive noti
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cr.fk_child;

-- expected_count_for_retention
-- notification_archive
SELECT * FROM {SOURCE_SN2_DB}.notification_archive noti
INNER JOIN {SOURCE_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cr.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);
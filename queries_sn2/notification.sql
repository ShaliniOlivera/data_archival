-- residual_check
-- notification
SELECT * FROM {ARCHIVED_SN2_DB}.notification noti
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cr.fk_child
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- notification
SELECT * FROM {ARCHIVED_SN2_DB}.notification noti
INNER JOIN {ARCHIVED_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {ARCHIVED_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {ARCHIVED_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cr.fk_child;

-- expected_count_for_retention
-- notification 
SELECT * FROM {SOURCE_SN2_DB}.notification noti
INNER JOIN {SOURCE_SN2_DB}.user us ON us.id = noti.fk_user
INNER JOIN {SOURCE_SN2_DB}.child_relation cr ON cr.fk_user = us.id
INNER JOIN {SOURCE_SN2_DB}.parent pa ON pa.id = cr.fk_parent
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cr.fk_child
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);
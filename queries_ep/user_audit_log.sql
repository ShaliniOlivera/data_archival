-- residual_check
-- user_audit_log
SELECT ch.birth_certificate, uac.*
FROM `skoolnet2_archival_mfs_ep_20250425`.child ch
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.child_relation cr ON cr.fk_child = ch.id
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.parent pa ON pa.id = cr.fk_parent
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.user u ON u.email = pa.email
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.user_audit_log uac ON uac.user_id = u.id
WHERE ch.id IN(
SELECT darch.fk_child FROM `skoolnet2_archival_mfs_ep_20250425`.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- user_audit_log
SELECT u.email AS archive_email, count(u.email)
FROM `skoolnet2_archival_mfs_ep_20250425`.child ch
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.child_relation cr ON cr.fk_child = ch.id
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.parent pa ON pa.id = cr.fk_parent
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.user u ON u.email = pa.email
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.user_audit_log uac ON uac.user_id = u.id
GROUP BY u.email;

-- expected_count_for_retention
-- user_audit_log
SELECT u.email AS source_email, count(u.email)
FROM `skoolnet2_archival_mfs_ep_20250425_org`.child ch
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.child_relation cr ON cr.fk_child = ch.id
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.parent pa ON pa.id = cr.fk_parent
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.user u ON u.email = pa.email
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.user_audit_log uac ON uac.user_id = u.id
WHERE ch.id NOT IN(
   SELECT darch.fk_child FROM `skoolnet2_archival_mfs_ep_20250425`.dar_child_archival_delete_unique_map darch
   WHERE ch.id = darch.fk_child)
AND u.id NOT IN (
SELECT darp.fk_user FROM `skoolnet2_archival_mfs_ep_20250425`.dar_parent_user_archival_map darp
WHERE darp.fk_user = u.id)
GROUP BY u.email;

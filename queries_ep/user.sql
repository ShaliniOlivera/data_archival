-- residual_check
-- user
SELECT ch.birth_certificate, u.*
FROM `skoolnet2_archival_mfs_ep_20250425`.child ch
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.child_relation cr ON cr.fk_child = ch.id
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.parent pa ON pa.id = cr.fk_parent
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.user u ON u.email = pa.email
WHERE ch.id IN(
SELECT darch.fk_child FROM `skoolnet2_archival_mfs_ep_20250425`.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);


-- retained_count
-- user
SELECT ch.birth_certificate AS archived_bc, u.email
FROM `skoolnet2_archival_mfs_ep_20250425`.child ch
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.child_relation cr ON cr.fk_child = ch.id
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.parent pa ON pa.id = cr.fk_parent
INNER JOIN `skoolnet2_archival_mfs_ep_20250425`.user u ON u.email = pa.email;

-- expected_count_for_retention
-- user
SELECT ch.birth_certificate AS source_bc, u.email
FROM `skoolnet2_archival_mfs_ep_20250425_org`.child ch
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.child_relation cr ON cr.fk_child = ch.id
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.parent pa ON pa.id = cr.fk_parent
INNER JOIN `skoolnet2_archival_mfs_ep_20250425_org`.user u ON u.email = pa.email
WHERE ch.id NOT IN(
   SELECT darch.fk_child FROM `skoolnet2_archival_mfs_ep_20250425`.dar_child_archival_delete_unique_map darch
   WHERE ch.id = darch.fk_child)
AND u.id NOT IN (
SELECT darp.fk_user FROM `skoolnet2_archival_mfs_ep_20250425`.dar_parent_user_archival_map darp
WHERE darp.fk_user = u.id
);

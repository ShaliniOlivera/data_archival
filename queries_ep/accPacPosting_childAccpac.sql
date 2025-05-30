-- residual_check
-- acc_pac_posting | child_acc_pac
SELECT *
FROM {ARCHIVED_SN2_DB}.child_acc_pac cap
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cap.fk_child
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- acc_pac_posting | child_acc_pac
SELECT *
FROM {ARCHIVED_SN2_DB}.child_acc_pac cap
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cap.fk_child;

-- expected_count_for_retention
-- acc_pac_posting | child_acc_pac
SELECT *
FROM {SOURCE_SN2_DB}.child_acc_pac cap
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cap.fk_child
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- residual_check 
-- acc_pac_posting | child_acc_pac
SELECT *
FROM {ARCHIVED_SN2_DB}.acc_pac_posting app
INNER JOIN {ARCHIVED_SN2_DB}.child_acc_pac cap ON cap.fk_acc_pac_posting = app.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cap.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- acc_pac_posting | child_acc_pac
SELECT *
FROM {ARCHIVED_SN2_DB}.acc_pac_posting app
INNER JOIN {ARCHIVED_SN2_DB}.child_acc_pac cap ON cap.fk_acc_pac_posting = app.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cap.fk_child;

-- expected_count_for_retention
-- acc_pac_posting | child_acc_pac
SELECT *
FROM {SOURCE_SN2_DB}.acc_pac_posting app
INNER JOIN {SOURCE_SN2_DB}.child_acc_pac cap ON cap.fk_acc_pac_posting = app.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cap.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
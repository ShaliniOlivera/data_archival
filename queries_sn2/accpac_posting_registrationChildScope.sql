-- residual_check 
-- acc_pac_posting | child_acc_pac
SELECT rc.birth_certificate, app.*, cap.*
FROM {ARCHIVED_SN2_DB}.acc_pac_posting app
INNER JOIN {ARCHIVED_SN2_DB}.child_acc_pac cap ON cap.fk_acc_pac_posting = app.id
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rc ON rc.id = cap.fk_registration_child
WHERE rc.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rc.id = darch.fk_registration_child
);

-- retained_count
-- acc_pac_posting | child_acc_pac
SELECT rc.birth_certificate, app.*, cap.*
FROM {ARCHIVED_SN2_DB}.acc_pac_posting app
INNER JOIN {ARCHIVED_SN2_DB}.child_acc_pac cap ON cap.fk_acc_pac_posting = app.id
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rc ON rc.id = cap.fk_registration_child;

-- expected_count_for_retention
-- acc_pac_posting | child_acc_pac
SELECT rc.birth_certificate, app.*, cap.*
FROM {SOURCE_SN2_DB}.acc_pac_posting app
INNER JOIN {SOURCE_SN2_DB}.child_acc_pac cap ON cap.fk_acc_pac_posting = app.id
INNER JOIN {SOURCE_SN2_DB}.registration_child rc ON rc.id = cap.fk_registration_child
WHERE rc.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rc.id = darch.fk_registration_child
);


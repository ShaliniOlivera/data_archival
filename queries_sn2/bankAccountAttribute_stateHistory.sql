-- residual_check
-- bank_account | bank_account_attribute | bank_account_state_history
SELECT * FROM {ARCHIVED_SN2_DB}.bank_account ba
INNER JOIN {ARCHIVED_SN2_DB}.bank_account_attribute baa ON baa.fk_bank_account = ba.id
INNER JOIN {ARCHIVED_SN2_DB}.bank_account_state_history bash ON bash.fk_bank_account = ba.id 
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ba.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- bank_account | bank_account_attribute | bank_account_state_history
SELECT * FROM {ARCHIVED_SN2_DB}.bank_account ba
INNER JOIN {ARCHIVED_SN2_DB}.bank_account_attribute baa ON baa.fk_bank_account = ba.id
INNER JOIN {ARCHIVED_SN2_DB}.bank_account_state_history bash ON bash.fk_bank_account = ba.id 
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ba.fk_child;

-- expected_count_for_retention
-- bank_account | bank_account_attribute | bank_account_state_history
SELECT * FROM {SOURCE_SN2_DB}.bank_account ba
INNER JOIN {SOURCE_SN2_DB}.bank_account_attribute baa ON baa.fk_bank_account = ba.id
INNER JOIN {SOURCE_SN2_DB}.bank_account_state_history bash ON bash.fk_bank_account = ba.id 
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ba.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
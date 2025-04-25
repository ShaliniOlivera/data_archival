-- residual_check
-- credit_debit_note_audit_log
SELECT * FROM {ARCHIVED_SN2_DB}.credit_debit_note_audit_log cdnal
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cdnal.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- credit_debit_note_audit_log
SELECT * FROM {ARCHIVED_SN2_DB}.credit_debit_note_audit_log cdnal
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = cdnal.fk_child;


-- expected_count_for_retention
-- credit_debit_note_audit_log
SELECT * FROM {SOURCE_SN2_DB}.credit_debit_note_audit_log cdnal
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = cdnal.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

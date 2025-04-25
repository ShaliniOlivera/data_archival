-- residual_check
-- invoice_void_note_audit_log
SELECT ch.birth_certificate, ial.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.invoice_void_note_audit_log ial ON ial.fk_invoice = inv.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- invoice_void_note_audit_log
SELECT ch.birth_certificate, ial.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.invoice_void_note_audit_log ial ON ial.fk_invoice = inv.id;

-- expected_count_for_retention
-- invoice_void_note_audit_log
SELECT ch.birth_certificate, ial.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.invoice_void_note_audit_log ial ON ial.fk_invoice = inv.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
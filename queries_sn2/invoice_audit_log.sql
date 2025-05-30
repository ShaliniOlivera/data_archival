-- residual_check
-- invoice_audit_log
SELECT ch.birth_certificate, ial.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.invoice_audit_log ial ON ial.invoice_no = inv.invoice_no
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- invoice_audit_log
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.invoice_audit_log ial ON ial.invoice_no = inv.invoice_no
group by ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- invoice_audit_log
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.invoice_audit_log ial ON ial.invoice_no = inv.invoice_no
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
)
group by ch.id, ch.birth_certificate;
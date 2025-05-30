-- residual_check
-- receipt_audit_log on fk_child
SELECT ch.id, ca.*
FROM {ARCHIVED_SN2_DB}.receipt_audit_log ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- receipt_audit_log on fk_child
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.receipt_audit_log ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- receipt_audit_log on fk_child
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.receipt_audit_log ca
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
)
GROUP BY ch.id, ch.birth_certificate;
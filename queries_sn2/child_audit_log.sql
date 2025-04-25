
-- residual_check
-- child_audit_log
SELECT ch.birth_certificate, ca.*
FROM {ARCHIVED_SN2_DB}.child_audit_log ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.birth_certificate = ca.birth_certificate
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- child_audit_log
SELECT ch.birth_certificate, ca.*
FROM {ARCHIVED_SN2_DB}.child_audit_log ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.birth_certificate = ca.birth_certificate;

-- expected_count_for_retention
-- child_audit_log
SELECT ch.birth_certificate, ca.*
FROM {SOURCE_SN2_DB}.child_audit_log ca
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.birth_certificate = ca.birth_certificate
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
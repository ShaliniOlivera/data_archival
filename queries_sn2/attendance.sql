-- residual_check
-- attendance
SELECT ch.birth_certificate, ca.*
FROM {ARCHIVED_SN2_DB}.attendance ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- attendance
SELECT ch.birth_certificate, ca.*
FROM {ARCHIVED_SN2_DB}.attendance ca
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ca.fk_child;

-- expected_count_for_retention
-- attendance
SELECT ch.birth_certificate, ca.*
FROM {SOURCE_SN2_DB}.attendance ca
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ca.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
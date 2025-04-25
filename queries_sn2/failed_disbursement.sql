-- residual_check
-- failed_disbursement
SELECT ch.birth_certificate, ev.*
FROM {ARCHIVED_SN2_DB}.failed_disbursement ev
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ev.fk_child
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- failed_disbursement
SELECT ch.birth_certificate, ev.*
FROM {ARCHIVED_SN2_DB}.failed_disbursement ev
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ev.fk_child;

-- expected_count_for_retention
-- failed_disbursement
SELECT ch.birth_certificate, ev.*
FROM {SOURCE_SN2_DB}.failed_disbursement ev
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ev.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
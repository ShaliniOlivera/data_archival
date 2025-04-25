
-- residual_check
-- soa_monthly_pdf
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.soa_monthly_pdf rcb ON rcb.fk_child = ch.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- soa_monthly_pdf
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.soa_monthly_pdf rcb ON rcb.fk_child = ch.id;

-- expected_count_for_retention
-- soa_monthly_pdf
SELECT ch.birth_certificate, rcb.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.soa_monthly_pdf rcb ON rcb.fk_child = ch.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);
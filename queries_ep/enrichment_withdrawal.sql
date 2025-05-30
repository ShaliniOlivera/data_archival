-- residual_check
-- enrichment_withdrawal
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_class_child ecc ON ecc.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_withdrawal ew ON ecc.id = ew.fk_enrichment_class_child
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_withdrawal
SELECT ch.birth_certificate, ew.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_class_child ecc ON ecc.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_withdrawal ew ON ecc.id = ew.fk_enrichment_class_child;


-- expected_count_for_retention
-- enrichment_withdrawal
SELECT ch.birth_certificate, ew.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_class_child ecc ON ecc.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.enrichment_withdrawal ew ON ecc.id = ew.fk_enrichment_class_child
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);
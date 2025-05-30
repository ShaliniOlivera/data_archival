-- residual_check
-- enrichment_class_attendance on fk_child
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_class_child ecc ON ecc.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_class_attendance eca ON eca.fk_enrichment_class_child = ecc.id
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_class_attendance on fk_child
SELECT ch.id, ch.birth_certificate, count(ch.id)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_class_child ecc ON ecc.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_class_attendance eca ON eca.fk_enrichment_class_child = ecc.id
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- enrichment_class_attendance on fk_child
SELECT ch.id, ch.birth_certificate, count(ch.id)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_class_child ecc ON ecc.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.enrichment_class_attendance eca ON eca.fk_enrichment_class_child = ecc.id
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
)
GROUP BY ch.id, ch.birth_certificate;
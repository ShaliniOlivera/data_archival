-- residual_check
-- enrichment_refund
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_refund er ON ch.id = er.fk_child
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_refund
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_refund er ON ch.id = er.fk_child;

-- expected_count_for_retention
-- enrichment_refund
SELECT *
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_refund er ON ch.id = er.fk_child
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);
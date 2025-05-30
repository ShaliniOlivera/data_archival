-- residual_check
-- enrichment_child_receipt
SELECT * FROM {ARCHIVED_SN2_DB}.enrichment_child_receipt ecr
WHERE ecr.fk_child IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE darch.birth_certificate = ecr.fk_child
);

-- retained_count
-- enrichment_child_receipt
SELECT * FROM {ARCHIVED_SN2_DB}.enrichment_child_receipt ecr;

-- expected_count_for_retention
-- enrichment_child_receipt
SELECT * FROM {SOURCE_SN2_DB}.enrichment_child_receipt ecr
WHERE ecr.fk_child NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE darch.birth_certificate = ecr.fk_child
);
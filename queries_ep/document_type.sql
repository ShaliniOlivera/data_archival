-- residual_check
-- document_type
SELECT * FROM {ARCHIVED_SN2_DB}.document_type dty
WHERE dty.fk_child IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE dty.fk_child = darch.fk_child
);

-- retained_count
-- document_type
SELECT * FROM {SOURCE_SN2_DB}.document_type dty;

-- expected_count_for_retention
-- document_type
SELECT * FROM {ARCHIVED_SN2_DB}.document_type dty;
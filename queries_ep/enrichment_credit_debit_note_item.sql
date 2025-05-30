-- residual_check
-- enrichment_credit_debit_note_item
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_credit_debit_note er ON ch.id = er.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_credit_debit_note_item eri ON er.id = eri.fk_enrichment_credit_debit_note
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_credit_debit_note_item
SELECT *
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_credit_debit_note er ON ch.id = er.fk_child
INNER JOIN {SOURCE_SN2_DB}.enrichment_credit_debit_note_item eri ON er.id = eri.fk_enrichment_credit_debit_note
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- expected_count_for_retention
-- enrichment_credit_debit_note_item
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_credit_debit_note er ON ch.id = er.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_credit_debit_note_item eri ON er.id = eri.fk_enrichment_credit_debit_note;
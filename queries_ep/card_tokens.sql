-- residual_check
-- card_tokens
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card
INNER JOIN `paymentdb_20250510`.card_tokens ct ON ct.id = pc.card_token
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);


-- retained_count
-- card_tokens
SELECT *
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {SOURCE_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card
INNER JOIN `paymentdb_20250510`.card_tokens ct ON ct.id = pc.card_token
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- expected_count_for_retention
-- card_tokens
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card
INNER JOIN `paymentdb_20250510`.card_tokens ct ON ct.id = pc.card_token;
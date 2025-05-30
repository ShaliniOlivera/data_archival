-- residual_check
-- enrichment_payment_card | enrichment_payment_card_relation
SELECT ch.id, ch.birth_certificate, pcr.*, pc.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_payment_card | enrichment_payment_card_relation
SELECT ch.id, ch.birth_certificate, pcr.*, pc.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card;


-- expected_count_for_retention
-- enrichment_payment_card | enrichment_payment_card_relation
SELECT ch.id, ch.birth_certificate, pcr.*, pc.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {SOURCE_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);
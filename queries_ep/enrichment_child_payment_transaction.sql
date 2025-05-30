-- residual_check
-- enrichment_child_payment_transaction
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card_relation pcr ON ch.id = pcr.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card pc ON pc.id = pcr.fk_enrichment_payment_card
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_child_payment_transaction cpt ON cpt.fk_enrichment_payment_card = pc.id
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_child_payment_transaction
SELECT *
from {ARCHIVED_SN2_DB}.enrichment_child_payment_transaction cpt
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_child_invoice eci ON eci.id = cpt.fk_enrichment_child_invoice
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_payment_card epc ON epc.id = cpt.fk_enrichment_payment_card;


-- expected_count_for_retention
-- enrichment_child_payment_transaction
SELECT *
from {SOURCE_SN2_DB}.enrichment_child_payment_transaction cpt
INNER JOIN {SOURCE_SN2_DB}.enrichment_child_invoice eci ON eci.id = cpt.fk_enrichment_child_invoice
INNER JOIN {SOURCE_SN2_DB}.enrichment_payment_card epc ON epc.id = cpt.fk_enrichment_payment_card
WHERE eci.fk_child NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE eci.fk_child = darch.fk_child
);
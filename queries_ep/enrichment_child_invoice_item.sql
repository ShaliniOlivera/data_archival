-- residual_check
-- enrichment_child_invoice_item
SELECT *
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_child_invoice inv ON ch.id = inv.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_child_invoice_item invi ON invi.fk_enrichment_child_invoice = inv.id
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);

-- retained_count
-- enrichment_child_invoice_item
SELECT ch.id, ch.birth_certificate , invi.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_child_invoice inv ON ch.id = inv.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.enrichment_child_invoice_item invi ON invi.fk_enrichment_child_invoice = inv.id;

-- expected_count_for_retention
-- enrichment_child_invoice_item
SELECT ch.id, ch.birth_certificate , invi.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.enrichment_child_invoice inv ON ch.id = inv.fk_child
INNER JOIN {SOURCE_SN2_DB}.enrichment_child_invoice_item invi ON invi.fk_enrichment_child_invoice = inv.id
WHERE ch.birth_certificate NOT IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_sn2_unique_map darch
WHERE darch.birth_certificate = ch.birth_certificate
);
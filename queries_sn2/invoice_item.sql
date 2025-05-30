-- residual_check
-- invoice_item
SELECT ch.birth_certificate, inv.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.invoice_item invi ON invi.fk_invoice = inv.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- invoice_item
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.invoice_item invi ON invi.fk_invoice = inv.id
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- invoice_item
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.invoice inv ON inv.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.invoice_item invi ON invi.fk_invoice = inv.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate;
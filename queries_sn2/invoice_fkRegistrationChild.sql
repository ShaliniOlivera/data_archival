-- THIS IS NOT NECESSARY. WE ONLY VALIDATE INVOICES ON fk_child
-- residual_check
-- invoice
SELECT rc.birth_certificate, inv.*
FROM {ARCHIVED_SN2_DB}.registration_child rc
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_registration_child = rc.id
WHERE rc.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);

-- retained_count
-- invoice
SELECT rc.birth_certificate, inv.*
FROM {ARCHIVED_SN2_DB}.registration_child rc
INNER JOIN {ARCHIVED_SN2_DB}.invoice inv ON inv.fk_registration_child = rc.id;

-- expected_count_for_retention
-- invoice
SELECT rc.birth_certificate, inv.*
FROM {SOURCE_SN2_DB}.registration_child rc
INNER JOIN {SOURCE_SN2_DB}.invoice inv ON inv.fk_registration_child = rc.id
WHERE rc.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
WHERE rc.id = darch.fk_registration_child
);
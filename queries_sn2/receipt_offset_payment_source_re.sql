-- residual_check
-- receipt | receipt_offset_payment_source on fk_registration_child
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.receipt rcb ON rch.id = rcb.fk_registration_child
INNER JOIN {ARCHIVED_SN2_DB}.receipt_offset_payment_source rei ON rei.fk_receipt = rcb.id
WHERE rch.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);

-- retained_count
-- receipt | receipt_offset_payment_source on fk_registration_child
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.receipt rcb ON rch.id = rcb.fk_registration_child
INNER JOIN {ARCHIVED_SN2_DB}.receipt_offset_payment_source rei ON rei.fk_receipt = rcb.id;

-- expected_count_for_retention
-- receipt | receipt_offset_payment_source on fk_registration_child
SELECT *
FROM {SOURCE_SN2_DB}.registration_child rch 
INNER JOIN {SOURCE_SN2_DB}.receipt rcb ON rch.id = rcb.fk_registration_child
INNER JOIN {SOURCE_SN2_DB}.receipt_offset_payment_source rei ON rei.fk_receipt = rcb.id
WHERE rch.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
) ;
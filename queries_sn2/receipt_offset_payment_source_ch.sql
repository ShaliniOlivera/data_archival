-- residual_check
-- receipt | receipt_offset_payment_source on fk_child
SELECT ch.birth_certificate,re.*, rei.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.receipt re ON re.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.receipt_offset_payment_source rei ON rei.fk_receipt = re.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
) ;

-- retained_count
-- receipt | receipt_offset_payment_source on fk_child
SELECT ch.birth_certificate,re.*, rei.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.receipt re ON re.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.receipt_offset_payment_source rei ON rei.fk_receipt = re.id;

-- expected_count_for_retention
-- receipt | receipt_offset_payment_source on fk_child
SELECT ch.birth_certificate,re.*, rei.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.receipt re ON re.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.receipt_offset_payment_source rei ON rei.fk_receipt = re.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
) ;
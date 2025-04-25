-- residual_check
-- paynow_transaction_item
SELECT ch.birth_certificate, pti.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.paynow_transaction pat ON pat.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.paynow_transaction_item pti ON pti.fk_paynow_transaction = pat.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);

-- retained_count
-- paynow_transaction_item
SELECT ch.birth_certificate, pti.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.paynow_transaction pat ON pat.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.paynow_transaction_item pti ON pti.fk_paynow_transaction = pat.id;

-- expected_count_for_retention
-- paynow_transaction_item
SELECT ch.birth_certificate, pti.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.paynow_transaction pat ON pat.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.paynow_transaction_item pti ON pti.fk_paynow_transaction = pat.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);
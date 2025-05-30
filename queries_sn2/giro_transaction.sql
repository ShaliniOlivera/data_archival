-- residual_check
-- giro_transaction
SELECT ch.id, ch.birth_certificate, gt.*
FROM {ARCHIVED_SN2_DB}.giro_transaction gt
INNER JOIN {ARCHIVED_SN2_DB}.bank_account ba ON ba.id = gt.fk_bank_account
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ba.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- giro_transaction
SELECT ch.id, ch.birth_certificate, ba.id, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.giro_transaction gt
INNER JOIN {ARCHIVED_SN2_DB}.bank_account ba ON ba.id = gt.fk_bank_account
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ba.fk_child
GROUP BY ch.id, ch.birth_certificate, ba.id;

-- expected_count_for_retention
-- giro_transaction
SELECT ch.id, ch.birth_certificate, ba.id, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.giro_transaction gt
INNER JOIN {SOURCE_SN2_DB}.bank_account ba ON ba.id = gt.fk_bank_account
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ba.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
)
GROUP BY ch.id, ch.birth_certificate, ba.id;

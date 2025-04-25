-- residual_check
-- statement_of_account
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.statement_of_account rcb ON rcb.fk_child = ch.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);


-- retained_count
-- statement_of_account
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.statement_of_account rcb ON rcb.fk_child = ch.id;

-- expected_count_for_retention
-- statement_of_account
SELECT ch.birth_certificate, rcb.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.statement_of_account rcb ON rcb.fk_child = ch.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
);
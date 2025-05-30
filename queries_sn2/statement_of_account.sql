-- residual_check
-- statement_of_account
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.statement_of_account rcb ON rcb.fk_child = ch.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);


-- retained_count
-- statement_of_account
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.statement_of_account rcb ON rcb.fk_child = ch.id
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- statement_of_account
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.statement_of_account rcb ON rcb.fk_child = ch.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
)
GROUP BY ch.id, ch.birth_certificate;
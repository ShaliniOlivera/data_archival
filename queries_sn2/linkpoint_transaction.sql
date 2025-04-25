-- residual_check
-- linkpoint_transaction
SELECT ch.birth_certificate,cl.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.linkpoint_transaction cl ON ch.id = cl.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- linkpoint_transaction
SELECT ch.birth_certificate,cl.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.linkpoint_transaction cl ON ch.id = cl.fk_child;

-- expected_count_for_retention
-- linkpoint_transaction
SELECT ch.birth_certificate,cl.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.linkpoint_transaction cl ON ch.id = cl.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
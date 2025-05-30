-- residual_count
-- refund_child_balance on fk_child
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance rcb ON rcb.fk_child = ch.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
where ch.id = darch.fk_child
);


-- retained_count
-- refund_child_balance on fk_child
SELECT ch.birth_certificate, rcb.*
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance rcb ON rcb.fk_child = ch.id;

-- expected_count_for_retention
-- refund_child_balance on fk_child
SELECT ch.birth_certificate, rcb.*
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.refund_child_balance rcb ON rcb.fk_child = ch.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
where ch.id = darch.fk_child
);
-- residual_count
-- refund_child_balance on fk_registration_child
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance rcb ON rch.id = rcb.fk_registration_child
WHERE rch.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);


-- retained_count
-- refund_child_balance on fk_registration_child
SELECT *
FROM {ARCHIVED_SN2_DB}.registration_child rch 
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance rcb ON rch.id = rcb.fk_registration_child;

-- expected_count_for_retention
-- refund_child_balance on fk_registration_child
SELECT *
FROM {SOURCE_SN2_DB}.registration_child rch 
INNER JOIN {SOURCE_SN2_DB}.refund_child_balance rcb ON rch.id = rcb.fk_registration_child
WHERE rch.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);
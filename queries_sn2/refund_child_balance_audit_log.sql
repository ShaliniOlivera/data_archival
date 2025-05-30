-- residual_count
-- refund_child_balance_audit_log
SELECT ch.birth_certificate, rcb.id AS rcb_id, rcbal.id AS rcbal_id, ch.id AS ch_id
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance rcb ON rcb.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance_audit_log rcbal ON rcbal.refund_child_balance_id = rcb.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);

-- retained_count
-- refund_child_balance_audit_log
SELECT ch.birth_certificate, rcb.id AS rcb_id, rcbal.id AS rcbal_id, ch.id AS ch_id
FROM {ARCHIVED_SN2_DB}.child ch
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance rcb ON rcb.fk_child = ch.id
INNER JOIN {ARCHIVED_SN2_DB}.refund_child_balance_audit_log rcbal ON rcbal.refund_child_balance_id = rcb.id;

-- expected_count_for_retention
-- refund_child_balance_audit_log
SELECT ch.birth_certificate, rcb.id AS rcb_id, rcbal.id AS rcbal_id, ch.id AS ch_id
FROM {SOURCE_SN2_DB}.child ch
INNER JOIN {SOURCE_SN2_DB}.refund_child_balance rcb ON rcb.fk_child = ch.id
INNER JOIN {SOURCE_SN2_DB}.refund_child_balance_audit_log rcbal ON rcbal.refund_child_balance_id = rcb.id
WHERE ch.id NOT IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
);
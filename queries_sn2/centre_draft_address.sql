-- residual_check
-- centre_draft_address
SELECT * FROM {SOURCE_SN2_DB}.centre_draft_address cda
WHERE cda.id NOT IN (
SELECT cda2.id FROM {ARCHIVED_SN2_DB}.centre_draft_address cda2
);

-- retained_count
-- centre_draft_address
SELECT * FROM {ARCHIVED_SN2_DB}.centre_draft_address;

-- expected_count_for_retention
-- centre_draft_address
SELECT * FROM {SOURCE_SN2_DB}.centre_draft_address;
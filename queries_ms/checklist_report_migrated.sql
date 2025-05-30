-- residual_count
-- cchecklist_report_migrated
SELECT crm.*
FROM {ARCHIVED_MS_CLASSOPS_DB}.checklist_report_migrated crm
WHERE crm.year <= 2018;

-- retained_count
-- cchecklist_report_migrated
SELECT crm.*
FROM {ARCHIVED_MS_CLASSOPS_DB}.checklist_report_migrated crm;


-- expected_count_for_retention
-- cchecklist_report_migrated
SELECT crm.*
FROM {SOURCE_MS_CLASSOPS_DB}.checklist_report_migrated crm
WHERE crm.year > 2018;
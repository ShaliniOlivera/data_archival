-- residual_check
-- checklist_report_migrated
SELECT crm.id 
FROM {ARCHIVED_SN2_DB}.checklist_report_migrated crm
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = crm.fk_class;

-- retained_count
-- checklist_report_migrated
SELECT crm.id 
FROM {ARCHIVED_SN2_DB}.checklist_report_migrated crm
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = crm.fk_class;

-- expected_count_for_retention
-- checklist_report_migrated
SELECT crm.id
FROM {SOURCE_SN2_DB}.checklist_report_migrated crm
INNER JOIN {SOURCE_SN2_DB}.checklist_report_path_migrated crpm ON crpm.fk_checklist_report_migrated = crm.id;
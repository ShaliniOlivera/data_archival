-- residual_count
-- class_activity_tag_relation
SELECT ch.birth_certificate, ca.title, ca.description,caas.fk_child, caas.fk_class
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_tag_relation calg ON calg.fk_class_activity = ca.id
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- class_activity_tag_relation
SELECT ch.birth_certificate, ca.title, ca.description,caas.fk_child, caas.fk_class
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_tag_relation calg ON calg.fk_class_activity = ca.id;

-- expected_count_for_retention
-- class_activity_tag_relation
SELECT ch.birth_certificate, ca.title, ca.description,caas.fk_child, caas.fk_class
FROM {SOURCE_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = caas.fk_child
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_tag_relation calg ON calg.fk_class_activity = ca.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
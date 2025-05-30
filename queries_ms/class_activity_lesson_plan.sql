-- residual_check 
-- class_activity_lesson_plan
SELECT ch.birth_certificate, ca.title, ca.description,caas.fk_child, caas.fk_class
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
LEFT JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image cai ON cai.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_lesson_plan clp ON clp.fk_class_activity = ca.id
WHERE ch.id IN(
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.id = darch.fk_child
); 

-- retained_count
-- class_activity_lesson_plan
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = caas.fk_child
LEFT JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_image cai ON cai.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_lesson_plan clp ON clp.fk_class_activity = ca.id
GROUP BY ch.id, ch.birth_certificate;

-- expected_count_for_retention
-- class_activity_lesson_plan
SELECT ch.id, ch.birth_certificate, count(ch.birth_certificate)
FROM {SOURCE_MS_CLASSOPS_DB}.class_activity ca 
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = caas.fk_child
LEFT JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_image cai ON cai.fk_class_activity = ca.id
INNER JOIN {SOURCE_MS_CLASSOPS_DB}.class_activity_lesson_plan clp ON clp.fk_class_activity = ca.id
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
)
GROUP BY ch.id, ch.birth_certificate;
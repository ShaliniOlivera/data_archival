-- residual_check
-- class_activity_parent_interaction on fk_class
SELECT ccla.fk_child, ca.id, caas.id, caas.fk_class
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = caas.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = cla.id AND ccla.fk_class = caas.fk_class
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_parent_interaction cai ON cai.fk_class_activity = ca.id
WHERE ccla.fk_child IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ccla.fk_child = darch.fk_child
)
AND ca.published_at BETWEEN ccla.FROM AND ccla.TO
AND (ca.created_at > '2017-12-31 23:59:59'
OR ca.published_at > '2017-12-31 23:59:59'
);

-- retained_count
-- class_activity_parent_interaction on fk_class
SELECT caas.fk_child, ca.id, count(caas.fk_child)
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = caas.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = cla.id AND ccla.fk_class = caas.fk_class
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_parent_interaction cai ON cai.fk_class_activity = ca.id
AND ca.published_at BETWEEN ccla.FROM AND ccla.TO
GROUP BY caas.fk_child, ca.id;

-- expected_count_for_retention
-- class_activity_parent_interaction on fk_class
SELECT caas.fk_child, ca.id, count(caas.fk_child)
FROM {ARCHIVED_MS_CLASSOPS_DB}.class_activity ca
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_access_scope caas ON caas.fk_class_activity = ca.id
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = caas.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = cla.id AND ccla.fk_class = caas.fk_class
INNER JOIN {ARCHIVED_MS_CLASSOPS_DB}.class_activity_parent_interaction cai ON cai.fk_class_activity = ca.id
WHERE ccla.fk_child NOT IN (
SELECT darch.fk_child FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ccla.fk_child = darch.fk_child
)
AND ca.published_at BETWEEN ccla.FROM AND ccla.TO
AND (ca.created_at > '2017-12-31 23:59:59'
OR ca.published_at > '2017-12-31 23:59:59'
)
GROUP BY caas.fk_child, ca.id;
-- residual_check | broadcasting_childScope
-- broadcasting | broadcasting_mark | broadcasting_scope |broadcasting_attachment
SELECT ch.birth_certificate, br.subject, br.description, brs.fk_class, brs.fk_child 
FROM {ARCHIVED_SN2_DB}.broadcasting br
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_attachment brat ON br.id = brat.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_mark brm  ON br.id = brm.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_scope brs ON br.id = brs.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = brs.fk_child
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count | broadcasting_childScope
-- broadcasting | broadcasting_mark | broadcasting_scope |broadcasting_attachment
SELECT ch.birth_certificate, br.subject, br.description, brs.fk_class, brs.fk_child 
FROM {ARCHIVED_SN2_DB}.broadcasting br
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_attachment brat ON br.id = brat.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_mark brm  ON br.id = brm.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_scope brs ON br.id = brs.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = brs.fk_child;

-- expected_count_for_retention | broadcasting_childScope
-- broadcasting | broadcasting_mark | broadcasting_scope |broadcasting_attachment
SELECT ch.birth_certificate, br.subject, br.description, brs.fk_class, brs.fk_child 
FROM {SOURCE_SN2_DB}.broadcasting br
INNER JOIN {SOURCE_SN2_DB}.broadcasting_attachment brat ON br.id = brat.fk_broadcasting
INNER JOIN {SOURCE_SN2_DB}.broadcasting_mark brm  ON br.id = brm.fk_broadcasting
INNER JOIN {SOURCE_SN2_DB}.broadcasting_scope brs ON br.id = brs.fk_broadcasting
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = brs.fk_child
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

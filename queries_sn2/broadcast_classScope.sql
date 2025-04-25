-- residual_check | broadcast_classScope
-- broadcasting | broadcasting_mark | broadcasting_scope |broadcasting_attachment
SELECT ch.birth_certificate, cla.label, le.label, cla.*, br.subject, br.description, brs.fk_class, brs.fk_child 
FROM {ARCHIVED_SN2_DB}.broadcasting br
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_attachment brat ON br.id = brat.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_mark brm  ON br.id = brm.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_scope brs ON br.id = brs.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = brs.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child_level cle ON cle.id = cla.fk_level
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = cla.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ccla.fk_child AND ch.id = cle.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.level le ON le.id = cle.fk_level
WHERE ch.birth_certificate IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count | broadcast_classScope
-- broadcasting | broadcasting_mark | broadcasting_scope |broadcasting_attachment 
SELECT ch.birth_certificate, cla.label, le.label, cla.*, br.subject, br.description, brs.fk_class, brs.fk_child 
FROM {ARCHIVED_SN2_DB}.broadcasting br
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_attachment brat ON br.id = brat.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_mark brm  ON br.id = brm.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.broadcasting_scope brs ON br.id = brs.fk_broadcasting
INNER JOIN {ARCHIVED_SN2_DB}.class cla ON cla.id = brs.fk_class
INNER JOIN {ARCHIVED_SN2_DB}.child_level cle ON cle.id = cla.fk_level
INNER JOIN {ARCHIVED_SN2_DB}.child_class ccla ON ccla.fk_class = cla.id
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = ccla.fk_child AND ch.id = cle.fk_child
INNER JOIN {ARCHIVED_SN2_DB}.level le ON le.id = cle.fk_level;


-- expected_count_for_retention | broadcast_classScope
-- broadcasting | broadcasting_mark | broadcasting_scope |broadcasting_attachment
SELECT ch.birth_certificate, cla.label, le.label, cla.*, br.subject, br.description, brs.fk_class, brs.fk_child 
FROM {SOURCE_SN2_DB}.broadcasting br
INNER JOIN {SOURCE_SN2_DB}.broadcasting_attachment brat ON br.id = brat.fk_broadcasting
INNER JOIN {SOURCE_SN2_DB}.broadcasting_mark brm  ON br.id = brm.fk_broadcasting
INNER JOIN {SOURCE_SN2_DB}.broadcasting_scope brs ON br.id = brs.fk_broadcasting
INNER JOIN {SOURCE_SN2_DB}.class cla ON cla.id = brs.fk_class
INNER JOIN {SOURCE_SN2_DB}.child_level cle ON cle.id = cla.fk_level
INNER JOIN {SOURCE_SN2_DB}.child_class ccla ON ccla.fk_class = cla.id
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = ccla.fk_child AND ch.id = cle.fk_child
INNER JOIN {SOURCE_SN2_DB}.level le ON le.id = cle.fk_level
WHERE ch.birth_certificate NOT IN(
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);
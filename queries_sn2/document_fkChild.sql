-- residual_check
-- document | document_tag | document_type
SELECT ch.id
FROM {ARCHIVED_SN2_DB}.document doc
INNER JOIN {ARCHIVED_SN2_DB}.document_tag dta ON doc.id = dta.fk_document
INNER JOIN {ARCHIVED_SN2_DB}.document_type dty ON dty.id = dta.fk_document_type
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = dty.fk_child
WHERE ch.birth_certificate IN (
SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
WHERE ch.birth_certificate = darch.birth_certificate
);

-- retained_count
-- document | document_tag | document_type
SELECT ch.id, doc.id, count(ch.id)
FROM {ARCHIVED_SN2_DB}.document doc
INNER JOIN {ARCHIVED_SN2_DB}.document_tag dta ON doc.id = dta.fk_document
INNER JOIN {ARCHIVED_SN2_DB}.document_type dty ON dty.id = dta.fk_document_type
INNER JOIN {ARCHIVED_SN2_DB}.child ch ON ch.id = dty.fk_child
GROUP BY ch.id, doc.id;

-- expected_count_for_retention
-- document | document_tag | document_type
SELECT ch.id, doc.id, count(ch.id)
FROM {SOURCE_SN2_DB}.document doc
INNER JOIN {SOURCE_SN2_DB}.document_tag dta ON doc.id = dta.fk_document
INNER JOIN {SOURCE_SN2_DB}.document_type dty ON dty.id = dta.fk_document_type
INNER JOIN {SOURCE_SN2_DB}.child ch ON ch.id = dty.fk_child
WHERE ch.birth_certificate NOT IN(
   SELECT darch.birth_certificate FROM {ARCHIVED_SN2_DB}.dar_child_archival_delete_unique_map darch
   WHERE ch.birth_certificate = darch.birth_certificate
   )
GROUP BY ch.id,doc.id;
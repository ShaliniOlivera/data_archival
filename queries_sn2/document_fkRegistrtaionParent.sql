-- residual_check
-- document | document_tag | document_type
SELECT rc.id, rc.birth_certificate, doc.*, dta.*,dty.*
FROM {ARCHIVED_SN2_DB}.document doc
INNER JOIN {ARCHIVED_SN2_DB}.document_tag dta ON doc.id = dta.fk_document
INNER JOIN {ARCHIVED_SN2_DB}.document_type dty ON dty.id = dta.fk_document_type
INNER JOIN {ARCHIVED_SN2_DB}.registration_parent rp ON rp.id = dty.fk_registration_parent
INNER JOIN {ARCHIVED_SN2_DB}.registration_child_parent rcp ON rcp.fk_registration_parent = rp.id
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rc ON rc.id = rcp.fk_registration_child
WHERE rc.id IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
);

-- retained_count
-- document | document_tag | document_type
SELECT rc.id, rc.birth_certificate, doc.*, dta.*,dty.*
FROM {ARCHIVED_SN2_DB}.document doc
INNER JOIN {ARCHIVED_SN2_DB}.document_tag dta ON doc.id = dta.fk_document
INNER JOIN {ARCHIVED_SN2_DB}.document_type dty ON dty.id = dta.fk_document_type
INNER JOIN {ARCHIVED_SN2_DB}.registration_parent rp ON rp.id = dty.fk_registration_parent
INNER JOIN {ARCHIVED_SN2_DB}.registration_child_parent rcp ON rcp.fk_registration_parent = rp.id
INNER JOIN {ARCHIVED_SN2_DB}.registration_child rc ON rc.id = rcp.fk_registration_child;

-- expected_count_for_retention
-- document | document_tag | document_type
SELECT rc.id, rc.birth_certificate, doc.*, dta.*,dty.*
FROM {SOURCE_SN2_DB}.document doc
INNER JOIN {SOURCE_SN2_DB}.document_tag dta ON doc.id = dta.fk_document
INNER JOIN {SOURCE_SN2_DB}.document_type dty ON dty.id = dta.fk_document_type
INNER JOIN {SOURCE_SN2_DB}.registration_parent rp ON rp.id = dty.fk_registration_parent
INNER JOIN {SOURCE_SN2_DB}.registration_child_parent rcp ON rcp.fk_registration_parent = rp.id
INNER JOIN {SOURCE_SN2_DB}.registration_child rc ON rc.id = rcp.fk_registration_child
WHERE rc.id NOT IN(
SELECT darch.fk_registration_child FROM {ARCHIVED_SN2_DB}.dar_registration_child_delete_unique_map darch
) ;
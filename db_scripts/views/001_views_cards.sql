CREATE VIEW vw_views_info AS
SELECT 
    c.id,
    c.hp,
    c.name,
    c.info,
    c.attack,
    c.dammage,
    c.weak,
    c.ressis,
    c.retreat,
    c.cadsNumberInColletion,
    col.collectionsSetName AS collection_name,
    t.typeName AS type_name,
    s.stageName AS stage_name
FROM 
    tbl_cards c
JOIN tbl_collections col ON c.collection_id = col.id
JOIN tbl_types t ON c.type_id = t.id
JOIN tbl_stages s ON c.stage_id = s.id;

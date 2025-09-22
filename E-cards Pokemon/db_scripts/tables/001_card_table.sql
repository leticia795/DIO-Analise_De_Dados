-- Table for Pokémon types
CREATE TABLE tbl_types (
    id INT PRIMARY KEY,
    typeName VARCHAR(20) NOT NULL UNIQUE
);

-- Table for Pokémon stages
CREATE TABLE tbl_stages (
    id INT PRIMARY KEY,
    stageName VARCHAR(20) NOT NULL UNIQUE
);

-- Table for collections
CREATE TABLE tbl_collections (
    id INT  PRIMARY KEY,
    collectionsSetName VARCHAR(80) NOT NULL,
    releaseDate DATE,
    totalCardsInCollections INT NOT NULL
);

-- Table for cards
CREATE TABLE tbl_cards (
    id INT PRIMARY KEY,
    hp INT,
    name VARCHAR(50) NOT NULL,
    info TEXT,
    attack VARCHAR(60),
    dammage VARCHAR(10),
    weak VARCHAR(20),
    ressis VARCHAR(20),
    retreat VARCHAR(10),
    cadsNumberInColletion INT ,
    collection_id INT,
    type_id INT,
    stage_id INT,
    FOREIGN KEY (collection_id) REFERENCES tbl_collections(id),
    FOREIGN KEY (type_id) REFERENCES tbl_types(id),
    FOREIGN KEY (stage_id) REFERENCES tbl_stages(id)
);

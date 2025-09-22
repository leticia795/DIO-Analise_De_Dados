
CREATE DATABASE IF NOT EXISTS pokemon_db;


USE pokemon_db;

CREATE TABLE IF NOT EXISTS tbl_types (
    id INT PRIMARY KEY,
    typeName VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS tbl_stages (
    id INT PRIMARY KEY,
    stageName VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS tbl_collections (
    id INT PRIMARY KEY,
    collectionsSetName VARCHAR(80) NOT NULL,
    releaseDate DATE,
    totalCardsInCollections INT NOT NULL
);


CREATE TABLE IF NOT EXISTS tbl_cards (
    id INT PRIMARY KEY,
    hp INT,
    name VARCHAR(50) NOT NULL,
    info TEXT,
    attack VARCHAR(60),
    dammage VARCHAR(10),
    weak VARCHAR(20),
    ressis VARCHAR(20),
    retreat VARCHAR(10),
    cadsNumberInColletion INT,
    collection_id INT,
    type_id INT,
    stage_id INT,
    FOREIGN KEY (collection_id) REFERENCES tbl_collections(id),
    FOREIGN KEY (type_id) REFERENCES tbl_types(id),
    FOREIGN KEY (stage_id) REFERENCES tbl_stages(id)
);


INSERT INTO tbl_types (id, typeName) VALUES
(1, 'Grass'),
(2, 'Fire'),
(3, 'Water'),
(4, 'Electric'),
(5, 'Psychic'),
(6, 'Fighting'),
(7, 'Darkness'),
(8, 'Metal'),
(9, 'Fairy'),
(10, 'Dragon'),
(11, 'Colorless');


INSERT INTO tbl_stages (id, stageName) VALUES
(1, 'Basic'),
(2, 'Stage 1'),
(3, 'Stage 2');


INSERT INTO tbl_collections (id, collectionsSetName, releaseDate, totalCardsInCollections) VALUES
(1, 'Base Set', '1999-01-09', 102),
(2, 'Jungle', '1999-06-16', 64),
(3, 'Fossil', '1999-10-10', 62);


INSERT INTO tbl_cards (id, hp, name, info, attack, dammage, weak, ressis, retreat, cadsNumberInColletion, collection_id, type_id, stage_id) VALUES
(1, 60, 'Bulbasaur', 'Seed Pokémon', 'Tackle', '10', 'Fire', 'Water', '1', 1, 1, 1, 1),
(2, 80, 'Charmeleon', 'Flame Pokémon', 'Flamethrower', '50', 'Water', 'None', '2', 5, 1, 2, 2),
(3, 90, 'Blastoise', 'Shellfish Pokémon', 'Hydro Pump', '60', 'Electric', 'None', '3', 9, 1, 3, 3);


INSERT INTO tbl_cards (id, hp, name, info, attack, dammage, weak, ressis, retreat, cadsNumberInColletion, collection_id, type_id, stage_id) VALUES
(4, 70, 'Pikachu', 'Mouse Pokémon', 'Thunder Shock', '30', 'Fighting', 'Metal', '1', 25, 1, 4, 1),
(5, 90, 'Venusaur', 'Seed Pokémon', 'Solar Beam', '100', 'Fire', 'Water', '4', 15, 1, 1, 3),
(6, 70, 'Charizard', 'Flame Pokémon', 'Fire Spin', '100', 'Water', 'Fighting', '3', 6, 1, 2, 3),
(7, 80, 'Gengar', 'Shadow Pokémon', 'Shadow Punch', '60', 'Psychic', 'Darkness', '2', 14, 2, 5, 2),
(8, 90, 'Mewtwo', 'Genetic Pokémon', 'Psychic', '50', 'Psychic', 'Fighting', '2', 10, 3, 5, 1),
(9, 60, 'Jigglypuff', 'Balloon Pokémon', 'Sing', '20', 'Steel', 'None', '1', 32, 2, 9, 1),
(10, 80, 'Machop', 'Superpower Pokémon', 'Karate Chop', '30', 'Psychic', 'None', '2', 42, 2, 6, 1),
(11, 100, 'Steelix', 'Iron Snake Pokémon', 'Iron Tail', '50', 'Fire', 'Psychic', '3', 14, 3, 8, 3),
(12, 70, 'Clefairy', 'Fairy Pokémon', 'Metronome', '20', 'Steel', 'Darkness', '2', 9, 3, 9, 1),
(13, 60, 'Dratini', 'Dragon Pokémon', 'Dragon Tail', '20', 'Fairy', 'None', '1', 22, 3, 10, 1),
(14, 90, 'Magmar', 'Spitfire Pokémon', 'Flamethrower', '50', 'Water', 'Metal', '2', 18, 2, 2, 2),
(15, 60, 'Primeape', 'Pig Monkey Pokémon', 'Fury Swipes', '20', 'Psychic', 'None', '2', 50, 2, 6, 2),
(16, 80, 'Umbreon', 'Moonlight Pokémon', 'Darkness Claw', '30', 'Fighting', 'None', '3', 17, 3, 7, 2),
(17, 110, 'Tyranitar', 'Armor Pokémon', 'Crunch', '60', 'Fighting', 'Psychic', '4', 45, 3, 6, 3),
(18, 70, 'Scizor', 'Pincer Pokémon', 'Metal Claw', '40', 'Fire', 'None', '2', 12, 3, 8, 2),
(19, 50, 'Rattata', 'Mouse Pokémon', 'Bite', '10', 'Fighting', 'Psychic', '1', 56, 1, 6, 1),
(20, 100, 'Salamence', 'Dragon Pokémon', 'Dragon Claw', '70', 'Fairy', 'None', '3', 7, 3, 10, 3),
(21, 90, 'Electabuzz', 'Electric Pokémon', 'Thunder Punch', '60', 'Fighting', 'Metal', '2', 23, 2, 4, 2),
(22, 60, 'Clefable', 'Fairy Pokémon', 'Moonlight', '40', 'Steel', 'Darkness', '3', 8, 3, 9, 3),
(23, 70, 'Haunter', 'Gas Pokémon', 'Shadow Punch', '40', 'Psychic', 'Darkness', '1', 14, 2, 5, 2);


INSERT INTO tbl_cards (id, hp, name, info, attack, dammage, weak, ressis, retreat, cadsNumberInColletion, collection_id, type_id, stage_id) VALUES
(46, 70, 'Blissey', 'Happiness Pokémon', 'Soft-Boiled', '30', 'Fighting', 'None', '2', 5, 3, 11, 2),
(47, 80, 'Lugia', 'Diving Pokémon', 'Aeroblast', '90', 'Electric', 'None', '4', 3, 3, 10, 3),
(48, 60, 'Mareep', 'Wool Pokémon', 'Thunder Wave', '20', 'Fighting', 'None', '1', 40, 1, 4, 1),
(49, 90, 'Gardevoir', 'Bright Pokémon', 'Psychic', '70', 'Darkness', 'Fighting', '2', 9, 3, 5, 2),
(50, 70, 'Tyrogue', 'Scuffle Pokémon', 'Double Kick', '30', 'Psychic', 'None', '1', 33, 2, 6, 1),
(51, 110, 'Salamence', 'Dragon Pokémon', 'Dragon Claw', '80', 'Fairy', 'None', '3', 7, 3, 10, 3),
(52, 60, 'Pachirisu', 'EleSquirrel Pokémon', 'Spark', '20', 'Fighting', 'None', '1', 25, 2, 4, 1),
(53, 80, 'Lucario', 'Aura Pokémon', 'Aura Sphere', '60', 'Psychic', 'None', '2', 14, 3, 6, 2),
(54, 70, 'Gliscor', 'Fang Scorp Pokémon', 'Poison Fang', '30', 'Water', 'None', '2', 18, 2, 3, 2),
(55, 90, 'Metagross', 'Iron Leg Pokémon', 'Meteor Mash', '70', 'Fire', 'Psychic', '3', 13, 3, 8, 3),
(56, 60, 'Hoothoot', 'Owl Pokémon', 'Peck', '20', 'Electric', 'None', '1', 34, 1, 11, 1),
(57, 80, 'Crobat', 'Bat Pokémon', 'Cross Poison', '60', 'Psychic', 'None', '3', 20, 2, 7, 3),
(58, 100, 'Togekiss', 'Jubilee Pokémon', 'Air Slash', '70', 'Electric', 'None', '3', 10, 3, 9, 3),
(59, 70, 'Sandslash', 'Mouse Pokémon', 'Slash', '40', 'Water', 'None', '2', 25, 2, 6, 2),
(60, 110, 'Hydreigon', 'Brutal Pokémon', 'Dark Pulse', '80', 'Fairy', 'None', '4', 11, 3, 7, 3),
(61, 60, 'Zweilous', 'Hostile Pokémon', 'Bite', '30', 'Fairy', 'None', '2', 28, 2, 10, 1),
(62, 90, 'Togetic', 'Happiness Pokémon', 'Swift', '40', 'Electric', 'None', '2', 18, 2, 9, 2),
(63, 70, 'Scrafty', 'Hoodlum Pokémon', 'Fake Out', '30', 'Psychic', 'None', '2', 20, 2, 6, 2),
(64, 100, 'Garchomp', 'Mach Pokémon', 'Dragon Rush', '90', 'Fairy', 'None', '3', 7, 3, 10, 3),
(65, 60, 'Timburr', 'Muscle Pokémon', 'Bulk Up', '20', 'Psychic', 'None', '1', 29, 1, 6, 1),
(66, 80, 'Heracross', 'Single Horn Pokémon', 'Megahorn', '60', 'Psychic', 'None', '2', 18, 2, 6, 2),
(67, 70, 'Noctowl', 'Owl Pokémon', 'Night Slash', '40', 'Electric', 'None', '2', 15, 2, 11, 2),
(68, 90, 'Cacturne', 'Scarecrow Pokémon', 'Needle Arm', '50', 'Fire', 'None', '3', 20, 3, 1, 2),
(69, 100, 'Torterra', 'Continent Pokémon', 'Wood Hammer', '80', 'Fire', 'Water', '4', 10, 3, 1, 3),
(70, 60, 'Mime Jr.', 'Mime Pokémon', 'Confuse Ray', '20', 'Psychic', 'None', '1', 34, 1, 5, 1),
(71, 80, 'Gallade', 'Blade Pokémon', 'Psycho Cut', '60', 'Darkness', 'None', '2', 13, 3, 5, 2),
(72, 70, 'Froslass', 'Snow Land Pokémon', 'Icy Wind', '30', 'Fighting', 'None', '2', 23, 2, 4, 2),
(73, 90, 'Luxray', 'Gleam Eyes Pokémon', 'Thunder Fang', '70', 'Fighting', 'None', '3', 15, 3, 4, 2),
(74, 100, 'Infernape', 'Flame Pokémon', 'Flamethrower', '90', 'Water', 'None', '3', 20, 3, 2, 3),
(75, 60, 'Dedenne', 'Antenna Pokémon', 'Nuzzle', '20', 'Psychic', 'None', '1', 24, 1, 4, 1),
(76, 80, 'Togedemaru', 'Roly-Poly Pokémon', 'Pin Missile', '50', 'Fighting', 'None', '2', 12, 2, 4, 2);

select * from tbl_cards;

INSERT INTO tbl_cards (id, hp, name, info, attack, dammage, weak, ressis, retreat, cadsNumberInColletion, collection_id, type_id, stage_id) VALUES
(77, 75, 'Tyrantrum', 'Despot Pokémon', 'Jaw Lock', '70', 'Fairy', 'None', '3', 15, 3, 10, 3),
(78, 55, 'Pichu', 'Tiny Mouse Pokémon', 'Thunder Jolt', '20', 'Fighting', 'None', '1', 30, 1, 4, 1),
(79, 85, 'Electivire', 'Electric Pokémon', 'Thunder Punch', '80', 'Fighting', 'None', '3', 20, 3, 4, 3),
(80, 60, 'Croagunk', 'Toxic Mouth Pokémon', 'Poison Jab', '30', 'Psychic', 'None', '2', 22, 2, 6, 1),
(81, 90, 'Absol', 'Disaster Pokémon', 'Night Slash', '70', 'Fighting', 'None', '2', 18, 3, 7, 2),
(82, 70, 'Swampert', 'Mud Fish Pokémon', 'Mud Shot', '60', 'Grass', 'Electric', '3', 12, 3, 3, 3),
(83, 50, 'Whismur', 'Whisper Pokémon', 'Pound', '10', 'Fighting', 'None', '1', 40, 1, 1, 1),
(84, 80, 'Gothitelle', 'Astral Body Pokémon', 'Psychic', '60', 'Darkness', 'None', '2', 12, 2, 5, 2),
(85, 70, 'Serperior', 'Regal Pokémon', 'Leaf Storm', '70', 'Fire', 'None', '3', 8, 3, 1, 3),
(86, 90, 'Haxorus', 'Axe Jaw Pokémon', 'Dragon Claw', '80', 'Fairy', 'None', '3', 10, 3, 10, 3),
(87, 60, 'Marill', 'Aqua Mouse Pokémon', 'Bubble Beam', '20', 'Electric', 'None', '1', 32, 1, 9, 1),
(88, 80, 'Togekiss', 'Jubilee Pokémon', 'Air Slash', '70', 'Electric', 'None', '3', 18, 2, 9, 3),
(89, 100, 'Luxray', 'Gleam Eyes Pokémon', 'Spark', '80', 'Fighting', 'None', '3', 14, 3, 4, 3),
(90, 70, 'Sneasel', 'Sharp Claw Pokémon', 'Fury Swipes', '40', 'Fighting', 'None', '2', 22, 2, 7, 2),
(91, 60, 'Combusken', 'Young Flame Pokémon', 'Peck', '30', 'Water', 'None', '1', 25, 1, 2, 2),
(92, 85, 'Feraligatr', 'Big Jaw Pokémon', 'Crunch', '80', 'Grass', 'None', '4', 12, 3, 3, 3),
(93, 75, 'Aegislash', 'Royal Sword Pokémon', 'Sacred Sword', '70', 'Fire', 'None', '3', 16, 3, 8, 3),
(94, 60, 'Zangoose', 'Cat Ferret Pokémon', 'Slash', '40', 'Psychic', 'None', '1', 30, 2, 6, 2),
(95, 90, 'Garchomp', 'Mach Pokémon', 'Dragon Rush', '90', 'Fairy', 'None', '4', 10, 3, 10, 3),
(96, 80, 'Gallade', 'Blade Pokémon', 'Psycho Cut', '60', 'Darkness', 'None', '2', 19, 2, 5, 2),
(97, 70, 'Floatzel', 'Sea Weasel Pokémon', 'Aqua Tail', '50', 'Grass', 'None', '2', 25, 2, 3, 2),
(98, 60, 'Shinx', 'Flash Pokémon', 'Spark', '20', 'Fighting', 'None', '1', 30, 1, 4, 1),
(99, 85, 'Altaria', 'Humming Pokémon', 'Dragon Breath', '70', 'Fairy', 'None', '3', 10, 3, 10, 2),
(100, 90, 'Dragalge', 'Sea Dragon Pokémon', 'Poison Fang', '60', 'Psychic', 'None', '3', 18, 3, 3, 3),
(101, 60, 'Noibat', 'Sound Wave Pokémon', 'Ultrasound', '30', 'Electric', 'None', '1', 25, 1, 4, 1),
(102, 80, 'Sableye', 'Darkness Pokémon', 'Shadow Sneak', '50', 'Fighting', 'None', '2', 21, 2, 7, 1),
(103, 70, 'Fennekin', 'Fox Pokémon', 'Flame Charge', '40', 'Water', 'None', '2', 18, 2, 2, 1),
(104, 100, 'Chandelure', 'Luring Pokémon', 'Shadow Ball', '80', 'Fighting', 'None', '3', 14, 3, 7, 3),
(105, 60, 'Tepig', 'Fire Pig Pokémon', 'Ember', '30', 'Water', 'None', '1', 32, 1, 2, 1),
(106, 90, 'Infernape', 'Flame Pokémon', 'Flamethrower', '90', 'Water', 'None', '3', 20, 3, 2, 3);


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


SHOW TABLES FROM pokemon_db;
SHOW FULL TABLES FROM pokemon_db WHERE TABLE_TYPE LIKE 'VIEW';

SELECT 
    id,
    hp,
    name,
    info,
    attack,
    dammage,
    weak,
    ressis,
    retreat,
    cadsNumberInColletion,
    collection_name,
    type_name,
    stage_name
FROM 
    vw_views_info;




SELECT 
    id,
    hp,
    name,
    info,
    attack,
    dammage,
    weak,
    ressis,
    retreat,
    cadsNumberInColletion,
    collection_name,
    type_name,
    stage_name
FROM 
    pokemon_db.vw_views_info;




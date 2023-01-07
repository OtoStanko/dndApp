CREATE TABLE [charactersTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    image TEXT,
    characterName TEXT,
    characterClass NUMBER,
    characterLevel INTEGER DEFAULT 1,
    FOREIGN KEY(characterClass) REFERENCES [classesTable] (id)
);
CREATE TABLE [classesTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    className TEXT NOT NULL,
    classDescription TEXT NOT NULL
);
CREATE TABLE [featuresTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    featureName TEXT NOT NULL,
    featureDescription TEXT NOT NULL
);

CREATE TABLE [featureConnectionsTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    featureMaxLevel INTEGER NOT NULL,
    featureUsed INTEGER DEFAULT 0,
    featureId INTEGER NOT NULL,
    characterId INTEGER NOT NULL,
    FOREIGN KEY(featureId) REFERENCES [featuresTable] (id),
    FOREIGN KEY(characterId) REFERENCES [charactersTable] (id)
);

INSERT INTO [classesTable] (className, classDescription)
VALUES('Barbarian', 'ARRGHHH!!!!');
INSERT INTO [classesTable] (className, classDescription)
VALUES('Rouge', 'Sneak attack!');
INSERT INTO [classesTable] (className, classDescription)
VALUES('Fighter', 'Hack and slash!');
INSERT INTO [classesTable] (className, classDescription)
VALUES('Wizard', 'Višard!');

INSERT INTO [featuresTable] (featureName, featureDescription)
VALUES('Rage', 'You can rage!');
INSERT INTO [featuresTable] (featureName, featureDescription)
VALUES('Sneak Attack', 'You can sneak attack!');
INSERT INTO [featuresTable] (featureName, featureDescription)
VALUES('Second Wind', 'You can use second wind!');
INSERT INTO [featuresTable] (featureName, featureDescription)
VALUES('Spellcasting', 'You can cast spells!');

INSERT INTO [featureConnectionsTable] (characterId, featureId, featureMaxLevel)
VALUES(1, 1, 3);
INSERT INTO [featureConnectionsTable] (characterId, featureId, featureMaxLevel)
VALUES(1, 2, 3);

INSERT INTO [charactersTable] (characterName, characterClass, characterLevel)
VALUES('TEST', 1, '19' );
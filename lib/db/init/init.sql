CREATE TABLE [charactersTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    image TEXT,
    characterName TEXT NOT NULL,
    characterClass NUMBER NOT NULL,
    characterLevel INTEGER DEFAULT 1,
    FOREIGN KEY(characterClass) REFERENCES [classesTable] (id)
);
CREATE TABLE [classesTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    className TEXT NOT NULL,
    classDescription TEXT,
    classHitDie INTEGER NOT NULL
);
CREATE TABLE [featuresTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    featureName TEXT NOT NULL,
    featureDescription TEXT NOT NULL,
    featureType TEXT NOT NULL,
    featureLevelAcquire INTEGER NOT NULL,
    featurePrimaryClass INTEGER NOT NULL,
    FOREIGN KEY(featurePrimaryClass) REFERENCES [classesTable] (id)
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

-- Mock Data
INSERT INTO [classesTable] (className, classDescription, classHitDie) VALUES ('Barbarian', 'A fierce warrior of primitive background who can enter a battle rage', 12);
INSERT INTO [classesTable] (className, classDescription, classHitDie) VALUES ('Bard', 'An inspiring magician whose power echoes the music of creation', 8);

INSERT INTO [featuresTable] (featureName, featureDescription, featureType, featureLevelAcquire, featurePrimaryClass) VALUES ('Rage', 'In battle, you fight with primal ferocity. On your turn, you can enter a rage as a bonus action.', 'Class Feature', 1, 1);
INSERT INTO [featuresTable] (featureName, featureDescription, featureType, featureLevelAcquire, featurePrimaryClass) VALUES ('Unarmored Defense', 'While you are not wearing armor, your Armor Class equals 10 + your Dexterity modifier + your Constitution modifier.', 'Class Feature', 1, 1);
INSERT INTO [featuresTable] (featureName, featureDescription, featureType, featureLevelAcquire, featurePrimaryClass) VALUES ('Reckless Attack', 'Starting at 2nd level, you can throw aside all concern for defense to attack with fierce desperation. When you make your first attack on your turn, you can decide to attack recklessly. Doing so gives you advantage on melee weapon attack rolls using Strength during this turn, but attack rolls against you have advantage until your next turn.', 'Class Feature', 2, 1);

INSERT INTO [featuresTable] (featureName, featureDescription, featureType, featureLevelAcquire, featurePrimaryClass) VALUES ('Bardic Inspiration', 'You can inspire others through stirring words or music. To do so, you use a bonus action on your turn to choose one creature other than yourself within 60 feet of you who can hear you. That creature gains one Bardic Inspiration die, a d6.', 'Class Feature', 1, 2);

INSERT INTO [charactersTable] (characterName, characterClass, characterLevel) VALUES ('Test Barbarian', 1, 1);
INSERT INTO [charactersTable] (characterName, characterClass, characterLevel) VALUES ('Test Bard', 2, 1);

INSERT INTO [featureConnectionsTable] (featureMaxLevel, featureId, characterId) VALUES (1, 1, 1);
INSERT INTO [featureConnectionsTable] (featureMaxLevel, featureId, characterId) VALUES (1, 2, 1);
INSERT INTO [featureConnectionsTable] (featureMaxLevel, featureId, characterId) VALUES (1, 3, 1);
INSERT INTO [featureConnectionsTable] (featureMaxLevel, featureId, characterId) VALUES (1, 4, 2);

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

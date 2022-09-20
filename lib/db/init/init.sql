CREATE TABLE [charactersTable] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    iconPath TEXT,
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
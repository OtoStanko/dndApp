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
INSERT INTO [classesTable] (className, classDescription)
VALUES('Barbarian', 'ARRGHHH!!!!');
INSERT INTO [classesTable] (className, classDescription)
VALUES('Rouge', 'Sneak attack!');
INSERT INTO [classesTable] (className, classDescription)
VALUES('Fighter', 'Hack and slash!');
INSERT INTO [classesTable] (className, classDescription)
VALUES('Wizard', 'Višard!');


INSERT INTO [charactersTable] (iconPath, characterName, characterClass, characterLevel) VALUES('/data/user/0/com.example.firstapp/cache/image_picker4117592116842250004.jpg', 'TEST', 1, '19')
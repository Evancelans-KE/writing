--
-- File generated with SQLiteStudio v3.3.3 on Sat Feb 19 20:56:40 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: funnytables
DROP TABLE IF EXISTS funnytables;

CREATE TABLE funnytables (
    id    INT (15)     PRIMARY KEY,
    meme  STRING (255),
    funny STRING (255) 
);

INSERT INTO funnytables (
                            id,
                            meme,
                            funny
                        )
                        VALUES (
                            1,
                            'funny',
                            'lol'
                        );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;

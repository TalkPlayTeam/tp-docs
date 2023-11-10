CREATE DATABASE IF NOT EXISTS TalkPlay;

DROP TABLE IF EXISTS TalkPlay.social;   
DROP TABLE IF EXISTS TalkPlay.notification;
DROP TABLE IF EXISTS TalkPlay.rePost;
DROP TABLE IF EXISTS TalkPlay.likePost;
DROP TABLE IF EXISTS TalkPlay.post;
DROP TABLE IF EXISTS TalkPlay.organise;
DROP TABLE IF EXISTS TalkPlay.event;
DROP TABLE IF EXISTS TalkPlay.recurrence;
DROP TABLE IF EXISTS TalkPlay.downloadLinks;
DROP TABLE IF EXISTS TalkPlay.play;
DROP TABLE IF EXISTS TalkPlay.hideGame;
DROP TABLE IF EXISTS TalkPlay.followGame;
DROP TABLE IF EXISTS TalkPlay.followStudio;
DROP TABLE IF EXISTS TalkPlay.reaction;
DROP TABLE IF EXISTS TalkPlay.message;
DROP TABLE IF EXISTS TalkPlay.partOf;
DROP TABLE IF EXISTS TalkPlay.group;
DROP TABLE IF EXISTS TalkPlay.game;
DROP TABLE IF EXISTS TalkPlay.studio;
DROP TABLE IF EXISTS TalkPlay.friends;
DROP TABLE IF EXISTS TalkPlay.followUser;
DROP TABLE IF EXISTS TalkPlay.user;



CREATE TABLE IF NOT EXISTS TalkPlay.user (
    idUser INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    username VARCHAR(42) UNIQUE,
    displayName VARCHAR(42),
    email VARCHAR(42) UNIQUE,
    password VARCHAR(110),
    dateSignUp DATETIME,
    about VARCHAR(255),
    private BOOLEAN,
    logo VARCHAR(255),
    banner VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS TalkPlay.followUser (
    idUser INT NOT NULL,
    idUserFollow INT NOT NULL,
    PRIMARY KEY (idUser, idUserFollow),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idUserFollow) REFERENCES user(idUser)
);


CREATE TABLE IF NOT EXISTS TalkPlay.friends (
    idUser INT NOT NULL,
    idUserFriend INT NOT NULL,
    PRIMARY KEY (idUser, idUserFriend),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idUserFriend) REFERENCES user(idUser)
);


CREATE TABLE IF NOT EXISTS TalkPlay.studio (
    idStudio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(42) UNIQUE,
    description VARCHAR(255),
    logo VARCHAR(255),
    banner VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS TalkPlay.game (
    idGame INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(42) UNIQUE,
    description VARCHAR(255),
    logo VARCHAR(255),
    banner VARCHAR(255),
    dateRelease DATETIME,
    platform VARCHAR(42)
);

CREATE TABLE IF NOT EXISTS TalkPlay.group (
    idGroup INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(42),
    about VARCHAR(255),
    auto BOOLEAN,
    idUser INT NOT NULL,
    idGame INT,
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idGame) REFERENCES game(idGame)
);

CREATE TABLE IF NOT EXISTS TalkPlay.partOf (
    idUser INT NOT NULL,
    idGroup INT NOT NULL,
    PRIMARY KEY (idUser, idGroup),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idGroup) REFERENCES `group`(idGroup)
);


CREATE TABLE IF NOT EXISTS TalkPlay.message (
    idMessage INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idUser INT NOT NULL,
    idGroup INT NOT NULL,
    content VARCHAR(255),
    date DATETIME,
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idGroup) REFERENCES `group`(idGroup)
);

CREATE TABLE IF NOT EXISTS TalkPlay.reaction (
    type VARCHAR(42),
    idUser INT NOT NULL,
    idMessage INT NOT NULL,
    PRIMARY KEY (type, idUser, idMessage),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idMessage) REFERENCES message(idMessage)
);

CREATE TABLE IF NOT EXISTS TalkPlay.followStudio (
    idUser INT NOT NULL,
    idStudio INT NOT NULL,
    PRIMARY KEY (idUser, idStudio),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idStudio) REFERENCES studio(idStudio)
);

CREATE TABLE IF NOT EXISTS TalkPlay.followGame (
    idUser INT NOT NULL,
    idGame INT NOT NULL,
    PRIMARY KEY (idUser, idGame),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idGame) REFERENCES game(idGame)
);


CREATE TABLE IF NOT EXISTS TalkPlay.hideGame (
    idUser INT NOT NULL,
    idGame INT NOT NULL,
    PRIMARY KEY (idUser, idGame),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idGame) REFERENCES game(idGame)
);

CREATE TABLE IF NOT EXISTS TalkPlay.play (
    idUser INT NOT NULL,
    idGame INT NOT NULL,
    pseudo VARCHAR(42),
    PRIMARY KEY (idUser, idGame),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idGame) REFERENCES game(idGame)
);


CREATE TABLE IF NOT EXISTS TalkPlay.downloadLinks (
    idLink INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idGame INT NOT NULL,
    ios VARCHAR(255),
    android VARCHAR(255),
    -- huawei VARCHAR(255),
    pc VARCHAR(255),
    FOREIGN KEY (idGame) REFERENCES game(idGame)
);

CREATE TABLE IF NOT EXISTS TalkPlay.recurrence (
    idRecurrence INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    dateStart DATETIME,
    dateEnd DATETIME,
    day VARCHAR(42),
    week VARCHAR(42),
    month VARCHAR(42),
    year VARCHAR(42)
);

CREATE TABLE IF NOT EXISTS TalkPlay.event (
    idEvent INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idRecurrence INT,
    name VARCHAR(42),
    description VARCHAR(255),
    dateStart DATETIME,
    dateEnd DATETIME,
    logo VARCHAR(255),
    banner VARCHAR(255),
    FOREIGN KEY (idRecurrence) REFERENCES recurrence(idRecurrence)
);

CREATE TABLE IF NOT EXISTS TalkPlay.organise (
    idGame INT NOT NULL,
    idEvent INT NOT NULL,
    PRIMARY KEY (idGame, idEvent),
    FOREIGN KEY (idGame) REFERENCES game(idGame),
    FOREIGN KEY (idEvent) REFERENCES event(idEvent)
);

CREATE TABLE IF NOT EXISTS TalkPlay.post (
    idPost INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idUser INT NOT NULL,
    idGame INT,
    content VARCHAR(255),
    file VARCHAR(255),
    date DATETIME,
    repPost INT,
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    -- FOREIGN KEY (idGame) REFERENCES game(idGame)
    FOREIGN KEY (repPost) REFERENCES post(idPost)
);

CREATE TABLE IF NOT EXISTS TalkPlay.likePost (
    idUser INT NOT NULL,
    idPost INT NOT NULL,
    PRIMARY KEY (idUser, idPost),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idPost) REFERENCES post(idPost)
);

CREATE TABLE IF NOT EXISTS TalkPlay.rePost (
    idUser INT NOT NULL,
    idPost INT NOT NULL,
    PRIMARY KEY (idUser, idPost),
    FOREIGN KEY (idUser) REFERENCES user(idUser),
    FOREIGN KEY (idPost) REFERENCES post(idPost)
);

CREATE TABLE IF NOT EXISTS TalkPlay.notification (
    idNotification INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idUser INT NOT NULL,
    content VARCHAR(255),
    date DATETIME,
    `read` TINYINT(1),
    FOREIGN KEY (idUser) REFERENCES `user`(idUser)
);

CREATE TABLE IF NOT EXISTS TalkPlay.social (
    idSocial INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    type VARCHAR(42),
    websiteLink VARCHAR(255),
    discord VARCHAR(255),
    twitter VARCHAR(255),
    instagram VARCHAR(255),
    tiktok VARCHAR(255),
    twitch VARCHAR(255),
    id INT NOT NULL
);


CREATE USER IF NOT EXISTS 'adminTalkPlay'@'localhost' IDENTIFIED BY 'g9hry3CajGBQNjm?';
GRANT SELECT, INSERT, UPDATE, DELETE ON `TalkPlay`.* TO 'adminTalkPlay'@'localhost';
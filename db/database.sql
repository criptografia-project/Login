CREATE DATABASE IF NOT EXISTS Ident;
use Ident;

CREATE TABLE IF NOT EXISTS users (

    id INT(10) unsigned NOT NULL AUTO_INCREMENT,
    uname VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
    surname VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
    email VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
    passw VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(id),
    INDEX(id)
) ENGINE=InnoDB DEFAULT CHARACTER SET = utf8;
DESCRIBE users;

CREATE TABLE IF NOT EXISTS passengers (

    id INT(10) unsigned NOT NULL AUTO_INCREMENT,
    id_user INT(10) unsigned NOT NULL,
    birthdate DATE NOT NULL,
    email VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
    phone VARCHAR(16) COLLATE utf8_unicode_ci NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (id_user)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARACTER SET = utf8;

DESCRIBE passengers;

CREATE TABLE IF NOT EXISTS crew (

    id INT(10) unsigned NOT NULL AUTO_INCREMENT,
    id_user INT(10) unsigned NOT NULL,
    dependence VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    INDEX(id),
    PRIMARY KEY(id),
    FOREIGN KEY (id_user)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARACTER SET = utf8;

DESCRIBE crew;

ALTER USER 'mysql'@'%' IDENTIFIED WITH mysql_native_password BY '1234';
FLUSH PRIVILEGES;

INSERT INTO users (uname, surname, email, passw)
VALUES
    ("David Arturo", "Mendez", "darturovela@gmail.com" ,"7bb49eecce79a190494fed8f42acb928"),
    ("Laura Sofia", "Velandia", "lsofiavela@gmail.com" ,"188478bbbbb6aaa4551477b1359dfeeb"),
    ("Samuel Camilo", "Torres", "sacamiloto@gmail.com" ,"$2y$10$B0j7MSVBdehRapbxoBicj.7BrLSTp.LpyHcOzMSxWmETHz3Sl4zDm"),
    ("Saray", "Fonseca", "saraseca@gmail.com" ,"$2y$10$B0j7MSVBdehRapbxoBicj.7BrLSTp.LpyHcOzMSxWmETHz3Sl4zDm"),
    ("Sara Sofia", "Novoa", "saravoa@gmail.com" ,"$2y$10$B0j7MSVBdehRapbxoBicj.7BrLSTp.LpyHcOzMSxWmETHz3Sl4zDm"),
    ("Mickey", "Dysney", "mickney@gmail.com" ,"$2y$10$KnkxGY6wBWGH8wz/OObLrOqBru34Kfb/Gs8iBhiqBuujG5LcQjZs6"),
    ("Daniela Maria", "Ruiz", "damaruiz@gmail.com" ,"$2y$10$KnkxGY6wBWGH8wz/OObLrOqBru34Kfb/Gs8iBhiqBuujG5LcQjZs6"),
    ("Luisa Fernanda", "Rodriguez", "luiferro@gmail.com" ,"$2y$10$KnkxGY6wBWGH8wz/OObLrOqBru34Kfb/Gs8iBhiqBuujG5LcQjZs6"),
    ("Andres Felipe", "Ramirez", "anframirezal@gmail.com" ,"$2y$10$KnkxGY6wBWGH8wz/OObLrOqBru34Kfb/Gs8iBhiqBuujG5LcQjZs6"),
    ("Ximena Penelope", "Fonseca", "ximepenefo@gmail.com" ,"$2y$10$KnkxGY6wBWGH8wz/OObLrOqBru34Kfb/Gs8iBhiqBuujG5LcQjZs6");

    INSERT INTO passengers (id_user, birthdate, email, phone)
VALUES
    (1, "1990-12-15 12:00:00", "darturovela@gmail.com", "3158302787"),
    (2, "1987-03-01 12:00:00", "lsofiavela@gmail.com", "3143752255"),
    (3, "1995-02-21 12:00:00","sacamiloto@gmail.com", "3102579249"),
    (4, "1977-08-11 12:00:00","saraseca@gmail.com", "3138611109"),
    (5, "2014-03-01 12:00:00","saravoa@gmail.com", "3013778966");


INSERT INTO crew (id_user, dependence)
VALUES
    (6, "Restaurant"),
    (7, "Store"),
    (8, "Laundry"),
    (9, "Security"),
    (10, "Logistics");
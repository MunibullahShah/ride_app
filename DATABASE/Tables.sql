CREATE TABLE IF NOT EXISTS ranks (
    ID INT(2) PRIMARY KEY,
    Name VARCHAR(30) UNIQUE NOT NULL
);

INSERT IGNORE INTO ranks (id, name) VALUES (0,'Employee'),(1,'Manager'),(2,'Owner'),(3,'Administrator');

CREATE TABLE IF NOT EXISTS users (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(35) NOT NULL,
    Password VARCHAR(128) NOT NULL,
    Email VARCHAR(50),
    ContactNo VARCHAR(15) NOT NULL,
    Rank INT(2) default '0',
    FOREIGN KEY (Rank) REFERENCES ranks (ID) ON UPDATE CASCADE
);

INSERT IGNORE INTO  users (ID,Name,Password,Email,ContactNo,Address,Rank) VALUE (0,'Arose Niazi','71CD76C3E9C101B44DE6603E7EEEBF951D06BD7E701AAE78A9209976548421121130A9599433CE57110729E9498E8596A7E05B9CA07B246EBC0FAABFEC8E1865','arose.niazi@yahoo.com','0315-2033333',3);

CREATE TABLE IF NOT EXISTS logs (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    User INT,
    Details VARCHAR(200),
    Rank INT(2),
    FOREIGN KEY (User) REFERENCES users (ID) ON UPDATE CASCADE ,
    FOREIGN KEY (Rank) REFERENCES ranks (ID) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS seasons (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Year INT(4),
    Season INT(1) CHECK (Season > 0 AND Season < 10)
); 

INSERT IGNORE INTO seasons (Year, Season) VALUES (YEAR(CURRENT_DATE),1);

CREATE TABLE IF NOT EXISTS parties (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    ContactNo VARCHAR(13),
    Address VARCHAR(100)
);

# INSERT IGNORE INTO parties (Name) VALUE ('Previous Stock');

CREATE TABLE IF NOT EXISTS product_type (
    Name VARCHAR(20) PRIMARY KEY
);

# INSERT IGNORE INTO product_type (Name) VALUES ('Cotton Seed'),('Mung Bean');

CREATE TABLE IF NOT EXISTS varieties (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Type VARCHAR(20) NOT NULL,
    Name VARCHAR(20),
    Size VARCHAR(20),
    Rate INT,
    UNIQUE INDEX (Name,Size),
    FOREIGN KEY (Type) REFERENCES product_type (Name) ON UPDATE CASCADE
);

# INSERT IGNORE INTO varieties (Type, Name, Size, Rate) VALUES ('Cotton Seed','SS-32','5 KG', 1500),('Mung Bean', 'NM-11', '10 KG', 2800);

CREATE TABLE IF NOT EXISTS stock (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Season INT NOT NULL,
    DATE DATE,
    Party INT NOT NULL,
    Variety INT NOT NULL,
    Quantity INT NOT NULL,
    Price INT,
    Expiry DATE,
    FOREIGN KEY (Season) REFERENCES seasons (ID) ON UPDATE CASCADE ,
    FOREIGN KEY (Party) REFERENCES parties (ID) ON UPDATE CASCADE ,
    FOREIGN KEY (Variety) REFERENCES varieties (ID) ON UPDATE CASCADE
);

# INSERT IGNORE INTO stock (Season, DATE, Party, Variety, Quantity, Price, Expiry)
# VALUES (1,CURRENT_DATE,'Previous Stock',1,1000,1000, '2021-5-17'),
#       (1,CURRENT_DATE,'Previous Stock',2,500,2500, '2021-5-17'),
#       (1,CURRENT_DATE,'Previous Stock',2,100,2350, '2021-5-17');

CREATE TABLE IF NOT EXISTS sale (
    Season INT NOT NULL,
    ID INT AUTO_INCREMENT PRIMARY KEY ,
    Name VARCHAR(35) NOT NULL,
    Address VARCHAR(256),
    Date DATE,
    ContactNo VARCHAR(13),
    Paid BOOLEAN,
    returnOf INT NULL,
    FOREIGN KEY (Season) REFERENCES seasons (ID) ON UPDATE CASCADE,
    FOREIGN KEY (returnOf) REFERENCES sale (ID) ON UPDATE CASCADE
);

# INSERT IGNORE INTO sale (Season, Name, Address, Date, ContactNo, Paid) VALUES (1,'Arose Niazi','Lahore Askari', CURRENT_DATE,'0315-2033333',true);

CREATE TABLE IF NOT EXISTS sold (
    Sale INT,
    Stock INT,
    Quantity INT,
    Rate FLOAT,
    PRIMARY KEY (Sale,Stock,Rate),
    FOREIGN KEY (Sale) REFERENCES sale (ID) ON UPDATE CASCADE ,
    FOREIGN KEY (Stock) REFERENCES stock(ID) ON UPDATE CASCADE
);

# INSERT IGNORE INTO sold (Sale, Stock, Quantity, Rate) VALUES (1,1,20,1400);


CREATE TABLE IF NOT EXISTS expenses (
    Season INT NOT NULL,
    ID INT AUTO_INCREMENT PRIMARY KEY ,
    Type VARCHAR(50) NOT NULL,
    Party INT,
    Date DATE,
    Amount INT DEFAULT '0',
    Description VARCHAR(128),
    FOREIGN KEY (Season) REFERENCES seasons (ID) ON UPDATE CASCADE,
    FOREIGN KEY (Party) REFERENCES parties (ID) ON UPDATE CASCADE
);

# INSERT IGNORE INTO expenses (Season, Type, Date, Amount) VALUES (1, 'Refreshments', CURRENT_DATE, '100');

CREATE TABLE IF NOT EXISTS payments (
    Season INT NOT NULL,
    ID INT UNSIGNED,
    Date DATE,
    Bank VARCHAR(30) NOT NULL ,
    Account VARCHAR(50),
    Amount INT NOT NULL,
    Description VARCHAR(128),
    FOREIGN KEY (Season) REFERENCES seasons (ID) ON UPDATE CASCADE
);

# INSERT IGNORE INTO payments (Season, ID, Date, Bank, Account, Amount) VALUES (1,2039,CURRENT_DATE,'HBL', 'Afraz Khan', 1000);

CREATE TABLE Books (
    ISBN VARCHAR (50) PRIMARY KEY,
    Title VARCHAR (40),
    Year INT
);

CREATE TABLE Author (
    Author_ID INT PRIMARY KEY,
    Full_name VARCHAR (50)
);

CREATE TABLE Authorship (
    ISBN_Book  VARCHAR (50),
    Author_ID  INT,
    PRIMARY KEY (ISBN_Book, Author_ID),
    FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID),
    FOREIGN KEY (ISBN_Book) REFERENCES Books(ISBN)
);

CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Reader_ID INT ,
    Book_ISBN VARCHAR (50),
    Issue_date DATE,
    Planned_return_date DATE,
    Actual_return_date DATE NULL,

    FOREIGN KEY (Reader_ID) REFERENCES Readers(Card_number),
    FOREIGN KEY (Book_ISBN) REFERENCES Books(ISBN)
);

CREATE TABLE Readers (
    Card_number INT PRIMARY KEY,
    Full_name VARCHAR (50),
    Phone VARCHAR (11)
);

INSERT INTO Readers (Card_number, Full_name, Phone)
VALUES
(1, 'Анна Соколова', '79001112233'),
(2, 'Иван Соколов', '79002223344'),
(3, 'Мария Ким', '79003334455'),
(4, 'Олег Васильев', '79004445566');

INSERT INTO Author (Author_ID, Full_name)
VALUES
    (1, 'Михаил Булгаков'),
    (2, 'Федор Достоевский'),
    (3, 'Лев Толстой'),
    (4, 'Илья Ильф'),
    (5, 'Евгений Петров'),
    (6, 'Аркадий Стругацкий'),
    (7, 'Борис Стругацкий');

INSERT INTO Books (ISBN, Title, Year)
VALUES
    ('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
    ('978-5-389-06256-6', 'Преступление и наказание', 1866),
    ('978-5-04-116716-3', 'Война и мир', 1869),
    ('978-5-699-12014-7', 'Золотой теленок', 1931),
    ('978-5-389-03713-7', 'Пикник на обочине', 1972);

INSERT INTO Authorship (ISBN_Book, Author_ID)
VALUES
    ('978-5-17-118366-8', 1),
    ('978-5-389-06256-6', 2),
    ('978-5-04-116716-3', 3),
    ('978-5-699-12014-7', 4),
    ('978-5-699-12014-7', 5),
    ('978-5-389-03713-7', 6),
    ('978-5-389-03713-7', 7);

INSERT INTO Loan
    (Loan_ID, Reader_ID, Book_ISBN, Issue_date, Planned_return_date, Actual_return_date)
VALUES
    (1, 1, '978-5-17-118366-8', '2026-09-01', '2026-09-15', NULL),
    (2, 1, '978-5-389-06256-6', '2026-09-05', '2026-09-19', NULL),
    (3, 2, '978-5-04-116716-3', '2026-08-01', '2026-08-15', '2026-08-14'),
    (4, 3, '978-5-699-12014-7', '2026-08-10', '2026-08-24', '2026-08-23'),
    (5, 4, '978-5-389-03713-7', '2026-09-10', '2026-09-24', NULL),
    (6, 2, '978-5-17-118366-8', '2026-07-01', '2026-07-15', '2026-07-14');

-- Практика 3-5

UPDATE Readers
SET Phone = '79009999999'
WHERE Card_number = 1;

UPDATE Loan
SET Actual_return_date = '2026-09-20'
WHERE Loan_ID = 1;

INSERT INTO Readers (Card_number, Full_name, Phone)
VALUES (5, 'Тестовый читатель', '79005555555');

DELETE FROM Readers
WHERE Card_number = 5;

DELETE FROM Readers

-- Практика 7

SELECT *
FROM Readers;
SELECT Title, Year
FROM Books;
SELECT Title, Year
FROM Books
WHERE Year BETWEEN 1801 AND 1900;
SELECT Title, Year
FROM Books
WHERE Year BETWEEN 1917 AND 1991;
SELECT *
FROM Readers
WHERE Phone = '+7-900-111-22-33';
SELECT *
FROM Readers
WHERE Full_name LIKE '%ов%';
SELECT *
FROM Loan
WHERE Actual_return_date IS NULL;
SELECT *
FROM Books
ORDER BY Title;
SELECT *
FROM Loan
WHERE Actual_return_date IS NULL
ORDER BY Planned_return_date ASC;
SELECT *
FROM Books
ORDER BY Year DESC
LIMIT 3;

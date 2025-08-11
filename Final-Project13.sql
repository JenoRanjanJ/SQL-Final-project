DROP DATABASE library_db;
CREATE DATABASE library_db;
USE library_db;


CREATE TABLE books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL
);

CREATE TABLE members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE borrows (
  id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  borrow_date DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO books (title, author) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald'),
('To Kill a Mockingbird', 'Harper Lee'),
('1984', 'George Orwell');

INSERT INTO members (name) VALUES
('Alice Johnson'),
('Bob Smith'),
('Charlie Brown');

INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(2, 2, '2025-08-02', NULL),
(3, 3, '2025-08-03', '2025-08-10'),
(1, 2, '2025-08-05', NULL);

SELECT b.id AS borrow_id, m.name AS member_name, bk.title AS book_title, b.borrow_date, b.return_date
FROM borrows b
JOIN members m ON b.member_id = m.id
JOIN books bk ON b.book_id = bk.id
ORDER BY b.borrow_date;

SELECT b.id AS borrow_id, m.name AS member_name, bk.title AS book_title,
DATEDIFF(CURDATE(), b.borrow_date) AS days_borrowed,
CASE 
  WHEN b.return_date IS NULL AND DATEDIFF(CURDATE(), b.borrow_date) > 7 THEN (DATEDIFF(CURDATE(), b.borrow_date) - 7) * 5
  ELSE 0
END AS fine_amount
FROM borrows b
JOIN members m ON b.member_id = m.id
JOIN books bk ON b.book_id = bk.id
ORDER BY fine_amount DESC;

CREATE INDEX idx_borrows_member ON borrows(member_id);
CREATE INDEX idx_borrows_book ON borrows(book_id);

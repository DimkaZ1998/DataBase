CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    duration_min INT CHECK (duration_min > 0),
    ticket_price NUMERIC(10, 2) DEFAULT 0.00,
    rating VARCHAR(10),
    is_3d BOOLEAN DEFAULT FALSE,
    release_date DATE
);

INSERT INTO movies (title, genre, duration_min, ticket_price, rating, is_3d, release_date) VALUES
('Интерстеллар', 'Фантастика', 169, 500.00, '12+', FALSE, '2014-11-06'),
('Бегущий по лезвию 2049', 'Фантастика', 164, 600.00, '16+', TRUE, '2017-10-05'),
('Мстители: Финал', 'Боевик', 181, 700.00, '12+', TRUE, '2019-04-24'),
('Король Лев', 'Мультфильм', 118, 350.00, '0+', FALSE, '2019-07-19'),
('Пираты Карибского моря', 'Боевик', 143, 550.00, '12+', FALSE, '2003-07-09'),
('Тайна Коко', 'Мультфильм', 105, 400.00, '0+', FALSE, '2017-11-22');

UPDATE movies
SET ticket_price = ticket_price + 50
WHERE genre = 'Фантастика';

DELETE FROM movies WHERE id = 3;

UPDATE movies
SET rating = '16+'
WHERE title = 'Интерстеллар';

SELECT title, ticket_price
FROM movies
WHERE duration_min > 120;

SELECT title, ticket_price
FROM movies
ORDER BY ticket_price ASC;

SELECT COUNT(*) AS total_films
FROM movies;

SELECT AVG(ticket_price) AS avg_price
FROM movies;

SELECT genre, COUNT(*) AS count_per_genre
FROM movies
GROUP BY genre;

SELECT genre, AVG(ticket_price) AS avg_price
FROM movies
GROUP BY genre
HAVING AVG(ticket_price) > 350;
-- Active: 1720909435626@@127.0.0.1@5432@examensql_solange_benitez_saavedra_444
-- 1. Revisa el tipo de relación y crea el modelo correspondiente. Respeta las claves primarias, foráneas y tipos de datos.

-- Crea tabla Peliculas
CREATE TABLE Peliculas (
    id INTEGER,
    nombre VARCHAR(255),
    anno INTEGER,
    PRIMARY KEY (id)
);

-- Crea tabla Tags.
CREATE TABLE Tags (
    id INTEGER,
    tag VARCHAR(32),
    PRIMARY KEY (id)
);

-- Creación tabla intermedia.
CREATE TABLE Peliculas_Tags (
    pelicula_id INTEGER,
    tag_id INTEGER,
    FOREIGN KEY (pelicula_id) REFERENCES Peliculas(id),
    FOREIGN KEY (tag_id) REFERENCES Tags(id),
    PRIMARY KEY (pelicula_id, tag_id)
);

-- 2.Inserta 5 películas y 5 tags; la primera película debe tener 3 tags asociados, la segunda película debe tener 2 tags asociados.
-- Inserta Peliculas.
INSERT INTO Peliculas (id, nombre, anno) VALUES 
  (1, 'The Lost Boys', 1987), 
  (2, 'La Boda de mi Mejor Amigo', 1997),
  (3, 'Star Wars Episodio IV: Una nueva esperanza', 1977),
  (4, 'Love Rosie', 2014),
  (5, 'Orgullo y Prejuicio', 2005);

  SELECT * FROM Peliculas;

-- Inserta Tags.
INSERT INTO Tags (id, tag) VALUES 
  (1, 'Comedia negra'),
  (2, 'Sobrenatural'),
  (3, 'Terror'),
  (4, 'Comedia'),
  (5, 'Romance');

SELECT * FROM Tags;


INSERT INTO Peliculas_Tags (pelicula_id, tag_id,) VALUES
  (1, 1), 
  (1, 2), 
  (1, 3), 
  (2, 4), 
  (2, 5); 

SELECT * FROM Peliculas_Tags;

-- 3.Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.
SELECT p.nombre AS pelicula, COUNT(pt.tag_id) AS cantidad_tags
FROM Peliculas p
LEFT JOIN Peliculas_Tags pt ON p.id = pt.pelicula_id
GROUP BY p.id;

-- 4. Crea las tablas correspondientes respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.
-- Creación tabla preguntas.
CREATE TABLE Preguntas (
id INTEGER,
pregunta VARCHAR(255),
respuesta_correcta VARCHAR,
PRIMARY KEY (id)
);

-- Creación tabla Usuarios.
CREATE TABLE Usuarios (
id INTEGER, 
nombre VARCHAR(255) NOT NULL,
edad INTEGER,
PRIMARY KEY (id)
);

-- Creación tabla Respuestas.
CREATE TABLE Respuestas (
id INTEGER,
respuesta VARCHAR(255),
usuario_id INTEGER,
pregunta_id INTEGER,
FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE,
FOREIGN KEY (pregunta_id) REFERENCES Preguntas(id) ON DELETE CASCADE,
PRIMARY KEY (id)
);

-- 5. Agrega 5 usuarios y 5 preguntas. 
INSERT INTO Usuarios (id, nombre, edad) VALUES 
  (1, 'Macarena Torres', 25),
  (2, 'Francisco Villalba', 30),
  (3, 'Klaus Sweezermann', 22),
  (4, 'Lía Arrigorriaga', 27),
  (5, 'Juan Pérez', 20);

  SELECT * FROM Usuarios;

INSERT INTO Preguntas (id, pregunta, respuesta_correcta ) VALUES 
  (1, '¿Quiénes son los principales Jedis de Star Wars?', 'Yoda, Obi-Wan, Luke'),
  (2, '¿Quién es la hermana de Luke?', 'Leia'),
  (3, '¿En qué lugar se desarrolla la Trama de The Lost Boys?', 'Santa Mónica'),
  (4, '¿Qué postres se utilizan para comparar la elección romántica del protagonista masculino?', 'Jalea y Cream Brulee'),
  (5, '¿Se queda la mejor amiga como esposa del novio?', 'No');

SELECT * FROM Preguntas;

-- a. La primera pregunta debe estar respondida correctamente dos veces, por dos usuarios diferentes.
-- b. La segunda pregunta debe estar contestada correctamente solo por un usuario.
-- c. Las otras tres preguntas deben tener respuestas incorrectas.
-- Contestada correctamente significa que la respuesta indicada en la tabla respuestas es exactamente igual al texto indicado en la tabla de preguntas.

INSERT INTO Respuestas (id, pregunta_id , usuario_id, respuesta) VALUES 
  (1, 1, 1, 'Yoda, Obi-Wan, Luke'),  
  (2, 1, 2, 'Yoda, Obi-Wan, Luke'),  
  (3, 2, 3, 'Leia'),                 
  (4, 3, 4, 'New York'),            
  (5, 4, 5, 'Se queda soltero y se exilia'); 

SELECT * FROM Respuestas;


--6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta).
 
SELECT u.id AS usuario_id, COUNT(r.id) AS "Cantidad de Respuestas Correctas"
FROM Respuestas r
JOIN Usuarios u ON r.usuario_id = u.id
JOIN Preguntas p ON r.pregunta_id = p.id
WHERE r.respuesta = p.respuesta_correcta
GROUP BY u.id, u.nombre;


--7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios respondieron correctamente.
SELECT p.id AS pregunta_id, p.pregunta, COUNT(r.usuario_id) AS "Usuarios Responden Correctamente"
FROM Preguntas p 
LEFT JOIN Respuestas r ON p.id = r.pregunta_id 
WHERE r.respuesta = p.respuesta_correcta 
GROUP BY p.id, p.pregunta
ORDER BY "Usuarios Responden Correctamente" DESC;

-- 8. Implementa un borrado en cascada de las respuestas al borrar un usuario. Prueba la implementación borrando el primer usuario.
DELETE FROM Usuarios WHERE id = 1;
Select * From usuarios;
Select * From respuestas;

-- 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.
ALTER TABLE Usuarios
ADD CONSTRAINT check_edad_mayor_18
CHECK (edad >= 18);

INSERT INTO Usuarios (id, nombre, edad) VALUES (6, 'Amparo Torres', 14);


-- 10. Altera la tabla existente de usuarios agregando el campo email. Debe tener la restricción de ser único.
ALTER TABLE Usuarios
ADD COLUMN email VARCHAR(255) UNIQUE;

SELECT * FROM Usuarios;

 
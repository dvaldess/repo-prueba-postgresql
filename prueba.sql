-- Creacion Base de Datos

CREATE DATABASE biblioteca;

\c biblioteca

-- Creacion Tabla

CREATE TABLE libros(
    id SERIAL,
    isbn VARCHAR(15) NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    numero_pagina INT NOT NULL,
    dia_prestamo INT NOT NULL,
    PRIMARY KEY(id)
);

-- Carga Datos

INSERT INTO libros (isbn,titulo,numero_pagina,dia_prestamo) VALUES ('111-1111111-111','CUENTOS DE TERROR',344,7);
INSERT INTO libros (isbn,titulo,numero_pagina,dia_prestamo) VALUES ('222-2222222-222','POESIAS CONTEMPORANES',167,7);
INSERT INTO libros (isbn,titulo,numero_pagina,dia_prestamo) VALUES ('333-3333333-333','HISTORIA DE ASIA',511,14);
INSERT INTO libros (isbn,titulo,numero_pagina,dia_prestamo) VALUES ('444-4444444-444','MANUAL DE MECANICA',298,14);

-- Creacion Tabla

CREATE TABLE autores(
    id SERIAL,
    nombre_autor VARCHAR(255) NOT NULL,
    apellido_autor VARCHAR(255) NOT NULL,
    fecha_nacimiento_autor INT NOT NULL,
    fecha_muerte_autor INT,
    tipo_autor VARCHAR(9) NOT NULL,
    PRIMARY KEY(id)
);

-- Carga Datos

INSERT INTO autores (nombre_autor,apellido_autor,fecha_nacimiento_autor,fecha_muerte_autor,tipo_autor) VALUES ('JOSE','SALGADO',1968,2020,'PRINCIPAL');
INSERT INTO autores (nombre_autor,apellido_autor,fecha_nacimiento_autor,tipo_autor) VALUES ('ANA','SALGADO',1972,'COAUTOR');
INSERT INTO autores (nombre_autor,apellido_autor,fecha_nacimiento_autor,tipo_autor) VALUES ('ANDRES','ULLOA',1982,'PRINCIPAL');
INSERT INTO autores (nombre_autor,apellido_autor,fecha_nacimiento_autor,fecha_muerte_autor,tipo_autor) VALUES ('SERGIO','MARDONES',1950,2012,'PRINCIPAL');
INSERT INTO autores (nombre_autor,apellido_autor,fecha_nacimiento_autor,tipo_autor) VALUES ('MARTIN','PORTA',1976,'PRINCIPAL');

-- Creacion Tabla

CREATE TABLE socios(
    id SERIAL,
    rut INT UNIQUE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono INT NOT NULL,
    PRIMARY KEY(id)
);

-- Carga Datos

INSERT INTO socios (rut,nombre,apellido,direccion,telefono) VALUES (1111111,'JUAN','SOTO','AVENIDA 1, SANTIAGO',911111111);
INSERT INTO socios (rut,nombre,apellido,direccion,telefono) VALUES (2222222,'ANA','PEREZ','PASAJE 2, SANTIAGO',922222222);
INSERT INTO socios (rut,nombre,apellido,direccion,telefono) VALUES (3333333,'SANDRA','AGUILAR','AVENIDA 2, SANTIAGO',933333333);
INSERT INTO socios (rut,nombre,apellido,direccion,telefono) VALUES (4444444,'ESTEBAN','JEREZ','AVENIDA 3, SANTIAGO',944444444);
INSERT INTO socios (rut,nombre,apellido,direccion,telefono) VALUES (5555555,'SILVANA','MUNOZ','PASAJE 3, SANTIAGO',955555555);

-- Creacion Tabla

CREATE TABLE prestamos(
    id SERIAL,
    socio_id INT,
    libro_id INT,
    fecha_inicio DATE,
    fecha_devolucion DATE,
    fecha_real_devolucion DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(socio_id) REFERENCES socios(id),
    FOREIGN KEY(libro_id) REFERENCES libros(id)
);

-- Carga Datos

INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (1,1,'2020/01/20','2020/01/27');
INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (5,2,'2020/01/20','2020/01/30');
INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (3,3,'2020/01/22','2020/01/30');
INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (4,4,'2020/01/23','2020/01/30');
INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (2,1,'2020/01/27','2020/02/04');
INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (1,4,'2020/01/31','2020/02/12');
INSERT INTO prestamos (socio_id,libro_id,fecha_inicio,fecha_devolucion) VALUES (3,2,'2020/01/31','2020/02/12');

-- Creacion Tabla

CREATE TABLE tiene(
    autor_id SERIAL,
    libro_id SERIAL,
    FOREIGN KEY(autor_id) REFERENCES autores(id),
    FOREIGN KEY(libro_id) REFERENCES libros(id)
);

-- Validación carga de datos

SELECT * FROM libros;
SELECT * FROM autores;
SELECT * FROM socios;
SELECT * FROM prestamos;
SELECT * FROM tiene;

-- Consultas

-- A)

SELECT isbn,titulo,numero_pagina FROM libros WHERE numero_pagina<300;

-- B)

SELECT nombre_autor, apellido_autor, fecha_nacimiento_autor FROM autores WHERE fecha_nacimiento_autor>=1970;

-- C)

-- Como lograr la consulta, 

-- Primero buscar la información que necesitas

SELECT libro_id, count(*) AS cuantas_veces_solicitado FROM prestamos GROUP BY libro_id HAVING COUNT(*)>1;
SELECT titulo FROM libros INNER JOIN prestamos ON libros.id = prestamos.libro_id;
SELECT libro_id FROM prestamos INNER JOIN libros ON prestamos.libro_id = libros.id;

-- Luego buscar la forma de como poder unir las consultas que necesitaste para lograr lo requerido (buscar en materia los tipos de Join y Subquery)

SELECT id, isbn, titulo FROM (SELECT libro_id, count(*) AS cuantas_veces_solicitado FROM prestamos GROUP BY libro_id HAVING COUNT(*)>1) AS x INNER JOIN libros AS y ON x.libro_id = y.id;
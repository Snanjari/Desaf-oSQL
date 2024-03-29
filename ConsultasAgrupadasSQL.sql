-- Crear base de datos --
CREATE DATABASE desafio2-simon_nanjari-123;
CREATE DATABASE

--Crear tabla --
 CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente
 VARCHAR);
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 44, '01/01/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 56, '01/01/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 39, '01/02/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 81, '01/02/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 12, '01/03/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 91, '01/03/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 48, '01/04/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 45, '01/04/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 55, '01/05/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 33, '01/05/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 18, '01/06/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 12, '01/06/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 34, '01/07/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 24, '01/07/2021', 'Página' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 83, '01/08/2021', 'Blog' );
 INSERT INTO INSCRITOS(cantidad, fecha, fuente)
 VALUES ( 99, '01/08/2021', 'Página' );


--CONSULTAS--

--1 ¿Cuántos registros hay?--
postgres=# SELECT COUNT (*)FROM inscritos;
 count
-------
 16


--2 ¿Cuántos inscritos hay en total?--
postgres=#  SELECT SUM(cantidad) FROM inscritos;
 sum
-----
 774


--3 ¿Cuál o cuáles son los registros de mayor antigüedad?--
postgres=# SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);
 cantidad |   fecha    | fuente
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página



--4 ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)--
postgres=# SELECT fecha, SUM(cantidad) as total_por_dia FROM INSCRITOS GROUP BY fecha ORDER BY fecha;
   fecha    | total_por_dia
------------+---------------
 2021-01-01 |           100
 2021-02-01 |           120
 2021-03-01 |           103
 2021-04-01 |            93
 2021-05-01 |            88
 2021-06-01 |            30
 2021-07-01 |            58
 2021-08-01 |           182


 --5 ¿Cuántos inscritos hay por fuente?--
postgres=# SELECT fuente, SUM(cantidad) as total FROM INSCRITOS GROUP BY fuente ORDER BY total;
 fuente | total
--------+-------
 Blog   |   333
 Página |   441


--6 ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?--
 postgres=# SELECT fecha, SUM(cantidad) FROM inscritos GROUP BY fecha ORDER BY MAX(cantidad) DESC LIMIT 1;
   fecha    | sum
------------+-----
 2021-08-01 | 182


--7 ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?--
postgres=# SELECT * FROM INSCRITOS WHERE cantidad = (SELECT MAX(cantidad) FROM INSCRITOS WHERE fuente = 'Blog' LIMIT 1);

 cantidad |   fecha    | fuente
----------+------------+--------
       83 | 2021-08-01 | Blog


--8 ¿Cuántas personas en promedio se inscriben en un día?--
 postgres=# SELECT AVG(cantidad) FROM (SELECT SUM(cantidad) AS cantidad FROM inscritos GROUP BY fecha ) AS cantidad_dias;

         avg
---------------------
 96.7500000000000000


--9 ¿Qué días se inscribieron más de 50 personas?--
 postgres=# SELECT fecha, SUM(cantidad)  FROM inscritos GROUP BY fecha HAVING SUM(cantidad) > 50;
   fecha    | sum
------------+-----
 2021-02-01 | 120
 2021-08-01 | 182
 2021-05-01 |  88
 2021-04-01 |  93
 2021-07-01 |  58
 2021-03-01 | 103
 2021-01-01 | 100


--10 ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?--
postgres=# SELECT AVG(promedio) FROM(SELECT fecha, SUM(cantidad) AS promedio FROM inscritos WHERE fecha >= '2021-03-01' GROUP BY fecha)AS promedio;
         avg
---------------------
 92.3333333333333333

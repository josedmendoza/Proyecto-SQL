-- SENTENCIA PARA CONFIGURAR AUTOCOMMIT EN 0
set autocommit = 0;

-- CONSULTAR VALOR DEL AUTOCOMMIT
SELECT @@autocommit;
############################################################ TRANSACCION 1 ######################################################################
-- SE REALIZA 2 DELECT SOBRE LA TABLA ORDER_GAME
-- SE DEJA LA CONSULTA PARA OBTENER TODOS LOS DATOS DE LA TABLA ORDER_GAME Y COMENTADO EL ROLLBACK GENERAL Y EL COMMIT
START TRANSACTION;

DELETE FROM order_game where ID_ORDER_GAME = 2;
DELETE FROM order_game where ID_USER = 10071086;

SELECT * FROM ORDER_GAME LIMIT 50;

--  ROLLBACK;

-- COMMIT;


############################################################ TRANSACCION 2 ######################################################################
-- SE REALIZA LA INSERCION DE 9 REGISTROS A LA TABLA GAME CON 2 SAVEPOINT, UNO CADA CUATRO REGISTROS
-- SE DEJA LA CONSULTA PARA OBTENER TODOS LOS DATOS DE LA TABLA GAME Y COMENTADO LOS ROLLBACK DE CADA SAVEPOINT, 
-- LA ELIMINACION DEL SAVEPOINT S1, UN ROLLBACK GENERAL Y EL COMMIT

START TRANSACTION;

INSERT INTO GAME (ID_CATEGORY,NAME,DESCRIPTION, PRICE, STOCK,RELEASE_DATE) VALUES
(1,'HORIZON DOWN 4','JUEGO AMBIENTADO EN EL FUTURO DE AVENTURA, RPG EN TERCERA PERSONA', 8000.00, 10, '2024-10-1'),
(1,'THW WITCHER 1','jUEGO AMBIENTADO EN LA EDAD MEDIA DE MAGIA Y PELEA', 14000.0, 50, '2008-02-06'),
(4,'FIFA 24','JUEGO DE FUTBOL', 10000.0,20, '2024-06-10'),
(1,'THW WITCHER 2','jUEGO AMBIENTADO EN LA EDAD MEDIA DE MAGIA Y PELEA, SECUELA DE THE WITCHER 1 ', 20000.0, 50, '2015-02-06');
SAVEPOINT S1;
INSERT INTO GAME (ID_CATEGORY,NAME,DESCRIPTION, PRICE, STOCK,RELEASE_DATE) VALUES
(1,'THW WITCHER 3','jUEGO AMBIENTADO EN LA EDAD MEDIA DE MAGIA Y PELEA, SECUELA DE THE WITCHER 2 ', 30000.0, 50, '2023-02-06'),
(3,'BORDERLANDS PRE SEQUEL','JUEGO DE SHOOTER, RPG EN SEGUNDA PERSONA AMBNIENTADO EN OTRO PLANETA', 5000.0, 14, '2014-09-02'),
(3,'RED DEAD REDEMPTION ','JUEGO DE SHOOTER, RPG EN TERCERA PERSONA AMBNIENTADO EN EL VIEJO OESTE', 5000.0, 20, '2010-10-15'),
(3,'THE DIVISION ', 'JUEGOS DE SHOOTER ABIENTADO EN UN MUNDO POST APOCALIPTICO LUEGO DE UNA GUERRA ENTRE PAISES',7200.0, 87, '2005-10-01');
SAVEPOINT S2;
INSERT INTO GAME (ID_CATEGORY,NAME,DESCRIPTION, PRICE, STOCK,RELEASE_DATE) VALUES
(3,'RED DEAD REDEMPTION 3','JUEGOS DE SHOOTER AMBIENTADO EN LA EPOCA DE LOS VAQUEROS', 25000.0, 56, '2022-12-15');

SELECT * FROM GAME LIMIT 50;

-- ROLLBACK TO S1;

-- ROLLBACK TO S2;

-- RELEASE SAVEPOINT S1;

-- ROLLBACK;

-- COMMIT

############################################################ TRANSACCION 3 ######################################################################
-- SE REALIZA LA INSERCION DE 3 REGISTROS A LA TABLA ORDER_GAME PARA VERIFICAR LA FUNCIONALIDAD DE LA TABLA LOG_ORDER_GAME
-- SE DEJA LA CONSULTA PARA OBTENER TODOS LOS DATOS DE LA TABLA ORDER_GAME Y COMENTADO EL ROLLBACK Y EL COMMIT


START TRANSACTION;

INSERT INTO ORDER_GAME(ID_GAME,ID_USER,ID_BILL_USERG,QUANTITY,PRICE) VALUES
(2,30264523,2,1,10000.00),
(3,3968568,6,1,15000.00),
(16,1404419,11,1,5000.00);

SELECT * FROM ORDER_GAME LIMIT 50;

--  ROLLBACK;

-- COMMIT;



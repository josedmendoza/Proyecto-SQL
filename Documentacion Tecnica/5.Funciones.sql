
-- Funcion que retorna el ID de un juegos segun su nombre, implementa datos de la tabla GAME,
-- se plantea para optimizar procesos, ya que si se desea validar la existecia de un juego que se desee agregar a la tabla GAME
-- se puede buscar si el juego existe en la tabla por el nombre, de retornar un id el juego existe y no debe agregarse sino actualizarse.
-- PARA PROBAR SE DEBE INGRESAR SE DEBEN INGRESAR DATOS COMO FIFA 22,FIFA 23, GTA V, SIMS

DROP FUNCTION IF EXISTS FN_GAME_BY_NAME;
DELIMITER $$
CREATE FUNCTION FN_GAME_BY_NAME(P_NAME_GAME VARCHAR(30))
RETURNS INT
DETERMINISTIC  
BEGIN
DECLARE GAME INT;
SET GAME = (SELECT ID_GAME FROM GAME WHERE UPPER(NAME) LIKE CONCAT('%',P_NAME_GAME,'%'));
RETURN GAME;
END$$
DELIMITER ;


-- Consulta para probar la funcion FN_GAME_BY_NAME
SELECT FN_GAME_BY_NAME('FIFA 22') AS GAME;


-- Funcion que retorna el precio total a pagar de un pedido, implementa datos de las tablas GAME y BIIL_USER_GAME
-- el objeto es optimizar procesos al momento de querer imprimir un comprobante de factura, 
-- la funcion retorna el total a pagar de una factura segun el id de esta.

-- PARA PROBAR EN ID_BILL_USERG SE DEBE INGRESAR VALORES DESDE 1 AL 15 
-- P_IVA SE DEBE INGRESAR UN VALOR DE HASTA DE 2 UNIDADES Y 2 DECIMALES
DROP FUNCTION IF EXISTS FN_TOTAL_PAY_PLUS_IVA;
DELIMITER $$
CREATE FUNCTION FN_TOTAL_PAY_PLUS_IVA(P_IVA DECIMAL (4,2),
								   P_ID_BILL_USERG INT)
RETURNS FLOAT
DETERMINISTIC  
BEGIN
DECLARE V_BILL_NUMBER INT;
DECLARE V_TOTAL FLOAT;
DECLARE V_PRICE_PRODUCT FLOAT;
DECLARE V_QUANTITY INT;

SET V_BILL_NUMBER = P_ID_BILL_USERG;

SET V_PRICE_PRODUCT = (SELECT SUM(order_game.PRICE) FROM order_game JOIN game 
ON order_game.ID_GAME = game.ID_GAME 
WHERE order_game.ID_BILL_USERG = V_BILL_NUMBER);

SET V_QUANTITY = (SELECT SUM(order_game.QUANTITY) FROM order_game JOIN bill_user_game ON
order_game.ID_BILL_USERG = bill_user_game.ID_BILL_USERG
WHERE order_game.ID_BILL_USERG = V_BILL_NUMBER);

SET V_TOTAL =  (V_PRICE_PRODUCT * V_QUANTITY) * P_IVA;
RETURN V_TOTAL;
END$$
DELIMITER ;

-- Consulta para probar la funcion FN_TOTAL_PRICE_IVA
select FN_TOTAL_PAY_PLUS_IVA(1.21, 2) AS TOTAL_PAY;


-- Funcion que retorna el total de juegos por la categoria elegida, implementa datos de las tablas GAME y CATEGORY
-- el objetivo es poder generar reporte de total de juegos que se tiene en el catalogo por la categoria elegida. 

-- PARA PROBAR EN P_CATEGORY SE DEBE INGRESAR VALORES COMO 'SHOOTER', 'AVENTURA', 'RPG', 'DEPORTE' ETC.
DROP FUNCTION IF EXISTS c;
DELIMITER //
CREATE FUNCTION FN_QUANTITY_GAME_FOR_CATEGORY (P_CATEGORY VARCHAR(30))
RETURNS INT 
DETERMINISTIC
BEGIN
DECLARE GAME_CATEGORY INT;
SET GAME_CATEGORY = (SELECT COUNT(ID_GAME) FROM GAME WHERE ID_CATEGORY 
IN(SELECT ID_CATEGORY FROM CATEGORY WHERE UPPER(CLASSIFICATION) LIKE CONCAT('%', P_CATEGORY,'%'))); 
RETURN GAME_CATEGORY;
END//
DELIMITER ;

-- Consulta para probar la funcion FN_QUANTITY_GAME_FOR_CATEGORY
select FN_QUANTITY_GAME_FOR_CATEGORY('SHOOTER') AS QUANTITY_GAME_CATEGORY;

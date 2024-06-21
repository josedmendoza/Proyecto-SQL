-- ############################# STORED PROCEDURE 1 ##############################################

-- Store precedure que retorna todo los registros de la tabla GAME ordenados segun la columna y tipo de ordenamiento que desee 
-- con el objeto de poder generar diversor reportes en base a los datos de la tabla y el orden que se desee como un filtro que permite ordenar por diferente condiciones,
-- como juegos con poco stock, juegos mas antigueos y nuevos, mas caros, mas baratos, todo a traves de una sola consulta
-- Para pruebas en el parametro P_COLUMN se pueden utilizar columnas(ID_GAME,ID_CATEGORY,NAME,DESCRIPTION,PRICE,STOCK,RELEASE_DATE,CREATION_DATE)
-- Tipo de orden puede ser ASC o DESC

DROP PROCEDURE IF EXISTS SP_GAME_ORDER;
DELIMITER //
CREATE PROCEDURE SP_GAME_ORDER (IN P_COLUMN varchar(25),
							   IN P_ORDER varchar(5))
 begin
 declare P_ORDENAR varchar(300);
 SET @P_ORDENAR = concat('SELECT DISTINCT * FROM GAME ORDER BY ', P_COLUMN, ' ', P_ORDER, ' LIMIT 30');
 PREPARE run FROM @P_ORDENAR;
 EXECUTE run;
 DEALLOCATE PREPARE run;
 end//
 DELIMITER ;
 
 call SP_GAME_ORDER('PRICE','desc');
  

-- ############################# STORED PROCEDURE 2 ##############################################


-- Stored procedure que inserta o elimina de la table order_game un registro de  segun la operacion que se desee realizar 
-- El insert se realiza sobre la tabla order_game si se selecciona la palaba "insertar" los tipos de datos a utilizar estan definidos en los parametros de entrada
-- El delete se realiza sobre la tabla order_game si se inserta la palabra "eliminar" 
-- Para pruebas en el parametro P_COLUMN se  pueden utilizar columnas(ID_ORDER_GAME, ID_GAME, ID_USER, ID_BILL_USERG, QUANTITY)
-- Para el parametro P_DATA se puede deja la siguiente consulta ( SELECT * FROM order_game LIMIT 20;) para obtener todos los registros de la tabla order_game y 
-- definir que con valor se desea realizar la eliminacion del registro 

DROP PROCEDURE IF EXISTS SP_ORDER_GAME_INSERT_DELETE;
DELIMITER //
CREATE PROCEDURE SP_ORDER_GAME_INSERT_DELETE (IN P_OPERACION VARCHAR(10),
										IN P_ID_GAME INT,
										IN P_ID_USER INT,
                                        IN P_ID_BILL_USERG INT,
                                        IN P_QUANTITY INT,
                                        IN P_PRICE FLOAT,
                                        IN P_COLUMN VARCHAR(30),
                                        IN P_DATA INT)
                                        
begin                        
IF P_OPERACION = 'INSERTAR' THEN  
	BEGIN                                
	SET @P_OPERACION = CONCAT('INSERT INTO ORDER_GAME (ID_GAME,ID_USER,ID_BILL_USERG,QUANTITY,PRICE) VALUES
 ( ',P_ID_GAME,' , ' , P_ID_USER, ' , ',P_ID_BILL_USERG,' , ' ,P_QUANTITY, ' , ',P_PRICE,' ) ');
	END;
ELSEIF P_OPERACION = 'ELIMINAR' THEN
	BEGIN
	SET @P_OPERACION = CONCAT('DELETE FROM order_game WHERE ' ,P_COLUMN, ' = ', P_DATA);
	END;
END IF;
PREPARE run FROM @P_OPERACION;
EXECUTE run;
DEALLOCATE PREPARE run;                                                                                                                                                                                
 end//
 DELIMITER  ;
 
call SP_ORDER_GAME_INSERT_DELETE('insertar', 3, 7124080 ,8, 12,15000.00,null,null);
call SP_ORDER_GAME_INSERT_DELETE('eliminar', null,null,null,null,null,'ID_ORDER_GAME', 17);

 -- A continuacion Se deja LA consulta para verficar la insercion o eliminacion del registro de la tabla order_game

 SELECT * FROM ORDER_GAME LIMIT 20;
 
 
 -- Stored procedure que retorna el ID de los juegos comprados por usuario de la tabla order_game
-- Para pruebas en el parametro P_ID_USER se  pueden utilizar los valores 30264523, 28127945 , 18468723 , 7717959 , 3968568
 DROP  PROCEDURE IF EXISTS SP_GAME_BY_USER;
 DELIMITER //
 CREATE PROCEDURE SP_GAME_BY_USER (IN P_ID_USER INT) 
 BEGIN
 DECLARE P_OUT VARCHAR(200);
 SET @P_OUT = CONCAT('SELECT ID_USER, ID_GAME FROM order_game WHERE ID_USER = ' , P_ID_USER); 
PREPARE run FROM @P_OUT;
 EXECUTE run;
 DEALLOCATE PREPARE run;
 END//
 DELIMITER ;
  
 CALL SP_GAME_BY_USER(3968568);

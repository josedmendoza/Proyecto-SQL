-- ##################################################### TRIGGER 1 #####################################################################

-- Trigger que inserta en la tabla LOG_ORDER_GAME los datos que tenia el registro eliminado de la tabla ORDER_GAME y
-- luego actualiza el stock de la tabla GAME segun el ID_GAME se que elimino de la tabla ORDER_gAME
-- Adicional inserta el usario que realizo la accion, un string indicando el tipo de accion, la fecha 
-- y hora en que se realizo la eliminacion del registro.

DROP TRIGGER IF EXISTS TRG_LOG_ORDER_GAME_DELETE;
DELIMITER //
CREATE TRIGGER TRG_LOG_ORDER_GAME_DELETE BEFORE DELETE ON juegos_ecommerce.order_game
FOR EACH ROW
BEGIN

 INSERT INTO LOG_ORDER_GAME SET
							ID_ORDER_GAME = OLD.ID_ORDER_GAME, 
							ID_GAME=OLD.ID_GAME, 
							ID_USER =  OLD.ID_USER,
							ID_BILL_USERG=  OLD.ID_BILL_USERG,
							QUANTITY = OLD.QUANTITY,
							USER = CURRENT_USER(),
							ACCION =  'BEFORE DELETE',
							DATE = CURDATE(),
							TIME = CURTIME();
                            
	update GAME SET STOCK = GAME.STOCK + OLD.QUANTITY 
	WHERE GAME.ID_GAME = OLD.ID_GAME; 
END//
DELIMITER ;

-- Consulta para obtener todos los tabla a la que va a realizar la actualizacion
SELECT * FROM ORDER_GAME LIMIT 20; 
-- SET SQL_SAFE_UPDATES = 0;
-- Consulta para realizar la eliminacion segun ID_GAME (desde el 1 al 15) sino por el campo se desee eliminar
DELETE FROM ORDER_GAME WHERE ID_GAME = '1';
 -- Consulta para obtener todos los registros insertados en la tabla de auditoria LOG_ORDER_GAME
SELECT * FROM LOG_ORDER_GAME;

-- ##################################################### TRIGGER 2 #####################################################################

-- Trigger que inserta en la tabla LOG_ORDER_GAME los datos del nuevo registro insertado en la tabla ORDER_GAME
-- luego actualiza el stock de la tabla GAME segun el id_GAME se que inserto en la tabla ORDER_gAME
-- Adicional inserta el usario que realizo la accion, un string indicando el tipo de accion, la fecha 
-- y hora en que se realizo la eliminacion del registro


DROP TRIGGER IF EXISTS TRG_LOG_ORDER_GAME_INSERT;
DELIMITER //
CREATE TRIGGER TRG_LOG_ORDER_GAME_INSERT AFTER INSERT ON juegos_ecommerce.order_game
FOR EACH ROW
BEGIN
 INSERT INTO LOG_ORDER_GAME SET
							ID_ORDER_GAME = NEW.ID_ORDER_GAME, 
							ID_GAME= NEW.ID_GAME, 
							ID_USER =  NEW.ID_USER,
							ID_BILL_USERG=  NEW.ID_BILL_USERG,
							QUANTITY = NEW.QUANTITY,
							USER = CURRENT_USER(),
							ACCION =  'AFTER INSERT',
							DATE = CURDATE(),
							TIME = CURTIME();
BEGIN
UPDATE GAME SET STOCK = STOCK - NEW.QUANTITY
WHERE ID_GAME = NEW.ID_GAME;
END;
END//
DELIMITER ;

-- Consulta para obtener todos los tabla a la que va a realizar la insercion
SELECT * FROM ORDER_GAME LIMIT 20; 
-- Consulta para realizar la inserccion de un registro para la tabla ORDER_GAME
INSERT INTO ORDER_GAME (ID_GAME,ID_USER,ID_BILL_USERG,QUANTITY,PRICE) VALUES (6,9671499,4,5,5000.00); 
 -- Consulta para obtener todos los registros insertados en la tabla de auditoria LOG_ORDER_GAME
SELECT * FROM LOG_ORDER_GAME;





-- ##################################################### TRIGGER 3 #####################################################################

-- Trigger que realiza la insercion de 2 registros continuos en la tabla LOG_GAME, correspondientes a los datos que tenia el registro antes de la actualizacion 
-- y los datos posterior a la actualizacion de la tabla GAME, Adicional inserta el usario que realizo la accion, un string en la columna ACCCION que indica si el registro insertado en la tabla LOG_GAME 
-- tiene los datos antes de la actualizacion o es posterior a la actualizacion, esto para facilitar la auditoria, la fecha y hora en que se realizo la actualizacion.

DROP TRIGGER IF EXISTS TRG_LOG_GAME_UPDATE;
DELIMITER //
CREATE TRIGGER TRG_LOG_GAME_UPDATE BEFORE UPDATE ON juegos_ecommerce.game
FOR EACH ROW
BEGIN
INSERT INTO LOG_GAME SET 
					ID_GAME = OLD.ID_GAME, 
					ID_CATEGORY = OLD.ID_CATEGORY, 
					NAME = OLD.NAME,
					DESCRIPTION=  OLD.DESCRIPTION,
					PRICE = OLD.PRICE,
					STOCK = OLD.STOCK,
					RELEASE_DATE = OLD.RELEASE_DATE,
					ACCION = 'BEFORE UPDATE',
					USER = CURRENT_USER(),
					DATE = CURDATE(),
					TIME = CURTIME(); 
                    
INSERT INTO LOG_GAME SET 
					ID_GAME = NEW.ID_GAME,
					ID_CATEGORY = NEW.ID_CATEGORY,
					NAME = NEW.NAME,
					DESCRIPTION = NEW.DESCRIPTION,
					PRICE = NEW.PRICE,
					STOCK = NEW.STOCK,
					RELEASE_DATE = NEW.RELEASE_DATE,
					ACCION = 'AFTER UPDATE',
					USER = CURRENT_USER(),
					DATE = CURDATE(),
					TIME = CURTIME();
END//
DELIMITER ;

-- Consulta para obtener todos los datos de la tabla a la que va a realizar la insercion del registro
SELECT * FROM GAME LIMIT 20;
-- Consulta para actualizar el precio, sotck y nombre de un registro segun su ID
UPDATE GAME SET PRICE = 4580, STOCK = 91, NAME = 'HORIZON DOWN 5'  WHERE ID_GAME = 1;
-- Consulta para obtener todos los registros insertados en la tabla de auditoria LOG_GAME
SELECT * FROM LOG_GAME;


-- ##################################################### TRIGGER 4 #####################################################################

-- Trigger que inserta en la tabla LOG_GAME los datos del nuevo registro insertado en la tabla GAME
-- Adicional inserta el usario que realizo la accion, un string indicando el tipo de accion, la fecha 
-- y hora en que se realizo la eliminacion del registro

DROP TRIGGER IF EXISTS TRG_LOG_GAME_DELETE;
DELIMITER //
CREATE TRIGGER TRG_LOG_GAME_DELETE AFTER INSERT ON juegos_ecommerce.game
FOR EACH ROW
BEGIN

INSERT INTO LOG_GAME SET 
					ID_GAME = NEW.ID_GAME,
					ID_CATEGORY = NEW.ID_CATEGORY,
					NAME = NEW.NAME,
					DESCRIPTION = NEW.DESCRIPTION,
					PRICE = NEW.PRICE,
					STOCK = NEW.STOCK,
					RELEASE_DATE = NEW.RELEASE_DATE,
					ACCION = 'AFTER INSERT',
					USER = CURRENT_USER(),
					DATE = CURDATE(),
					TIME = CURTIME();
END//
DELIMITER ;

-- Consulta para obtener todos los datos de la tabla a la que va a realizar la insercion 
SELECT * FROM GAME LIMIT 20;
-- Consulta para insertar los datos de un nuevo registro en la tabla GAME, los parametros con sus tipos de datos son
-- ID_CATEGORY INT ,NAME VARCHAR ,DESCRIPTION VARCHAR, PRICE FLOAT, STOCK INT,RELEASE_DATE DATE
INSERT INTO GAME (ID_CATEGORY,NAME,DESCRIPTION, PRICE, STOCK,RELEASE_DATE) VALUES
(4,'FIFA 24','JUEGO DE FUTBOL CON LA PLANTILLA DE JUGADORES EL 2023', 5000.00, 10, '2024-10-1');
-- Consulta para obtener todos los registros insertados en la tabla de auditoria LOG_GAME
SELECT * FROM LOG_GAME;



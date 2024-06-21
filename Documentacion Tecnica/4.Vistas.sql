
-- vista para obtener todos los juegos que tengan stock disponible
CREATE OR REPLACE VIEW VW_GAME_STOCK AS
(SELECT game.name, game.stock FROM GAME WHERE STOCK > 0);

SELECT * FROM VW_GAME_STOCK;

-- vista obtener, nombre, apellido, mail y telefono de los usuarios con ordenes de compras, 
-- se consultan datos de la tabla order_Game y se implementan datos de la tabla user.
CREATE OR REPLACE VIEW VW_USER_ORDER_GAME AS 
(SELECT distinct user.firts_name, user.last_name, mail, TELF from order_game 
JOIN user ON order_game.id_user = user.dni);

SELECT * FROM VW_USER_ORDER_GAME;

-- vista para obtener el juego mas vendido, se realiza un join entre las tablas order_game y game
-- para obtener el id del juego, el nombre y la cantidad de unidades vendidas
CREATE OR REPLACE VIEW VW_BEST_SELLING_GAMES AS 
(SELECT  game.id_game, game.name, order_game.QUANTITY FROM order_game
JOIN game ON order_game.ID_GAME = game.ID_GAME
WHERE QUANTITY in (SELECT max(QUANTITY) FROM order_game));

SELECT * FROM VW_BEST_SELLING_GAMES;

-- vista para obtener los juegos menos vendidos, se realiza un join entre las tablas order_game y game
-- para obtener el id del juego, nombre y la cantidad de unidades vendidas por cada juego.
CREATE OR REPLACE VIEW VW_LEAST_SELLING_GAMES AS 
(SELECT  game.id_game, game.name, order_game.QUANTITY FROM order_game
JOIN game ON order_game.ID_GAME = game.ID_GAME
WHERE QUANTITY in (SELECT min(QUANTITY) FROM order_game));

SELECT * FROM VW_LEAST_SELLING_GAMES;

-- vista para obtener la subscripion mas vendidas con su la cantida de subscripciones vendidas.
CREATE OR REPLACE VIEW VW_SUBSCRIPTION_MOST_SOLD AS
(SELECT ID_SUBSCRIPTION, SUM(QUANTITY) AS TOTAL_SOLD FROM order_suscription group by 1,2 ORDER BY TOTAL_SOLD DESC LIMIT 1 );

SELECT * FROM VW_SUBSCRIPTION_MOST_SOLD;

-- vista para obtener el total de usuario con suscripciones.
CREATE OR REPLACE VIEW VW_TOTAL_USER_WITH_SUBS AS
(SELECT COUNT(order_suscription.ID_USER) as TOTAL_USER_WITH_SUBS FROM order_suscription );

SELECT * FROM VW_TOTAL_USER_WITH_SUBS;

-- vista para obtener los nombres del top 3 de clientes con mas juegos comprados y la cantidad de juegos comprados,
--  se obtene el nombre completo y la cantidad de productos que han comprado.
CREATE OR REPLACE VIEW VW_TOP_USER_WITH_GAME AS 
(select ID_USER, concat(FIRTS_NAME, " ",LAST_NAME) as FULL_NAME, QUANTITY from order_game 
JOIN user ON order_game.id_user = user.dni
where QUANTITY > (select avg(QUANTITY) from order_game) 
ORDER BY QUANTITY desc
LIMIT 3);

SELECT * FROM VW_TOP_USER_WITH_GAME;



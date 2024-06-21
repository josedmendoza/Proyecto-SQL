-- sentencia para usar el schema mysql donde donde se puede crear los usuarios y otorgar permisos 
use mysql;

-- ######################################################## Creacion de Usuarios ################################################################################


-- consulta para crear un usuario nuevo de nombre:jose - dominio:localhost - y password: 251290JOSE;
CREATE USER IF NOT EXISTS jose@localhost IDENTIFIED BY '251290JOSE';

-- consulta para verificar la creacion del usuario jose;
SELECT * FROM mysql.user where user like 'jose%';

-- consulta para crear un usuario nuevo de nombre:david - dominio:localhost - y password: 22787DAVID;
CREATE USER IF NOT EXISTS david@localhost IDENTIFIED BY '22787DAVID';

-- consulta para verificar la creacion del usuario david;
SELECT * FROM mysql.user where user like 'david%';

drop user if exists pedro@localhost;
CREATE USER IF NOT EXISTS pedro@localhost IDENTIFIED BY '123456PEDRO';


-- ######################################################## Permisos para usuario jose@localhost ################################################################################

-- sentencia para otorgar permiso de lectura de la tabla bill_suscription
GRANT SELECT ON juegos_ecommerce.bill_suscription to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla bill_user_game
GRANT SELECT ON juegos_ecommerce.bill_user_game to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla category
GRANT SELECT ON juegos_ecommerce.category to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla game
GRANT SELECT ON juegos_ecommerce.game to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla log_game
GRANT SELECT ON juegos_ecommerce.log_game to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla log_order_game
GRANT SELECT ON juegos_ecommerce.log_order_game to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla order_game
GRANT SELECT ON juegos_ecommerce.order_game to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla order_suscription
GRANT SELECT ON juegos_ecommerce.order_suscription to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla subscription
GRANT SELECT ON juegos_ecommerce.subscription to jose@localhost;

-- sentencia para otorgar permiso de lectura de la tabla user
GRANT SELECT ON juegos_ecommerce.user to jose@localhost;

-- consulta para listar los permiso del usuario jose
show grants for jose@localhost;

-- ######################################################## Permisos para usuario david@localhost ################################################################################


-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla bill_suscription
GRANT SELECT, INSERT, UPDATE,DELETE ON juegos_ecommerce.bill_suscription to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla bill_user_game
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.bill_user_game to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla category
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.category to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla game
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.game to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla log_game
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.log_game to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla log_order_game
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.log_order_game to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla order_game
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.order_game to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla order_suscription
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.order_suscription to david@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla subscription
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.subscription to david@localhost;


-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla user
GRANT SELECT, INSERT, UPDATE, DELETE ON juegos_ecommerce.user to david@localhost;

-- consulta para listar los permiso del usuario david
show grants for david@localhost;


-- ######################################################## Permisos para usuario pedro@localhost ################################################################################


-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla bill_suscription
GRANT SELECT, DELETE ON juegos_ecommerce.bill_suscription to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla bill_user_game
GRANT SELECT, DELETE ON juegos_ecommerce.bill_user_game to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla category
GRANT SELECT, DELETE ON juegos_ecommerce.category to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla game
GRANT SELECT, DELETE ON juegos_ecommerce.game to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla log_game
GRANT SELECT, DELETE ON juegos_ecommerce.log_game to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla log_order_game
GRANT SELECT, DELETE ON juegos_ecommerce.log_order_game to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla order_game
GRANT SELECT, DELETE ON juegos_ecommerce.order_game to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla order_suscription
GRANT SELECT, DELETE ON juegos_ecommerce.order_suscription to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla subscription
GRANT SELECT, DELETE ON juegos_ecommerce.subscription to pedro@localhost;

-- sentencia para otorgar permiso de lectura, insercion y modificacion de datos de la tabla user
GRANT SELECT, DELETE ON juegos_ecommerce.user to pedro@localhost;




INSERT INTO estatus (nombre)
VALUES ('Active'),  ('Inactive'), ('Deleted'), ('Seen'), ('NotSeen'), ('Out for Delivery'), ('In Transit'), ('Delivered');
--------------------------
------------------- rol
--------------------------

INSERT INTO rol (nombre) 
VALUES ('SuperUser');
INSERT INTO rol (nombre) 
VALUES ('User');


--------------------------
------------------- tipo_envio
--------------------------

INSERT INTO tipo_envio (
	nombre,
	descripcion,
	tarifa_base
) 
VALUES (
	'Standard',
	'Este es el tipo de envío básico. No posee consideraciones especiales en el tiempo de entrega y cuidado, estos son el standard para todos los paquetes enviados. Su paquete llegará a su destino en máximo 3 semanas.',
	15
);

INSERT INTO tipo_envio (
	nombre,
	descripcion,
	tarifa_base
) 
VALUES (
	'Priority',
	'Pone especial atención en el cuidado y trato de los paquetes. Es el mejor servicio para paquetes frágiles. Además, el tiempo máximo de llegado del paquete a su destino es de 1 semana.',
	20
);

INSERT INTO tipo_envio (
	nombre,
	descripcion,
	tarifa_base
) 
VALUES (
	'Express',
	'Este servicio se enfoca en la rapidez de entrega. Al seleccionarlo garantizamos que el tiempo de llegada de su paquete a su destino no superará los 3 días. Es el mejor servicio para entregas urgentes.',
	30
);

INSERT INTO estatus_tipo_envio ( fecha, fk_estatus, fk_tipo_envio) VALUES ('2020/02/03', 1, 1);
INSERT INTO estatus_tipo_envio ( fecha, fk_estatus, fk_tipo_envio) VALUES ('2020/01/03', 2, 1);
INSERT INTO estatus_tipo_envio ( fecha, fk_estatus, fk_tipo_envio) VALUES ('2020/02/03', 1, 2);
INSERT INTO estatus_tipo_envio ( fecha, fk_estatus, fk_tipo_envio) VALUES ('2020/02/03', 1, 3);

--------------------------
------------------- seguro
--------------------------

INSERT INTO seguro (
	nombre,
	descripcion,
	tarifa,
	tarifa_max_devolucion
) 
VALUES (
	'We Care',
	'Asegura tu envio por el 50% de su valor en caso de extraviarse lo que enviaste durante el trayecto',
	70,
	3000
);

INSERT INTO seguro (
	nombre,
	descripcion,
	tarifa,
	tarifa_max_devolucion
) 
VALUES (
	'We Love',
	'Asegura tu envio por el 100% de su valor en caso de extraviarse lo que enviaste durante el trayecto',
	100,
	5000
);
INSERT INTO estatus_seguro ( fecha, fk_estatus, fk_seguro) VALUES ('2020/02/03', 1, 1);
INSERT INTO estatus_seguro ( fecha, fk_estatus, fk_seguro) VALUES ('2020/02/02', 2, 1);
INSERT INTO estatus_seguro ( fecha, fk_estatus, fk_seguro) VALUES ('2020/02/03', 1, 2);
--------------------------
------------------- configuracion_simulacion
--------------------------

INSERT INTO configuracion_simulacion (
	tiempo_inicio
) 
VALUES (
	5
);

--------------------------
------------------- lugar
--------------------------

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
) 
VALUES (
	'1301-1399 NW 7th Ct, Miami, FL 33136, USA',
	25.787685,
	-80.207872,
	33136
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
) 
VALUES (
	'1084 Bedford Ave, Brooklyn, NY 11216, USA',
	40.687778,
	-73.954956,
	11216
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
) 
VALUES (
	'Roxbury, Massachusetts 02119, USA',
	42.328915,
	-71.084241,
	02119
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'5441 9th Ave N St. Petersburg, FL 33710, USA',
	27.782244,
	-82.707975,
	33701
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'Maxwell Park Oakland, California, USA',
	37.776712,
	-122.190289,
	94619
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'Marshall Square Chicago, Illinois, USA',
	41.846097,
	-87.700196,
	60623
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'Jeff-Vander-Lou SaintLouis, Missouri, USA',
	38.647000,
	-90.217379,
	63106
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'Logan/ Ogontz/ Fern Rock Philadelphia, Pennsylvania, USA',
	40.043391,
	-75.148867,
	19141
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'West Highlands Atlanta, Georgia 30318, USA',
	33.790998,
	-84.445999,
	30318
);

INSERT INTO lugar (
	direccion,
	altitud,
	longitud,
	zip
)
VALUES (
	'Lincoln Creek Milwaukee, Wisconsin, USA',
	43.103402,
	-87.988,
	53209
);
--------------------------
------------------- oficina
--------------------------

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Florida-01',
	1
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'NewYork-01',
	2
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Boston-01',
	3
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'TampaBay-01',
	4
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Oakland-01',
	5
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Chicago-01',
	6
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'SaintLouis-01',
	7
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Philadelphia-01',
	8
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Atlanta-01',
	9
);

INSERT INTO oficina (
	nombre,
	fk_lugar
) 
VALUES (
	'Milwaukee-01',
	10
);


INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 1);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/02', 2, 1);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 2);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 3);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 4);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 5);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 6);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 7);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 8);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 9);
INSERT INTO estatus_oficina ( fecha, fk_estatus, fk_oficina) VALUES ('2020/02/03', 1, 10);
--------------------------
------------------- parametro
--------------------------

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo
) 
VALUES (
	'Alto',
	'cm',
	'PAQUETE',
	178,
	0
);

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo
) 
VALUES (
	'Ancho',
	'cm',
	'PAQUETE',
	203,
	0.1
);

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo
) 
VALUES (
	'Largo',
	'cm',
	'PAQUETE',
	302,
	0.1
);

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo
) 
VALUES (
	'Peso',
	'kg',
	'PAQUETE',
	997,
	0.1
);

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo
) 
VALUES (
	'Cantidad',
	'unidades',
	'PAQUETE',
	25,
	1
);

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo,
	fk_parametro
) 
VALUES (
	'Cantidad envío',
	'unidades',
	'ENVIO',
	25,
	1,
	5
);

INSERT INTO parametro (
	nombre,
	unidad,
	tipo,
	valor_maximo,
	valor_minimo
) 
VALUES (
	'Valor calculado',
	'$',
	'PAQUETE',
	3000,
	0
);

--------------------------
------------------- empaque
--------------------------

INSERT INTO empaque (
	nombre,
	descripcion,
	ancho,
	largo,
	precio
) 
VALUES (
	'Sobre - Pequeño',
	'Sobre pequeño tamaño C7. Sobre blanco.',
	8.1,
	11.3,
	0.02
);

INSERT INTO empaque (
	nombre,
	descripcion,
	ancho,
	largo,
	precio
) 
VALUES (
	'Sobre - Mediano',
	'Tamaño Americano. Sobre blanco',
	11,
	22,
	0.04
);

INSERT INTO empaque (
	nombre,
	descripcion,
	ancho,
	largo,
	precio
) 
VALUES (
	'Sobre - Grande',
	'Tamaño C4. Sobre Manila',
	22.9,
	37.4,
	0.1
);

INSERT INTO empaque (
	nombre,
	descripcion,
	ancho,
	largo,
	precio
) 
VALUES (
	'Sobre - Extra grande',
	'Tamaño C3. Sobre Manila',
	32.4,
	45.8,
	0.2
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja cuadrada - Pequeña',
	'Caja ideal para objetos pequeños y frágiles',
	20,
	20,
	20,
	13.5
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja cuadrada - Mediana',
	'Caja perfecta para objetos un poco pesados y espaciosos',
	40,
	40,
	40,
	34
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja cuadrada - Grande',
	'Caja utilizada para objetos de mayor envergadura y pesados',
	71,
	71,
	71,
	165
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja rectangular - Pequeña',
	'Caja ideal para objetos pequeños y frágiles',
	3,
	27,
	32,
	11
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja rectangular - Mediana',
	'Caja perfecta para objetos un poco pesados y espaciosos',
	18,
	43,
	43,
	28
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja rectangular - Grande',
	'Caja utilizada para objetos de mayor envergadura y pesados',
	30,
	43,
	58,
	42
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja especial - Tubo',
	'Caja de tubo doble interior',
	17.5,
	27.5,
	150,
	120
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja especial - Laptop',
	'Caja para laptops y dispositivos parecidos',
	20,
	20,
	41,
	71
);

INSERT INTO empaque (
	nombre,
	descripcion,
	alto,
	ancho,
	largo,
	precio
) 
VALUES (
	'Caja especial - Dispositivos pequeños',
	'Caja para dispositivos electrónicos pequeños',
	20,
	13,
	8,
	40
);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 1);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/02', 2, 1);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 2);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 3);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 4);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 5);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 6);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 7);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 8);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 9);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 10);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 11);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 12);
INSERT INTO estatus_empaque ( fecha, fk_estatus, fk_empaque) VALUES ('2020/02/03', 1, 13);

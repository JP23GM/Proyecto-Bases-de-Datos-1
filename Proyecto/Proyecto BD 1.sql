CREATE DATABASE Proyecto_BD_1
GO

USE Proyecto_BD_1
GO

Alter authorization on database::Proyecto_BD_1 to sa 
SET DATEFORMAT dmy
SET LANGUAGE spanish
GO

CREATE TABLE Sector_Aledano(
	ID_Sector_Aledano INT NOT NULL,
	Nomb_Sector_Aledano VARCHAR(80) NULL,
	CONSTRAINT PK_Sector_Aledano PRIMARY KEY (ID_Sector_Aledano ASC),
)
GO

CREATE TABLE Paciente(
	Cedula_Paciente INT NOT NULL,
	Nomb_Paciente VARCHAR (80) NULL,
	Apellidos_Paciente VARCHAR(80) NULL,
	Direccion_Exacta VARCHAR(150) NULL,
	Fecha_Nacimiento DATE NULL,
	Correo VARCHAR(80) NULL,
	Sector_Aledano INT NULL,
	CONSTRAINT PK_Paciente PRIMARY KEY (Cedula_Paciente ASC),
	CONSTRAINT FK_Paciente_Sector_Aledano FOREIGN KEY (Sector_Aledano) REFERENCES Sector_Aledano (ID_Sector_Aledano),
)
GO

CREATE TABLE Telefonos_Paciente(
	ID_Telefonos_Paciente INT NOT NULL,
	Numeros_Telefono INT NULL,
	Paciente INT NULL
	CONSTRAINT PK_Telefonos_Paciente PRIMARY KEY (ID_Telefonos_Paciente ASC),
	CONSTRAINT FK_Telefonos_Paciente_Paciente FOREIGN KEY (Paciente) REFERENCES Paciente (Cedula_Paciente),
)
GO

CREATE TABLE Odontologo(
	Cedula_Odontologo INT NOT NULL,
	Nomb_Odontologo VARCHAR(80) NULL,
	Apellidos_Odontologo VARCHAR(150) NULL,
	CONSTRAINT PK_Odontologo PRIMARY KEY (Cedula_Odontologo ASC),
)
GO

CREATE TABLE Especialidad(
	ID_Especialidad INT NOT NULL,
	Tipo_Especialidad VARCHAR(80) NULL,
	Odontologo INT NULL,
	CONSTRAINT PK_Especialidad PRIMARY KEY (ID_Especialidad ASC),
	CONSTRAINT FK_Especialidad_Odontologo FOREIGN KEY (Odontologo) REFERENCES Odontologo (Cedula_Odontologo),
)
GO

CREATE TABLE Telefonos_Odontologo(
	ID_Telefonos_Odontologo INT NOT NULL,
	Numeros_Telefono INT NULL,
	Odontologo INT NULL
	CONSTRAINT PK_Telefonos_Odontologo PRIMARY KEY (ID_Telefonos_Odontologo ASC),
	CONSTRAINT FK_Telefonos_Odontologo_Odontologo FOREIGN KEY (Odontologo) REFERENCES Odontologo (Cedula_Odontologo),
)
GO


CREATE TABLE Cita(
	ID_Cita INT NOT NULL,
	Fecha DATE NULL,
	Hora TIME NULL,
	Servicio_Solicitado VARCHAR(80) NULL,
	Costo_Aproximado INT NULL,
	Asistencia BIT NULL,
	Paciente INT NULL,
	Odontologo INT NULL,
	CONSTRAINT PK_Cita PRIMARY KEY (ID_Cita),
	CONSTRAINT FK_Cita_Paciente FOREIGN KEY (Paciente) REFERENCES Paciente (Cedula_Paciente),
	CONSTRAINT FK_Cita_Odontologo FOREIGN KEY (Odontologo) REFERENCES Odontologo (Cedula_Odontologo),
)
GO

CREATE TABLE Servicio_Odontologico(
	Codigo INT NOT NULL,
	Nombre_Servicio_Odontologico VARCHAR(80) NULL,
	Costo_Referencia_Min INT NOT NULL,
	Costo_Referencia_Max INT NOT NULL,
	CONSTRAINT PK_Servicio_Odontologico PRIMARY KEY (Codigo),
)
GO

CREATE TABLE Servicio_Cita(
	Codigo INT NOT NULL,
	ID_Cita INT NOT NULL,
	CONSTRAINT PK_Codigo_ID_Cita PRIMARY KEY (Codigo, ID_Cita),
	CONSTRAINT FK_Codigo FOREIGN KEY (Codigo) REFERENCES Servicio_Odontologico (Codigo),
	CONSTRAINT FK_ID_Cita FOREIGN KEY (ID_Cita) REFERENCES Cita (ID_Cita),
)
GO

INSERT Sector_Aledano VALUES (1321,'Tibás')		
INSERT Sector_Aledano VALUES (2426,'Escazú')		
INSERT Sector_Aledano VALUES (1111,'San José')		
INSERT Sector_Aledano VALUES (4627,'Curridabat')	
INSERT Sector_Aledano VALUES (7951,'Moravia')		
INSERT Sector_Aledano VALUES (8821,'Desamparados')	
INSERT Sector_Aledano VALUES (6934,'Santa Ana')	
INSERT Sector_Aledano VALUES (3745,'Montes de Oca')
GO

INSERT Servicio_Odontologico VALUES (90000,'Cirugía Oral',1000000,2500000)
INSERT Servicio_Odontologico VALUES (91010,'Odontología Preventiva',45000,180000)
INSERT Servicio_Odontologico VALUES (92020,'Periodoncia',30000,75000)
INSERT Servicio_Odontologico VALUES (93030,'Terapéutica Dental',50000,120000)
INSERT Servicio_Odontologico VALUES (94040,'Endodoncia',50000,160000)
INSERT Servicio_Odontologico VALUES (95050,'Prótesis Dental',15000,90000)
INSERT Servicio_Odontologico VALUES (96060,'Radiología Dental',50000,120000)
INSERT Servicio_Odontologico VALUES (97070,'Ortodoncia',750000,1500000)
GO

INSERT Paciente VALUES (89756,'Andrés','Vega Quirós','Carretera vieja, 200m Norte Bar Boquitas','03/03/1990', 'vegaquiros@email.com',7951)
INSERT Paciente VALUES (71429,'Adriana','Fernández López','250m Este de Ferretería Epa','02/05/1996','fernandezlopez@email.com',4627)
INSERT Paciente VALUES (65542,'Jorge','Castillo Alfaro','400m Sur de Ferretería Brenes','09/06/1973', 'castilloalfaro@email.com',4627)
INSERT Paciente VALUES (50238,'Angie','Silva García','100m Norte de residencial Las Palmas','12/12/2001', 'silvagarcia@email.com',8821)
INSERT Paciente VALUES (45619,'Hernán','Gómez Martínez','Diagonal a Pizzeria Torres','07/05/1967', 'gomezmartines@email.com',1321)
INSERT Paciente VALUES (54310,'Bryan','Coto Hernández','200m Sur y 75m Oeste Bazar Nuevo Mundo','25/07/1983', 'cotohernandez@email.com',1111)
INSERT Paciente VALUES (13450,'Alejandra','Ramírez Muñoz','175m Norte iglesia San Pastor','16/10/1982', 'ramirezmuñoz@email.com',1111)
INSERT Paciente VALUES (78628,'Alonso','Mora Valverde','Carretera principal, 150m Este Veterinaria Cachorros','29/11/1975', 'moravalverde@email.com',3745)
INSERT Paciente VALUES (62344,'María','Fuentes Araya','275m Sur de iglesia Divina Gracia','22/12/2002', 'fuentesaraya@email.com',1111)
INSERT Paciente VALUES (43262,'Mario','Flores Cedeño','Contiguo a Lagar','23/09/1959', 'florescedeño@email.com',8821)
INSERT Paciente VALUES (25234,'Álvaro','Jimémez Pérez','300m Este de Walmart','19/02/1971', 'jimenezperez@email.com',2426)
INSERT Paciente VALUES (34561,'Veronica','Rodríguez Álvarez','Contiguo a Lagar','31/03/1989', 'rodrigezalvarez@email.com',1321)
INSERT Paciente VALUES (94233,'Andrey','Ortega Díaz','Frente a residencial Calletano','17/06/1969', 'ortegadiaz@email.com',6934)
INSERT Paciente VALUES (53144,'Elizabeth','Pizarro Vásquez','Frente a liceo Araya','13/08/1994', 'pizarrovasques@email.com',1111)
INSERT Paciente VALUES (45235,'Antonio','Carvajal Villalobos','Costado Norte de iglesia Santo Tomás','10/01/1994', 'carvajalvillalobos@email.com',1111)
INSERT Paciente VALUES (50347,'Yendri','Soto Morales','400m Oeste de universidad UAM','30/04/1999', 'sotomorales@email.com',3745)
INSERT Paciente VALUES (62349,'Catalina','Castro Reyes','75m Este del restaurante Pelicano','09/01/2006', 'castroreyes@email.com',7951)
INSERT Paciente VALUES (82324,'Daniel','Rivera Espinoza','Calle Los Encinos. Costado Sur colegio Martínez-Fernández','20/04/2008', 'riveraespinoza@email.com',6934)
INSERT Paciente VALUES (41239,'Elena','Bonilla Solano','600m Este de Agencia Nissan','27/01/2010', 'bonillasolano@email.com',2426)
INSERT Paciente VALUES (18725,'Ana','Cortés Herrera','600m Norte del ICE','16/07/1986', 'cortesherrera@email.com',1321)
GO

INSERT Odontologo VALUES (56481,'David','Cordero Gutiérrez')
INSERT Odontologo VALUES (12389,'Mercedes','Rivas Torres')
INSERT Odontologo VALUES (54784,'Gabriela','Contreras Molina')
INSERT Odontologo VALUES (37887,'Shirley','Zúñiga Miranda')
INSERT Odontologo VALUES (48692,'Gabriel','Sandoval Ortiz')
INSERT Odontologo VALUES (15739,'Jesús','Salazar Guzmán')
GO

INSERT Especialidad VALUES (92783,'Odontología General',56481)
INSERT Especialidad VALUES (92784,'Cirugía Oral y Maxilofacial',56481)
INSERT Especialidad VALUES (92785,'Ortodoncia',56481)
INSERT Especialidad VALUES (92786,'Radiología Oral y Maxilofacial',56481)
INSERT Especialidad VALUES (92787,'Odontología General',12389)
INSERT Especialidad VALUES (92788,'Odontopediatría',12389)
INSERT Especialidad VALUES (92789,'Odontología General',54784)
INSERT Especialidad VALUES (92790,'Prostodoncia y Rehabilitación Oral',54784)
INSERT Especialidad VALUES (92782,'Endodoncia',54784)
INSERT Especialidad VALUES (92781,'Odontología General',37887)
INSERT Especialidad VALUES (92780,'Odontología Estética',37887)
INSERT Especialidad VALUES (92779,'Ortodoncia',37887)
INSERT Especialidad VALUES (92778,'Odontología General',48692)
INSERT Especialidad VALUES (92777,'Radiología Oral y Maxilofacial',48692)
INSERT Especialidad VALUES (92776,'Prostodoncia y Rehabilitación Oral',48692)
INSERT Especialidad VALUES (92775,'Odontología General',15739)
INSERT Especialidad VALUES (92774,'Endodoncia',15739)
INSERT Especialidad VALUES (92773,'Ortodoncia',15739)
INSERT Especialidad VALUES (92772,'Odontología Estética',15739)
GO

INSERT Telefonos_Odontologo VALUES (98060,88511297,56481)
INSERT Telefonos_Odontologo VALUES (98058,71357629,56481)
INSERT Telefonos_Odontologo VALUES (98056,89036863,56481)
INSERT Telefonos_Odontologo VALUES (98054,22755630,12389)
INSERT Telefonos_Odontologo VALUES (98052,86480547,12389)
INSERT Telefonos_Odontologo VALUES (98050,70244723,54784)
INSERT Telefonos_Odontologo VALUES (98048,22967236,37887)
INSERT Telefonos_Odontologo VALUES (98046,22676726,48692)
INSERT Telefonos_Odontologo VALUES (98044,84305049,48692)
INSERT Telefonos_Odontologo VALUES (98042,78917199,15739)
GO

INSERT Telefonos_Paciente VALUES (99098,85518457,89756)
INSERT Telefonos_Paciente VALUES (99096,80011194,65542)
INSERT Telefonos_Paciente VALUES (99094,89305105,45619)
INSERT Telefonos_Paciente VALUES (99092,77825932,45619)
INSERT Telefonos_Paciente VALUES (99090,20598426,54310)
INSERT Telefonos_Paciente VALUES (99088,81588178,78628)
INSERT Telefonos_Paciente VALUES (99086,87088960,43262)
INSERT Telefonos_Paciente VALUES (99084,76352481,25234)
INSERT Telefonos_Paciente VALUES (99082,85194921,94233)
INSERT Telefonos_Paciente VALUES (99080,86498354,45235)
INSERT Telefonos_Paciente VALUES (99078,79730035,34561)
INSERT Telefonos_Paciente VALUES (99076,84706439,71429)
INSERT Telefonos_Paciente VALUES (99074,71694370,13450)
INSERT Telefonos_Paciente VALUES (99072,84109612,50347)
INSERT Telefonos_Paciente VALUES (99070,86597920,50238)
INSERT Telefonos_Paciente VALUES (99068,79297175,62349)
INSERT Telefonos_Paciente VALUES (99066,75686284,82324)
INSERT Telefonos_Paciente VALUES (99064,87212351,41239)
INSERT Telefonos_Paciente VALUES (99062,86597913,62344)
INSERT Telefonos_Paciente VALUES (99060,89603049,94233)
INSERT Telefonos_Paciente VALUES (99058,77769248,41239)
INSERT Telefonos_Paciente VALUES (99056,78103243,53144)
INSERT Telefonos_Paciente VALUES (99054,84207799,18725)
GO


INSERT Cita VALUES (79501,'05/12/2022','10:00:00','Ortodoncia',1200000,0,18725,56481)
INSERT Cita VALUES (79502,'14/08/2022','13:00:00','Limpieza',45000,1,41239,15739)
INSERT Cita VALUES (79503,'03/06/2023','15:30:00','Cirugía',1900000,1,82324,12389)
INSERT Cita VALUES (79504,'31/01/2020','17:00:00','Ortodoncia',800000,0,62349,15739)
INSERT Cita VALUES (79505,'03/12/2023','14:30:00','Limpieza',45000,1,50347,56481)
INSERT Cita VALUES (79506,'10/06/2023','11:30:00','Terapéutica Dental',80000,1,45235,37887)
INSERT Cita VALUES (79507,'29/10/2023','10:00:00','Limpieza',45000,1,53144,12389)
INSERT Cita VALUES (79508,'17/02/2023','13:30:00','Cirugía',1700000,1,94233,54784)
INSERT Cita VALUES (79509,'01/04/2023','14:00:00','Limpieza',45000,1,34561,37887)
INSERT Cita VALUES (79510,'26/04/2021','15:00:00','Ortodoncia',1000000,0,25234,48692)
INSERT Cita VALUES (79511,'25/07/2023','16:00:00','Terapéutica Dental',90000,1,43262,12389)
INSERT Cita VALUES (79512,'15/06/2021','11:00:00','Limpieza',45000,1,62344,54784)
INSERT Cita VALUES (79513,'13/01/2023','13:30:00','Prótesis Dental',30000,1,78628,48692)
INSERT Cita VALUES (79514,'04/02/2023','15:00:00','Limpieza',45000,1,13450,54784)
INSERT Cita VALUES (79515,'12/04/2022','17:00:00','Terapéutica Dental',120000,0,54310,12389)
INSERT Cita VALUES (79516,'25/11/2020','16:30:00','Ortodoncia',1400000,1,45619,56481)
INSERT Cita VALUES (79517,'28/04/2021','10:00:00','Limpieza',45000,1,50238,54784)
INSERT Cita VALUES (79518,'18/12/2021','13:00:00','Prótesis Dental',60000,0,65542,48692)
INSERT Cita VALUES (79519,'07/07/2022','16:00:00','Limpieza',45000,1,71429,54784)
INSERT Cita VALUES (79520,'30/12/2021','14:30:00','Ortodoncia',750000,0,89756,56481)
INSERT Cita VALUES (79521,'10/07/2021','11:00:00','Terapéutica Dental',100000,1,25234,54784)
INSERT Cita VALUES (79522,'11/05/2020','13:00:00','Limpieza',45000,0,53144,37887)
INSERT Cita VALUES (79523,'17/02/2023','15:30:00','Prótesis Dental',25000,1,62344,56481)
INSERT Cita VALUES (79524,'15/08/2021','17:00:00','Terapéutica Dental',100000,1,41239,54784)
GO

INSERT Servicio_Cita VALUES (90000,79511)
INSERT Servicio_Cita VALUES (90000,79512)
INSERT Servicio_Cita VALUES (90000,79513)
INSERT Servicio_Cita VALUES (91010,79514)
INSERT Servicio_Cita VALUES (91010,79515)
INSERT Servicio_Cita VALUES (91010,79516)
INSERT Servicio_Cita VALUES (92020,79517)
INSERT Servicio_Cita VALUES (92020,79518)
INSERT Servicio_Cita VALUES (92020,79519)
INSERT Servicio_Cita VALUES (93030,79520)
INSERT Servicio_Cita VALUES (93030,79501)
INSERT Servicio_Cita VALUES (93030,79502)
INSERT Servicio_Cita VALUES (94040,79503)
INSERT Servicio_Cita VALUES (94040,79504)
INSERT Servicio_Cita VALUES (94040,79505)
INSERT Servicio_Cita VALUES (95050,79506)
INSERT Servicio_Cita VALUES (95050,79507)
INSERT Servicio_Cita VALUES (95050,79508)
INSERT Servicio_Cita VALUES (96060,79509)
INSERT Servicio_Cita VALUES (96060,79510)
INSERT Servicio_Cita VALUES (96060,79524)
INSERT Servicio_Cita VALUES (97070,79523)
INSERT Servicio_Cita VALUES (97070,79522)
INSERT Servicio_Cita VALUES (97070,79521)
GO

/* 1.	Listar todas las citas de un paciente en particular. en un Rango de Fechas. Mostrando código y nombre del paciente, el código y fecha de la cita. */

SELECT P.[Cedula_Paciente],P.[Nomb_Paciente],P.[Apellidos_Paciente],C.[ID_Cita],C.[Fecha]
	FROM [dbo].[Paciente] P LEFT JOIN [dbo].[Cita] C
	ON P.Cedula_Paciente = C.Paciente
	WHERE (C.Fecha BETWEEN '01/01/2020' AND '31/12/2023') AND P.Cedula_Paciente = 62344

/* 2.	Listar todas las especialidades de un doctor en Mostrando código y nombre del odontólogo, el código y descripción de la especialidad. */

SELECT O.[Cedula_Odontologo],O.[Nomb_Odontologo],O.[Apellidos_Odontologo],E.[ID_Especialidad],E.[Tipo_Especialidad]
	FROM [dbo].[Odontologo] O LEFT JOIN [dbo].[Especialidad] E
	ON O.Cedula_Odontologo = E.Odontologo
	WHERE O.Cedula_Odontologo = 56481

/* 3.	Mostrar las citas atendidas por un odontólogo en particular en un Rango de Fechas, 
ordenado por fechas (Los datos a mostrar serán el id y nombre del médico, código de la cita y la fecha. */

SELECT O.[Cedula_Odontologo],O.[Nomb_Odontologo],O.[Apellidos_Odontologo],C.[ID_Cita], C.[Fecha]
	FROM [dbo].[Odontologo] O LEFT JOIN [dbo].[Cita] C
	ON O.Cedula_Odontologo = C.Odontologo
	WHERE (C.Fecha BETWEEN '01/01/2020' AND '31/12/2023') AND O.Cedula_Odontologo = 56481

/* 4.	Mostrar la cantidad total de citas atendidas en un Rango de Fechas. */

SELECT COUNT (*)  AS Cant_Citas_2023
	FROM [dbo].[Cita] C
	WHERE C.Fecha BETWEEN '01/01/2023' AND '31/12/2023'

/* 5.	Lista de los servicios aplicados por un paciente en particular. la consulta debe mostrar 
el código y nombre del paciente, así como la fecha, el código y el nombre del tratamiento. */

SELECT P.Nomb_Paciente, P.Apellidos_Paciente,C.ID_Cita, C.Fecha,C.Servicio_Solicitado
	FROM [dbo].[Cita] C LEFT JOIN [dbo].[Paciente] P
	ON C.Paciente = P.Cedula_Paciente
	WHERE P.Cedula_Paciente = 62344
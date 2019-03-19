DROP TABLE IF EXISTS "booking";
CREATE TABLE "booking" ("_id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , "username" VARCHAR NOT NULL , "bus_company" VARCHAR NOT NULL , "trip" VARCHAR NOT NULL , "date_time" VARCHAR, "price" DOUBLE NOT NULL , "promo_code" VARCHAR, "station" VARCHAR);
DROP TABLE IF EXISTS "promo";
CREATE TABLE "promo" ("_id" INTEGER PRIMARY KEY  NOT NULL ,"promo_value" TEXT NOT NULL ,"company_name" TEXT NOT NULL ,"trip_from" TEXT NOT NULL  DEFAULT (null) ,"promo_duration" TEXT NOT NULL ,"additional_info" TEXT NOT NULL , "trip_to" TEXT);
INSERT INTO "promo" VALUES(1,'10','Astral Express','Yobe','1st April 2016 - 21st May 2016','Purchase a ticket for this trip on this app to be eligible for this promotion','Kano');
INSERT INTO "promo" VALUES(6,'12','Astral Express','Yobe','1st April 2016 - 25th May 2016','Purchase a ticket for this trip on this app to be eligible for this promotion','Lagos');
INSERT INTO "promo" VALUES(7,'9','Astral Express','Yobe','1st April 2016 - 22nd May 2016','Purchase a ticket for this trip on this app to be eligible for this promotion','Abuja');
INSERT INTO "promo" VALUES(8,'15','Astral Express','Yobe','21st April 2016 - 30 May 2016','Purchase a ticket for this trip on this app to be eligible for this promotion','Port Harcourt');
DROP TABLE IF EXISTS "travels";
CREATE TABLE "travels" ("_id" INTEGER PRIMARY KEY  NOT NULL , "bus_company" VARCHAR(200) NOT NULL , "destination" VARCHAR(200) NOT NULL , "departure" DATETIME NOT NULL , "arrival" DATETIME NOT NULL , "price" DOUBLE NOT NULL , "station" VARCHAR(200) NOT NULL , "departure_time" TEXT, "arrival_time" TEXT);
INSERT INTO "travels" VALUES(1,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(2,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(3,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(4,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(5,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(6,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(7,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(8,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(9,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(10,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(11,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(12,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(13,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(14,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(15,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(16,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(17,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(18,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(19,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(20,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(21,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(22,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(23,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(24,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(25,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(26,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(27,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
INSERT INTO "travels" VALUES(28,'Road Express','Abuja','10/04/2016','10/04/2016',4000,'Postikum','13:30:00','19:30:00');
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" ("_id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , "username" VARCHAR(30) NOT NULL , "password" VARCHAR(6) NOT NULL , "email" VARCHAR(200) NOT NULL , "mobile" VARCHAR(17));
INSERT INTO "users" VALUES(1,'userexample','userpass','example@gmail.com','080237463723');

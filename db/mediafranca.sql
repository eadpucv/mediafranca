# ************************************************************
# Sequel Pro SQL dump
# Versión 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.10)
# Base de datos: mediafranca
# Tiempo de Generación: 2014-04-03 14:30:46 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Volcado de tabla circumscriptions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `circumscriptions`;

CREATE TABLE `circumscriptions` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla citizens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `citizens`;

CREATE TABLE `citizens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `img` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `citizens` WRITE;
/*!40000 ALTER TABLE `citizens` DISABLE KEYS */;

INSERT INTO `citizens` (`id`, `name`, `lastname`, `email`, `password`, `img`)
VALUES
	(1,'yes','Moya','t@gmail.com','39b358227b976b7e7c384f342b9d9f4b8aa27fab',''),
	(2,'Roro','Moya','roromt@gmail.com','55dcff4d8986ed98305b0be9789a10032e5bcf53','');

/*!40000 ALTER TABLE `citizens` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla citys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `citys`;

CREATE TABLE `citys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `osd_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla conversations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `conversations`;

CREATE TABLE `conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `first_publication` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;

INSERT INTO `conversations` (`id`, `title`, `citizen_id`, `first_publication`)
VALUES
	(4,'Primera publicacion ',1,3),
	(5,'bla',1,8),
	(6,'Asigna un tÃ­tulo',1,10),
	(7,'Nueva Publicacion',2,35);

/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla districts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `districts`;

CREATE TABLE `districts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `circumscription_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla multimedias
# ------------------------------------------------------------

DROP TABLE IF EXISTS `multimedias`;

CREATE TABLE `multimedias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publication_id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `url` text NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `multimedias` WRITE;
/*!40000 ALTER TABLE `multimedias` DISABLE KEYS */;

INSERT INTO `multimedias` (`id`, `publication_id`, `citizen_id`, `url`, `descripcion`)
VALUES
	(1,61,2,'http://www.demasiadaoreja.info/discos.jpg',NULL),
	(2,61,2,'http://www.laultimapapita.com/wp-content/uploads/2011/06/AchiraDiscoImaginario.jpg',NULL),
	(3,62,2,'http://www.laultimapapita.com/wp-content/uploads/2011/06/AchiraDiscoImaginario.jpg?9707a5',NULL),
	(4,62,2,'http://www.youtube.com/watch?v=fi1HL-Og49c&feature=related',NULL),
	(5,62,2,'http://www.google.cl/url?sa=t&source=web&cd=1&ved=0CBsQFjAA&url=http%3A%2F%2Fwww.dibam.cl%2Fpatrimonio_cultural%2Fpdf_revistas%2FRPC_50_low.pdf&rct=j&q=filetype%3Apdf%20historia%20chile&ei=mJgjTsaxKIWugQfM5b2-Cw&usg=AFQjCNEfUtrQxWOGZHefeqgG7ne5MHPgQg&cad=rja',NULL);

/*!40000 ALTER TABLE `multimedias` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla positions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `positions`;

CREATE TABLE `positions` (
  `id` int(11) NOT NULL,
  `coordenadas` varchar(200) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `publication_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;

INSERT INTO `positions` (`id`, `coordenadas`, `citizen_id`, `publication_id`)
VALUES
	(0,'-33.03975190521168,-71.57318115234375',1,7),
	(0,'-33.06277328703265,-71.39053344726562',1,29),
	(0,'-32.90265033334125,-68.84445190429688',1,30),
	(0,'-33.04550781490999,-71.59103393554688',2,36),
	(0,'-33.04550781490999,-71.59103393554688',2,37);

/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla publication_positions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `publication_positions`;

CREATE TABLE `publication_positions` (
  `publication_id` int(11) NOT NULL,
  `positions_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla publication_topics
# ------------------------------------------------------------

DROP TABLE IF EXISTS `publication_topics`;

CREATE TABLE `publication_topics` (
  `publication_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `publication_topics` WRITE;
/*!40000 ALTER TABLE `publication_topics` DISABLE KEYS */;

INSERT INTO `publication_topics` (`publication_id`, `topic_id`)
VALUES
	(4,16),
	(3,18),
	(3,17),
	(3,16),
	(5,19),
	(6,19),
	(7,19),
	(8,20),
	(9,20),
	(10,20),
	(11,20),
	(12,20),
	(13,20),
	(14,20),
	(15,20),
	(16,20),
	(17,20),
	(18,20),
	(19,20),
	(20,20),
	(21,20),
	(22,20),
	(23,20),
	(24,18),
	(25,18),
	(26,18),
	(27,18),
	(28,18),
	(29,21),
	(29,22),
	(30,23),
	(35,16),
	(35,24),
	(36,25),
	(36,18),
	(37,25),
	(37,18),
	(38,26),
	(38,21),
	(62,27),
	(62,28),
	(62,29);

/*!40000 ALTER TABLE `publication_topics` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla publications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `publications`;

CREATE TABLE `publications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `conversation_id` int(11) DEFAULT NULL,
  `title` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;

INSERT INTO `publications` (`id`, `date`, `citizen_id`, `conversation_id`, `title`)
VALUES
	(4,'2011-07-16 23:35:01',1,4,'Testeando '),
	(3,'2011-07-16 23:30:44',1,4,'Provando la creacion de una conversacion'),
	(5,'2011-07-16 23:43:39',1,4,'blabla'),
	(6,'2011-07-16 23:44:26',1,4,'blabla'),
	(7,'2011-07-16 23:45:15',1,4,'blabla'),
	(8,'2011-07-17 00:33:39',1,5,'blablabla 2 test'),
	(9,'2011-07-17 00:43:03',1,NULL,'blablabla 2 test'),
	(10,'2011-07-17 00:43:09',1,6,'blablabla 2 test'),
	(11,'2011-07-17 00:44:46',1,NULL,'blablabla 2 test'),
	(12,'2011-07-17 00:44:48',1,NULL,'blablabla 2 test'),
	(13,'2011-07-17 00:45:53',1,NULL,'blablabla 2 test'),
	(14,'2011-07-17 00:46:21',1,NULL,'blablabla 2 test'),
	(15,'2011-07-17 00:46:53',1,NULL,'blablabla 2 test'),
	(16,'2011-07-17 00:47:10',1,NULL,'blablabla 2 test'),
	(17,'2011-07-17 00:47:37',1,NULL,'blablabla 2 test'),
	(18,'2011-07-17 00:48:00',1,NULL,'blablabla 2 test'),
	(19,'2011-07-17 00:59:54',1,NULL,'blablabla 2 test'),
	(20,'2011-07-17 01:06:12',1,NULL,'blablabla 2 test'),
	(21,'2011-07-17 01:07:00',1,NULL,'blablabla 2 test'),
	(22,'2011-07-17 01:07:51',1,NULL,'blablabla 2 test'),
	(23,'2011-07-17 01:13:35',1,NULL,'blablabla 2 test'),
	(24,'2011-07-17 01:16:02',1,NULL,'blablabla 2 test'),
	(25,'2011-07-17 01:52:00',1,NULL,'blablabla 2 test'),
	(26,'2011-07-17 01:52:36',1,NULL,'blablabla 2 test'),
	(27,'2011-07-17 01:52:52',1,NULL,'blablabla 2 test'),
	(28,'2011-07-17 01:53:01',1,4,'blablabla 2 test'),
	(29,'2011-07-17 02:15:08',1,4,'Agregando Posicion'),
	(30,'2011-07-17 07:58:36',1,6,'Esta va con geoPunto'),
	(31,'2011-07-17 19:30:05',2,NULL,''),
	(32,'2011-07-17 19:31:45',2,NULL,''),
	(33,'2011-07-17 19:42:47',2,NULL,''),
	(34,'2011-07-17 19:44:48',2,NULL,''),
	(35,'2011-07-17 21:00:51',2,7,'Testeando desde villa alemana'),
	(36,'2011-07-17 21:29:17',2,7,'probando multimedia'),
	(37,'2011-07-17 21:33:45',2,7,'probando multimedia'),
	(38,'2011-07-17 21:34:49',2,7,'probando multimedia'),
	(39,'2011-07-17 21:37:00',2,7,'probando multimedia'),
	(40,'2011-07-17 21:38:24',2,7,'probando multimedia'),
	(41,'2011-07-17 21:49:37',2,7,'probando multimedia'),
	(42,'2011-07-17 21:50:04',2,7,'probando multimedia'),
	(43,'2011-07-17 21:53:25',2,7,'asdasd'),
	(44,'2011-07-17 21:54:11',2,7,'asdasd'),
	(45,'2011-07-17 21:55:14',2,7,'asdasd'),
	(46,'2011-07-17 21:55:51',2,7,'asdasd'),
	(47,'2011-07-17 21:56:02',2,7,'asdasd'),
	(48,'2011-07-17 21:56:30',2,7,'asdasd'),
	(49,'2011-07-17 21:57:07',2,7,'asdasd'),
	(50,'2011-07-17 21:57:28',2,7,'asdasd'),
	(51,'2011-07-17 21:58:17',2,7,'asdasd'),
	(52,'2011-07-17 21:59:24',2,7,'asdasd'),
	(53,'2011-07-17 22:00:34',2,7,'asdasd'),
	(54,'2011-07-17 22:01:11',2,7,'asdasd'),
	(55,'2011-07-17 22:02:39',2,7,'asdasd'),
	(56,'2011-07-17 22:02:58',2,7,'asdasd'),
	(57,'2011-07-18 01:48:06',2,5,'Agregando multimedia'),
	(58,'2011-07-18 01:57:20',2,5,'Agregando multimedia'),
	(59,'2011-07-18 01:58:08',2,5,'Agregando multimedia'),
	(60,'2011-07-18 02:02:03',2,5,'Agregando multimedia'),
	(61,'2011-07-18 02:02:20',2,5,'Agregando multimedia'),
	(62,'2011-07-18 02:24:32',2,5,'Partido de futbol en el barrio');

/*!40000 ALTER TABLE `publications` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla publications_multimedia
# ------------------------------------------------------------

DROP TABLE IF EXISTS `publications_multimedia`;

CREATE TABLE `publications_multimedia` (
  `publication_id` int(11) NOT NULL,
  `multimedia_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla ratings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ratings`;

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `publication_id` int(11) NOT NULL,
  `tipo` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;

INSERT INTO `ratings` (`id`, `citizen_id`, `publication_id`, `tipo`)
VALUES
	(0,1,6,'up'),
	(0,1,29,'up'),
	(0,1,4,'up');

/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla regions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `regions`;

CREATE TABLE `regions` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `sigla` int(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla relevances
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relevances`;

CREATE TABLE `relevances` (
  `id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `tipo` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `relevances` WRITE;
/*!40000 ALTER TABLE `relevances` DISABLE KEYS */;

INSERT INTO `relevances` (`id`, `citizen_id`, `conversation_id`, `tipo`)
VALUES
	(0,1,4,'up');

/*!40000 ALTER TABLE `relevances` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla representatives
# ------------------------------------------------------------

DROP TABLE IF EXISTS `representatives`;

CREATE TABLE `representatives` (
  `id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla senators
# ------------------------------------------------------------

DROP TABLE IF EXISTS `senators`;

CREATE TABLE `senators` (
  `id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `circumscription_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla topics
# ------------------------------------------------------------

DROP TABLE IF EXISTS `topics`;

CREATE TABLE `topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;

INSERT INTO `topics` (`id`, `title`)
VALUES
	(26,'multimedia'),
	(25,'chile'),
	(24,'Casa'),
	(23,'geopunto'),
	(22,'casas'),
	(21,'villa alemana'),
	(20,'joder'),
	(19,'blabla'),
	(18,'Valparaiso'),
	(17,'palacio'),
	(16,'perro'),
	(27,'futbol'),
	(28,'barrio'),
	(29,'robos');

/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` int(11) NOT NULL,
  `email` int(11) NOT NULL,
  `password` int(11) NOT NULL,
  `password_confirmation` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

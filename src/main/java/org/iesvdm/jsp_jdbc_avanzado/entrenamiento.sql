-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 23-08-2014 a las 11:18:07
-- Versión del servidor: 5.5.38-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


-- Base de datos: `baloncesto`
USE `baloncesto`;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `entrenamiento`
--
CREATE TABLE IF NOT EXISTS `entrenamiento` (
                               `entrenamientoID` int(11) NOT NULL auto_increment,
                               `tipo` varchar(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
                               `ubicacion` varchar(60) COLLATE utf8_spanish2_ci DEFAULT NULL,
                               `fecha` date DEFAULT NULL,
                               PRIMARY KEY (`entrenamientoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
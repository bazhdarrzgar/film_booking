-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 20, 2021 at 07:31 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `TAX_CALC` ()  BEGIN
DECLARE ch_done INT DEFAULT 0;
DECLARE C_A INT(10);
DECLARE C_B INT(10);
DECLARE C_C INT(10);
DECLARE C_net_amt DEC(10,2);

DECLARE C_tax DEC(10,2);

DECLARE C_Tprice CURSOR FOR
SELECT `price` AS A,`movie_id` AS B,`tax` AS C FROM `movie` WHERE `net_amt` IS NULL 
FOR UPDATE;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET ch_done = 1;

OPEN C_Tprice;
FETCH C_Tprice INTO C_A,C_B,C_C;

SET C_tax = (C_C/100);

SET C_net_amt=C_A + (C_A*C_tax);
UPDATE `movie` SET `net_amt`=C_net_amt where `movie_id`=C_B;

CLOSE C_Tprice;

IF(ch_done = 1) THEN 
        -- handle the No data error!
        SELECT 'Oh no!';
    END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admi`
--

CREATE TABLE `admi` (
  `username` varchar(20) NOT NULL,
  `pword` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admi`
--

INSERT INTO `admi` (`username`, `pword`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` int(5) NOT NULL,
  `movie_name` varchar(20) NOT NULL,
  `movie_lang` text NOT NULL,
  `movie_genre` text NOT NULL,
  `ratings` int(11) NOT NULL,
  `movie_des` text NOT NULL,
  `price` int(6) NOT NULL,
  `tax` int(11) NOT NULL DEFAULT 8,
  `net_amt` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `movie`
--


-- --------------------------------------------------------

--
-- Table structure for table `poster`
--

CREATE TABLE `poster` (
  `movie_name` varchar(20) NOT NULL,
  `poster_img` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `poster`
--

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `seat_id` int(5) NOT NULL,
  `date_time` datetime NOT NULL,
  `movie_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `no_seat` int(5) NOT NULL,
  `sts` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seats`
--

-- --------------------------------------------------------

--
-- Table structure for table `snacks`
--

CREATE TABLE `snacks` (
  `seat_id` int(11) NOT NULL,
  `snack_name` text NOT NULL,
  `no_snack` int(11) NOT NULL,
  `snack_amt` int(11) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `snacks`
--


-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL,
  `total_net_amt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ticket`
--

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(10) NOT NULL,
  `fullname` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `pword` varbinary(255) NOT NULL,
  `phone` bigint(15) NOT NULL,
  `email` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--


--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `pass_crypt` BEFORE INSERT ON `user` FOR EACH ROW SET new.pword := AES_ENCRYPT(new.pword,'kar')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reset_pass_crypt` BEFORE UPDATE ON `user` FOR EACH ROW SET new.pword := AES_ENCRYPT(new.pword,'kar')
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admi`
--
ALTER TABLE `admi`
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_id`),
  ADD UNIQUE KEY `movie_name` (`movie_name`);

--
-- Indexes for table `poster`
--
ALTER TABLE `poster`
  ADD KEY `movie_name` (`movie_name`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`seat_id`),
  ADD KEY `movie_id` (`movie_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `snacks`
--
ALTER TABLE `snacks`
  ADD KEY `seat_id` (`seat_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `seat_id` (`seat_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `movie_id` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `seat_id` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables

-- Constraints for table `poster`
--
ALTER TABLE `poster`
  ADD CONSTRAINT `poster_ibfk_1` FOREIGN KEY (`movie_name`) REFERENCES `movie` (`movie_name`),
  ADD CONSTRAINT `poster_ibfk_2` FOREIGN KEY (`movie_name`) REFERENCES `movie` (`movie_name`);

--
-- Constraints for table `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`),
  ADD CONSTRAINT `seats_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `snacks`
--
ALTER TABLE `snacks`
  ADD CONSTRAINT `snacks_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: Jun 14, 2025 at 06:09 PM
-- Server version: 9.3.0
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Student_loan`
--

-- --------------------------------------------------------

--
-- Table structure for table `Server_editLoan`
--

CREATE TABLE `Server_editLoan` (
  `server_status` varchar(10) NOT NULL,
  `open_date` date DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `study_year` varchar(10) NOT NULL,
  `updated_at` date DEFAULT NULL,
  `study_semester` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Server_editLoan`
--

INSERT INTO `Server_editLoan` (`server_status`, `open_date`, `close_date`, `study_year`, `updated_at`, `study_semester`) VALUES
('open', '2025-05-30', '2025-06-16', '2568', '2025-06-05', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Server_editLoan`
--
ALTER TABLE `Server_editLoan`
  ADD UNIQUE KEY `server` (`server_status`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 20, 2025 at 03:03 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

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
-- Table structure for table `daily_expenses_options`
--

CREATE TABLE `daily_expenses_options` (
  `category` varchar(50) NOT NULL,
  `sub_category` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sub_category`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_expenses_options`
--

INSERT INTO `daily_expenses_options` (`category`, `sub_category`) VALUES
('กู้ยืมค่าครองชีพจาก กยศ.', NULL),
('จากผู้ปกครอง', NULL),
('ทุนการศึกษา', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `education_level`
--

CREATE TABLE `education_level` (
  `level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `education_level`
--

INSERT INTO `education_level` (`level`) VALUES
('ประกาศนียบัตร'),
('ปริญญาตรี'),
('ปริญญาโท');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `Faculty` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`Faculty`) VALUES
('สำนักวิชาการจัดการ'),
('สำนักวิชาการแพทย์บูรณาการ'),
('สำนักวิชาจีนวิทยา'),
('สำนักวิชาทันตแพทยศาสตร์'),
('สำนักวิชานวัตกรรมสังคม'),
('สำนักวิชานิติศาสตร์'),
('สำนักวิชาพยาบาลศาสตร์'),
('สำนักวิชาวิทยาศาสตร์'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ'),
('สำนักวิชาวิทยาศาสตร์เครื่องสำอาง'),
('สำนักวิชาศิลปศาสตร์'),
('สำนักวิชาอุตสาหกรรมเกษตร'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์'),
('สำนักวิชาเวชศาสตร์ชะลอวัยและฟื้นฟูสุขภาพ'),
('สำนักวิชาแพทยศาสตร์');

-- --------------------------------------------------------

--
-- Table structure for table `field_of_study`
--

CREATE TABLE `field_of_study` (
  `Faculty` varchar(50) NOT NULL,
  `Field_of_study` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `field_of_study`
--

INSERT INTO `field_of_study` (`Faculty`, `Field_of_study`) VALUES
('สำนักวิชาศิลปศาสตร์', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาอังกฤษ'),
('สำนักวิชาศิลปศาสตร์', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาและวัฒนธรรมไทยสำหรับชาวต่างประเทศ'),
('สำนักวิชาศิลปศาสตร์', 'หลักสูตรศิลปศาสตรมหาบัณฑิต  สาขาวิชาภาษาอังกฤษเพื่อการพัฒนาวิชาชีพ'),
('สำนักวิชาศิลปศาสตร์', 'หลักสูตรปรัชญาดุษฎีบัณฑิต  สาขาวิชาภาษาอังกฤษเพื่อการพัฒนาวิชาชีพ '),
('สำนักวิชาการจัดการ', 'หลักสูตรบัญชีบัณฑิต'),
('สำนักวิชาการจัดการ', 'หลักสูตรเศรษฐศาสตรบัณฑิต'),
('สำนักวิชาการจัดการ', 'หลักสูตรบริหารธุรกิจบัณฑิต'),
('สำนักวิชาการจัดการ', 'หลักสูตรบริหารธุรกิจมหาบัณฑิต สาขาวิชาการจัดการโลจิสติกส์และโซ่อุปทานระหว่างประเทศ'),
('สำนักวิชาการจัดการ', 'หลักสูตรบริหารธุรกิจมหาบัณฑิต สาขาวิชาผู้นำธุรกิจสุขภาพเชิงสร้างสรรค์'),
('สำนักวิชาการจัดการ', 'หลักสูตรบริหารธุรกิจมหาบัณฑิต สาขาวิชาบริหารธุรกิจ  '),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาเทคโนโลยีดิจิทัลเพื่อนวัตกรรมทางธุรกิจ'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาวิทยาการคอมพิวเตอร์และนวัตกรรม'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาเทคโนโลยีมัลติมีเดียและการสร้างภาพเคลื่อนไหว'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิศวกรรมศาสตรบัณฑิต สาขาวิชาวิศวกรรมซอฟต์แวร์'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิศวกรรมศาสตรบัณฑิต สาขาวิชาวิศวกรรมคอมพิวเตอร์'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิศวกรรมศาสตรบัณฑิต สาขาวิชาวิศวกรรมดิจิทัลและการสื่อสาร'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรวิศวกรรมศาสตรมหาบัณฑิต สาขาวิชาวิศวกรรมคอมพิวเตอร์'),
('สำนักวิชาเทคโนโลยีดิจิทัลประยุกต์', 'หลักสูตรปรัชญาดุษฎีบัณฑิต สาขาวิชาวิศวกรรมคอมพิวเตอร์'),
('สำนักวิชาอุตสาหกรรมเกษตร', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชานวัตกรรมวิทยาศาสตร์และเทคโนโลยีอาหาร'),
('สำนักวิชาอุตสาหกรรมเกษตร', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาโลจิสติกส์เกษตรและอาหาร'),
('สำนักวิชาอุตสาหกรรมเกษตร', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชานวัตกรรมวิทยาศาสตร์และเทคโนโลยีอาหาร'),
('สำนักวิชาอุตสาหกรรมเกษตร', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาเทคโนโลยีและนวัตกรรมหลังการเก็บเกี่ยว'),
('สำนักวิชานิติศาสตร์', 'หลักสูตรนิติศาสตรบัณฑิต'),
('สำนักวิชานิติศาสตร์', 'หลักสูตรนิติศาสตรบัณฑิต สาขาวิชากฎหมายธุรกิจและการสื่อสารด้วยภาษาจีน'),
('สำนักวิชานิติศาสตร์', 'หลักสูตรนิติศาสตรมหาบัณฑิต'),
('สำนักวิชาวิทยาศาสตร์เครื่องสำอาง', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาวิทยาศาสตร์เครื่องสำอาง'),
('สำนักวิชาวิทยาศาสตร์เครื่องสำอาง', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาเทคโนโลยีความงาม'),
('สำนักวิชาวิทยาศาสตร์เครื่องสำอาง', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาวิทยาศาสตร์เครื่องสำอาง'),
('สำนักวิชาวิทยาศาสตร์เครื่องสำอาง', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชานวัตกรรมวิทยาศาสตร์เครื่องสำอางเชิงสร้างสรรค์'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรสาธารณสุขศาสตรบัณฑิต'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาวิทยาศาสตร์การกีฬาและสุขภาพ'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาอนามัยสิ่งแวดล้อม'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาอาชีวอนามัยและความปลอดภัย'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรสาธารณสุขศาสตรมหาบัณฑิต สาขาวิชาการจัดการสุขภาพชายแดน'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาวิทยาการวิเคราะห์ทางสุขภาพและชีวการแพทย์'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาเทคโนโลยีและการจัดการสิ่งแวดล้อมอย่างยั่งยืน'),
('สำนักวิชาวิทยาศาสตร์สุขภาพ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิทยาศาสตร์และเทคโนโลยีการกีฬาประยุกต์'),
('สำนักวิชาพยาบาลศาสตร์', 'หลักสูตรประกาศนียบัตรผู้ช่วยพยาบาล'),
('สำนักวิชาพยาบาลศาสตร์', 'หลักสูตรพยาบาลศาสตรบัณฑิต'),
('สำนักวิชาเวชศาสตร์ชะลอวัยและฟื้นฟูสุขภาพ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาตจวิทยา'),
('สำนักวิชาเวชศาสตร์ชะลอวัยและฟื้นฟูสุขภาพ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาเวชศาสตร์ชะลอวัยและฟื้นฟูสุขภาพ'),
('สำนักวิชาเวชศาสตร์ชะลอวัยและฟื้นฟูสุขภาพ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาวิทยาศาสตร์ชะลอวัยและฟื้นฟูสุขภาพ'),
('สำนักวิชาแพทยศาสตร์', 'หลักสูตรแพทยศาสตรบัณฑิต'),
('สำนักวิชาแพทยศาสตร์', 'หลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาวิทยาศาสตร์การแพทย์'),
('สำนักวิชานวัตกรรมสังคม', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาการพัฒนาระหว่างประเทศ'),
('สำนักวิชานวัตกรรมสังคม', 'หลักสูตรศิลปศาสตรมหาบัณฑิต สาขาวิชาการพัฒนาระหว่างประเทศ'),
('สำนักวิชาจีนวิทยา', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาจีนศึกษา'),
('สำนักวิชาจีนวิทยา', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาจีนธุรกิจ'),
('สำนักวิชาจีนวิทยา', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาและวัฒนธรรมจีน'),
('สำนักวิชาจีนวิทยา', 'หลักสูตรศึกษาศาสตรบัณฑิต สาขาวิชาการสอนภาษาจีน'),
('สำนักวิชาการแพทย์บูรณาการ', 'หลักสูตรกายภาพบำบัดบัณฑิต'),
('สำนักวิชาการแพทย์บูรณาการ', 'หลักสูตรการแพทย์แผนไทยประยุกต์บัณฑิต'),
('สำนักวิชาการแพทย์บูรณาการ', 'หลักสูตรการแพทย์แผนจีนบัณฑิต'),
('สำนักวิชาการแพทย์บูรณาการ', 'หลักสูตรวิทยาศาสตรมหาบัณฑิต สาขาวิชาการส่งเสริมสุขภาพด้วยการแพทย์บูรณาการ'),
('สำนักวิชาทันตแพทยศาสตร์', 'หลักสูตรประกาศนียบัตรผู้ช่วยทันตแพทย์'),
('สำนักวิชาทันตแพทยศาสตร์', 'หลักสูตรทันตแพทยศาสตรบัณฑิต');

-- --------------------------------------------------------

--
-- Table structure for table `form_response`
--

CREATE TABLE `form_response` (
  `id` bigint(255) NOT NULL,
  `user_lvlStudy` varchar(50) NOT NULL,
  `user_yearStudy` int(10) DEFAULT NULL,
  `user_semesterStudy` tinyint(2) NOT NULL,
  `user_faculty` varchar(200) NOT NULL,
  `user_fieldStudy` varchar(200) NOT NULL,
  `user_studentID` text NOT NULL,
  `user_gpax` decimal(3,2) NOT NULL,
  `user_loanType` varchar(50) DEFAULT NULL,
  `user_username` text NOT NULL,
  `user_surname` text NOT NULL,
  `user_old` bigint(50) NOT NULL,
  `user_phoneNumber` text NOT NULL,
  `user_citizenID` text NOT NULL,
  `user_graduateLvl` varchar(50) NOT NULL,
  `daily_expenses_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`daily_expenses_options`)),
  `occupation` varchar(100) DEFAULT NULL,
  `income` bigint(50) DEFAULT NULL,
  `loan_purposes_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`loan_purposes_options`)),
  `Public_Service_Number` int(11) NOT NULL,
  `Public_Service_File` longtext NOT NULL,
  `dad_status` varchar(50) NOT NULL,
  `dad_citizenID` text DEFAULT NULL,
  `dad_name` text DEFAULT NULL,
  `dad_surname` text DEFAULT NULL,
  `dad_phoneNumber` text DEFAULT NULL,
  `dad_email` text DEFAULT NULL,
  `dad_job` varchar(100) DEFAULT NULL,
  `dad_income` longtext DEFAULT NULL,
  `dad_file` varchar(100) DEFAULT NULL,
  `dad_death_certificate_file` longtext DEFAULT NULL,
  `mom_status` varchar(50) DEFAULT NULL,
  `mom_citizenID` text DEFAULT NULL,
  `mom_name` text DEFAULT NULL,
  `mom_surname` text DEFAULT NULL,
  `mom_phoneNumber` text DEFAULT NULL,
  `mom_email` text DEFAULT NULL,
  `mom_job` varchar(100) DEFAULT NULL,
  `mom_income` int(50) DEFAULT NULL,
  `mom_file` longtext DEFAULT NULL,
  `mom_death_certificate_file` longtext DEFAULT NULL,
  `Marital_status_of_parents` varchar(50) NOT NULL,
  `Marital_status_of_parents_file` longtext DEFAULT NULL,
  `other_status` varchar(50) DEFAULT NULL,
  `other_citizenID` text DEFAULT NULL,
  `other_name` text DEFAULT NULL,
  `other_surname` text DEFAULT NULL,
  `other_phoneNumber` text DEFAULT NULL,
  `other_email` text DEFAULT NULL,
  `other_job` varchar(100) DEFAULT NULL,
  `other_income` bigint(50) DEFAULT NULL,
  `other_file` longtext DEFAULT NULL,
  `other_relationship` varchar(50) DEFAULT NULL,
  `rightful_guardian` varchar(50) NOT NULL,
  `loan_status` varchar(50) DEFAULT 'อยู่ระหว่างดำเนินการ',
  `loan_details` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `public_id` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_response`
--

INSERT INTO `form_response` (`id`, `user_lvlStudy`, `user_yearStudy`, `user_semesterStudy`, `user_faculty`, `user_fieldStudy`, `user_studentID`, `user_gpax`, `user_loanType`, `user_username`, `user_surname`, `user_old`, `user_phoneNumber`, `user_citizenID`, `user_graduateLvl`, `daily_expenses_options`, `occupation`, `income`, `loan_purposes_options`, `Public_Service_Number`, `Public_Service_File`, `dad_status`, `dad_citizenID`, `dad_name`, `dad_surname`, `dad_phoneNumber`, `dad_email`, `dad_job`, `dad_income`, `dad_file`, `dad_death_certificate_file`, `mom_status`, `mom_citizenID`, `mom_name`, `mom_surname`, `mom_phoneNumber`, `mom_email`, `mom_job`, `mom_income`, `mom_file`, `mom_death_certificate_file`, `Marital_status_of_parents`, `Marital_status_of_parents_file`, `other_status`, `other_citizenID`, `other_name`, `other_surname`, `other_phoneNumber`, `other_email`, `other_job`, `other_income`, `other_file`, `other_relationship`, `rightful_guardian`, `loan_status`, `loan_details`, `created_at`, `public_id`) VALUES
(50, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาทันตแพทยศาสตร์', 'หลักสูตรทันตแพทยศาสตรบัณฑิต', '6531501001', 3.14, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4oeC4nOC4hyIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.xjgd6jlP5b4MyLkCVVFuagpYvH-EnRl63iUmrHqP0gA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4geC4oyIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.3615zN4RKTfhwdvrpOAFyrLBKWZhpPVWIxek_HzcYkE', 21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNTEyMzQxMjUiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.KgbBKx5NRAwUceZzyo9mLbxYkaFKnMpMbvkitB9Bx9s', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjUyMTQxMjUxMjUxMjQiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.BcQi_ccIEeakSAb2qr6iugqrzYhtT9ef4QL3MRS3VFs', 'ปวช./ปวส./ปวท.', '[\"ทุนการศึกษา\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\"]', 412312, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL1B1YmxpY19TZXJ2aWNlX0ZpbGVfMTc0MDQ4NTgyOTUxN19MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQwNDg1ODI5LCJleHAiOjQ4OTYyNDU4Mjl9.bxo6AEFd8Aljrw8vGylDelEgrDENtKatj_vXG613bjc', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjQyMTQxMjMxMzIxMzEiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.iW3WkrwzXWpVXqpcQ_n5j_Ng7ymLDW7CkvC3DIdRxsg', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4meC4suC4mSIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.jdVAvgDuFDxVCp37ma37tQnlG-AURQOvEunUfqsizAU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4s-C4geC4siIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.Nkkjr6kat_3obiyf4cSSX6FTTI-OYNJHknFlnLxeOYo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1MTUxMjMxMjMiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.zsc0P7x6hauGKlrkn2z8fIAPtaVXP7q-Es8y0cHMUXI', NULL, 'หมอ', 249994, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL290aGVyX2ZpbGVfMTc0MDQ4NTgyOTUxOV9MYWJUZXN0MS5wZGYiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.6t1Df-q5a8WwTRdWaBaUW_LjaSklmEioXmgSt4b2pa8', NULL, 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ตีกลับเพื่อแก้เอกสาร', NULL, '2025-02-25 12:17:09', '807f629e-725a-4c71-adbc-257a66d7b558'),
(51, 'ปริญญาตรี', 2567, 2, 'สำนักวิชานวัตกรรมสังคม', 'หลักสูตรศิลปศาสตรมหาบัณฑิต สาขาวิชาการพัฒนาระหว่างประเทศ', '6531501001', 3.18, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4oSIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.SHDjbNAdPm83DKYAJCDhA9C8TuPaX5Ppqv0IF4PtS6E', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4oeC4gSIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.YlmbNC8aEFV1ZHDb058NS6m_YXER-9Y6TKiY0SpITVM', 22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjAxMjQxMjMxMjQiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.AoshH9pMtWeghhVjxbMed3gBlnT5g4G7saRQPIImstU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIzMTI0MTIzMTIzMTIiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.9F9W4UF3p3cuT2zqK5lW91yckGRbjCI-p2j5yZbdYWk', 'ปริญญาตรี', '[\"จากผู้ปกครอง\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\",\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 3124, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL1B1YmxpY19TZXJ2aWNlX0ZpbGVfMTc0MDU3NDk4NDkwM19QSEFUVEFSQURBTkFJIFBST01NQU5FRSAtIE1EMDMtUHJvamVjdDEucGRmIiwiaWF0IjoxNzQwNTc0OTg0LCJleHAiOjQ4OTYzMzQ5ODR9.kkWr-bo1Jx3fYyjfhlglQuRr9v2nMzpE9PZRLQJVxEQ', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzQxMjMxMjQyMTMiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.4SUcoVcIk7mcIpqNeZjDuVnwKdXa2STlUJcT35_yloU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4n-C4qyIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.IC7XFlDIZp1i07nCeSdhkkehdmBPJNJaxpPq9PvvTgY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4q-C4nyIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.gsDlHPjBkznD_geDKbQy3tU7YDYkNgXEI0OGwR-1VTM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjIzMTMxMjMiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.w8_AsXLS4LengC7y1oBljZFvctz8So3AmsxP1tU1xcA', NULL, 'หมอ', 270000, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL290aGVyX2ZpbGVfMTc0MDU3NDk4NDkwN19QSEFUVEFSQURBTkFJLVBST01NQU5FRS1NRDAyLURhcnQtQ29ubmVjdGlvbi5wZGYiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.d5oEM54pvYH9SmlJxtAsdTYkYMyJJUHZRaU0kcYfhEE', 'ลุง', 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ตีกลับเพื่อแก้เอกสาร', NULL, '2025-02-26 13:03:04', 'b280297e-c5f0-48a4-817f-eb4c8e9e9831'),
(52, 'ประกาศนียบัตร', 2567, 2, 'สำนักวิชาทันตแพทยศาสตร์', 'หลักสูตรทันตแพทยศาสตรบัณฑิต', '6531501001', 3.12, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC5geC4geC5iTEiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.9pvVkvmE05m4WoNSbpc4ZYnPBFbeBCVo7lwFkkH_4ec', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC5geC4geC5iTIiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.tY0gRQ9Vy5Fyz7MmD7wmpZd0xzBtFto4Rz3xRX683IE', 23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjExMTExMTIzMTIiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.MhPkgCh7E_QcdAIcOB_11XdFPVBDI1IWr80mLtJo7hU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjU1MTI0MTIxMjMxMjMiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.FV1ycTGZVVuP5k8h13tXQ8L2pSqT0QlUVkYV0vpGqaY', 'ปริญญาตรี', '[\"ทุนการศึกษา\",\"กู้ยืมค่าครองชีพจาก กยศ.\",\"จากการประกอบอาชีพ\"]', 'แก้3', 213214, '[\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQxODA4MDY3MTg0X1BIQVRUQVJBREFOQUkgUFJPTU1BTkVFIC0gTUQwMi1EYXJ0LUNvbm5lY3Rpb24ucGRmIiwiaWF0IjoxNzQxODA4MDY3LCJleHAiOjQ4OTc1NjgwNjd9._ga-K68ZUG1Jf7hpqaI7PuSdCQbLZV7iQ4PFcPnWL_A', 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มีชีวิตอยู่', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNDEyMzEyMzEyMzEiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.YKHFyTuXIZYA6bMQtPTcK5bcWQ0ldOuUsHt-wWqrbRU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4lOC4reC4gSIsImlhdCI6MTc0MTgwODA2NywiZXhwIjo0ODk3NTY4MDY3fQ.lSjdp2EVbyeavoQZUQPfsXJ259QntZMcBlQRIOdCj8s', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4ouC4geC4q-C4gSIsImlhdCI6MTc0MTgwODA2NywiZXhwIjo0ODk3NTY4MDY3fQ.CLhwzR-IDb5zg5Ibb1dVssWdlu2fcVQVZasK08mqwOI', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzEyMzEyMzEiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.4jE1P4OsJsDidegRbjcpuJcK2y0xxcdClKPNu49BbZs', NULL, 'แม่ค้า', 299999, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvbW9tX2ZpbGVfMTc0MTgwODA2NzE4N19QSEFUVEFSQURBTkFJLVBST01NQU5FRS1NRDAyLURhcnQtQ29ubmVjdGlvbi5wZGYiLCJpYXQiOjE3NDE4MDgwNjcsImV4cCI6NDg5NzU2ODA2N30.vHDg60zA43SaVLF_2ihvbMPesuXHJyskP9DXmPmNhVI', NULL, 'ไม่ทราบ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มารดาเพียงผู้เดียว', 'อยู่ระหว่างดำเนินการ', NULL, '2025-02-26 18:29:57', '8e233159-30af-456a-a5dc-bc98a14584cc'),
(53, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาการแพทย์บูรณาการ', 'หลักสูตรการแพทย์แผนไทยประยุกต์บัณฑิต', '6531501001', 3.12, 'ลักษณะที่ 1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4q-C4geC5hCIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.poodjvCzRZkCoochnUGCNgoNLlxI8Bf1zS-ua1br0Ng', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC5hOC4n-C4q-C4gSIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.YSndTs0T3Wq09kbRkCYqk4PIyHur2jI7-1H9-nNrej4', 31, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIxMzEyNDIxNDIiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.kXBooS0h1O1X9U4LgU0qU-dne0XgihhbY-wbUBSnIlU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjMyMTQxNDIxMzMiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.gbpMRAJJCV6mh2bMhK2vJbsPsM_fo5pPUk4jusUJPPM', 'ปวช./ปวส./ปวท.', '[\"จากผู้ปกครอง\",\"จากการประกอบอาชีพ\"]', '7-11', 6500, '[\"ค่าครองชีพ\"]', 122, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQwNzc0MDIxNDgyX0xhYiAxIHN1bW1hcnkgNjUzMTUwMTAwMS5wZGYiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.wN1bBkRImGNTAieqJa3PgsFGMg6NZ6DJNXWkLOFUVzA', 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มีชีวิตอยู่', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjMxMjMxMzEzMjEiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.Xf2iFmUFSGkZJTSXOm9kI-DfQtViGL2mhwVRWlHItn0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4q-C4n-C4geC5hOC4nyIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.JhZRxxOkaDEqDdGEZXyM6GiYUCECzUGHdljF5lLaKzA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4n-C4q-C4geC5hOC4nyIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.VoUeSsTTM7mcwdKEbd0uu-fUZ_aZBbpNVk9q18oX3Nw', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzEyMzIxMzEiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.khHu-ROIPDI0duIk5_v0ajjgg-yEwCpN1kdBHOM6sXc', NULL, 'หมอ', 231213, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvbW9tX2ZpbGVfMTc0MDc3NDAyMTQ4NV9MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQwNzc0MDIxLCJleHAiOjQ4OTY1MzQwMjF9.tWgcKLcCzv42cPxm248tJnH_T07RIiwsRWmVE426CK8', NULL, 'ไม่ทราบ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มารดาเพียงผู้เดียว', 'อยู่ระหว่างดำเนินการ', '', '2025-02-26 18:50:14', '112ab616-b873-443a-a6cf-1def4232ae38'),
(54, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาพยาบาลศาสตร์', 'หลักสูตรพยาบาลศาสตรบัณฑิต', '6531501001', 3.15, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4q-C4gSIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.G6FFUA4eepJr7hIgSaFuM9NWtjSuojAGRocnnLAsvfo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4n-C4q-C4nyIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.6HxFkAHSqlpZ_adZVYCEyS701bTjeFyaIpb1vXLXIfQ', 23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNDEyNTEyNDEiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.RokHUTggvUAEuLGw19sZEZ9ESlxrE_Gtl8h6yLjVzgM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1Nzk5MDEwMTI0MTIiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.nyG5Tnz-mitMpxo9N-lhIkXEQd7AWOAdJHbiMsgwIvM', 'ปริญญาตรี', '[\"จากผู้ปกครอง\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าเล่าเรียน\",\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQxNzg5MTYyMTA0X1BlcnNvbmFsLURhdGEtQ29sbGVjdGlvbi1Xb3Jrc2hlZXQtZm9yLUNhcmJvbi1Gb290cHJpbnQtQ2FsY3VsYXRpb24ucGRmIiwiaWF0IjoxNzQxNzg5MTYyLCJleHAiOjQ4OTc1NDkxNjJ9.n7Ovn8bnWLTN0VHd3RJ3YD9it8Qzsqh_YZJDVaGg7HU', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzE0MTIxMjMyMTQiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.UNBGTXt4I5S8reSEHMcjjrqcJcho_HXssZpsIhXrspo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4gSIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.GBtTaQJHzhjd9fwTgKW0eGB2XIBM9fzN-3ikSki4EPs', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4n-C5hOC4gSIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.47ub3LN6wyBl4IqS8Yq5qc1ChZHtqY1vTvsoO1VwhKc', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjAxMjUxNTIxMzEiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.9z8nntzp8Vpi8LwINupPz3K22nU2EQ-N4F2uieFyMl4', NULL, 'หมอ', 99999, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvb3RoZXJfZmlsZV8xNzQxNzg5MTYyMTA5X1BIQVRUQVJBREFOQUkgUFJPTU1BTkVFIC0gTUQwMy1Qcm9qZWN0MS5wZGYiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.WOwzoWq3j7rEGJDv88MaMIiKXQtfmEo4KljOHyXs3FQ', NULL, 'ผู้ปกครองไม่ใช่บิดา มารดา', 'อนุมัติ', '', '2025-03-12 14:19:22', 'd8f7d663-e603-43b8-99dc-93013dd9ca70'),
(55, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาการแพทย์บูรณาการ', 'หลักสูตรการแพทย์แผนไทยประยุกต์บัณฑิต', '6531501001', 3.12, 'ลักษณะที่ 1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4q-C4geC5hCIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.poodjvCzRZkCoochnUGCNgoNLlxI8Bf1zS-ua1br0Ng', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC5hOC4n-C4q-C4gSIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.YSndTs0T3Wq09kbRkCYqk4PIyHur2jI7-1H9-nNrej4', 31, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIxMzEyNDIxNDIiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.kXBooS0h1O1X9U4LgU0qU-dne0XgihhbY-wbUBSnIlU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjMyMTQxNDIxMzMiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.gbpMRAJJCV6mh2bMhK2vJbsPsM_fo5pPUk4jusUJPPM', 'ปวช./ปวส./ปวท.', '[\"จากผู้ปกครอง\",\"จากการประกอบอาชีพ\"]', '7-11', 6500, '[\"ค่าครองชีพ\"]', 122, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQwNzc0MDIxNDgyX0xhYiAxIHN1bW1hcnkgNjUzMTUwMTAwMS5wZGYiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.wN1bBkRImGNTAieqJa3PgsFGMg6NZ6DJNXWkLOFUVzA', 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มีชีวิตอยู่', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjMxMjMxMzEzMjEiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.Xf2iFmUFSGkZJTSXOm9kI-DfQtViGL2mhwVRWlHItn0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4q-C4n-C4geC5hOC4nyIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.JhZRxxOkaDEqDdGEZXyM6GiYUCECzUGHdljF5lLaKzA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4n-C4q-C4geC5hOC4nyIsImlhdCI6MTc0MDc3NDAyMSwiZXhwIjo0ODk2NTM0MDIxfQ.VoUeSsTTM7mcwdKEbd0uu-fUZ_aZBbpNVk9q18oX3Nw', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzEyMzIxMzEiLCJpYXQiOjE3NDA3NzQwMjEsImV4cCI6NDg5NjUzNDAyMX0.khHu-ROIPDI0duIk5_v0ajjgg-yEwCpN1kdBHOM6sXc', NULL, 'หมอ', 231213, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvbW9tX2ZpbGVfMTc0MDc3NDAyMTQ4NV9MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQwNzc0MDIxLCJleHAiOjQ4OTY1MzQwMjF9.tWgcKLcCzv42cPxm248tJnH_T07RIiwsRWmVE426CK8', NULL, 'ไม่ทราบ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มารดาเพียงผู้เดียว', 'อยู่ระหว่างดำเนินการ', '', '2025-02-26 18:50:14', '112ab616-b873-443a-a6cf-1def4232ae38'),
(56, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาพยาบาลศาสตร์', 'หลักสูตรพยาบาลศาสตรบัณฑิต', '6531501001', 3.15, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4q-C4gSIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.G6FFUA4eepJr7hIgSaFuM9NWtjSuojAGRocnnLAsvfo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4n-C4q-C4nyIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.6HxFkAHSqlpZ_adZVYCEyS701bTjeFyaIpb1vXLXIfQ', 23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNDEyNTEyNDEiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.RokHUTggvUAEuLGw19sZEZ9ESlxrE_Gtl8h6yLjVzgM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1Nzk5MDEwMTI0MTIiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.nyG5Tnz-mitMpxo9N-lhIkXEQd7AWOAdJHbiMsgwIvM', 'ปริญญาตรี', '[\"จากผู้ปกครอง\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าเล่าเรียน\",\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQxNzg5MTYyMTA0X1BlcnNvbmFsLURhdGEtQ29sbGVjdGlvbi1Xb3Jrc2hlZXQtZm9yLUNhcmJvbi1Gb290cHJpbnQtQ2FsY3VsYXRpb24ucGRmIiwiaWF0IjoxNzQxNzg5MTYyLCJleHAiOjQ4OTc1NDkxNjJ9.n7Ovn8bnWLTN0VHd3RJ3YD9it8Qzsqh_YZJDVaGg7HU', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzE0MTIxMjMyMTQiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.UNBGTXt4I5S8reSEHMcjjrqcJcho_HXssZpsIhXrspo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4gSIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.GBtTaQJHzhjd9fwTgKW0eGB2XIBM9fzN-3ikSki4EPs', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4n-C5hOC4gSIsImlhdCI6MTc0MTc4OTE2MiwiZXhwIjo0ODk3NTQ5MTYyfQ.47ub3LN6wyBl4IqS8Yq5qc1ChZHtqY1vTvsoO1VwhKc', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjAxMjUxNTIxMzEiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.9z8nntzp8Vpi8LwINupPz3K22nU2EQ-N4F2uieFyMl4', NULL, 'หมอ', 99999, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvb3RoZXJfZmlsZV8xNzQxNzg5MTYyMTA5X1BIQVRUQVJBREFOQUkgUFJPTU1BTkVFIC0gTUQwMy1Qcm9qZWN0MS5wZGYiLCJpYXQiOjE3NDE3ODkxNjIsImV4cCI6NDg5NzU0OTE2Mn0.WOwzoWq3j7rEGJDv88MaMIiKXQtfmEo4KljOHyXs3FQ', NULL, 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ไม่อนุมัติ', '', '2025-03-12 14:19:22', 'd8f7d663-e603-43b8-99dc-93013dd9ca70'),
(57, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาทันตแพทยศาสตร์', 'หลักสูตรทันตแพทยศาสตรบัณฑิต', '6531501001', 3.14, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4oeC4nOC4hyIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.xjgd6jlP5b4MyLkCVVFuagpYvH-EnRl63iUmrHqP0gA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4geC4oyIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.3615zN4RKTfhwdvrpOAFyrLBKWZhpPVWIxek_HzcYkE', 21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNTEyMzQxMjUiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.KgbBKx5NRAwUceZzyo9mLbxYkaFKnMpMbvkitB9Bx9s', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjUyMTQxMjUxMjUxMjQiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.BcQi_ccIEeakSAb2qr6iugqrzYhtT9ef4QL3MRS3VFs', 'ปวช./ปวส./ปวท.', '[\"ทุนการศึกษา\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\"]', 412312, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL1B1YmxpY19TZXJ2aWNlX0ZpbGVfMTc0MDQ4NTgyOTUxN19MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQwNDg1ODI5LCJleHAiOjQ4OTYyNDU4Mjl9.bxo6AEFd8Aljrw8vGylDelEgrDENtKatj_vXG613bjc', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjQyMTQxMjMxMzIxMzEiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.iW3WkrwzXWpVXqpcQ_n5j_Ng7ymLDW7CkvC3DIdRxsg', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4meC4suC4mSIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.jdVAvgDuFDxVCp37ma37tQnlG-AURQOvEunUfqsizAU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4s-C4geC4siIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.Nkkjr6kat_3obiyf4cSSX6FTTI-OYNJHknFlnLxeOYo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1MTUxMjMxMjMiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.zsc0P7x6hauGKlrkn2z8fIAPtaVXP7q-Es8y0cHMUXI', NULL, 'หมอ', 249994, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL290aGVyX2ZpbGVfMTc0MDQ4NTgyOTUxOV9MYWJUZXN0MS5wZGYiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.6t1Df-q5a8WwTRdWaBaUW_LjaSklmEioXmgSt4b2pa8', NULL, 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ตีกลับเพื่อแก้เอกสาร', NULL, '2025-02-25 12:17:09', '807f629e-725a-4c71-adbc-257a66d7b558'),
(58, 'ปริญญาตรี', 2567, 2, 'สำนักวิชานวัตกรรมสังคม', 'หลักสูตรศิลปศาสตรมหาบัณฑิต สาขาวิชาการพัฒนาระหว่างประเทศ', '6531501001', 3.18, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4oSIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.SHDjbNAdPm83DKYAJCDhA9C8TuPaX5Ppqv0IF4PtS6E', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4oeC4gSIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.YlmbNC8aEFV1ZHDb058NS6m_YXER-9Y6TKiY0SpITVM', 22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjAxMjQxMjMxMjQiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.AoshH9pMtWeghhVjxbMed3gBlnT5g4G7saRQPIImstU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIzMTI0MTIzMTIzMTIiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.9F9W4UF3p3cuT2zqK5lW91yckGRbjCI-p2j5yZbdYWk', 'ปริญญาตรี', '[\"จากผู้ปกครอง\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\",\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 3124, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL1B1YmxpY19TZXJ2aWNlX0ZpbGVfMTc0MDU3NDk4NDkwM19QSEFUVEFSQURBTkFJIFBST01NQU5FRSAtIE1EMDMtUHJvamVjdDEucGRmIiwiaWF0IjoxNzQwNTc0OTg0LCJleHAiOjQ4OTYzMzQ5ODR9.kkWr-bo1Jx3fYyjfhlglQuRr9v2nMzpE9PZRLQJVxEQ', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzQxMjMxMjQyMTMiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.4SUcoVcIk7mcIpqNeZjDuVnwKdXa2STlUJcT35_yloU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4n-C4qyIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.IC7XFlDIZp1i07nCeSdhkkehdmBPJNJaxpPq9PvvTgY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4q-C4nyIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.gsDlHPjBkznD_geDKbQy3tU7YDYkNgXEI0OGwR-1VTM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjIzMTMxMjMiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.w8_AsXLS4LengC7y1oBljZFvctz8So3AmsxP1tU1xcA', NULL, 'หมอ', 270000, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL290aGVyX2ZpbGVfMTc0MDU3NDk4NDkwN19QSEFUVEFSQURBTkFJLVBST01NQU5FRS1NRDAyLURhcnQtQ29ubmVjdGlvbi5wZGYiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.d5oEM54pvYH9SmlJxtAsdTYkYMyJJUHZRaU0kcYfhEE', 'ลุง', 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ตีกลับเพื่อแก้เอกสาร', NULL, '2025-02-26 13:03:04', 'b280297e-c5f0-48a4-817f-eb4c8e9e9831'),
(59, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาทันตแพทยศาสตร์', 'หลักสูตรทันตแพทยศาสตรบัณฑิต', '6531501001', 3.14, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4oeC4nOC4hyIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.xjgd6jlP5b4MyLkCVVFuagpYvH-EnRl63iUmrHqP0gA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4geC4oyIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.3615zN4RKTfhwdvrpOAFyrLBKWZhpPVWIxek_HzcYkE', 21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNTEyMzQxMjUiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.KgbBKx5NRAwUceZzyo9mLbxYkaFKnMpMbvkitB9Bx9s', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjUyMTQxMjUxMjUxMjQiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.BcQi_ccIEeakSAb2qr6iugqrzYhtT9ef4QL3MRS3VFs', 'ปวช./ปวส./ปวท.', '[\"ทุนการศึกษา\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\"]', 412312, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL1B1YmxpY19TZXJ2aWNlX0ZpbGVfMTc0MDQ4NTgyOTUxN19MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQwNDg1ODI5LCJleHAiOjQ4OTYyNDU4Mjl9.bxo6AEFd8Aljrw8vGylDelEgrDENtKatj_vXG613bjc', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjQyMTQxMjMxMzIxMzEiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.iW3WkrwzXWpVXqpcQ_n5j_Ng7ymLDW7CkvC3DIdRxsg', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4meC4suC4mSIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.jdVAvgDuFDxVCp37ma37tQnlG-AURQOvEunUfqsizAU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4s-C4geC4siIsImlhdCI6MTc0MDQ4NTgyOSwiZXhwIjo0ODk2MjQ1ODI5fQ.Nkkjr6kat_3obiyf4cSSX6FTTI-OYNJHknFlnLxeOYo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1MTUxMjMxMjMiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.zsc0P7x6hauGKlrkn2z8fIAPtaVXP7q-Es8y0cHMUXI', NULL, 'หมอ', 249994, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL290aGVyX2ZpbGVfMTc0MDQ4NTgyOTUxOV9MYWJUZXN0MS5wZGYiLCJpYXQiOjE3NDA0ODU4MjksImV4cCI6NDg5NjI0NTgyOX0.6t1Df-q5a8WwTRdWaBaUW_LjaSklmEioXmgSt4b2pa8', NULL, 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ตีกลับเพื่อแก้เอกสาร', NULL, '2025-02-25 12:17:09', '807f629e-725a-4c71-adbc-257a66d7b558'),
(60, 'ปริญญาตรี', 2567, 2, 'สำนักวิชานวัตกรรมสังคม', 'หลักสูตรศิลปศาสตรมหาบัณฑิต สาขาวิชาการพัฒนาระหว่างประเทศ', '6531501001', 3.18, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4oSIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.SHDjbNAdPm83DKYAJCDhA9C8TuPaX5Ppqv0IF4PtS6E', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4oeC4gSIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.YlmbNC8aEFV1ZHDb058NS6m_YXER-9Y6TKiY0SpITVM', 22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjAxMjQxMjMxMjQiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.AoshH9pMtWeghhVjxbMed3gBlnT5g4G7saRQPIImstU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIzMTI0MTIzMTIzMTIiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.9F9W4UF3p3cuT2zqK5lW91yckGRbjCI-p2j5yZbdYWk', 'ปริญญาตรี', '[\"จากผู้ปกครอง\",\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\",\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 3124, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL1B1YmxpY19TZXJ2aWNlX0ZpbGVfMTc0MDU3NDk4NDkwM19QSEFUVEFSQURBTkFJIFBST01NQU5FRSAtIE1EMDMtUHJvamVjdDEucGRmIiwiaWF0IjoxNzQwNTc0OTg0LCJleHAiOjQ4OTYzMzQ5ODR9.kkWr-bo1Jx3fYyjfhlglQuRr9v2nMzpE9PZRLQJVxEQ', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzQxMjMxMjQyMTMiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.4SUcoVcIk7mcIpqNeZjDuVnwKdXa2STlUJcT35_yloU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4n-C4qyIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.IC7XFlDIZp1i07nCeSdhkkehdmBPJNJaxpPq9PvvTgY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4geC4q-C4nyIsImlhdCI6MTc0MDU3NDk4NCwiZXhwIjo0ODk2MzM0OTg0fQ.gsDlHPjBkznD_geDKbQy3tU7YDYkNgXEI0OGwR-1VTM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjIzMTMxMjMiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.w8_AsXLS4LengC7y1oBljZFvctz8So3AmsxP1tU1xcA', NULL, 'หมอ', 270000, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL290aGVyX2ZpbGVfMTc0MDU3NDk4NDkwN19QSEFUVEFSQURBTkFJLVBST01NQU5FRS1NRDAyLURhcnQtQ29ubmVjdGlvbi5wZGYiLCJpYXQiOjE3NDA1NzQ5ODQsImV4cCI6NDg5NjMzNDk4NH0.d5oEM54pvYH9SmlJxtAsdTYkYMyJJUHZRaU0kcYfhEE', 'ลุง', 'ผู้ปกครองไม่ใช่บิดา มารดา', 'ตีกลับเพื่อแก้เอกสาร', NULL, '2025-02-26 13:03:04', 'b280297e-c5f0-48a4-817f-eb4c8e9e9831'),
(61, 'ปริญญาตรี', 2567, 2, 'สำนักวิชานิติศาสตร์', 'หลักสูตรนิติศาสตรบัณฑิต สาขาวิชากฎหมายธุรกิจและการสื่อสารด้วยภาษาจีน', '6531501001', 3.14, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3QyIiwiaWF0IjoxNzQxODA1ODE3LCJleHAiOjQ4OTc1NjU4MTd9.DkkPvfyUJ7IyzJnPx7UsXUB_o2gKGhzwikBAZvZJQB8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3Q0IiwiaWF0IjoxNzQxODA1ODE3LCJleHAiOjQ4OTc1NjU4MTd9._7yCojmU1FEKB1IxwNrrhBvKI63z-Mnvv5qnMWP1l9I', 123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMyMTQyMTEyNDEiLCJpYXQiOjE3NDE4MDU4MTcsImV4cCI6NDg5NzU2NTgxN30.o-NE1RkdmW375uq8wcIq42M7H7AevbrnNMlhcdj6WBA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIzMTMyMTMxMjMyMTMiLCJpYXQiOjE3NDE4MDU4MTcsImV4cCI6NDg5NzU2NTgxN30.E9fi0CwJoqpVqtNmAVqyIRJhL9M6UB9q7h_Hs_T8fps', 'ปวช./ปวส./ปวท.', '[\"จากผู้ปกครอง\"]', 'test123', 1234, '[\"ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา\"]', 123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQxODA1ODE3MTg0X0xhYlRlc3QxLnBkZiIsImlhdCI6MTc0MTgwNTgxNywiZXhwIjo0ODk3NTY1ODE3fQ.WuJIuwD8hz42DPYQFky1ZReT-luGId2E4LtbD_Qy5eY', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzEyMzEzMjEzMTMiLCJpYXQiOjE3NDE4MDU4MTcsImV4cCI6NDg5NzU2NTgxN30.Zwxb9AvPZLkCTV0qN1VEwyXChMRv-KkMiJjHlPBXYQs', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3QyNCIsImlhdCI6MTc0MTgwNTgxNywiZXhwIjo0ODk3NTY1ODE3fQ.8YcBNtDXpQth4gDQZHY1U0vxRQpzBDP5GFNKZCZ831k', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3QyMyIsImlhdCI6MTc0MTgwNTgxNywiZXhwIjo0ODk3NTY1ODE3fQ.ffyXgC-sQzFouVz6kpCtodnJqtkQyYIrbddqwzs02PY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIxMzEyMzIxNDEiLCJpYXQiOjE3NDE4MDU4MTcsImV4cCI6NDg5NzU2NTgxN30.Co9Qdaz6hhQG_Vc9p0y7Aula4vGLo5XjWP9OxM_kSM0', NULL, 'ตลาด', 23400, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvb3RoZXJfZmlsZV8xNzQxODA1ODE3MTg3X1BIQVRUQVJBREFOQUktUFJPTU1BTkVFLU1EMDItRGFydC1Db25uZWN0aW9uLnBkZiIsImlhdCI6MTc0MTgwNTgxNywiZXhwIjo0ODk3NTY1ODE3fQ.Q6LMc4G0cUmO_w3ZFi61d8Wh_s_ubOD6TDRpDaRo4Xs', 'ย่า', 'ผู้ปกครองไม่ใช่บิดา มารดา', 'อยู่ระหว่างดำเนินการ', NULL, '2025-03-12 18:56:57', '7f9c559a-8e70-4312-8b8b-53e1eb91566b'),
(62, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาจีนวิทยา', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาจีนธุรกิจ', '6531501001', 3.16, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4quC4oeC4ouC4qiIsImlhdCI6MTc0MTg0Njk5NCwiZXhwIjo0ODk3NjA2OTk0fQ.Ttropqo1dFOxLiivW1siRFs7w7p-JYVWaiZ5TxDa0wU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4ouC4quC4p-C4hyIsImlhdCI6MTc0MTg0Njk5NCwiZXhwIjo0ODk3NjA2OTk0fQ.K_7HSms8ojcIHTiKFB1iB4pV5m4aOjhNJW4BjM5t7kA', 21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjA1NTU1NTU1NTUiLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.u9J-eWcPG0MnYQM2a4dgGFwf1jFFqvgyh-5hbswt-vU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1NTU1NTU1NTU1NTUiLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.rKGX9OsWw3Pk5nMRCvZZe8_ub6CGXMufbkfmXTm2frw', 'มัธยมศึกษาตอนปลาย', '[\"ทุนการศึกษา\",\"จากผู้ปกครอง\"]', NULL, NULL, '[\"ค่าครองชีพ\",\"ค่าเล่าเรียน\"]', 80, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQxODQ2OTk0MTQ4X0xhYiAxIHN1bW1hcnkgNjUzMTUwMTAwMS5wZGYiLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.HQHO7ojIegobllqpq4qGJe6A4cZXGQ6m5MVPIb3NGEM', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มีชีวิตอยู่', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjE1NzU1NTU1NTU1NTUiLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.aOw9r8P2pBfQl7Oqkze9QqeIJWtha53QXUQI2CF8ngs', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4ouC4qiIsImlhdCI6MTc0MTg0Njk5NCwiZXhwIjo0ODk3NjA2OTk0fQ.zHkUoDa0XxtCgrpBQPGil6eZ7heD3WAk5cQeBoJyaSM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4geC4oyIsImlhdCI6MTc0MTg0Njk5NCwiZXhwIjo0ODk3NjA2OTk0fQ.nrHTkkp1xoPVSiyGEkuu0NJh-aZlTUqPCifGSVVszDU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjU1NTU1NTk5OTkiLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.-cRlzkG-DWIXqEzfE3ja6sDypSzKmRUppIJd0NVm598', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IuC4oeC4suC4o-C4lOC4skBnbWFpbC5jb20iLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.qu_qdk6XczHHw9rOxoxt_cUva8iKAfVz9q3DFOf5VqM', 'ค้าขาย', 150000, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvbW9tX2ZpbGVfMTc0MTg0Njk5NDE1Ml9MYWJUZXN0MS5wZGYiLCJpYXQiOjE3NDE4NDY5OTQsImV4cCI6NDg5NzYwNjk5NH0.3u6OUXLkBZmL86G0G7XTZ3RcaEjj8eFf78kYxRx2EhE', NULL, 'ไม่ทราบ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'มารดาเพียงผู้เดียว', 'ตีกลับเพื่อแก้เอกสาร', 'แก้ไขเอกสาร', '2025-03-13 06:23:14', '7d86d0ba-55c3-4c8d-ab2e-3906fdc1c1ef'),
(63, 'ปริญญาตรี', 2567, 2, 'สำนักวิชาจีนวิทยา', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาและวัฒนธรรมจีน', '6531501001', 3.15, 'ลักษณะที่ 1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6ImRlYWRjZXIxIiwiaWF0IjoxNzQxODkzNzM1LCJleHAiOjQ4OTc2NTM3MzV9.9VPs8yPfR0EH6kXxZrN4aA-smE0Gbw9ZHHUjFR9AyYA', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6ImRlYWRjZXIyIiwiaWF0IjoxNzQxODkzNzM1LCJleHAiOjQ4OTc2NTM3MzV9.PgsnG9EDj5viO4eBB-SXSXBnOX8sAfDqoaJysBbFta8', 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyNDMyMTQxMjQiLCJpYXQiOjE3NDE4OTM3MzUsImV4cCI6NDg5NzY1MzczNX0.0E9fnZflIRdNrGs4MgaDaSXxwGNVq1PqRppBkjp3YAY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIxNTEyNTIxNTEyNTIiLCJpYXQiOjE3NDE4OTM3MzUsImV4cCI6NDg5NzY1MzczNX0.jxkjBjUHDgksD7SZKvC5dBGm8JhKg01wrpiVbBqAcY0', 'ปริญญาตรี', '[\"กู้ยืมค่าครองชีพจาก กยศ.\"]', NULL, NULL, '[\"ค่าครองชีพ\"]', 214214, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQxODkzNzM1NTgzX1BIQVRUQVJBREFOQUktUFJPTU1BTkVFLU1EMDItRGFydC1Db25uZWN0aW9uLnBkZiIsImlhdCI6MTc0MTg5MzczNSwiZXhwIjo0ODk3NjUzNzM1fQ.aH0-_OTt5cGBTX1vnBAofuG67oqHs4R3Ijn9se6BJXw', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvZGFkX2RlYXRoX2NlcnRpZmljYXRlX2ZpbGVfMTc0MTg5MzczNTU4N19MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQxODkzNzM1LCJleHAiOjQ4OTc2NTM3MzV9.Lb-hbhhz1jz_1gp5RwvYTSHycTJH5yQUhqe9rQBCag0', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvbW9tX2RlYXRoX2NlcnRpZmljYXRlX2ZpbGVfMTc0MTg5MzczNTU4N19MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQxODkzNzM1LCJleHAiOjQ4OTc2NTM3MzV9.JVXASfyABf28jdDJkemuNu8vwYVWmOonnAhB2BKcu3I', 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzIxMzEyMzIxMzEiLCJpYXQiOjE3NDE4OTM3MzUsImV4cCI6NDg5NzY1MzczNX0.-FYtx-N8japkZuHnEyen9MiZn0rPBdtBaykFSRA4Xk8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6ImRlYWRjZXI0IiwiaWF0IjoxNzQxODkzNzM1LCJleHAiOjQ4OTc2NTM3MzV9.jnaG7wNZnJbHsHBC2xZhV2m8LL5QdNfONXV8-2V1QX8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6ImRlYWRjZXI1IiwiaWF0IjoxNzQxODkzNzM1LCJleHAiOjQ4OTc2NTM3MzV9.hIDiCGoCx54aTOLMRsRgtoRyVS7GHaOwDrqHdEs3888', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjIxMzIxNDEyNDEiLCJpYXQiOjE3NDE4OTM3MzUsImV4cCI6NDg5NzY1MzczNX0.Qy2lV9pRID9XUzfH-FassId_e0vwTsLlt1ydzWBsqJk', NULL, 'deadcer6', 12312312, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvb3RoZXJfZmlsZV8xNzQxODkzNzM1NTg3X0xhYiAxIHN1bW1hcnkgNjUzMTUwMTAwMS5wZGYiLCJpYXQiOjE3NDE4OTM3MzUsImV4cCI6NDg5NzY1MzczNX0.8ZDKoEU-0FCs7_OqMo86JfWPWpBxTIYIR7wkgihvJNk', 'deadcer7', 'ผู้ปกครองไม่ใช่บิดา มารดา', 'อยู่ระหว่างดำเนินการ', NULL, '2025-03-13 19:22:15', '745809a9-942b-43cd-8191-0a24f91915e4'),
(64, 'ประกาศนียบัตร', 2567, 1, 'สำนักวิชาจีนวิทยา', 'หลักสูตรศิลปศาสตรบัณฑิต สาขาวิชาภาษาและวัฒนธรรมจีน', '6531501001', 3.15, 'ลักษณะที่ 2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3R0MSIsImlhdCI6MTc0MjIzNzQ0MSwiZXhwIjo0ODk3OTk3NDQxfQ.xubCGQSa2f15hVUOoimxU01i-EaX6d9IcgX55qh04M8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3R0MiIsImlhdCI6MTc0MjIzNzQ0MSwiZXhwIjo0ODk3OTk3NDQxfQ.52mBN2m4NzWpWhBt1r23hSVXuZelvGfXwm_loOs7Qps', 31231, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjMxMjMyMTMxMjMiLCJpYXQiOjE3NDIyMzc0NDEsImV4cCI6NDg5Nzk5NzQ0MX0.dxR0_ZUq2uFgiUQVoGsoKKo80exD4ny7yq82gVvBU-o', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjUxMjMxMjQyMTMxMjMiLCJpYXQiOjE3NDIyMzc0NDEsImV4cCI6NDg5Nzk5NzQ0MX0.LxDxGN8a-REllUyGV09wTmAkkiO06ss6e9Hp-vYChq8', 'ปริญญาตรี', '[\"จากผู้ปกครอง\",\"กู้ยืมค่าครองชีพจาก กยศ.\",\"จากการประกอบอาชีพ\"]', 'testt', 200000, '[\"ค่าเล่าเรียน\"]', 3123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvUHVibGljX1NlcnZpY2VfRmlsZV8xNzQyMjM3NDQxODIyX0xhYiAxIHN1bW1hcnkgNjUzMTUwMTAwMS5wZGYiLCJpYXQiOjE3NDIyMzc0NDEsImV4cCI6NDg5Nzk5NzQ0MX0.QEys2BRsx1KZl_o5gIpqHyXP7oQGZxhwMIkxn-sPet4', 'เสียชีวิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvZGFkX2RlYXRoX2NlcnRpZmljYXRlX2ZpbGVfMTc0MjIzNzQ0MTgyNV9MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQyMjM3NDQxLCJleHAiOjQ4OTc5OTc0NDF9.f4sotwhAZqx3NxyFwB6ISgBglKpVag2jJyz-y4_xR5o', 'ไม่ทราบข้อมูล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvbW9tX2RlYXRoX2NlcnRpZmljYXRlX2ZpbGVfMTc0MjIzNzQ0MTgyNV9MYWIgMSBzdW1tYXJ5IDY1MzE1MDEwMDEucGRmIiwiaWF0IjoxNzQyMjM3NDQxLCJleHAiOjQ4OTc5OTc0NDF9.OsE1nl4WCEm9ZwZoyLX053VJqq6mwKC0_Pqs1PG2uIA', 'ไม่ทราบ', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEyMzEyMzEyMzIxMzEiLCJpYXQiOjE3NDIyMzc0NDEsImV4cCI6NDg5Nzk5NzQ0MX0.Gjh953czgmAoLOdzOKwGXgKdvgtViJq-yOzWp29yxjE', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3R0NiIsImlhdCI6MTc0MjIzNzQ0MSwiZXhwIjo0ODk3OTk3NDQxfQ.s5MFyPnOq9P9amKS_OgrmAtF1uV-VM_yUfENIreYN5g', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3R0NyIsImlhdCI6MTc0MjIzNzQ0MSwiZXhwIjo0ODk3OTk3NDQxfQ.jIfoSIsQc7spCDgidtxNtSHCieBvVp1jKyjaPoWUeLM', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6IjEzMTIzMTIzMjEiLCJpYXQiOjE3NDIyMzc0NDEsImV4cCI6NDg5Nzk5NzQ0MX0.T5qgECD8YYTpLUN-3elwvUq5PjbDXNE4jes4xD6jYGs', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6InRlc3R0OCIsImlhdCI6MTc0MjIzNzQ0MSwiZXhwIjo0ODk3OTk3NDQxfQ.RXreZreKIhun0cHT45ZBq8cSa2lA4voLbmgVOy4-b9M', 'testt9', 1231223, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2YWx1ZSI6Ii91cGxvYWRzL2xvYW5fZmlsZXMvb3RoZXJfZmlsZV8xNzQyMjM3NDQxODI0X0xhYiAxIHN1bW1hcnkgNjUzMTUwMTAwMS5wZGYiLCJpYXQiOjE3NDIyMzc0NDEsImV4cCI6NDg5Nzk5NzQ0MX0.RKad3A97bUQfu5ZuNUXxD3Wp78yWOwV8SLQmXm-T-mY', 'testt10', 'ผู้ปกครองไม่ใช่บิดา มารดา', 'อยู่ระหว่างดำเนินการ', 'wadsadwadsadwaddadwad', '2025-03-17 18:11:29', '457bd660-ed3b-4956-8bed-40b688990666');

-- --------------------------------------------------------

--
-- Table structure for table `graduated_level`
--

CREATE TABLE `graduated_level` (
  `Graduated_level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `graduated_level`
--

INSERT INTO `graduated_level` (`Graduated_level`) VALUES
('ประกาศนียบัตร'),
('ปริญญาตรี'),
('ปวช./ปวส./ปวท.'),
('มัธยมศึกษาตอนปลาย'),
('อนุปริญญาตรี');

-- --------------------------------------------------------

--
-- Table structure for table `loan_purposes_options`
--

CREATE TABLE `loan_purposes_options` (
  `purpose` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_purposes_options`
--

INSERT INTO `loan_purposes_options` (`purpose`) VALUES
('ค่าครองชีพ'),
('ค่าเล่าเรียน'),
('ค่าใช้จ่ายที่เกี่ยวเนื่องกับการศึกษา');

-- --------------------------------------------------------

--
-- Table structure for table `Server`
--

CREATE TABLE `Server` (
  `server_status` varchar(10) NOT NULL DEFAULT 'open',
  `open_date` date DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `study_year` varchar(10) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `study_semester` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Server`
--

INSERT INTO `Server` (`server_status`, `open_date`, `close_date`, `study_year`, `updated_at`, `study_semester`) VALUES
('open', '2025-03-20', '2025-03-24', '2567', '2025-03-20', '2');

-- --------------------------------------------------------

--
-- Table structure for table `user_reject_toloan`
--

CREATE TABLE `user_reject_toloan` (
  `id` bigint(255) NOT NULL,
  `student_id` bigint(50) NOT NULL,
  `user_studyYear` bigint(50) NOT NULL,
  `want_to_loan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_reject_toloan`
--

INSERT INTO `user_reject_toloan` (`id`, `student_id`, `user_studyYear`, `want_to_loan`) VALUES
(4, 6531501001, 2567, 'yes');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daily_expenses_options`
--
ALTER TABLE `daily_expenses_options`
  ADD PRIMARY KEY (`category`);

--
-- Indexes for table `education_level`
--
ALTER TABLE `education_level`
  ADD PRIMARY KEY (`level`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`Faculty`);

--
-- Indexes for table `field_of_study`
--
ALTER TABLE `field_of_study`
  ADD KEY `faculty` (`Faculty`);

--
-- Indexes for table `form_response`
--
ALTER TABLE `form_response`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `graduated_level`
--
ALTER TABLE `graduated_level`
  ADD PRIMARY KEY (`Graduated_level`);

--
-- Indexes for table `loan_purposes_options`
--
ALTER TABLE `loan_purposes_options`
  ADD PRIMARY KEY (`purpose`);

--
-- Indexes for table `user_reject_toloan`
--
ALTER TABLE `user_reject_toloan`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `form_response`
--
ALTER TABLE `form_response`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `user_reject_toloan`
--
ALTER TABLE `user_reject_toloan`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `field_of_study`
--
ALTER TABLE `field_of_study`
  ADD CONSTRAINT `faculty` FOREIGN KEY (`Faculty`) REFERENCES `faculty` (`Faculty`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

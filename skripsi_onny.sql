-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2022 at 03:38 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `skripsi_onny`
--

-- --------------------------------------------------------

--
-- Table structure for table `wp_bobot`
--

CREATE TABLE `wp_bobot` (
  `id_kriteria` int(11) NOT NULL,
  `nilai_bobot` double NOT NULL,
  `hasil_bobot` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wp_kriteria`
--

CREATE TABLE `wp_kriteria` (
  `id_kriteria` int(11) NOT NULL,
  `nama_kriteria` varchar(255) NOT NULL,
  `tipe_kriteria` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='5';

--
-- Dumping data for table `wp_kriteria`
--

INSERT INTO `wp_kriteria` (`id_kriteria`, `nama_kriteria`, `tipe_kriteria`) VALUES
(6, 'Waktu Memasak', 'cost'),
(7, 'Keuntungan', 'benefit'),
(8, 'Penjualan', 'benefit');

-- --------------------------------------------------------

--
-- Table structure for table `wp_menu`
--

CREATE TABLE `wp_menu` (
  `id_menu` int(11) NOT NULL,
  `nama_menu` varchar(255) NOT NULL,
  `vektor_s` double NOT NULL,
  `vektor_v` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wp_nilai`
--

CREATE TABLE `wp_nilai` (
  `id_nilai` int(6) NOT NULL,
  `ket_nilai` varchar(45) NOT NULL,
  `jum_nilai` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wp_pengguna`
--

CREATE TABLE `wp_pengguna` (
  `id_pengguna` int(11) NOT NULL,
  `nama_lengkap` varchar(225) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wp_pengguna`
--

INSERT INTO `wp_pengguna` (`id_pengguna`, `nama_lengkap`, `username`, `password`) VALUES
(1, 'onny anggraeni', 'onny', '3e1306268f883c6f76a03fd36ceab600'),
(2, 'Nurhayati', 'nur', 'e00cf25ad42683b3df678c61f42c6bda');

-- --------------------------------------------------------

--
-- Table structure for table `wp_rangking`
--

CREATE TABLE `wp_rangking` (
  `id_menu` int(11) NOT NULL,
  `id_kriteria` int(11) NOT NULL,
  `nilai_rangking` double NOT NULL,
  `nilai_normalisasi` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wp_bobot`
--
ALTER TABLE `wp_bobot`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indexes for table `wp_kriteria`
--
ALTER TABLE `wp_kriteria`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indexes for table `wp_menu`
--
ALTER TABLE `wp_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indexes for table `wp_nilai`
--
ALTER TABLE `wp_nilai`
  ADD PRIMARY KEY (`id_nilai`);

--
-- Indexes for table `wp_pengguna`
--
ALTER TABLE `wp_pengguna`
  ADD PRIMARY KEY (`id_pengguna`) USING BTREE;

--
-- Indexes for table `wp_rangking`
--
ALTER TABLE `wp_rangking`
  ADD PRIMARY KEY (`id_menu`,`id_kriteria`),
  ADD KEY `id_kriteria` (`id_kriteria`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `wp_kriteria`
--
ALTER TABLE `wp_kriteria`
  MODIFY `id_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `wp_menu`
--
ALTER TABLE `wp_menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `wp_nilai`
--
ALTER TABLE `wp_nilai`
  MODIFY `id_nilai` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `wp_pengguna`
--
ALTER TABLE `wp_pengguna`
  MODIFY `id_pengguna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `wp_bobot`
--
ALTER TABLE `wp_bobot`
  ADD CONSTRAINT `wp_bobot_ibfk_1` FOREIGN KEY (`id_kriteria`) REFERENCES `wp_kriteria` (`id_kriteria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wp_rangking`
--
ALTER TABLE `wp_rangking`
  ADD CONSTRAINT `rangking_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `wp_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rangking_ibfk_2` FOREIGN KEY (`id_kriteria`) REFERENCES `wp_kriteria` (`id_kriteria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

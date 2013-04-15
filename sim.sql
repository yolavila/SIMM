-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 11, 2013 at 02:29 PM
-- Server version: 5.1.37
-- PHP Version: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sim`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id_adm` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `nip_adm` int(5) NOT NULL,
  `nama_adm` varchar(50) NOT NULL,
  `level` varchar(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_adm`, `username`, `password`, `nip_adm`, `nama_adm`, `level`) VALUES
(1, 'admin', 'admin', 12345, 'Vila Yustira', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `applicant`
--

CREATE TABLE IF NOT EXISTS `applicant` (
  `no_applicant` int(11) NOT NULL AUTO_INCREMENT,
  `no_identitas` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(20) NOT NULL,
  `no_tlp` bigint(12) NOT NULL,
  `email` varchar(50) NOT NULL,
  `tempat_lahir` varchar(20) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `jenis_kelamin` varchar(6) NOT NULL,
  `status_pernikahan` varchar(13) NOT NULL,
  `agama` varchar(8) NOT NULL,
  `gol_darah` varchar(2) NOT NULL,
  `pendidikan` varchar(3) NOT NULL,
  `penempatan` varchar(12) NOT NULL,
  `posisi` varchar(20) NOT NULL,
  `image` varchar(55) NOT NULL,
  `tanggal` date NOT NULL,
  `status` int(1) NOT NULL COMMENT '1 = buffer (belum terjadwal), 2=terjadwal, 3=hadir, 4=tidak hadir, 5=qualified, 6=not qualified, 7=hired,8=terminate',
  PRIMARY KEY (`no_applicant`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `applicant`
--

INSERT INTO `applicant` (`no_applicant`, `no_identitas`, `nama_lengkap`, `alamat`, `kota`, `no_tlp`, `email`, `tempat_lahir`, `tgl_lahir`, `jenis_kelamin`, `status_pernikahan`, `agama`, `gol_darah`, `pendidikan`, `penempatan`, `posisi`, `image`, `tanggal`, `status`) VALUES
(8, 6787899, 'bunga', 'lalala', 'yogyakarta', 85643143078, 'yopi.rahman78.yahoo.com', 'medan', '1972-02-03', 'wanita', 'menikah', 'Islam', 'B', 'S2', 'magelang', 'Admin', '', '2013-03-23', 8),
(9, 6787899, 'papa', 'lalalal', 'yogyakarta', 86729412123, 'yosiamalia@yahoo.com', 'klaten', '1970-01-01', 'wanita', 'belum menikah', 'Islam', 'A', 'SMP', 'DIY', 'AO', '', '2013-03-02', 8),
(10, 6787899, 'didi', 'lalala', 'yogyakarta', 85643143078, 'yog_leon@yahoo.com', 'bbbbbbbbbbbbbbbbbbb', '1970-01-02', 'wanita', 'belum menikah', 'Islam', 'A', 'SMP', 'DIY', 'frontliner', '', '2013-03-12', 8),
(11, 0, 'heni', '', 'yogyakarta', 81802835550, 'yopi.rahman78.yahoo.com', 'kebumen', '1970-01-01', 'wanita', 'belum menikah', 'Islam', 'A', 'SMP', 'Solo', 'field', '', '2013-03-11', 5),
(12, 6787899, 'vila yustira', 'lalala', 'yogyakarta', 86729412123, 'yog_leon@yahoo.com', 'klaten', '1971-02-03', 'wanita', 'belum menikah', 'Islam', 'A', 'SMP', 'DIY', 'frontliner', '', '2013-03-21', 2),
(13, 0, 'bobo', 'kota', 'puertorico', 877885643123, 'iniemailku@yahoo.com', 'alaska', '1993-03-13', 'pria', 'belum menikah', 'khatolik', 'O', 'S1', 'purwokerto', 'field', '13_images.jpeg', '2013-03-26', 5);

-- --------------------------------------------------------

--
-- Table structure for table `hired`
--

CREATE TABLE IF NOT EXISTS `hired` (
  `no_applicant` int(11) NOT NULL,
  `kantor` varchar(12) NOT NULL,
  `cabang` varchar(10) NOT NULL,
  `posisi` varchar(20) NOT NULL,
  `tgl_hired` date NOT NULL,
  PRIMARY KEY (`no_applicant`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hired`
--

INSERT INTO `hired` (`no_applicant`, `kantor`, `cabang`, `posisi`, `tgl_hired`) VALUES
(1, 'FIF', 'Bantul', 'Admin', '2013-03-31'),
(2, 'BAF', 'Yogya', 'surveyor', '2013-03-27'),
(4, 'Bank Sahabat', 'Yogya', 'cmo', '2013-03-31'),
(6, 'BAF', 'Bantul', 'Admin', '2013-03-25'),
(7, 'FIAL', 'Bantul', 'Admin', '2013-03-21'),
(8, 'Bank Sahabat', 'Bantul', 'Admin', '2013-03-24'),
(9, 'BAF', 'Bantul', 'Admin', '2013-03-31'),
(10, 'FIF', 'purwokerto', 'surveyor', '2013-03-24');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_user`
--

CREATE TABLE IF NOT EXISTS `jadwal_user` (
  `no_applicant` int(5) NOT NULL,
  `kantor` varchar(5) NOT NULL,
  `cabang` varchar(10) NOT NULL,
  `posisi` varchar(10) NOT NULL,
  `tanggal_pengiriman` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jadwal_user`
--

INSERT INTO `jadwal_user` (`no_applicant`, `kantor`, `cabang`, `posisi`, `tanggal_pengiriman`) VALUES
(1, 'FIF', 'Bantul', 'Admin', '2013-03-22'),
(1, 'BAF', 'Yogya', 'Admin', '2013-03-25'),
(1, 'FIAL', 'Yogya', 'AO', '2013-03-26'),
(6, 'FIF', 'Yogya', 'surveyor', '2013-03-20'),
(8, 'BAF', 'Bantul', 'Admin', '2013-03-20'),
(8, 'Bank ', 'Bantul', 'AO', '2013-03-21'),
(8, 'Bank ', 'Yogya', 'cmo', '2013-03-21'),
(10, 'FIF', 'Bantul', 'Admin', '2013-03-21'),
(10, 'FIF', 'Bantul', 'Admin', '2013-03-23'),
(11, 'wom', 'solo', 'admin', '2013-03-25'),
(11, 'fif', 'solo', 'cs', '2013-03-27'),
(13, 'FIF', 'kebumen', 'surveyor', '2013-04-01'),
(11, 'FIAL', 'purwokerto', 'Admin', '2013-04-01');

-- --------------------------------------------------------

--
-- Table structure for table `penjadwalan`
--

CREATE TABLE IF NOT EXISTS `penjadwalan` (
  `no_applicant` int(11) NOT NULL,
  `jadwal` date NOT NULL,
  `konfirmasi` int(2) NOT NULL COMMENT '1=HADIR, 0=TIDAK HADIR',
  PRIMARY KEY (`no_applicant`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjadwalan`
--

INSERT INTO `penjadwalan` (`no_applicant`, `jadwal`, `konfirmasi`) VALUES
(1, '2013-03-20', 1),
(2, '2013-03-21', 1),
(3, '2013-03-25', 0),
(4, '2013-03-20', 1),
(5, '2013-03-20', 1),
(6, '2013-03-20', 1),
(7, '2013-03-24', 1),
(8, '2013-03-21', 1),
(9, '2013-03-21', 1),
(10, '2013-03-21', 1),
(11, '2013-03-27', 1),
(12, '0000-00-00', 0),
(13, '2013-03-29', 1),
(14, '0000-00-00', 0),
(15, '0000-00-00', 0),
(16, '0000-00-00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE IF NOT EXISTS `result` (
  `no_applicant` int(11) NOT NULL,
  `hasil` varchar(13) NOT NULL COMMENT '1=qualified,0=not qualified',
  `tanggal` date NOT NULL,
  PRIMARY KEY (`no_applicant`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`no_applicant`, `hasil`, `tanggal`) VALUES
(1, '1', '2013-03-20'),
(2, '1', '2013-03-20'),
(3, '', '0000-00-00'),
(4, '1', '2013-03-18'),
(5, '0', '2013-03-31'),
(6, '1', '2013-02-12'),
(7, '1', '2013-02-28'),
(8, '1', '2013-03-07'),
(9, '1', '2013-03-20'),
(10, '1', '2013-03-18'),
(11, '1', '0000-00-00'),
(12, '', '0000-00-00'),
(13, '1', '0000-00-00'),
(14, '', '0000-00-00'),
(15, '', '0000-00-00'),
(16, '', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
  `id_status` int(1) NOT NULL AUTO_INCREMENT,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id_status`, `status`) VALUES
(1, 'Buffer'),
(2, 'Terjadwal'),
(3, 'Hadir'),
(4, 'Tidak Hadir'),
(5, 'Qualified'),
(6, 'Not Qualified'),
(7, 'Hired'),
(8, 'Terminate');

-- --------------------------------------------------------

--
-- Table structure for table `terminate`
--

CREATE TABLE IF NOT EXISTS `terminate` (
  `no_applicant` int(11) NOT NULL,
  `tgl_terminate` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `terminate`
--

INSERT INTO `terminate` (`no_applicant`, `tgl_terminate`) VALUES
(1, '2013-03-31'),
(2, '2013-04-22'),
(4, '2013-03-12'),
(10, '2013-03-12'),
(6, '2013-03-30'),
(7, '2013-03-27'),
(8, '2013-03-27'),
(9, '2013-04-30');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

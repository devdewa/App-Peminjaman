-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2022 at 09:59 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_ipuls`
--

-- --------------------------------------------------------

--
-- Table structure for table `barangs`
--

CREATE TABLE `barangs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_barang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori_id` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `nama_barang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `satuan` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_rusak` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barangs`
--

INSERT INTO `barangs` (`id`, `id_barang`, `kategori_id`, `nama_barang`, `satuan`, `jumlah`, `jumlah_rusak`) VALUES
(30, 'A1', '4', 'KUNCI', '1', '10', '0'),
(31, '1010', '5', 'Barang', '1', '90', '0');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(200) NOT NULL,
  `nama_kategori` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(4, 'Mebel'),
(5, 'Elektronik'),
(6, 'Perkakas');

-- --------------------------------------------------------

--
-- Table structure for table `keluar`
--

CREATE TABLE `keluar` (
  `id_keluar` int(11) NOT NULL,
  `id_barang` varchar(200) NOT NULL,
  `jumlah_keluar` varchar(150) NOT NULL,
  `untuk` text NOT NULL,
  `tanggal_keluar` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `keluar`
--
DELIMITER $$
CREATE TRIGGER `tg_barang_keluar` AFTER INSERT ON `keluar` FOR EACH ROW BEGIN
UPDATE barangs
SET jumlah = jumlah - NEW.jumlah_keluar
WHERE
id_barang = NEW.id_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_keluar`
--

CREATE TABLE `keranjang_keluar` (
  `id_keluar` int(11) NOT NULL,
  `id_barang` varchar(200) NOT NULL,
  `jumlah_keluar` varchar(150) NOT NULL,
  `untuk` text NOT NULL,
  `tanggal_keluar` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_masuk`
--

CREATE TABLE `keranjang_masuk` (
  `id_masuk` int(11) NOT NULL,
  `id_barang` varchar(200) NOT NULL,
  `jumlah_asup` varchar(50) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `harga_satuan` varchar(200) NOT NULL DEFAULT '0',
  `harga_total` varchar(200) NOT NULL DEFAULT '0',
  `nama_toko` varchar(200) NOT NULL DEFAULT '0',
  `merek` varchar(200) NOT NULL DEFAULT '0',
  `sumber_dana` varchar(200) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_peminjaman`
--

CREATE TABLE `keranjang_peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `nama_peminjam` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_barang` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_pinjam` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `masuk`
--

CREATE TABLE `masuk` (
  `id_masuk` int(11) NOT NULL,
  `id_barang` varchar(200) NOT NULL,
  `jumlah_asup` varchar(50) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `harga_satuan` varchar(200) NOT NULL DEFAULT '0',
  `harga_total` varchar(200) NOT NULL DEFAULT '0',
  `nama_toko` varchar(200) NOT NULL DEFAULT '0',
  `merek` varchar(200) NOT NULL DEFAULT '0',
  `sumber_dana` varchar(200) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `masuk`
--

INSERT INTO `masuk` (`id_masuk`, `id_barang`, `jumlah_asup`, `tanggal_masuk`, `harga_satuan`, `harga_total`, `nama_toko`, `merek`, `sumber_dana`) VALUES
(15, '10101010', '9', '2020-01-30', '50000', '200000', 'toko1', 'futura', 'BOS'),
(16, '10101010', '6', '2020-01-27', '30000', '180000', 'Bangku Shop', 'Futura', 'BOS'),
(17, '10101010', '11', '2020-04-15', '100000', '1100000', 'Toko 1', 'Futura', 'BOS'),
(18, '10101011', '5', '2020-04-15', '120000', '600000', 'Toko 1', 'Futura', 'BOS'),
(19, '10101010', '5', '2020-04-16', '120000', '600000', 'Toko 1', 'Futura', 'BOS');

--
-- Triggers `masuk`
--
DELIMITER $$
CREATE TRIGGER `tg_masuk_barang` AFTER INSERT ON `masuk` FOR EACH ROW BEGIN
UPDATE barangs
SET jumlah = jumlah + NEW.jumlah_asup
WHERE
id_barang = NEW.id_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(22, '2014_10_12_000000_create_users_table', 1),
(23, '2014_10_12_100000_create_password_resets_table', 1),
(24, '2019_09_30_134041_create_barangs_table', 1),
(25, '2019_10_10_031322_create_jenis_table', 1),
(26, '2019_10_10_062257_create_ruangan_table', 1),
(27, '2019_10_11_025053_create_peminjaman_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `nama_peminjam` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_barang` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_pinjam` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `nama_peminjam`, `id_barang`, `jumlah_pinjam`, `tanggal_pinjam`, `tanggal_kembali`, `status`, `created_at`, `updated_at`) VALUES
(23, 'test', 'A1', '5', '2022-09-23', '2022-09-24', 'Sudah Dikembalikan', NULL, NULL),
(24, 'test', '1010', '10', '2022-09-23', '2022-09-24', 'Belum Dikembalikan', NULL, NULL);

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `tg_pinjam` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
UPDATE barangs
SET jumlah = jumlah - NEW.jumlah_pinjam
WHERE
id_barang = NEW.id_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` enum('rayon','pj','admin','bukan_pj') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `username`, `password`, `level`, `remember_token`, `created_at`, `updated_at`) VALUES
(20, 'Admin', 'admin@gmail.com', NULL, 'admin', '$2y$10$.XapfceL50Tb8EbgJLh04ezrzKePx0ae7kYCbHosyW9SZ3.koUCPu', 'admin', NULL, '2020-01-27 00:51:09', '2020-01-27 00:51:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barangs`
--
ALTER TABLE `barangs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_barang` (`id_barang`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `keluar`
--
ALTER TABLE `keluar`
  ADD PRIMARY KEY (`id_keluar`);

--
-- Indexes for table `keranjang_keluar`
--
ALTER TABLE `keranjang_keluar`
  ADD PRIMARY KEY (`id_keluar`);

--
-- Indexes for table `keranjang_masuk`
--
ALTER TABLE `keranjang_masuk`
  ADD PRIMARY KEY (`id_masuk`);

--
-- Indexes for table `keranjang_peminjaman`
--
ALTER TABLE `keranjang_peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `masuk`
--
ALTER TABLE `masuk`
  ADD PRIMARY KEY (`id_masuk`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barangs`
--
ALTER TABLE `barangs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `keluar`
--
ALTER TABLE `keluar`
  MODIFY `id_keluar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `keranjang_keluar`
--
ALTER TABLE `keranjang_keluar`
  MODIFY `id_keluar` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_masuk`
--
ALTER TABLE `keranjang_masuk`
  MODIFY `id_masuk` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_peminjaman`
--
ALTER TABLE `keranjang_peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `masuk`
--
ALTER TABLE `masuk`
  MODIFY `id_masuk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

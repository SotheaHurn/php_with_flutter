-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 23, 2023 at 04:11 AM
-- Server version: 8.0.31
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `product_my_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`, `image`) VALUES
(3, 'McDonald’s', 'https://cdn2.avada.io/media/resources/ePUG4p5.jpg'),
(4, 'Coca Cola', 'https://blog.hubspot.com/hs-fs/hubfs/coca-cola-brand-identity-example.png?width=350&name=coca-cola-brand-identity-example.png');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `image`) VALUES
(1, '33333', 'https://img.freepik.com/free-icon/menu_318-388431.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `model`
--

CREATE TABLE `model` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `brand_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `model`
--

INSERT INTO `model` (`id`, `name`, `brand_id`) VALUES
(4, 'Big Burger', 3),
(5, 'King Buger', 3),
(6, 'Yo Bridget', 3),
(7, 'Cafe Coca', 4),
(8, 'Coca Zero', 4),
(9, 'Caca milk', 4);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `model_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `qty` int NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `supplier_id`, `category_id`, `brand_id`, `model_id`, `price`, `qty`, `image`, `create_at`) VALUES
(1, 'Coca', 3, 1, 4, 9, 100.00, 2, 'https://m.media-amazon.com/images/I/81AyNAm-QiL.jpg', '2023-05-22 03:53:05'),
(2, '22', 1, 1, 3, 4, 33.00, 3, 'https://www.lactaid.com/sites/lactaid_us/files/product-images/hg_whole_front_0.png', '2023-05-22 06:41:15'),
(3, '33', NULL, 1, 4, 8, 24.00, 2, 'https://cdn.loveandlemons.com/wp-content/uploads/2020/01/oat-milk-500x500.jpg', '2023-05-22 06:42:49'),
(4, 'box', 4, 1, 4, 9, 777.00, 8, 'https://cdn3d.iconscout.com/3d/premium/thumb/product-optimize-4889670-4076847.png', '2023-05-23 02:12:12'),
(5, '22', NULL, 1, 4, 7, 1.99, 2, 'https://cdn3d.iconscout.com/3d/premium/thumb/product-protection-8487466-6699217.png?f=webp', '2023-05-23 02:34:43'),
(6, 'Apple', NULL, 1, 3, 5, 0.66, 1, 'https://www.collinsdictionary.com/images/full/apple_158989157.jpg', '2023-05-23 02:34:14');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` int NOT NULL,
  `profile` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dob` timestamp NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id`, `profile`, `name`, `sex`, `dob`, `phone`) VALUES
(1, 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80', 'Tian Yang', 'Male', '2000-02-23 17:00:00', '096363636'),
(2, 'https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg', 'Jessy', 'Female', '2003-12-18 17:00:00', '012121212'),
(3, 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg', 'Tom', 'Male', '1987-04-03 17:00:00', '025656563'),
(4, 'https://zipmex.com/static/d1af016df3c4adadee8d863e54e82331/Twitter-NFT-profile.jpg', 'Monkey', 'Male', '2017-12-15 17:00:00', '0147852369');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `model`
--
ALTER TABLE `model`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

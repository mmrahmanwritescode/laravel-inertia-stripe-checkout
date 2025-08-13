-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.42 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table laravel-inertia-stripe.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci GENERATED ALWAYS AS (concat(`first_name`,_utf8mb4' ',`last_name`)) VIRTUAL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `post_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.users: ~2 rows (approximately)
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `address`, `post_code`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Test', 'User', 'test@example.com', '469-803-7605', '24855 Antonette Ridge\nTheresaberg, AR 53366', '04747-3211', '2025-08-07 01:32:06', '$2y$12$lyKIwU.HZLvzQYHGazrPG.RXwOsjQbp7.OrgmBtk9IBjcRGNXR2ty', 'fuh0aiyxmM', '2025-08-07 01:32:06', '2025-08-07 01:32:06'),
	(2, 'Mahfoozur', 'Rahman', 'mahfoozur.rahman.bd@gmail.com', '1111111111', 'east kafrul', '1206', NULL, NULL, NULL, '2025-08-07 04:25:03', '2025-08-07 04:25:03');

-- Dumping structure for table laravel-inertia-stripe.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.cache: ~0 rows (approximately)

-- Dumping structure for table laravel-inertia-stripe.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.cache_locks: ~0 rows (approximately)

-- Dumping structure for table laravel-inertia-stripe.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table laravel-inertia-stripe.food_items
CREATE TABLE IF NOT EXISTS `food_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(8,2) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.food_items: ~6 rows (approximately)
INSERT INTO `food_items` (`id`, `name`, `description`, `price`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'Margherita Pizza', 'Classic pizza with fresh tomato sauce, mozzarella cheese, and basil', 12.99, NULL, 1, '2025-08-07 01:32:06', '2025-08-07 01:32:06'),
	(2, 'Chicken Burger', 'Grilled chicken breast with lettuce, tomato, and mayo on a brioche bun', 9.99, NULL, 1, '2025-08-07 01:32:06', '2025-08-07 01:32:06'),
	(3, 'Caesar Salad', 'Fresh romaine lettuce with caesar dressing, croutons, and parmesan cheese', 7.99, NULL, 1, '2025-08-07 01:32:06', '2025-08-07 01:32:06'),
	(4, 'Fish & Chips', 'Beer battered cod with crispy fries and mushy peas', 14.99, NULL, 1, '2025-08-07 01:32:06', '2025-08-07 01:32:06'),
	(5, 'Pasta Carbonara', 'Spaghetti with bacon, eggs, parmesan cheese, and black pepper', 11.99, NULL, 1, '2025-08-07 01:32:06', '2025-08-07 01:32:06'),
	(6, 'Chocolate Brownie', 'Rich chocolate brownie served with vanilla ice cream', 5.99, NULL, 1, '2025-08-07 01:32:06', '2025-08-07 01:32:06');
	
-- Dumping structure for table laravel-inertia-stripe.cart_items
CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `food_item_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_food_item_id_foreign` (`food_item_id`),
  CONSTRAINT `cart_items_food_item_id_foreign` FOREIGN KEY (`food_item_id`) REFERENCES `food_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.cart_items: ~5 rows (approximately)
INSERT INTO `cart_items` (`id`, `session_id`, `food_item_id`, `quantity`, `price`, `discount`, `created_at`, `updated_at`) VALUES
	(27, 'UYprKyCWEYgILNwCIup7Oks5Fv5hARWystHf0Ydn', 5, 1, 11.99, 0.00, '2025-08-07 05:40:50', '2025-08-07 05:40:50'),
	(28, 'UYprKyCWEYgILNwCIup7Oks5Fv5hARWystHf0Ydn', 4, 1, 14.99, 0.00, '2025-08-07 05:40:50', '2025-08-07 05:40:50'),
	(29, 'UYprKyCWEYgILNwCIup7Oks5Fv5hARWystHf0Ydn', 3, 1, 7.99, 0.00, '2025-08-07 05:40:50', '2025-08-07 05:40:50'),
	(30, 'mMF6MLTZ43LdaRTfCbYeog49p435akDg0mULf8SL', 3, 1, 7.99, 0.00, '2025-08-07 11:49:25', '2025-08-07 11:49:25'),
	(31, 'mMF6MLTZ43LdaRTfCbYeog49p435akDg0mULf8SL', 5, 1, 11.99, 0.00, '2025-08-07 11:49:25', '2025-08-07 11:49:25'),
	(32, 'mMF6MLTZ43LdaRTfCbYeog49p435akDg0mULf8SL', 4, 1, 14.99, 0.00, '2025-08-07 11:49:25', '2025-08-07 11:49:25');	

-- Dumping structure for table laravel-inertia-stripe.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.jobs: ~0 rows (approximately)

-- Dumping structure for table laravel-inertia-stripe.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.job_batches: ~0 rows (approximately)

-- Dumping structure for table laravel-inertia-stripe.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.migrations: ~7 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_08_07_000001_create_food_items_table', 1),
	(5, '2025_08_07_000002_create_cart_items_table', 1),
	(6, '2025_08_07_000003_create_orders_table', 1),
	(7, '2025_08_07_000004_create_order_items_table', 1);

-- Dumping structure for table laravel-inertia-stripe.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `purchase_order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('order_in_progress','order_placed','confirmed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'order_in_progress',
  `payment_method` enum('stripe','N/A') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stripe',
  `price` decimal(8,2) NOT NULL,
  `shipping_cost` decimal(8,2) NOT NULL DEFAULT '0.00',
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_intent_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `order_type` enum('delivery','takeaway','pay_on_spot') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'delivery',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_purchase_order_id_unique` (`purchase_order_id`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.orders: ~1 rows (approximately)
INSERT INTO `orders` (`id`, `user_id`, `purchase_order_id`, `status`, `payment_method`, `price`, `shipping_cost`, `transaction_id`, `payment_intent_id`, `notes`, `order_type`, `created_at`, `updated_at`) VALUES
	(4, 2, 'ORD20250807113825483', 'order_in_progress', 'stripe', 23.97, 5.00, 'PENDING', 'pi_3RtSA8C8YG4MiUi80CoVoszD', 'stripe order inertia part 1', 'delivery', '2025-08-07 05:38:25', '2025-08-07 05:38:25'),
	(5, 2, 'ORD20250807114116734', 'order_in_progress', 'stripe', 34.97, 5.00, 'PENDING', 'pi_3RtSCqC8YG4MiUi80PUyFUPr', NULL, 'delivery', '2025-08-07 05:41:16', '2025-08-07 05:41:16');

-- Dumping structure for table laravel-inertia-stripe.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `food_item_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_food_item_id_foreign` (`food_item_id`),
  CONSTRAINT `order_items_food_item_id_foreign` FOREIGN KEY (`food_item_id`) REFERENCES `food_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.order_items: ~4 rows (approximately)
INSERT INTO `order_items` (`id`, `order_id`, `food_item_id`, `quantity`, `price`, `discount`, `created_at`, `updated_at`) VALUES
	(1, 4, 5, 1, 11.99, 0.00, '2025-08-07 05:38:25', '2025-08-07 05:38:25'),
	(2, 4, 6, 2, 5.99, 0.00, '2025-08-07 05:38:25', '2025-08-07 05:38:25'),
	(3, 5, 5, 1, 11.99, 0.00, '2025-08-07 05:41:16', '2025-08-07 05:41:16'),
	(4, 5, 4, 1, 14.99, 0.00, '2025-08-07 05:41:16', '2025-08-07 05:41:16'),
	(5, 5, 3, 1, 7.99, 0.00, '2025-08-07 05:41:16', '2025-08-07 05:41:16');

-- Dumping structure for table laravel-inertia-stripe.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table laravel-inertia-stripe.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table laravel-inertia-stripe.sessions: ~2 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('mMF6MLTZ43LdaRTfCbYeog49p435akDg0mULf8SL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTDNwSFI0dzB3UkY0Z2VGQWJMNjVObEdERHFRYjN4eGs1MnQwSHYyNCI7czoxNToiY2FydF9zZXNzaW9uX2lkIjtzOjQwOiJtTUY2TUxUWjQzTGRhUlRmQ2JZZW9nNDlwNDM1YWtEZzBtVUxmOFNMIjtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNDoiaHR0cDovL2xhcmF2ZWwtaW5lcnRpYS1zdHJpcGUudGVzdCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1754588984),
	('UYprKyCWEYgILNwCIup7Oks5Fv5hARWystHf0Ydn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOG9Nd2Z4bEJoc0xTME50UGJ6bkdwNG04NXBKTDdZcWhEdmRFRjlhaCI7czoxNToiY2FydF9zZXNzaW9uX2lkIjtzOjQwOiJVWXByS3lDV0VZZ0lMTndDSXVwN09rczVGdjVoQVJXeXN0SGYwWWRuIjtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNDoiaHR0cDovL2xhcmF2ZWwtaW5lcnRpYS1zdHJpcGUudGVzdCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1754566923);



/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

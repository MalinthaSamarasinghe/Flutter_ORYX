-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2024 at 03:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oryx`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_10_07_055751_add_role_to_users_table', 1),
(6, '2024_10_07_060945_create_products_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 2, 'auth_token', 'd95d0b7c4b03c880aa1293b8190d64d25e61a876e27f8ed94f4afb810dfa64dc', '[\"*\"]', NULL, NULL, '2024-10-13 22:43:08', '2024-10-13 22:43:08'),
(3, 'App\\Models\\User', 2, 'auth_token', '14735a36ba47e4db80426402b0c0f36ec91d2e42aac34fdc876242052c7a6eb7', '[\"*\"]', NULL, NULL, '2024-10-13 22:43:21', '2024-10-13 22:43:21'),
(4, 'App\\Models\\User', 2, 'auth_token', '857b9331543e9a3cd2d22e4357a8c028596cd744aa05fd1dd38324addb436c96', '[\"*\"]', NULL, NULL, '2024-10-13 22:45:06', '2024-10-13 22:45:06'),
(5, 'App\\Models\\User', 2, 'auth_token', 'fd2a7344d8ea4942e6201cee0778c5a9066ea114f4edd04ce6baa57b7551a20f', '[\"*\"]', NULL, NULL, '2024-10-13 22:51:23', '2024-10-13 22:51:23'),
(6, 'App\\Models\\User', 2, 'auth_token', '74334c456882a18b39553592dec7fc37e3394c2d7a7f2834412bfb29c844638d', '[\"*\"]', NULL, NULL, '2024-10-14 00:16:05', '2024-10-14 00:16:05'),
(7, 'App\\Models\\User', 3, 'auth_token', 'bf32fa4591183b843042566e40023cc1ce5cfa51309355ea49e52f5f164b9e7b', '[\"*\"]', NULL, NULL, '2024-10-14 00:17:21', '2024-10-14 00:17:21'),
(8, 'App\\Models\\User', 3, 'auth_token', '2ec8dfcf56935d287df95f29e454be59351a88c84d75c5871cf2dff7b4a92e18', '[\"*\"]', NULL, NULL, '2024-10-14 00:17:42', '2024-10-14 00:17:42'),
(9, 'App\\Models\\User', 3, 'auth_token', '191a9864105b07910593afb9cd39882bd54bcac26060999f06822be9777b5888', '[\"*\"]', NULL, NULL, '2024-10-14 00:23:37', '2024-10-14 00:23:37'),
(10, 'App\\Models\\User', 3, 'auth_token', 'c41e9a5edd698966ea71421b4b545a6f56fe8307c490cfa78659b8b32eebf83c', '[\"*\"]', NULL, NULL, '2024-10-14 00:29:52', '2024-10-14 00:29:52'),
(23, 'App\\Models\\User', 4, 'auth_token', '2e0e73d2c15c29919d87552507b3680eed45937d6d4abad72382ce7a3279082f', '[\"*\"]', '2024-10-14 15:08:16', NULL, '2024-10-14 06:14:26', '2024-10-14 15:08:16'),
(38, 'App\\Models\\User', 8, 'auth_token', '520881b5cef5a1c2e75293e3709269d17227397faa6f1c1ab26cdad42946e61d', '[\"*\"]', NULL, NULL, '2024-10-16 22:50:10', '2024-10-16 22:50:10'),
(39, 'App\\Models\\User', 9, 'auth_token', 'eb19dd9996a97b9f776b4024cc9c6d53eee3734e705e668b339c781bd8d81b09', '[\"*\"]', NULL, NULL, '2024-10-17 00:03:38', '2024-10-17 00:03:38'),
(55, 'App\\Models\\User', 1, 'auth_token', '3b46c0796ac266dbce8c81000265f88d6dbacc2269f45c82f3e05aa282fd68c0', '[\"*\"]', '2024-10-17 04:33:05', NULL, '2024-10-17 04:20:43', '2024-10-17 04:33:05'),
(56, 'App\\Models\\User', 1, 'auth_token', '17f881044e99f63d48761a992b265a198d3da02ac456362298d8b7530a9a88d5', '[\"*\"]', '2024-10-17 04:37:08', NULL, '2024-10-17 04:33:15', '2024-10-17 04:37:08'),
(57, 'App\\Models\\User', 1, 'auth_token', '94c2227f8faec1396eddc19a5155b97a6d0f5f31a19d7daa9958e6f461df77ce', '[\"*\"]', '2024-10-17 04:38:38', NULL, '2024-10-17 04:38:34', '2024-10-17 04:38:38'),
(58, 'App\\Models\\User', 1, 'auth_token', 'bca7a1893bf96857abfdfcc336dbc1627b785cb2c8c691f2e5e81bb5d2ad3aa2', '[\"*\"]', NULL, NULL, '2024-10-17 04:44:21', '2024-10-17 04:44:21'),
(59, 'App\\Models\\User', 1, 'auth_token', 'f3f3a12e48d5bbe7045433a8ff94d9ffda747dd10ba52434eb8635cbe97cdbbf', '[\"*\"]', NULL, NULL, '2024-10-17 04:44:23', '2024-10-17 04:44:23'),
(60, 'App\\Models\\User', 10, 'auth_token', 'ebfa00cea9de52c41a82404b3b4b9feb92806b98ab1b0bb0df3a80c613cfffb2', '[\"*\"]', NULL, NULL, '2024-10-17 04:45:25', '2024-10-17 04:45:25'),
(61, 'App\\Models\\User', 1, 'auth_token', '2e474bae4cebd0731174fe8a372b6a5731c9d53b677949fe46820cbafdbffc84', '[\"*\"]', NULL, NULL, '2024-10-17 04:50:40', '2024-10-17 04:50:40'),
(62, 'App\\Models\\User', 1, 'auth_token', 'c7ab079fb71870e6bc1a6126415c584c6fb43f655fc0bea27406235c79b1b6fa', '[\"*\"]', NULL, NULL, '2024-10-17 05:35:55', '2024-10-17 05:35:55'),
(63, 'App\\Models\\User', 1, 'auth_token', '601b02e0ced899fb1de6d4420a76751ff676ecfaeac2c52bb460dd1a33473d6c', '[\"*\"]', NULL, NULL, '2024-10-17 07:23:22', '2024-10-17 07:23:22'),
(64, 'App\\Models\\User', 1, 'auth_token', '2c02f7987946ba6b3aad440192665910f2489b4267dcbc9ee48cba5d7a8ba9fa', '[\"*\"]', NULL, NULL, '2024-10-17 08:26:18', '2024-10-17 08:26:18'),
(65, 'App\\Models\\User', 1, 'auth_token', '00d21673e034f57ce8fe510e2a15c05e9b9537b4376b92c45d923fdbe90ac08d', '[\"*\"]', NULL, NULL, '2024-10-17 09:50:13', '2024-10-17 09:50:13'),
(66, 'App\\Models\\User', 1, 'auth_token', 'c9e26efa8c294c7f65f23d751a8a012ada5c3ca1b963229b95c660330050a1c4', '[\"*\"]', NULL, NULL, '2024-10-17 10:18:04', '2024-10-17 10:18:04'),
(67, 'App\\Models\\User', 1, 'auth_token', '0d30b3f114d9f9d1fc41d495fb29e2c69e57ef36f820ad6cf00772ce8b3797e8', '[\"*\"]', NULL, NULL, '2024-10-17 10:18:11', '2024-10-17 10:18:11'),
(68, 'App\\Models\\User', 1, 'auth_token', 'f8a3f5058f67ba245733965e48b54c59ef57ab914a3a41307798148db9174bf3', '[\"*\"]', NULL, NULL, '2024-10-17 10:52:50', '2024-10-17 10:52:50'),
(69, 'App\\Models\\User', 1, 'auth_token', '0f408da97debf018f8b48225dc7f771c091f0846f45634efc3d7faba60b660cc', '[\"*\"]', NULL, NULL, '2024-10-17 11:35:08', '2024-10-17 11:35:08'),
(70, 'App\\Models\\User', 1, 'auth_token', '34849018e6343c40ef2b39e39542cb3761692e3b9a39849ff071928800fbb39e', '[\"*\"]', NULL, NULL, '2024-10-17 11:35:25', '2024-10-17 11:35:25'),
(71, 'App\\Models\\User', 1, 'auth_token', '6bd6cbe43d309a451d03de81648685ba81dde40631a607b39e35d0f6e06efbb7', '[\"*\"]', NULL, NULL, '2024-10-17 12:31:46', '2024-10-17 12:31:46'),
(72, 'App\\Models\\User', 1, 'auth_token', '7c6a61a3918ecb793d9713c25c42992b594db3d3dba345ac3c54c987158bcb05', '[\"*\"]', NULL, NULL, '2024-10-17 12:36:02', '2024-10-17 12:36:02'),
(73, 'App\\Models\\User', 1, 'auth_token', '84351869994299de495d09e89e8ed43082f0b5a6b11e4e4e9acdc801b8ab7781', '[\"*\"]', NULL, NULL, '2024-10-17 12:54:36', '2024-10-17 12:54:36'),
(74, 'App\\Models\\User', 1, 'auth_token', '318f03ca8725316081e65316fd26906157317756690aafa7924852d28dd359c6', '[\"*\"]', NULL, NULL, '2024-10-17 14:29:29', '2024-10-17 14:29:29'),
(75, 'App\\Models\\User', 1, 'auth_token', '3efd0f8f139c95db019379152f1bfecdb1389df263dc7f51bc9cd4b8f186f5f6', '[\"*\"]', NULL, NULL, '2024-10-17 15:42:33', '2024-10-17 15:42:33'),
(76, 'App\\Models\\User', 1, 'auth_token', 'c0055ee7aad8adb990b85e8cfbf086b317b28c911de0c4d9190c03a69802be6a', '[\"*\"]', NULL, NULL, '2024-10-17 18:31:51', '2024-10-17 18:31:51'),
(77, 'App\\Models\\User', 1, 'auth_token', 'e8846a101e893e45b12ee2f1db3aa5b6ebaa6db87682f0fc1fb5b45c3c5af574', '[\"*\"]', NULL, NULL, '2024-10-18 05:00:52', '2024-10-18 05:00:52'),
(78, 'App\\Models\\User', 1, 'auth_token', '7fd2d293ad8fd4046239dd146a37aa49cd362b42a23e9132254ea8f79133cb2c', '[\"*\"]', NULL, NULL, '2024-10-18 05:05:58', '2024-10-18 05:05:58'),
(79, 'App\\Models\\User', 1, 'auth_token', '8e11f4c1c547ef5ac72cac88d7c645b47f29d9117937354deec8b923e0e9f284', '[\"*\"]', NULL, NULL, '2024-10-18 05:07:08', '2024-10-18 05:07:08'),
(80, 'App\\Models\\User', 1, 'auth_token', 'c6f6cc29bc3890c762896eb9fc1a44b6232fc914d0ca66fb6b27900d81050186', '[\"*\"]', NULL, NULL, '2024-10-18 05:44:18', '2024-10-18 05:44:18'),
(81, 'App\\Models\\User', 1, 'auth_token', '34874c434698a9c8a25404597280d2a30077de56d161ce1cd1f0530c2a73d200', '[\"*\"]', NULL, NULL, '2024-10-18 05:49:22', '2024-10-18 05:49:22'),
(82, 'App\\Models\\User', 1, 'auth_token', 'a56beb723f312bc8a3974dc7a3408e393ab4516f04922806b187d4382b12d9bf', '[\"*\"]', NULL, NULL, '2024-10-18 05:50:59', '2024-10-18 05:50:59');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Flawless Liquid Foundation', 'Discover the secret to a smooth, radiant complexion with our Flawless Liquid Foundation. Designed to provide a natural, airbrushed finish, this lightweight formula effortlessly blends into the skin, delivering buildable coverage that conceals imperfections without feeling heavy. Infused with nourishing ingredients, it hydrates your skin throughout the day, leaving it soft and supple while minimizing the appearance of pores and fine lines.\n\nThis foundation not only enhances your natural glow but also provides long-lasting wear, ensuring your look stays fresh and flawless from morning to night. Its non-greasy, breathable texture makes it perfect for everyday use, while the wide range of shades ensures a perfect match for every skin tone, from the lightest to the deepest. Whether you prefer a sheer look or full coverage, Flawless Liquid Foundation adapts to your needs, giving you the confidence of a beautifully even complexion, no matter the occasion. Ideal for all skin types, it offers a comfortable, weightless feel, making it your go-to foundation for a flawless, radiant finish.', 290.00, 100, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FFlawless%20Liquid%20Foundation.png?alt=media&token=d63e3191-d75b-4310-84f8-9decc269b04a', '2024-10-11 11:13:09', '2024-10-18 13:07:28'),
(2, 'Velvet Matte Lipstick', 'Elevate your look with our luxurious Velvet Matte Lipstick, designed to deliver intense color payoff with a soft, velvety finish. This highly pigmented formula glides effortlessly across your lips, providing full coverage in just one stroke. Its rich, matte texture offers a bold, statement look without drying out your lips, ensuring long-lasting wear that feels comfortable all day.\n\nEnriched with moisturizing ingredients, the Velvet Matte Lipstick keeps your lips smooth and hydrated while giving you that perfect matte look. Available in a range of stunning shades, from classic nudes to vibrant reds, it\'s the ultimate accessory for any occasion. Whether you\'re going for an everyday look or a dramatic evening style, this lipstick ensures a flawless, non-transferable finish that stays put without smudging or fading.', 190.00, 150, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FVelvet%20Matte%20Lipstick.png?alt=media&token=45ce9255-0fc1-48f6-a0fb-9081a562748f', '2024-10-11 11:13:09', '2024-10-18 13:07:33'),
(3, '12-Shade Eyeshadow Palette', 'Unleash your creativity with our versatile 12-Shade Eyeshadow Palette, featuring a stunning array of colors to elevate your eye looks. From soft, neutral tones to vibrant, bold shades, this palette offers endless possibilities for any occasion, whether you’re aiming for a subtle daytime look or a dramatic evening ensemble.\n\nEach shadow is finely milled for a smooth, blendable application, allowing you to easily create gradients and dimension. The rich pigmentation ensures that the colors remain true and vibrant throughout the day, while the lightweight formula glides on effortlessly without creasing or fading.\n\nPackaged in a sleek, portable design, this palette is perfect for makeup enthusiasts on the go. Elevate your makeup game and express your unique style with this must-have eyeshadow palette, tailored for every beauty lover.', 400.00, 75, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2F12-Shade%20Eyeshadow%20Palette.png?alt=media&token=4b18add6-10a5-451f-949d-8b9abf4a1bd5', '2024-10-11 11:13:09', '2024-10-18 13:07:37'),
(4, 'Volumizing Mascara', 'Transform your lashes with our Volumizing Mascara, expertly crafted to deliver dramatic volume and intensity. This innovative formula coats each lash evenly, providing stunning lift and fullness without clumping or weighing them down. The unique brush design separates and defines every lash, allowing for a fanned-out effect that enhances your natural beauty.\n\nEnriched with nourishing ingredients, this mascara not only amplifies your lashes but also cares for them, promoting strength and flexibility. Its long-lasting, smudge-proof formula ensures your look stays flawless from morning to night, making it ideal for any occasion. Whether you’re aiming for a bold, dramatic look or simply want to enhance your everyday style, our Volumizing Mascara is your go-to solution for beautifully defined, voluminous lashes that command attention.', 140.00, 200, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FVolumizing%20Mascara.png?alt=media&token=142b23ff-f664-4e2c-b070-e58c6745a0dc', '2024-10-11 11:13:09', '2024-10-18 13:07:42'),
(5, 'Soft Glow Blush', 'Achieve a radiant, healthy flush with our Soft Glow Blush, designed to add a natural warmth to your complexion. This silky formula blends effortlessly onto the skin, delivering a sheer wash of color that enhances your features without overpowering them. Infused with light-reflecting particles, the blush provides a soft, luminous finish that mimics a natural glow, perfect for any occasion.\n\nAvailable in a range of beautiful shades, from delicate pinks to warm peaches, the Soft Glow Blush allows you to customize your look effortlessly. Whether you’re going for a subtle everyday look or a more vibrant evening style, this blush is buildable and versatile, making it easy to achieve your desired intensity. Lightweight and long-lasting, it ensures your cheeks stay beautifully flushed throughout the day, giving you a fresh, youthful appearance that radiates confidence.', 240.00, 120, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FSoft%20Glow%20Blush.png?alt=media&token=7b1c05ac-6cd6-46e2-aad0-6814d723317a', '2024-10-11 11:13:09', '2024-10-18 13:07:47'),
(6, 'Liquid Gold Highlighter', 'Illuminate your complexion with our Liquid Gold Highlighter, a luxurious formula that provides a stunning, radiant glow. This lightweight, liquid highlighter glides on effortlessly, blending seamlessly into your skin for a natural, dewy finish. Infused with finely milled pearls, it captures and reflects light, accentuating your cheekbones, brow bones, and cupid\'s bow for a luminous look that lasts all day.\n\nThe versatile formula can be used alone for a subtle shimmer or layered over your foundation for an intense, eye-catching highlight. Available in a rich golden hue, this highlighter complements all skin tones, adding warmth and dimension to your makeup routine. Perfect for any occasion, from casual outings to special events, the Liquid Gold Highlighter is your go-to product for achieving a radiant, glowing complexion that enhances your natural beauty.', 220.00, 80, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FLiquid%20Gold%20Highlighter.png?alt=media&token=baefae8b-a8f1-4dfe-8ffe-ab20f0c26ee3', '2024-10-11 11:13:09', '2024-10-18 13:07:53'),
(7, '10-Piece Professional Makeup Brush Set', 'Elevate your makeup application with our 10-Piece Professional Makeup Brush Set, thoughtfully curated for both beginners and beauty enthusiasts alike. Each brush is expertly crafted with high-quality synthetic fibers that ensure a soft, luxurious feel while providing flawless results. The set includes a variety of brushes designed for different tasks, from foundation and concealer to eyeshadow and contouring, making it a versatile addition to your beauty collection.\n\nThe ergonomic handles offer a comfortable grip, allowing for precise control and easy application. With this brush set, you can achieve seamless blending and expert techniques, whether you’re creating a natural everyday look or a bold, dramatic style. Durable and easy to clean, these brushes are designed to withstand regular use, ensuring they remain a staple in your beauty routine for years to come. Transform your makeup application experience with our 10-Piece Professional Makeup Brush Set, and unleash your creativity with confidence.', 490.00, 50, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2F10-Piece%20Professional%20Makeup%20Brush%20Set.png?alt=media&token=04120777-0563-4de7-9c27-1dcf778125e1', '2024-10-11 11:13:09', '2024-10-18 13:07:56'),
(8, 'Hydrating Makeup Primer', 'Prepare your skin for flawless makeup application with our Hydrating Makeup Primer. This lightweight, non-greasy formula is designed to nourish and hydrate your skin, creating the perfect canvas for your makeup. Enriched with skin-loving ingredients, it helps to lock in moisture while smoothing the surface, minimizing the appearance of pores and fine lines for a beautifully even complexion.\n\nThe Hydrating Makeup Primer enhances the longevity of your makeup, ensuring it stays fresh and vibrant throughout the day. Its silky texture glides on effortlessly, allowing for seamless blending and application. Suitable for all skin types, this primer not only boosts hydration but also helps control shine, making it ideal for both dry and oily skin. Experience the difference of a well-prepped base and enjoy a radiant, long-lasting look with our Hydrating Makeup Primer, your essential first step in any makeup routine.', 270.00, 90, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FHydrating%20Makeup%20Primer.png?alt=media&token=4267fc3a-67a4-47dc-b69c-791b25c6db93', '2024-10-11 11:13:09', '2024-10-18 13:07:57'),
(9, 'Waterproof Liquid Eyeliner', 'Define your eyes with precision using our Waterproof Liquid Eyeliner, expertly formulated for long-lasting wear and stunning results. This high-performance eyeliner glides on smoothly, delivering intense color that stays put throughout the day without smudging or fading. Its quick-drying formula ensures a clean, sharp line, making it easy to create everything from delicate flicks to bold cat eyes.\n\nThe fine-tip applicator allows for precise control, enabling you to achieve your desired look effortlessly, whether you\'re going for a subtle everyday style or a dramatic evening effect. Waterproof and resistant to sweat, humidity, and tears, this eyeliner is perfect for any occasion, ensuring your eye makeup remains flawless no matter the conditions. Elevate your eye game with our Waterproof Liquid Eyeliner and enjoy striking, defined eyes that stand out beautifully.', 120.00, 250, 'https://firebasestorage.googleapis.com/v0/b/fir-storage-58a6f.appspot.com/o/Images%2FWaterproof%20Liquid%20Eyeliner.png?alt=media&token=581db397-44e1-4307-8c20-afd791e51ebe', '2024-10-11 11:13:09', '2024-10-18 13:07:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role`) VALUES
(1, 'example', 'example@example.com', NULL, '$2y$10$XRrdFauKMI1rXQH0gm1X.e.R6ej7UBq28li6WIhklF794VabxYwF.\\', NULL, '2024-10-13 22:34:29', '2024-10-13 22:34:29', 'customer'),
(2, 'test one', 'testone@example.com', NULL, '$2y$10$w/VanWBJaVqSfMGEhdaYauSlQniObQ39tkCDTpawLDF5nXn3etKee', NULL, '2024-10-13 22:43:08', '2024-10-13 22:43:08', 'customer'),
(3, 'rush', 'rush@test.com', NULL, '$2y$10$bv4tJSfvunhaykQR7F9ds.JZC1Vqx8CWBPk9fz2teL9eZh.Nn.cOG', NULL, '2024-10-14 00:17:21', '2024-10-14 00:17:21', 'customer'),
(4, 'something', 'something@test.com', NULL, '$2y$10$/WlShafLEiWu1htATUnXve5xBi/M5.rRoMgVYI1dnkRgGWCDl5S.i', NULL, '2024-10-14 00:31:20', '2024-10-14 00:31:20', 'customer'),
(5, 'test', 'test@test.com', NULL, '$2y$10$v6rb724nC8coR2foS4QruuiBsbsDXSWjIxBy/GOjXI2BWZlPVMGuS', NULL, '2024-10-14 01:26:56', '2024-10-14 01:26:56', 'customer'),
(6, 'parami', 'parami123@gmail.com', NULL, '$2y$10$3MXaLUkAe9KMzhNXmi37DOXpw1NW8Fr27aksBh1K481KtzFn0VNly', NULL, '2024-10-14 08:30:27', '2024-10-14 08:30:27', 'customer'),
(7, 'admin', 'admin@test.com', NULL, '$2y$10$alS5SM6Hbm1tZm8tpBCC3OblNWf6.T6D/FX9owXtDP/NRRmuj215i', NULL, '2024-10-14 08:31:30', '2024-10-14 08:31:30', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

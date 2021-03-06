-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 08, 2016 at 07:16 PM
-- Server version: 5.5.53-0+deb8u1
-- PHP Version: 5.6.27-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `quizzlebot`
--

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `telegram_id` int(11) UNSIGNED NOT NULL,
  `riddle_id` int(11) UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `identity`
--

CREATE TABLE `identity` (
  `telegram_id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `riddle_id` int(10) UNSIGNED DEFAULT NULL,
  `participants_count` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `riddle`
--

CREATE TABLE `riddle` (
  `id` int(11) UNSIGNED NOT NULL,
  `session_id` int(10) UNSIGNED NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` timestamp NULL DEFAULT NULL,
  `answer` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `salt` char(2) COLLATE utf8_bin NOT NULL,
  `channel_message_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(10) UNSIGNED NOT NULL,
  `creation_date` date NOT NULL,
  `telegram_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`telegram_id`,`riddle_id`) USING BTREE,
  ADD KEY `riddle_id_index` (`riddle_id`) USING BTREE,
  ADD KEY `telegram_id_index` (`telegram_id`) USING BTREE;

--
-- Indexes for table `identity`
--
ALTER TABLE `identity`
  ADD PRIMARY KEY (`telegram_id`),
  ADD KEY `riddle_id` (`riddle_id`);

--
-- Indexes for table `riddle`
--
ALTER TABLE `riddle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `riddle`
--
ALTER TABLE `riddle`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `riddle_id_fkey` FOREIGN KEY (`riddle_id`) REFERENCES `riddle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `telegram_id_fkey` FOREIGN KEY (`telegram_id`) REFERENCES `identity` (`telegram_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `riddle`
--
ALTER TABLE `riddle`
  ADD CONSTRAINT `riddle_constraint` FOREIGN KEY (`session_id`) REFERENCES `riddle` (`id`);

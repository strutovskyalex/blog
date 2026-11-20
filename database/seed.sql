SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `posts`;
TRUNCATE TABLE `categories`;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'PHP & Backend', 'Articles about PHP, architecture, performance, and backend development.', '2026-01-10 10:00:00'),
(2, 'Databases & SQL', 'MySQL, indexing, query optimization, and schema design notes.', '2026-01-11 11:00:00'),
(3, 'DevOps & Docker', 'Containers, local environments, deployment, and server setup.', '2026-01-12 12:00:00'),
(4, 'Frontend & UI', 'Layouts, CSS styling, templates, and user interface patterns.', '2026-01-13 13:00:00'),
(5, 'Career & Practice', 'Test tasks, code reviews, engineering habits, and problem solving.', '2026-01-14 14:00:00'),
(6, 'Empty Category', 'Category intentionally left without any posts for testing empty states.', '2026-01-15 15:00:00');

INSERT INTO `posts` (`id`, `category_ids`, `title`, `short_description`, `description`, `image`, `viewed`, `created_at`) VALUES
(1, '1', 'Post 1 in PHP & Backend', 'Short summary for post 1 in category 1.', 'Full content for post 1 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 09:00:00'),
(2, '1', 'Post 2 in PHP & Backend', 'Short summary for post 2 in category 1.', 'Full content for post 2 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 10:00:00'),
(3, '1', 'Post 3 in PHP & Backend', 'Short summary for post 3 in category 1.', 'Full content for post 3 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 11:00:00'),
(4, '1', 'Post 4 in PHP & Backend', 'Short summary for post 4 in category 1.', 'Full content for post 4 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 12:00:00'),
(5, '1', 'Post 5 in PHP & Backend', 'Short summary for post 5 in category 1.', 'Full content for post 5 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 13:00:00'),
(6, '1', 'Post 6 in PHP & Backend', 'Short summary for post 6 in category 1.', 'Full content for post 6 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 14:00:00'),
(7, '1', 'Post 7 in PHP & Backend', 'Short summary for post 7 in category 1.', 'Full content for post 7 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 15:00:00'),
(8, '1', 'Post 8 in PHP & Backend', 'Short summary for post 8 in category 1.', 'Full content for post 8 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 16:00:00'),
(9, '1', 'Post 9 in PHP & Backend', 'Short summary for post 9 in category 1.', 'Full content for post 9 in category 1 with sample details and examples.', '/images/preview.png', 0, '2026-02-01 17:00:00'),
(10, '1,2', 'Post 10 in PHP & Backend (Multi-category)', 'Short summary for post 10 in category 1.', 'Full content for post 10 in category 1 with sample details and examples.', '/images/preview.png', 33, '2026-02-01 18:00:00'),

(11, '2', 'Post 1 in Databases & SQL', 'Short summary for post 1 in category 2.', 'Full content for post 1 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 09:00:00'),
(12, '2', 'Post 2 in Databases & SQL', 'Short summary for post 2 in category 2.', 'Full content for post 2 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 10:00:00'),
(13, '2', 'Post 3 in Databases & SQL', 'Short summary for post 3 in category 2.', 'Full content for post 3 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 11:00:00'),
(14, '2', 'Post 4 in Databases & SQL', 'Short summary for post 4 in category 2.', 'Full content for post 4 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 12:00:00'),
(15, '2', 'Post 5 in Databases & SQL', 'Short summary for post 5 in category 2.', 'Full content for post 5 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 13:00:00'),
(16, '2', 'Post 6 in Databases & SQL', 'Short summary for post 6 in category 2.', 'Full content for post 6 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 14:00:00'),
(17, '2', 'Post 7 in Databases & SQL', 'Short summary for post 7 in category 2.', 'Full content for post 7 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 15:00:00'),
(18, '2', 'Post 8 in Databases & SQL', 'Short summary for post 8 in category 2.', 'Full content for post 8 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 16:00:00'),
(19, '2', 'Post 9 in Databases & SQL', 'Short summary for post 9 in category 2.', 'Full content for post 9 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 17:00:00'),
(20, '2,3', 'Post 10 in Databases & SQL (Multi-category)', 'Short summary for post 10 in category 2.', 'Full content for post 10 in category 2 with sample details and examples.', '/images/preview.png', 0, '2026-02-02 18:00:00'),

(21, '3', 'Post 1 in DevOps & Docker', 'Short summary for post 1 in category 3.', 'Full content for post 1 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 09:00:00'),
(22, '3', 'Post 2 in DevOps & Docker', 'Short summary for post 2 in category 3.', 'Full content for post 2 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 10:00:00'),
(23, '3', 'Post 3 in DevOps & Docker', 'Short summary for post 3 in category 3.', 'Full content for post 3 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 11:00:00'),
(24, '3', 'Post 4 in DevOps & Docker', 'Short summary for post 4 in category 3.', 'Full content for post 4 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 12:00:00'),
(25, '3', 'Post 5 in DevOps & Docker', 'Short summary for post 5 in category 3.', 'Full content for post 5 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 13:00:00'),
(26, '3', 'Post 6 in DevOps & Docker', 'Short summary for post 6 in category 3.', 'Full content for post 6 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 14:00:00'),
(27, '3', 'Post 7 in DevOps & Docker', 'Short summary for post 7 in category 3.', 'Full content for post 7 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 15:00:00'),
(28, '3', 'Post 8 in DevOps & Docker', 'Short summary for post 8 in category 3.', 'Full content for post 8 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 16:00:00'),
(29, '3', 'Post 9 in DevOps & Docker', 'Short summary for post 9 in category 3.', 'Full content for post 9 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 17:00:00'),
(30, '3,4', 'Post 10 in DevOps & Docker (Multi-category)', 'Short summary for post 10 in category 3.', 'Full content for post 10 in category 3 with sample details and examples.', '/images/preview.png', 0, '2026-02-03 18:00:00'),

(31, '4', 'Post 1 in Frontend & UI', 'Short summary for post 1 in category 4.', 'Full content for post 1 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 09:00:00'),
(32, '4', 'Post 2 in Frontend & UI', 'Short summary for post 2 in category 4.', 'Full content for post 2 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 10:00:00'),
(33, '4', 'Post 3 in Frontend & UI', 'Short summary for post 3 in category 4.', 'Full content for post 3 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 11:00:00'),
(34, '4', 'Post 4 in Frontend & UI', 'Short summary for post 4 in category 4.', 'Full content for post 4 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 12:00:00'),
(35, '4', 'Post 5 in Frontend & UI', 'Short summary for post 5 in category 4.', 'Full content for post 5 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 13:00:00'),
(36, '4', 'Post 6 in Frontend & UI', 'Short summary for post 6 in category 4.', 'Full content for post 6 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 14:00:00'),
(37, '4', 'Post 7 in Frontend & UI', 'Short summary for post 7 in category 4.', 'Full content for post 7 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 15:00:00'),
(38, '4', 'Post 8 in Frontend & UI', 'Short summary for post 8 in category 4.', 'Full content for post 8 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 16:00:00'),
(39, '4', 'Post 9 in Frontend & UI', 'Short summary for post 9 in category 4.', 'Full content for post 9 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 17:00:00'),
(40, '4,5', 'Post 10 in Frontend & UI (Multi-category)', 'Short summary for post 10 in category 4.', 'Full content for post 10 in category 4 with sample details and examples.', '/images/preview.png', 0, '2026-02-04 18:00:00'),

(41, '5', 'Post 1 in Career & Practice', 'Short summary for post 1 in category 5.', 'Full content for post 1 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 09:00:00'),
(42, '5', 'Post 2 in Career & Practice', 'Short summary for post 2 in category 5.', 'Full content for post 2 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 10:00:00'),
(43, '5', 'Post 3 in Career & Practice', 'Short summary for post 3 in category 5.', 'Full content for post 3 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 11:00:00'),
(44, '5', 'Post 4 in Career & Practice', 'Short summary for post 4 in category 5.', 'Full content for post 4 in category 5 with sample details and examples.', '/assets/images/ppreview.jpg', 0, '2026-02-05 12:00:00'),
(45, '5', 'Post 5 in Career & Practice', 'Short summary for post 5 in category 5.', 'Full content for post 5 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 13:00:00'),
(46, '5', 'Post 6 in Career & Practice', 'Short summary for post 6 in category 5.', 'Full content for post 6 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 14:00:00'),
(47, '5', 'Post 7 in Career & Practice', 'Short summary for post 7 in category 5.', 'Full content for post 7 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 15:00:00'),
(48, '5', 'Post 8 in Career & Practice', 'Short summary for post 8 in category 5.', 'Full content for post 8 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 16:00:00'),
(49, '5', 'Post 9 in Career & Practice', 'Short summary for post 9 in category 5.', 'Full content for post 9 in category 5 with sample details and examples.', '/images/preview.png', 0, '2026-02-05 17:00:00'),
(50, '5,4', 'Post 10 in Career & Practice (Multi-category)', 'Short summary for post 10 assigned to two categories (5 and 6).', 'Full content for post 50 assigned to categories 5 and 6 to verify multi-category filtering and display.', '/images/preview.png', 0, '2026-02-05 18:00:00');
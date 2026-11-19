<?php

declare(strict_types=1);

$host = $_ENV['DB_HOST'] ?? $_SERVER['DB_HOST'] ?? (getenv('DB_HOST') ?: 'db');
$port = $_ENV['DB_PORT'] ?? $_SERVER['DB_PORT'] ?? (getenv('DB_PORT') ?: '3306');
$db   = $_ENV['DB_NAME'] ?? $_SERVER['DB_NAME'] ?? (getenv('DB_NAME') ?: 'root');
$user = $_ENV['DB_USER'] ?? $_SERVER['DB_USER'] ?? (getenv('DB_USER') ?: 'root');
$pass = $_ENV['DB_PASS'] ?? $_SERVER['DB_PASS'] ?? (getenv('DB_PASS') ?: '');

$dsn = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4', $host, $port, $db);


return new PDO($dsn, $user, $pass, [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
]);
<?php

declare(strict_types=1);

namespace App\Models;

use PDO;

final class CategoryModel
{
    public function __construct(private readonly PDO $pdo) {}

    public function getCategoriesWithPosts(): array
    {
        $sql = <<<'SQL'
            SELECT c.id, c.name, c.description, c.created_at
            FROM `categories` c
            WHERE EXISTS (
                SELECT 1
                FROM `posts` p
                WHERE FIND_IN_SET(CAST(c.id AS CHAR) COLLATE utf8mb4_unicode_ci,p.category_ids COLLATE utf8mb4_unicode_ci) > 0
            )
            ORDER BY c.id ASC
        SQL;

        return $this->pdo->query($sql)->fetchAll();
    }

    public function findById(int $id): ?array
    {
        $stmt = $this->pdo->prepare(
            'SELECT id, name, description, created_at FROM `categories` WHERE id = :id LIMIT 1'
        );
        $stmt->execute(['id' => $id]);
        $row = $stmt->fetch();

        return $row !== false ? $row : null;
    }

    public function findByIds(array $ids): array
    {
        $cleanIds = array_values(array_unique(array_filter(array_map('intval', $ids))));
        if ($cleanIds === []) {
            return [];
        }

        $placeholders = implode(',', array_fill(0, count($cleanIds), '?'));
        $stmt = $this->pdo->prepare(
            "SELECT id, name, description, created_at FROM `categories` WHERE id IN ($placeholders) ORDER BY id ASC"
        );
        $stmt->execute($cleanIds);

        return $stmt->fetchAll();
    }
}
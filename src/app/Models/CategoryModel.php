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
}
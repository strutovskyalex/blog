<?php

declare(strict_types=1);

namespace App\Models;

use PDO;

final class PostModel
{
    private const DEFAULT_IMAGE = '/assets/img/preview.jpg';

    public function __construct(private readonly PDO $pdo) {}

    public function getLatestByCategoryId(int $categoryId, int $limit = 3): array
    {
        $sql = <<<'SQL'
            SELECT id, category_ids, title, short_description, description, image, viewed, created_at
            FROM `posts`
            WHERE FIND_IN_SET(:category_id, category_ids) > 0
            ORDER BY created_at DESC, id DESC
            LIMIT :limit
        SQL;

        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':category_id', (string) $categoryId, PDO::PARAM_STR);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();

        return array_map([$this, 'normalizePost'], $stmt->fetchAll());
    }

    private function normalizePost(array $row): array
    {
        $image = trim((string) ($row['image'] ?? ''));
        $row['image_url'] = $image !== '' ? $image : self::DEFAULT_IMAGE;
        $row['category_id_list'] = array_values(array_filter(
            array_map('intval', explode(',', (string) ($row['category_ids'] ?? '')))
        ));

        return $row;
    }
}
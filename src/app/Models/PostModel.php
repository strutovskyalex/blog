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


    public function getAllByCategoryId(int $categoryId): array
    {
        $sql = <<<'SQL'
            SELECT id, category_ids, title, short_description, description, image, viewed, created_at
            FROM `posts`
            WHERE FIND_IN_SET(:category_id, category_ids) > 0
            ORDER BY created_at DESC, id DESC
        SQL;

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(['category_id' => (string) $categoryId]);

        return array_map([$this, 'normalizePost'], $stmt->fetchAll());
    }


    public function findAndIncrementViews(int $id): ?array
    {
        $this->pdo->beginTransaction();

        try {
            $update = $this->pdo->prepare(
                'UPDATE `posts` SET viewed = viewed + 1 WHERE id = :id'
            );
            $update->execute(['id' => $id]);

            if ($update->rowCount() === 0) {
                $this->pdo->rollBack();
                return null;
            }

            $select = $this->pdo->prepare(
                'SELECT id, category_ids, title, short_description, description, image, viewed, created_at FROM `posts` WHERE id = :id LIMIT 1'
            );
            $select->execute(['id' => $id]);
            $post = $select->fetch();

            $this->pdo->commit();

            return $post !== false ? $this->normalizePost($post) : null;
        } catch (\Throwable $e) {
            if ($this->pdo->inTransaction()) {
                $this->pdo->rollBack();
            }
            throw $e;
        }
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

    public function getRandomSuggestedByCategories(array|string $categoryIds, int $excludePostId, int $limit = 3): array
    {
        $rawIds = is_string($categoryIds)
            ? explode(',', $categoryIds)
            : $categoryIds;

        $ids = array_values(array_unique(array_filter(
            array_map('intval', $rawIds),
            static fn(int $id): bool => $id > 0
        )));

        if ($ids === [] || $limit <= 0) {
            return [];
        }

        $conditions = [];
        foreach ($ids as $index => $_) {
            $conditions[] = "FIND_IN_SET(:cat_{$index}, category_ids) > 0";
        }

        $whereCategories = '(' . implode(' OR ', $conditions) . ')';

        $sql = <<<SQL
        SELECT DISTINCT id, title, short_description, image, viewed, created_at, category_ids
        FROM posts
        WHERE id <> :exclude_id
          AND {$whereCategories}
        ORDER BY RAND()
        LIMIT :limit
    SQL;

        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':exclude_id', $excludePostId, PDO::PARAM_INT);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);

        foreach ($ids as $index => $catId) {
            $stmt->bindValue(":cat_{$index}", $catId, PDO::PARAM_INT);
        }

        $stmt->execute();
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $filtered = array_values(array_filter(
            $rows,
            static fn(array $row): bool => (int) ($row['id'] ?? 0) !== $excludePostId
        ));

        return array_slice($filtered, 0, $limit);
    }
}
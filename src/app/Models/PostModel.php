<?php

declare(strict_types=1);

namespace App\Models;

use PDO;

class PostModel
{
    public function __construct(private readonly PDO $pdo) {}


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

            return $post !== false ? $post : null;
        } catch (\Throwable $e) {
            if ($this->pdo->inTransaction()) {
                $this->pdo->rollBack();
            }
            throw $e;
        }
    }


    public function getRandomSuggestedByCategories(string $categoryIds, int $excludePostId, int $limit = 3): array
    {
        $sql = <<<SQL
            SELECT id, title, short_description, image, viewed, created_at, category_ids
            FROM posts
            WHERE id <> :exclude_id
            AND category_ids IN ({$categoryIds})
            ORDER BY RAND()
            LIMIT :limit
        SQL;

        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':exclude_id', $excludePostId, PDO::PARAM_INT);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);


        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getPostsByCategorySorted(
        int $categoryId,
        string $sort = 'date',
        string $direction = 'desc',
        int|string $limit = 'all'
    ): array {
        if ($categoryId <= 0) {
            return [];
        }

        $allowedSorts = [
            'date' => 'created_at',
            'views' => 'viewed',
        ];

        $orderColumn = $allowedSorts[$sort] ?? 'created_at';
        $orderDirection = strtoupper($direction) === 'ASC' ? 'ASC' : 'DESC';

        $sql = <<<SQL
        SELECT id, title, short_description, image, viewed, created_at, category_ids
        FROM posts
        WHERE FIND_IN_SET(:category_id, category_ids) > 0
        ORDER BY {$orderColumn} {$orderDirection}, id DESC
        SQL;

        if (is_int($limit)) {
            $sql .= ' LIMIT :limit';
        }

        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':category_id', $categoryId, PDO::PARAM_INT);

        if (is_int($limit)) {
            $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        }

        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
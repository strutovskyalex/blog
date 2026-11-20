<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\CategoryModel;
use App\Models\PostModel;
use PDO;
use Smarty\Smarty;

final class PostController
{
    private PostModel $postModel;
    private CategoryModel $categoryModel;

    public function __construct(PDO $pdo, private readonly Smarty $smarty)
    {
        $this->postModel = new PostModel($pdo);
        $this->categoryModel = new CategoryModel($pdo);
    }

    public function show(?int $id = null): void
    {
        $id = $id ?? (filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT) ?: null);

        if (!$id || $id <= 0) {
            http_response_code(400);
            echo 'Invalid post ID';
            return;
        }

        $post = $this->postModel->findAndIncrementViews($id);
        if ($post === null) {
            http_response_code(404);
            echo 'Post not found';
            return;
        }


        $categories = $this->categoryModel->findByIds($post['category_id_list']);
        $currentPostId = (int) $post['id'];

        $suggestedPosts = $this->postModel->getRandomSuggestedByCategories(
            categoryIds: $post['category_ids'],
            excludePostId: $post['id'],
            limit: 3
        );

        $this->smarty->assign('pageTitle', $post['title'] . ' — Blog');
        $this->smarty->assign('post', $post);
        $this->smarty->assign('categories', $categories);
        $this->smarty->assign('suggestedPosts', $suggestedPosts);
        $this->smarty->display('post.tpl');
    }
}
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

    public function show(?int $postId = null): void
    {
        if (!is_int($postId) || $postId <= 0) {
            $this->renderNotFound('Invalid post ID');
            return;
        }

        $post = $this->postModel->findAndIncrementViews($postId);
        if ($post === null) {
            $this->renderNotFound('Post not found.');
            return;
        }


        $categories = $this->categoryModel->findByIds($post['category_ids']);

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

    private function renderNotFound(string $message): void
    {
        http_response_code(404);
        $this->smarty->assign('pageTitle', '404 — Post Not Found');
        $this->smarty->assign('errorMessage', $message);
        $this->smarty->display('404.tpl');
    }
}
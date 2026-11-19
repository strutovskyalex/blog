<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\CategoryModel;
use App\Models\PostModel;
use PDO;
use Smarty\Smarty;

final class CategoryController
{
    private CategoryModel $categoryModel;
    private PostModel $postModel;

    public function __construct(
        PDO $pdo,
        private readonly Smarty $smarty
    ) {
        $this->categoryModel = new CategoryModel($pdo);
        $this->postModel = new PostModel($pdo);
    }

    public function show(?int $id = null): void
    {
        $categoryId = $id ?? (filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT) ?: null);
        if ($categoryId === null || $categoryId <= 0) {
            $this->renderNotFound('Invalid category identifier.');
            return;
        }

        $category = $this->categoryModel->findById($categoryId);
        if ($category === null) {
            $this->renderNotFound('Category not found.');
            return;
        }

        $posts = $this->postModel->getAllByCategoryId($categoryId);

        $this->smarty->assign('pageTitle', $category['name'] . ' — Blog');
        $this->smarty->assign('category', $category);
        $this->smarty->assign('posts', $posts);
        $this->smarty->display('category.tpl');
    }

    private function renderNotFound(string $message): void
    {
        http_response_code(404);
        $this->smarty->assign('pageTitle', '404 — Category Not Found');
        $this->smarty->assign('errorMessage', $message);
        $this->smarty->display('404.tpl');
    }
}
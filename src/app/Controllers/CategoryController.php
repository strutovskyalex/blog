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

    public function show(?int $categoryId = null): void
    {
        if ($categoryId === null || $categoryId <= 0) {
            $this->renderNotFound('Invalid category identifier.');
            return;
        }


        $category = $this->categoryModel->findById($categoryId);
        if ($category === null) {
            $this->renderNotFound('Category not found.');
            return;
        }

        $sort = (string) ($_GET['sort'] ?? 'date');
        $sort = in_array($sort, ['date', 'views'], true) ? $sort : 'date';

        $dir = strtolower((string) ($_GET['dir'] ?? 'desc'));
        $dir = in_array($dir, ['asc', 'desc'], true) ? $dir : 'desc';

        $posts = $this->postModel->getPostsByCategorySorted($categoryId, $sort, $dir);

        $this->smarty->assign('pageTitle', $category['name'] . ' — Blog');
        $this->smarty->assign('category', $category);
        $this->smarty->assign('posts', $posts);
        $this->smarty->assign('currentSort', $sort);
        $this->smarty->assign('currentDir', $dir);
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
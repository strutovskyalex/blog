<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\CategoryModel;
use App\Models\PostModel;
use PDO;
use Smarty\Smarty;

final class CategoryController
{
    const PER_PAGE = 3;
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

        $currentPage = (int) ($_GET['page'] ?? 1);

        $totalPosts = $this->postModel->getCountOfPostsCategory($categoryId);
        $totalPages = max(1, (int) ceil($totalPosts / self::PER_PAGE));

        if ($currentPage > $totalPages) {
            $currentPage = $totalPages;
        }

        if(is_string($currentPage) || $currentPage < 1) {
            $this->renderNotFound('Category page not found.');
            return;
        }

        $offset = ($currentPage - 1) * self::PER_PAGE;

        $posts = $this->postModel->getPostsByCategorySorted($categoryId, $sort, $dir, self::PER_PAGE, $offset);


        // show correct pagination on page left and right, calculation
        // by default 2 pages left and right
        $window = 2;
        $pagesToShow = [];
        $pagesToShow[] = 1;

        $startPage = max(2, $currentPage - $window);
        $endPage = min($totalPages - 1, $currentPage + $window);

        if ($startPage > 2) {
            $pagesToShow[] = 'dots';
        }

        for ($p = $startPage; $p <= $endPage; $p++) {
            $pagesToShow[] = $p;
        }

        if ($endPage < $totalPages - 1) {
            $pagesToShow[] = 'dots';
        }

        if ($totalPages > 1) {
            $pagesToShow[] = $totalPages;
        }

        // END


        $this->smarty->assign('pageTitle', $category['name'] . ' — Blog');
        $this->smarty->assign('category', $category);
        $this->smarty->assign('posts', $posts);
        $this->smarty->assign('currentSort', $sort);
        $this->smarty->assign('currentDir', $dir);
        $this->smarty->assign('currentPage', $currentPage);
        $this->smarty->assign('totalPages', $totalPages);
        $this->smarty->display('category.tpl');
        $this->smarty->assign('pagesToShow', $pagesToShow);
    }

    private function renderNotFound(string $message): void
    {
        http_response_code(404);
        $this->smarty->assign('pageTitle', '404 — Category Not Found');
        $this->smarty->assign('errorMessage', $message);
        $this->smarty->display('404.tpl');
    }
}
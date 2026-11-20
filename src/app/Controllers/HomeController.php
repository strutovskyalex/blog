<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\CategoryModel;
use App\Models\PostModel;
use PDO;
use Smarty\Smarty;

final class HomeController
{
    private CategoryModel $categoryModel;
    private PostModel $postModel;

    public function __construct(PDO $pdo, private readonly Smarty $smarty)
    {
        $this->categoryModel = new CategoryModel($pdo);
        $this->postModel = new PostModel($pdo);
    }

    public function index(): void
    {
        $categories = $this->categoryModel->getCategoriesWithPosts();

        $sections = [];
        foreach ($categories as $category) {
            $categoryId = (int) $category['id'];
            $sections[] = [
                'category' => $category,
                'posts'    => $this->postModel->getPostsByCategorySorted($categoryId, 'date', 'desc', 3),
            ];
        }

        $this->smarty->assign('pageTitle', 'Blog — Categories & Latest Posts');
        $this->smarty->assign('sections', $sections);
        $this->smarty->display('home.tpl');
    }
}
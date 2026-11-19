<?php

declare(strict_types=1);

namespace App\Controllers;

use PDO;
use Smarty\Smarty;

final class PostController
{

    public function __construct(
            PDO $pdo,
            private readonly Smarty $smarty
    ) {
    }

    public function show(?int $id = null): void
    {

        $this->smarty->display('post.tpl');
    }
}
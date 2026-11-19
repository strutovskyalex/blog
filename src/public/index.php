<?php

declare(strict_types=1);

use App\Routing\RouteDispatcher;
use Dotenv\Dotenv;
use Smarty\Smarty;

$appRoot = dirname(__DIR__);

require_once $appRoot . '/vendor/autoload.php';

if (is_file($appRoot . '/.env')) {
    Dotenv::createImmutable($appRoot)->safeLoad();
}

$pdo = require $appRoot . '/config/database.php';
$routes = require $appRoot . '/config/routes.php';



$smarty = new Smarty();
$smarty->setTemplateDir($appRoot . '/templates/');
$smarty->setCompileDir(sys_get_temp_dir() . '/smarty_compile/');
$smarty->setCacheDir(sys_get_temp_dir() . '/smarty_cache/');
$smarty->escape_html = true;

$dispatcher = new RouteDispatcher($routes, $pdo, $smarty);
$dispatcher->dispatch(
    $_SERVER['REQUEST_METHOD'] ?? 'GET',
    $_SERVER['REQUEST_URI'] ?? '/'
);
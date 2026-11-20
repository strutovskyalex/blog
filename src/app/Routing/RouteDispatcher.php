<?php

declare(strict_types=1);

namespace App\Routing;

use FastRoute\Dispatcher;
use FastRoute\RouteCollector;
use PDO;
use Smarty\Smarty;
use App\Models\CategoryModel;

use function FastRoute\simpleDispatcher;

final class RouteDispatcher
{
    private Dispatcher $dispatcher;

    /**
     * @param callable(RouteCollector): void $routesDefinition
     */
    public function __construct(
        callable $routesDefinition,
        private readonly PDO $pdo,
        private readonly Smarty $smarty
    ) {
        $this->dispatcher = simpleDispatcher($routesDefinition);
    }

    public function dispatch(string $httpMethod, string $requestUri): void
    {
        $uri = rawurldecode(parse_url($requestUri, PHP_URL_PATH) ?: '/');
        $routeInfo = $this->dispatcher->dispatch($httpMethod, $uri);

        match ($routeInfo[0]) {
            Dispatcher::NOT_FOUND => $this->notFound(),
            Dispatcher::METHOD_NOT_ALLOWED => $this->methodNotAllowed($routeInfo[1]),
            Dispatcher::FOUND => $this->invokeHandler($routeInfo[1], $routeInfo[2]),
        };
    }

    /**
     * @param array{0: class-string, 1: string} $handler
     * @param array<string, string> $vars
     */
    private function invokeHandler(array $handler, array $vars): void
    {
        [$controllerClass, $method] = $handler;

        $categoryModel = new CategoryModel($this->pdo);
        $categories = $categoryModel->getAll();

        $this->smarty->assign('categories', $categories);


        $controller = new $controllerClass($this->pdo, $this->smarty);
        $routeId = isset($vars['id']) ? (int) $vars['id'] : null;

        $controller->{$method}($routeId);
    }

    private function notFound(string $message = 'The requested page was not found.'): void
    {
        http_response_code(404);
        $this->smarty->assign('pageTitle', '404 — Page Not Found');
        $this->smarty->assign('errorMessage', $message);
        $this->smarty->display('404.tpl');
    }

    /**
     * @param string[] $allowedMethods
     */
    private function methodNotAllowed(array $allowedMethods): void
    {
        http_response_code(405);
        header('Allow: ' . implode(', ', $allowedMethods));
        echo '405 — Method Not Allowed';
    }
}
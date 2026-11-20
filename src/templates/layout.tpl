<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$pageTitle|default:'Блог'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="/assets/css/style.css?v={$styleVersion|default:'1'}">
</head>
<body class="d-flex flex-column min-vh-100">
<nav class="navbar navbar-expand-lg glass-nav sticky-top mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="/">
            <span class="badge text-bg-primary rounded-pill px-2 py-1">MVC</span>
            <span>Blog</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu" aria-controls="navMenu" aria-expanded="false" aria-label="Меню">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto gap-lg-1">
                {if !empty($categories)}
                    {foreach $categories as $cat}
                        <li class="nav-item"><a class="nav-link" href="/category/{$cat.id}">{$cat.name}</a></li>
                    {/foreach}
                {/if}
            </ul>
        </div>
    </div>
</nav>

<main class="container flex-grow-1 pb-5">
    {block name="content"}{/block}
</main>

<footer class="border-top bg-white py-3 mt-auto">
    <div class="container d-flex justify-content-between small text-secondary">
        <span>PHP 8.1 MVC + Smarty v5 + Bootstrap 5</span>
        <span>{$smarty.now|date_format:"%Y"}</span>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
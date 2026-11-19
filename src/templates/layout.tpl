<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$pageTitle|default:'Blog'}</title>
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<header class="site-header">
    <div class="container">
        <a class="site-logo" href="/">Blog</a>
    </div>
</header>

<main class="site-main">
    <div class="container">
        {block name="content"}{/block}
    </div>
</main>
</body>
</html>
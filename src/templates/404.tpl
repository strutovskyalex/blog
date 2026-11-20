{extends file="layout.tpl"}

{block name="content"}
    <div class="card post-card text-center py-5 px-4 shadow-sm">
        <div class="card-body">
            <p class="display-4 fw-bold text-primary mb-2">404</p>
            <h1 class="h4 fw-bold mb-2">Page not found</h1>
            <p class="text-secondary mb-4">{$errorMessage|default:'The requested resource does not exist or has been deleted.'}</p>
            <a href="/" class="btn btn-primary rounded-pill px-4">Home Page</a>
        </div>
    </div>
{/block}
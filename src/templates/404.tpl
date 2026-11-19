{extends file="layout.tpl"}

{block name="content"}
    <section class="error-page" aria-labelledby="error-heading">
        <p class="error-page__code">404</p>
        <h1 id="error-heading" class="error-page__title">Page Not Found</h1>
        <p class="error-page__message">
            {$errorMessage|default:'The page or resource you are looking for does not exist or has been moved.'}
        </p>
        <a class="btn btn--primary" href="/">Back to home</a>
    </section>
{/block}
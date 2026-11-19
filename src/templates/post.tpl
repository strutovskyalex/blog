{extends file="layout.tpl"}

{block name="content"}
    <article class="post-detail">
        <header class="post-detail__header">
            <a class="back-link" href="/">&larr; Back to blog</a>

            <h1 class="post-detail__title">{$post.title}</h1>

            <div class="post-detail__meta">
                <span>ID: {$post.id}</span>
                <time datetime="{$post.created_at}">Published: {$post.created_at}</time>
                <span>Views: {$post.viewed}</span>
            </div>

            {if $categories|@count > 0}
                <ul class="post-detail__categories">
                    {foreach $categories as $cat}
                        <li>
                            <a href="/category?id={$cat.id}">{$cat.name}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </header>

        <figure class="post-detail__media">
            <img src="{$post.image_url}" alt="{$post.title}">
        </figure>

        <p class="post-detail__lead">{$post.short_description}</p>

        <div class="post-detail__content">
            {$post.description|nl2br}
        </div>

        <dl class="post-detail__fields">
            <dt>id</dt>
            <dd>{$post.id}</dd>
            <dt>category_ids</dt>
            <dd>{$post.category_ids}</dd>
            <dt>title</dt>
            <dd>{$post.title}</dd>
            <dt>short_description</dt>
            <dd>{$post.short_description}</dd>
            <dt>description</dt>
            <dd>{$post.description}</dd>
            <dt>image</dt>
            <dd>{$post.image|default:'NULL'}</dd>
            <dt>viewed</dt>
            <dd>{$post.viewed}</dd>
            <dt>created_at</dt>
            <dd>{$post.created_at}</dd>
        </dl>
    </article>
{/block}
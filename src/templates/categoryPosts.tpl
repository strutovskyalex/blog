<article class="post-card">
    <figure class="post-card__media">
        <a href="/post?id={$post.id}">
            <img
                    src="{$post.image_url}"
                    alt="{$post.title}"
                    loading="lazy"
            >
        </a>
    </figure>

    <div class="post-card__body">
        <h3 class="post-card__title">
            <a href="/post?id={$post.id}">{$post.title}</a>
        </h3>

        <p class="post-card__excerpt">{$post.short_description}</p>

        <footer class="post-card__meta">
            <time datetime="{$post.created_at}">{$post.created_at|date_format:"%Y-%m-%d"}</time>
            <span class="post-card__views">Views: {$post.viewed}</span>
        </footer>
    </div>
</article>
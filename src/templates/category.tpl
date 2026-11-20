{extends file="layout.tpl"}

{block name="content"}
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <span class="badge text-bg-primary rounded-pill mb-2">Category</span>
            <h1 class="h2 fw-bold mb-0">{$category.name}</h1>
        </div>
    </div>

    {if !empty($posts)}
        <div class="row g-4">
            {foreach $posts as $post}
                <div class="col-md-6">
                    <article class="card post-card h-100">
                        <div class="card-body p-4">
                            <div class="post-card__meta mb-2">
                                <span>{$post.created_at|date_format:"%d.%m.%Y"}</span>
                                {if isset($post.views)}
                                    <span class="ms-2">• {$post.views} переглядів</span>
                                {/if}
                            </div>
                            <h2 class="h5 card-title fw-bold">
                                <a href="/post/{$post.id}" class="text-decoration-none text-dark stretched-link">{$post.title}</a>
                            </h2>
                            <p class="card-text text-secondary mt-2 mb-0">{$post.short_description|strip_tags|truncate:170:"...":true}</p>
                        </div>
                    </article>
                </div>
            {/foreach}
        </div>
    {else}
        <div class="alert alert-light border text-secondary">There are no posts in this category yet.</div>
    {/if}
{/block}
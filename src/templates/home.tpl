{extends file="layout.tpl"}

{block name="content"}
    <div class="hero-banner p-4 p-md-5 mb-4 shadow-sm">
        <h1 class="h2 fw-bold mb-2">Latest publications by category</h1>
    </div>

    {if !empty($sections)}
        {foreach $sections as $section}
            <section class="mb-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="h4 fw-bold mb-0">{$section.category.name}</h2>
                    <a href="/category/{$section.category.id}" class="btn btn-sm btn-primary rounded-pill px-3">All posts →</a>
                </div>

                {if !empty($section.posts)}
                    <div class="row g-4">
                        {foreach $section.posts as $post}
                            <div class="col-md-6 col-lg-4">
                                <article class="card post-card h-100">
                                    <div class="card-body d-flex flex-column p-4">
                                        <div class="post-card__meta mb-2">
                                            <span>{$post.created_at|date_format:"%d.%m.%Y %H:%M"}</span>
                                            {if isset($post.views)}
                                                <span class="ms-2">• {$post.views} views</span>
                                            {/if}
                                        </div>
                                        <h3 class="h5 card-title fw-bold">
                                            <a href="/post/{$post.id}" class="text-decoration-none text-dark stretched-link">{$post.title}</a>
                                        </h3>
                                        <p class="card-text text-secondary mt-2 mb-0 flex-grow-1">
                                            {$post.short_description|strip_tags|truncate:135:"...":true}
                                        </p>
                                    </div>
                                </article>
                            </div>
                        {/foreach}
                    </div>
                {else}
                    <div class="alert alert-light border text-secondary mb-0">There are no posts in this category yet.</div>
                {/if}
            </section>
        {/foreach}
    {else}
        <div class="alert alert-info">There are no categories yet.</div>
    {/if}
{/block}
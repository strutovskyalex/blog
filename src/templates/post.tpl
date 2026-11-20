{extends file="layout.tpl"}

{block name="content"}
    <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-9">
            <article class="article-sheet shadow-sm p-4 p-md-5">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
                    <div class="article-categories d-flex flex-wrap gap-2">
                        <a href="#" class="badge rounded-pill text-bg-primary text-decoration-none bg-dark text">Post</a>
                        {foreach $categories as $category}
                            <a href="/category/{$category.id}" class="badge rounded-pill text-bg-primary text-decoration-none">
                                {$category.name}
                            </a>
                        {/foreach}
                    </div>

                    <div class="post-card__meta">
                        {if !empty($post.created_at)}
                            <span>{$post.created_at|date_format:"%d.%m.%Y"}</span>
                        {/if}
                        {if isset($post.viewed)}
                            <span class="ms-2">• {$post.viewed} viewed</span>
                        {/if}
                    </div>
                </div>

                <h1 class="h2 fw-bold mb-3">{$post.title}</h1>

                <div class="mb-4 text-center">
                    <img src="{$post.image}" alt="{$post.title}" class="article-cover">
                </div>

                {if !empty($post.description)}
                    <div class="article-body">
                        {$post.description|nl2br}
                    </div>
                {/if}

                {if !empty($suggestedPosts)}
                    <div class="container-fluid mt-4">
                        <div class="row row-cols-1 row-cols-md-3 g-4 mx-0">
                            {foreach $suggestedPosts as $suggestedPost}
                                <div class="col">
                                    <article class="card post-card h-100">
                                        <div class="card-body p-4">
                                            <div class="post-card__meta mb-2">
                                                <span>{$suggestedPost.created_at|date_format:"%d.%m.%Y"}</span>
                                                {if isset($suggestedPost.viewed)}
                                                    <span class="ms-2">• {$suggestedPost.viewed} viewed</span>
                                                {/if}
                                            </div>
                                            <h2 class="h5 card-title fw-bold">
                                                <a href="/post/{$suggestedPost.id}" class="text-decoration-none text-dark stretched-link">{$suggestedPost.title}</a>
                                            </h2>
                                            <p class="card-text text-secondary mt-2 mb-0">{$suggestedPost.short_description|strip_tags|truncate:170:"...":true}</p>
                                        </div>
                                    </article>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                {/if}
            </article>
        </div>
    </div>
{/block}
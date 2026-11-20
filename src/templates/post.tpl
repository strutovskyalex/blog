{extends file="layout.tpl"}

{block name="content"}
    <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-9">
            <article class="article-sheet shadow-sm p-4 p-md-5">
                <div class="post-card__meta mb-2">
                    <span>{$post.created_at|date_format:"%d.%m.%Y"}</span>
                    {if isset($post.views)}
                        <span class="ms-2">• {$post.views} переглядів</span>
                    {/if}
                </div>

                <h1 class="h2 fw-bold mb-4">{$post.title}</h1>

                <div class="article-body">
                    {$post.short_description|nl2br}
                </div>
            </article>
        </div>
    </div>
{/block}
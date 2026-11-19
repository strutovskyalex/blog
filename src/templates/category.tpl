{extends file="layout.tpl"}

{block name="content"}
    <section class="category-page" aria-labelledby="category-heading">
        <header class="category-page__header">
            <a class="back-link" href="/">&larr; All categories</a>
            <h1 id="category-heading" class="category-page__title">{$category.name}</h1>
            {if $category.description}
                <p class="category-page__description">{$category.description}</p>
            {/if}
        </header>

        {if $posts|@count > 0}
            <div class="posts-grid">
                {foreach $posts as $post}
                    {include file="categoryPosts.tpl" post=$post}
                {/foreach}
            </div>
        {else}
            <p class="empty-state">There are no posts in this category yet.</p>
        {/if}
    </section>
{/block}
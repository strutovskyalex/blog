{extends file="layout.tpl"}

{block name="content"}
    <div class="home-feed">
        {foreach $sections as $section}
            <section class="category-section" aria-labelledby="cat-title-{$section.category.id}">
                <header class="category-section__header">
                    <h2 id="cat-title-{$section.category.id}" class="category-section__title">
                        <a href="/category?id={$section.category.id}">{$section.category.name}</a>
                    </h2>

                    <a
                            class="btn btn--secondary"
                            href="/category?id={$section.category.id}"
                    >
                        Show all posts
                    </a>
                </header>

                <div class="posts-grid">
                    {foreach $section.posts as $post}
                        {include file="categoryPosts.tpl" post=$post}
                    {/foreach}
                </div>
            </section>
        {/foreach}
    </div>
{/block}
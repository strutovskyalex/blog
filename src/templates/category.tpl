{extends file="layout.tpl"}

{block name="content"}
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <span class="badge text-bg-primary rounded-pill mb-2 bg-dark text">Category</span>
            <h1 class="h2 fw-bold mb-2">{$category.name}</h1>
            <h4 class="h4 fw-bold mb-0">{$category.description}</h4>
        </div>
    </div>


    <div class="d-flex flex-wrap align-items-center gap-2 h2 fw-bold mb-4">
        <a href="/category/{$category.id}?sort=date&dir={$dateNextDir|default:'desc'}"
           class="btn btn-sm rounded-pill px-3 {if $currentSort|default:'date' === 'date'}btn-primary{else}btn-outline-secondary{/if}">
            Date {if $currentSort|default:'date' === 'date'}({$currentDir|default:'desc'|upper}){/if}
        </a>

        <a href="/category/{$category.id}?sort=views&dir={$viewsNextDir|default:'desc'}"
           class="btn btn-sm rounded-pill px-3 {if $currentSort|default:'' === 'views'}btn-primary{else}btn-outline-secondary{/if}">
            View {if $currentSort|default:'' === 'views'}({$currentDir|default:'desc'|upper}){/if}
        </a>

        {$toggleDir = ($currentDir|default:'desc' === 'desc') ? 'asc' : 'desc'}
        <a href="/category/{$category.id}?sort={$currentSort|default:'date'}&dir={$toggleDir}"
           class="btn btn-sm btn-outline-dark rounded-pill px-3"
           title="Змінити порядок сортування">
            Sorting: {$currentDir|default:'desc'|upper} → {$toggleDir|upper}
        </a>
    </div>

    {if !empty($posts)}
        <div class="row g-4 mb-4">
            {foreach $posts as $post}
                <div class="col-md-6">
                    <article class="card post-card h-100">
                        <div class="card-body p-4">
                            <div class="post-card__meta mb-2">
                                <span>{$post.created_at|date_format:"%d.%m.%Y %H:%M"}</span>
                                {if isset($post.viewed)}
                                    <span class="ms-2">• {$post.viewed} viewed</span>
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

        {if $totalPages > 1}
            <nav aria-label="Pagination" class="mt-5">
                <div class="d-flex flex-column align-items-center gap-3">
                    <ul class="pagination flex-wrap justify-content-center gap-1 mb-0">
                        <li class="page-item {if $currentPage <= 1}disabled{/if}">
                            <a class="page-link rounded-pill px-3"
                               href="/category/{$category.id}?sort={$currentSort}&dir={$currentDir}&page={$currentPage - 1}">
                                ← Previous
                            </a>
                        </li>

                        {foreach $pagesToShow as $item}
                            {if $item === 'dots'}
                                <li class="page-item disabled">
                                    <span class="page-link border-0 bg-transparent px-2">…</span>
                                </li>
                            {else}
                                <li class="page-item {if $item === $currentPage}active{/if}" {if $item === $currentPage}aria-current="page"{/if}>
                                    <a class="page-link rounded-pill"
                                       href="/category/{$category.id}?sort={$currentSort}&dir={$currentDir}&page={$item}">
                                        {$item}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}

                        <li class="page-item {if $currentPage >= $totalPages}disabled{/if}">
                            <a class="page-link rounded-pill px-3"
                               href="/category/{$category.id}?sort={$currentSort}&dir={$currentDir}&page={$currentPage + 1}">
                                Next →
                            </a>
                        </li>
                    </ul>

                    <form method="get"
                          action="/category/{$category.id}"
                          class="d-flex align-items-center gap-2 small text-secondary">
                        <input type="hidden" name="sort" value="{$currentSort}">
                        <input type="hidden" name="dir" value="{$currentDir}">
                        <label for="jumpToPage" class="mb-0">Page:</label>
                        <input type="number"
                               id="jumpToPage"
                               name="page"
                               min="1"
                               max="{$totalPages}"
                               value="{$currentPage}"
                               class="form-control form-control-sm text-center"
                               style="width: 76px;">
                        <span>з {$totalPages}</span>
                        <button type="submit" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                            Goto
                        </button>
                    </form>
                </div>
            </nav>
        {/if}
    {else}
        <div class="alert alert-light border text-secondary">There are no posts in this category yet.</div>
    {/if}
{/block}
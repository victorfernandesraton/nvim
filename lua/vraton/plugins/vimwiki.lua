return {
    "vimwiki/vimwiki",
    event = "BufEnter *.md",
    -- The keys that trigger the plugin
    keys = { "<leader>ww", "<leader>wt" },
    init = function()
        vim.g.vimwiki_list = {
            {
                -- Here will be the path for your wiki
                path = "~/Nextcloud/Notes/",
                -- The syntax for the wiki
                syntax = "markdown",
                ext = "md",
            },
        }
        vim.g.vimwiki_global_ext = 0
    end,
}

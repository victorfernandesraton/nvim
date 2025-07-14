return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({
            global_settings = {
                save_on_toggle = true,
                save_on_change = true,
                enter_on_sendcmd = false,
                tabline = true
            },
        })

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add file in harpoon" })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "show harpoon menu" })
        vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon telescope" })

        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
        vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Harpoon clear" })
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

    end
}

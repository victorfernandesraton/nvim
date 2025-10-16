return {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    -- Example key mappings for common actions:
    keys = {
        { "<leader>a/", "<cmd>Aider toggle<cr>",       desc = "Toggle Aider" },
        {
            "<leader>as",
            "<cmd>Aider send<cr>",
            desc = "Send to Aider",
            mode = { "n", "v" }
        },
        { "<leader>ac", "<cmd>Aider command<cr>",      desc = "Aider Commands" },
        { "<leader>ab", "<cmd>Aider buffer<cr>",       desc = "Send Buffer" },
        { "<leader>a+", "<cmd>Aider add<cr>",          desc = "Add File" },
        { "<leader>a-", "<cmd>Aider drop<cr>",         desc = "Drop File" },
        { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
        { "<leader>aR", "<cmd>Aider reset<cr>",        desc = "Reset session (clean history and drop all files)" },
    },
    dependencies = {
        "folke/snacks.nvim",
    },
    opts = {
        win = {
            position = "float", -- you can change this to "bottom", "top", or "left" if you like
            style = "nvim_aider",
            resize = true
        },
    },
}

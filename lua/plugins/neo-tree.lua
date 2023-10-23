return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>`",
            "<cmd>Neotree toggle<CR>",
            desc = "File explorer",
        },
    },
    opts = {
        close_if_last_window = true,
        window = {
            position = "float",
        }
    },
    -- init = function()
    --     if vim.fn.argc() == 0 then
    --         return
    --     end

    --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --     if stat and stat.type == "directory" then
    --         require("neo-tree")
    --     end
    -- end,
}

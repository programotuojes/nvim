return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
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
        {
            "<leader>1",
            "<cmd>Neotree reveal<CR>",
            desc = "File explorer (current file)",
        },
    },
    opts = {
        close_if_last_window = true,
        window = {
            position = "float",
        },
        filesystem = {
            hijack_netrw_behavior = "open_current",
        },
    },
}

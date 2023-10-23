return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = "light"
        -- vim.o.background = "dark"

        vim.o.termguicolors = true
        vim.g.everforest_background = "hard"
        vim.g.everforest_ui_contrast = "high"
        vim.g.everforest_better_performance = 1

        vim.cmd("colorscheme everforest")
    end,
}

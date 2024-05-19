vim.o.background = "dark";

return {
    {
        "morhetz/gruvbox",
        enabled = true,
        priority = 1001,
        lazy = false,
        config = function()
            vim.keymap.set("n", "coh", ":call gruvbox#hls_toggle()<CR>", { silent = true })
            vim.keymap.set("n", "*", ":let @/ = \"\"<CR>:call gruvbox#hls_show()<CR>*")
            vim.keymap.set("n", "/", ":let @/ = \"\"<CR>:call gruvbox#hls_show()<CR>/")
            vim.keymap.set("n", "?", ":let @/ = \"\"<CR>:call gruvbox#hls_show()<CR>?")

            vim.g.gruvbox_contrast_dark = "hard"
            vim.g.gruvbox_italic = 1
            vim.g.gruvbox_invert_selection = 0
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_background = "hard"
            vim.g.everforest_ui_contrast = "high"
            vim.g.everforest_better_performance = 1
            vim.cmd.colorscheme("everforest")
        end,
    },
}

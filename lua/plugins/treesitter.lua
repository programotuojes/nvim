return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "lua" },
            auto_install = true,
            highlight = { enable = true },
            indent = { 
                enable = true,
                disable = { "dart" },
            },
        })
    end,
}
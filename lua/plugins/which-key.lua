return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function (_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register({
            ["<leader>t"] = { name = "+telescope" },
            ["<leader>tf"] = { name = "+find" },
            ["<leader>tl"] = { name = "+lsp" },
            ["<leader>td"] = { name = "+diagnostics" },
            ["<leader>tg"] = { name = "+git" },
        })
    end,
}

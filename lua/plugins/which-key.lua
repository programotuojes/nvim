return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.add({
            { "<leader>t",  group = "telescope" },
            { "<leader>td", group = "diagnostics" },
            { "<leader>tf", group = "find" },
            { "<leader>tg", group = "git" },
            { "<leader>tl", group = "lsp" },
        })
    end,
}

local function create_opts()
    local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
    end

    local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
    end

    local opts = {
        hidden = true,
    }

    if is_git_repo() then
        table.insert(opts, get_git_root())
    end

    return opts
end

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>tr",
            function() require("telescope.builtin").resume() end,
            desc = "Resume previous Telescope search",
        },
        {
            "<leader>/",
            function() require("telescope.builtin").live_grep(create_opts()) end,
            desc = "Grep through files",
        },
        {
            "<leader>s",
            function() require("telescope.builtin").grep_string(create_opts()) end,
            desc = "Search word under cursor",
        },
        {
            "<leader>e",
            function() require("telescope.builtin").find_files(create_opts()) end,
            desc = "Find files",
        },
        {
            "<leader>r",
            function()
                require("telescope.builtin").lsp_references({
                    include_declaration = false,
                    show_line = false,
                })
            end,
            desc = "LSP references",
        },
        {
            "<leader>d",
            function()
                require("telescope.builtin").diagnostics({
                    bufnr = nil,
                })
            end,
            desc = "All diagnostics",
        },
        {
            "<leader>gs",
            function() require("telescope.builtin").git_status() end,
            desc = "Git status",
        },
        {
            "<leader>:",
            function() require("telescope.builtin").command_history() end,
            desc = "Command history",
        },
    },
}

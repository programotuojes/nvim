local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    return capabilities
end

local function on_attach(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then desc = "LSP: " .. desc end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<A-cr>", vim.lsp.buf.code_action, "Code action")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    -- nmap("<leader>wl", function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

return {
    {
        "j-hui/fidget.nvim", -- progress bar for LSPs
        tag = "legacy",
        opts = {},
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp"
            },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup {}

            ---@diagnostic disable: missing-fields
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete {},
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
            }
        end,
    },
    {
        "mfussenegger/nvim-dap",
        keys = {
            {
                "<C-b>",
                function() require('dap').toggle_breakpoint() end,
                desc = "Debugger: toggle breakpoint",
            },
            {
                "<F8>",
                function() require('dap').step_over() end,
                desc = "Debugger: step over",
            },
            {
                "<F9>",
                function() require('dap').continue() end,
                desc = "Debugger: continue",
            },
            {
                "<A-b>",
                function() require('dap').set_exception_breakpoints() end,
                desc = "Debugger: set exception breakpoints",
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            -- "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        init = function()
            require('dapui').setup()
        end,
        keys = {
            {
                "<S-F9>",
                -- "<F21>",
                function() require('dapui').toggle() end,
                desc = "Toggle debugger UI",
            },
        }
    },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "stevearc/dressing.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        ft = "dart",
        keys = {
            {
                "<S-F10>",
                -- "<F22>",
                "<cmd>FlutterRun<cr>",
                desc = "Flutter: run",
            },
            { "<leader>0", "<cmd>FlutterVisualDebug<cr>", desc = "Flutter: show guidelines", },
        },
        config = function()
            local flutter_sdk = os.getenv("FLUTTER_SDK")
            require("flutter-tools").setup {
                flutter_path = flutter_sdk .. "/bin/flutter",
                widget_guides = {
                    enabled = true,
                },
                dev_log = {
                    enabled = false,
                },
                debugger = {
                    enabled = true,
                    run_via_dap = true,
                },
                lsp = {
                    capabilities = get_capabilities(),
                    on_attach = on_attach,
                    settings = {
                        analysisExcludedFolders = {
                            "/home/gustas/.pub-cache",
                            flutter_sdk,
                        },
                        lineLength = 120,
                        completeFunctionCalls = true,
                        renameFilesWithClasses = "prompt",
                        updateImportsOnRename = true,
                        debugSdkLibraries = false,
                        debugExternalLibraries = false,
                    },
                },
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            {
                "folke/neodev.nvim",
                opts = {},
            },
        },
        config = function()
            local servers = {
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            }

            local capabilities = get_capabilities()
            require("lspconfig").nixd.setup({
                settings = {
                    nixd = {
                        formatting = {
                            command = { "nixpkgs-fmt" },
                        },
                        diagnostic = {
                            suppress = { "sema-escaping-with", "escaping-this-with", "var-bind-to-this", },
                        },
                    },
                },
            })
            require("mason").setup()
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
                ["omnisharp"] = function()
                    require("lspconfig").omnisharp.setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
                        enable_import_completion = true,
                        enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                        analyze_open_documents_only = true,
                    }
                end,
            }
        end,
    }
}

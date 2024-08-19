vim.o.termguicolors = true

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Indents
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Scroll
vim.o.scrolloff = 8

-- Save undo history to disk
vim.o.undofile = true

-- Disable netrw
--vim.g.loaded_netrw = 0
--vim.g.loaded_netrwPlugin = 0

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = {
    space = "⋅",
    tab = "» ",
    eol = "↴",
}

-- Wrapping
vim.o.breakindent = true

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Highlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Spelling
vim.o.spelllang = 'en_us,lt'
vim.o.spell = true
vim.o.spelloptions = 'camel'
vim.o.spellcapcheck = ''


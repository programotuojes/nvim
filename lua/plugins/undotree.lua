vim.g.undotree_WindowLayout = 4

return {
    "mbbill/undotree",
    keys = {
        { "<leader><F5>", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
    },
}

return {
    "rcarriga/nvim-notify",
    opts = {
        timeout = 6000,
        fps = 144,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        render = "wrapped-compact",
        stages = "slide",
        top_down = false,
    },
    init = function()
        vim.notify = require("notify")
    end,
}

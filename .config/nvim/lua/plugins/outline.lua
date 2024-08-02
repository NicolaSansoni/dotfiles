return {
    {
        "hedyhli/outline.nvim",
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            {
                "<leader>so",
                function()
                    local outline = require("outline")

                    if outline.is_open() then
                        outline.refresh()
                    else
                        outline.open()
                    end
                end,
                desc = "Show Outline",
            },
        },
        opts = {
            outline_window = {
                -- split_command = "rightbelow 36 vsplit",
                position = "right",
                width = 36,
                split_command = nil,
                relative_width = false,
                auto_close = false,
                auto_jump = false,
                focus_on_open = false,
            },
            outline_items = {
                auto_update_events = {
                    follow = {},
                    items = {},
                },
            },
        },
    },
}

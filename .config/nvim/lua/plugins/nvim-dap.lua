-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua
---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.input({
            prompt = "Run with args: ",
            default = table.concat(args, " "),
            completions = "file",
        })
        return vim.split(vim.fn.expand(new_args), " ")
    end
    return config
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },

        -- TODO: modify keys
        -- stylua: ignore
        keys = {
            { "<F5>", function() require("dap").continue() end, desc = "Dap: Continue" },
            { "<F10>", function() require("dap").step_over() end, desc = "Dap: Step Over" },
            { "<F11>", function() require("dap").step_into() end, desc = "Dap: Step Into" },
            { "<leader><F11>", function() require("dap").step_out() end, desc = "Dap: Step Out" },

            { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Dap: Run with Args" },
            { "<leader>dc", function() require("dap").set_breakpoint(vim.fn.input('Dap: Condition: ')) end, desc = "Dap: Conditional Breakpoint" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Dap: Breakpoint" },
            { "<leader>dk", function() require("dap").terminate() end, desc = "Dap: Kill" },

            -- { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            -- { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
            -- { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            -- { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            -- { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            -- { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
            -- { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            -- { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },

        config = function()
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        -- TODO: keys
        -- stylua: ignore
        keys = {
            -- { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
            -- { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" }, },
        },
        opts = {},
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {},
        },
    },
}

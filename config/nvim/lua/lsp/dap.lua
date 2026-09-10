local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")
local dap_python = require("dap-python")
local peristent = require("persistent-breakpoints")
local dap_breakpoint = require("dap-breakpoints")


-- Dap Virtual Text
dap_virtual_text.setup()

dap_python.setup("python")

mason_dap.setup({
    --    ensure_installed = { "cppdbg", "python" },
    automatic_installation = true,
    handlers = {
        function(config)
            require("mason-nvim-dap").default_setup(config)
        end,
    },
})

dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}

local pythonPath = function()
    if true then
        return "/home/luan/.local/share/virtualenvs/shareforce-jMzm7b4u/bin/python"
    end



    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
    else
        return "python"
    end
end

-- Configurations
dap.configurations = {
    c = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = false,
            MIMode = "lldb",
        },
        {
            name = "Attach to lldbserver :1234",
            type = "cppdbg",
            request = "launch",
            MIMode = "lldb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/bin/lldb",
            cwd = "${workspaceFolder}",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
        },
    },
    python = {
        {
            type = 'python',
            request = 'launch',
            name = "Launch file",
            program = "${file}",
            pythonPath = pythonPath()
        },
        {
            type = 'python',
            request = 'launch',
            name = 'DAP Django Server',
            program = vim.loop.cwd() .. '/manage.py',
            args = { 'runserver', '--noreload' },
            justMyCode = true,
            django = true,
            console = "integratedTerminal",
        },
        {
            type = 'python',
            request = 'launch',
            name = 'DAP Django Celery',
            program = vim.loop.cwd() .. '/manage.py',
            args = { 'celery', '--noreload' },
            justMyCode = true,
            django = true,
            console = "integratedTerminal",
        },
        {
            type = 'python',
            request = 'attach',
            name = 'Attach remote',
            connect = function()
                return {
                    host = '127.0.0.1',
                    port = 5678
                }
            end,
        },
        {
            type = 'python',
            request = 'launch',
            name = 'Launch file with arguments',
            program = '${file}',
            args = function()
                local args_string = vim.fn.input('Arguments: ')
                return vim.split(args_string, " +")
            end,
            console = "integratedTerminal",
            pythonPath = pythonPath()
        },
    },
}

-- Dap UI
peristent.setup()
dap_breakpoint.setup()

ui.setup()

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', {
    text = '🐞',
    texthl = 'DapBreakpoint',
    linehl = 'DapBreakpoint',
    numhl =
    'DapBreakpoint'
})
vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

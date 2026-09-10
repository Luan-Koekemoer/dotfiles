--[[ kitty.lua ]]
--
-- Kitty's cursor_trail animation fires on nvim's cursor jumps, so switch it off
-- for the duration of the session. Needs `allow_remote_control yes` in kitty.conf.

if vim.env.KITTY_PID == nil or vim.fn.exepath("kitten") == "" then
	return
end

local function load_config(args)
	local cmd = { "kitten", "@", "load-config", "--no-response" }
	vim.list_extend(cmd, args)
	return vim.system(cmd, { text = true })
end

local group = vim.api.nvim_create_augroup("KittyCursorTrail", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	group = group,
	callback = function()
		load_config({ "-o", "cursor_trail=0" })
	end,
})

vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
	group = group,
	callback = function()
		-- Dropping the override restores kitty.conf's value, so the trail setting
		-- lives in one place. wait() because nvim will not outlive an async call.
		load_config({ "--ignore-overrides" }):wait(2000)
	end,
})

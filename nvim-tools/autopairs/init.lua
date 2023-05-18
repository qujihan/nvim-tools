local M = {}

M.opts = {
	trigger_chars = {
		"()",
		"[]",
		"{}",
	}
}

function M.setup(opts)
	if opts then
		M.opts = vim.tbl_extend("force", M.opts, opts)
	end
	vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.autopair()', { expr = true, noremap = true })
end


local function is_trigger_char(char)
	for _, value in ipairs(M.opts.trigger_chars) do
		if value.sub(1,1) == char then
			return true
		end
	end
	return false
end

local function is_closing_bracket(char)
	for _, value in ipairs(M.opts.trigger_chars) do
		if value.sub(2,2) == char then
			return true
		end
	end
	return false
end

local function should_skip_autopairing()
  local current_line = vim.api.nvim_get_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local next_char = current_line:sub(cursor_pos[2], cursor_pos[2])
  if is_closing_bracket(next_char) then
    return true
  end
  return false
end

local function autopair()
  local char = vim.api.nvim_get_mode().char
  if is_trigger_char(char) and not should_skip_autopairing() then
    vim.cmd('norm i' .. char .. '<Esc>a' .. string.char(string.byte(char) + 1))
  end
end


return M

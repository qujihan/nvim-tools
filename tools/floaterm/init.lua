local M = {}

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  Default opts                                                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
M.opts = {
	filetype = "Floaterm",
	cmd = function()
		return assert(
			os.getenv("SHELL"),
			"[FTerm] $SHELL is not present! Please provide a shell (`config.cmd`) to use."
		)
	end,
	border = "single",
	auto_close = true,
	hl = "Normal",
	blend = 0,
	clear_env = false,
	dimensions = {
		height = 0.8,
		width = 0.8,
		x = 0.5,
		y = 0.5,
	},
}




-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  Utils                                                                       │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
function M.get_dimension(opts)
	-- get lines and columns
	local cl = vim.o.columns
	local ln = vim.o.lines

	-- calculate our floating window size
	local width = math.ceil(cl * opts.width)
	local height = math.ceil(ln * opts.height - 4)

	-- and its starting position
	local col = math.ceil((cl - width) * opts.x)
	local row = math.ceil((ln - height) * opts.y - 1)

	return {
		width = width,
		height = height,
		col = col,
		row = row,
	}
end

function M.is_win_valid(win)
	return win and vim.api.nvim_win_is_valid(win)
end

function M.is_buf_valid(buf)
	return buf and vim.api.nvim_buf_is_loaded(buf)
end

function M.is_cmd(cmd)
	return type(cmd) == "function" and cmd() or cmd
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  Floaterm                                                                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local term = {}

function term:new()
	return setmetatable({
		win = nil,
		buf = nil,
		term = nil,
		opts = M.opts,
	}, {
		__index = self,
	})
end


function term:setup()
end

function term:store()
end

function term:remember_cursor()
end

function term:restore_cursor()
end

function term:create_buf()
end

function term:create_win()
end

function term:handle_exit()
end

function term:prompt()
end

function term:open_term()
end

function term:open()
end

function term:close()
end

function term:toggle()
end

function term:run()
end


-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │  Setup                                                                       │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local t = term:new()

function M.setup(user_opts)
	if user_opts then
		M.opts = vim.tbl_extend("force", M.opts, user_opts)
	end
end

return M

local M = {}

M.opts = {}
function M.setup(user_opts)
	if user_opts then
		M.opts = vim.tbl_extend("force", M.opts, user_opts)
	end
end

return M

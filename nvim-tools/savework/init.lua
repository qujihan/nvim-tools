local M = {}

M.opts = {
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/savework/"),
  options = { "buffers", "curdir", "tabpages", "winsize" },
}

function M.setup(user_opts)
	if user_opts then
		M.opts = vim.tbl_extend("force", M.opts, user_opts)
	end
	vim.fn.mkdir(M.opts.dir,"p")
	M.start()
end

function M.save()
  local tmp = vim.o.sessionoptions
  vim.o.sessionoptions = table.concat(Config.options.options, ",")
  vim.cmd("mks!" .. vim.fn.fnameescape())
  vim.cmd("mks! " .. e(M.get_current()))
  vim.o.sessionoptions = tmp
end

function M.start()
	vim.api.nvim_create_autocmd(
		"VimLeavePre",
		{
			"savework",
			{clear = true},
			callback = function
				M.save()
			end
		}
	)
end

function M.stop()
	pcall(vim.api.nvim_del_augroup_by_name, "savework")
end

function M.load()
end

return M

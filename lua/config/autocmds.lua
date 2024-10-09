-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" }, -- 同时匹配 C 和 C++ 文件
	callback = function()
		-- 根据文件类型选择编译器和标准
		local filetype = vim.bo.filetype
		local compiler, file_extension

		if filetype == "cpp" then
			compiler = "g++"
			file_extension = ".cpp"
		else
			compiler = "gcc"
			file_extension = ".c"
		end

		-- F7 编译并执行
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F7>",
			string.format(
				"<ESC>:w<CR>:split<CR>:te %s -Wshadow -Wall -o %%:t:r.exe %%:t:r%s && %%:t:r.exe<CR>i",
				compiler,
				file_extension
			),
			{ silent = true, noremap = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F5>",
			"<ESC>:w<CR>:split<CR>:te g++ -std=c++20 -Wshadow -Wall -o %:t:r.out % -g  && %:t:r.out<CR>i",
			{ silent = true, noremap = true }
		)
	end,
})

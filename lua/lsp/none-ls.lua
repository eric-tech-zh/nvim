local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("没有找到 null-ls")
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		-- Formatting ---------------------
		formatting.shfmt,
		-- StyLua
		formatting.stylua,
		-- go fmt
		formatting.goimports,
		-- frontend
		formatting.prettier.with({
			filetypes = {
				-- TODO: "javascript",
				-- TODO: "javascriptreact",
				-- TODO: "typescript",
				-- TODO: "typescriptreact",
				-- TODO: "vue",
				-- TODO: "css",
				-- TODO: "scss",
				-- TODO: "less",
				-- TODO: "html",
				-- TODO: "json",
				-- TODO: "yaml",
				-- TODO: "graphql",
				-- TODO: "astro",
				"markdown",
                "c",
                "cpp",
                "cc",
                "h",
			},
			extra_filetypes = { "njk" },
			prefer_local = "node_modules/.bin",
		}),
	},
	-- 保存自动格式化
	-- on_attach = function(client)
	-- 	-- if client.server_capabilities.documentFormattingProvider then
	-- 	--	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format{ async = true}")
	-- 	-- end
	-- end,
})

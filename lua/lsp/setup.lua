require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = { "lua_ls", "clangd", "rust_analyzer" },
})

function LspKeybind(client, bufnr)
	-- 禁用格式化功能，交给专门插件插件处理
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- 绑定快捷键
	require("keybindings").mapLSP(buf_set_keymap)
end

-- TODO: function GoLspKeybind(client, bufnr)
-- TODO: 	client.server_capabilities.semanticTokensProvider = {
-- TODO: 		full = {
-- TODO: 			delta = false,
-- TODO: 		},
-- TODO: 		legend = {
-- TODO: 			-- from https://github.com/golang/tools/blob/master/gopls/internal/lsp/semantic.go#L981
-- TODO: 			tokenTypes = {
-- TODO: 				"namespace",
-- TODO: 				"type",
-- TODO: 				"class",
-- TODO: 				"enum",
-- TODO: 				"interface",
-- TODO: 				"struct",
-- TODO: 				"typeParameter",
-- TODO: 				"parameter",
-- TODO: 				"variable",
-- TODO: 				"property",
-- TODO: 				"enumMember",
-- TODO: 				"event",
-- TODO: 				"function",
-- TODO: 				"method",
-- TODO: 				"macro",
-- TODO: 				"keyword",
-- TODO: 				"modifier",
-- TODO: 				"comment",
-- TODO: 				"string",
-- TODO: 				"number",
-- TODO: 				"regexp",
-- TODO: 				"operator",
-- TODO: 			},
-- TODO: 			tokenModifiers = {
-- TODO: 				"declaration",
-- TODO: 				"definition",
-- TODO: 				"readonly",
-- TODO: 				"static",
-- TODO: 				"deprecated",
-- TODO: 				"abstract",
-- TODO: 				"async",
-- TODO: 				"modification",
-- TODO: 				"documentation",
-- TODO: 				"defaultLibrary",
-- TODO: 			},
-- TODO: 		},
-- TODO: 		range = true,
-- TODO: 	}
-- TODO: 	-- 禁用格式化功能，交给专门插件插件处理
-- TODO: 	client.server_capabilities.documentFormattingProvider = false
-- TODO: 	client.server_capabilities.documentRangeFormattingProvider = false
-- TODO: 	local function buf_set_keymap(...)
-- TODO: 		vim.api.nvim_buf_set_keymap(bufnr, ...)
-- TODO: 	end
-- TODO: 	-- 绑定快捷键
-- TODO: 	require("keybindings").mapLSP(buf_set_keymap)
-- TODO: end
local nvim_lsp = require("lspconfig")
-- lua
-- mason.lua
nvim_lsp.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					hint = {
						enable = true,
					},
				},
			})
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
	on_attach = LspKeybind,
})

-- rust_analyzer

nvim_lsp.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
	on_attach = LspKeybind,
})

-- go
local util = require("lspconfig/util")

-- TODO: nvim_lsp.gopls.setup({
-- TODO: 	cmd = { "gopls", "serve" },
-- TODO: 	filetypes = { "go", "gomod" },
-- TODO: 	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
-- TODO: 	settings = {
-- TODO: 		gopls = {
-- TODO: 			analyses = {
-- TODO: 				unusedparams = true,
-- TODO: 			},
-- TODO: 			staticcheck = true,
-- TODO: 		},
-- TODO: 		semanticTokens = true,
-- TODO: 	},
-- TODO: 	on_attach = GoLspKeybind,
-- TODO: })

-- astro
-- TODO: nvim_lsp.astro.setup({
-- TODO: 	on_attach = LspKeybind,
-- TODO: })

-- TODO: nvim_lsp.tsserver.setup({
-- TODO: 	on_attach = LspKeybind,
-- TODO: 	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
-- TODO: })

-- tailwindcss
-- TODO: nvim_lsp.tailwindcss.setup({})

nvim_lsp.pyright.setup({
	on_attach = LspKeybind,
})

nvim_lsp.marksman.setup({
	on_attach = LspKeybind,
})

nvim_lsp.rust_analyzer.setup({
    settings = {
        ['rust_analyzer'] = {
            diagnostics = {
                enable = false;
            }
        }
    },
	on_attach = LspKeybind,
})

nvim_lsp.clangd.setup({
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/clang,/usr/bin/clang++",
    },
    filetypes = { "c", "cpp", "cc", "h" };
    root_dir = util.root_pattern(
          '.ROOT_TAG'
        ),
    single_file_support = true,
	on_attach = LspKeybind,
})



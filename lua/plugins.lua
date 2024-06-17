local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- UI --
    -- - theme
    "navarasu/onedark.nvim",
    "folke/tokyonight.nvim",
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    "rcarriga/nvim-notify",
    "nvim-lua/lsp-status.nvim",
    "petertriho/nvim-scrollbar",
    -- file tree
    { "nvim-tree/nvim-web-devicons" },
    { "kyazdani42/nvim-tree.lua", event = "VimEnter" },
    { "akinsho/bufferline.nvim", dependencies = { "moll/vim-bbye" } },
    { "nvim-lualine/lualine.nvim" },
    { "arkav/lualine-lsp-progress" },
    -- flash
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "<leader>s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "<leader>S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            -- TODO1: {
            -- TODO1:   "r",
            -- TODO1:   mode = "o",
            -- TODO1:   function()
            -- TODO1:       require("flash").remote()
            -- TODO1:   end,
            -- TODO1:   desc = "Remote Flash",
            -- TODO1: },
            -- TODO1: {
            -- TODO1:   "R",
            -- TODO1:   mode = { "o", "x" },
            -- TODO1:   function()
            -- TODO1:       require("flash").treesitter_search()
            -- TODO1:   end,
            -- TODO1:   desc = "Treesitter Search",
            -- TODO1: },
            -- TODO1: {
            -- TODO1:   "<c-s>",
            -- TODO1:   mode = { "c" },
            -- TODO1:   function()
            -- TODO1:       require("flash").toggle()
            -- TODO1:   end,
            -- TODO1:   desc = "Toggle Flash Search",
            -- TODO1: },
        },
    },
    -- telescope
    { "nvim-telescope/telescope.nvim" },
    "LinArcX/telescope-env.nvim",
    -- 自动补全
    { "windwp/nvim-autopairs" },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    -- dashboard
    { "nvimdev/dashboard-nvim", event = "VimEnter", dependencies = { { "nvim-tree/nvim-web-devicons" } } },
    "ahmedkhalf/project.nvim",

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    { "nvimdev/lspsaga.nvim", event = "BufEnter" },
    -- terminal
    "voldikss/vim-floaterm",
    -- format
    { "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
    -- 补全
    "hrsh7th/nvim-cmp",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "mortepau/codicons.nvim",

    "HiPhish/rainbow-delimiters.nvim",
    -- 常见片段
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim",
    -- git
    "lewis6991/gitsigns.nvim",
    -- dap
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    -- go dap
    -- TODO: {
    -- TODO:    "ray-x/go.nvim",
    -- TODO:    dependencies = { -- optional packages
    -- TODO:        "ray-x/guihua.lua",
    -- TODO:    },
    -- TODO:    event = { "CmdlineEnter" },
    -- TODO:    ft = { "go", "gomod" },
    -- TODO: },
    -- auto save
    "Pocco81/auto-save.nvim",
    -- leetcode
    -- TODO: { "kawre/leetcode.nvim", dependencies = {
    -- TODO:    "MunifTanjim/nui.nvim",
    -- TODO: } },
    -- markdown
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    -- codeium
    {
        "Exafunction/codeium.nvim",
    },
    {
        "numToStr/Comment.nvim",
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            -- Example mapping to toggle outline
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                { desc = "Toggle Outline" })

            require("outline").setup {
                -- Your setup opts here (leave empty to use defaults)
            }
        end,
    },
})

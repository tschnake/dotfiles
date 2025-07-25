-- Set leader key
vim.g.mapleader = " "  -- space as leader

-- Basic settings
vim.o.number = true             -- line numbers
vim.o.relativenumber = true     -- relative line numbers
vim.o.mouse = "a"               -- enable mouse
vim.o.clipboard = "unnamedplus" -- use system clipboard
vim.o.expandtab = true          -- use spaces instead of tabs
vim.o.shiftwidth = 4            -- 4 spaces for autoindent
vim.o.tabstop = 4               -- 4 spaces per tab
vim.o.termguicolors = true      -- enable true color

if vim.g.vscode then
  -- VS Code Neovim: hide the statusline completely
  vim.o.laststatus = 2
else
  -- Standalone Neovim: show statusline per window
  vim.o.laststatus = 2
end

-- Key mapping example
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<Esc><Esc>", ":w<CR>", { noremap = true, silent = true, desc = "Save file on double Esc" })
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle line comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment block" })

-- Install plugin manager if not installed (lazy.nvim)
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

-- Load plugins using lazy.nvim
    require("lazy").setup({
      -- { "nvim-lualine/lualine.nvim",
      -- config = function()
      --   require("lualine").setup({
      --     options = {
      --       theme = "catppuccin",  -- match your color scheme
      --       icons_enabled = true,
      --       section_separators = { left = "", right = "" }, -- Nerd Font symbols
      --       component_separators = { left = "│", right = "│" }, -- vertical bars
      --     },
      --   })
      -- end, },         -- status line
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },  -- better syntax
      { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- fuzzy finder
      { "neovim/nvim-lspconfig" },             -- LSP support
      {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
          'nvim-tree/nvim-web-devicons', -- für Icons (Nerd Font)
        },
        config = function()
          require("nvim-tree").setup({})

          -- Keymap HIER rein
          vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        end
      },
      {
        "lervag/vimtex",
        ft = { "tex" },  -- loads only for .tex files
        config = function()
        vim.g.vimtex_view_method = "skim" -- for macOS; other options: zathura, sumatrapdf
        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_skim_activate = 1
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_syntax_conceal_disable = 1  -- disable hiding things like \alpha
        -- vim.g.vimtex_syntax_custom_cmds = 1      -- better user-defined command parsing
        -- vim.g.vimtex_syntax_custom_envs = 1      -- includes environments like align, equation
        vim.g.vimtex_compiler_latexmk = {
          out_dir = "build",
          build_dir = "build",
          continuous = 1,
          callback = 1,
          build_dir = "",
          options = {
            "-shell-escape",
            "-verbose",
            "-file-line-error",
            "-synctex=1",
            "-interaction=nonstopmode"
          },
        }
        end
      },
      -- Lazy-Pluginliste:
      {
        "folke/tokyonight.nvim",
        lazy = true,
        --priority = 1000,
        --config = function()
        --  vim.cmd("colorscheme tokyonight")
        --end,
      },
      {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,  -- load immediately
        config = function()
          vim.cmd("colorscheme catppuccin-mocha")
        end,
      },
      {
        "morhetz/gruvbox",
        lazy = true, -- geladen, aber nicht aktiv
      },
      {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
        config = function()
          vim.g.mkdp_auto_start = 1  -- optional: auto open preview
          vim.g.mkdp_auto_close = 1  -- close preview when leaving buffer
        end,
      },
      {
       "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-nvim-lua",
          "saadparwaiz1/cmp_luasnip",
          "L3MON4D3/LuaSnip",
          "rafamadriz/friendly-snippets",
        },
        config = function()
          local cmp = require("cmp")
          local luasnip = require("luasnip")

          require("luasnip.loaders.from_vscode").lazy_load()

          cmp.setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
                  ["<Tab>"] = cmp.mapping.select_next_item(),
                  ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                  ["<CR>"] = cmp.mapping.confirm({ select = true }),
                  ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                  { name = "buffer" },
                  { name = "path" },
                }),
              })
            end,
          },
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
      lazy = false,
    }})


    require("nvim-treesitter.configs").setup({
    ensure_installed = { "python", "lua", "javascript", "html", "css", "markdown", "bash", "vim", "json" },
      highlight = {
        enable = true,              -- enable highlighting
        disable= { "latex", "tex"},
        additional_vim_regex_highlighting = { "latex", "tex" }, -- <- das aktiviert vimtex-Syntax
      },
    })
    


if not vim.g.vscode then
 -- require("lazy").setup({
 --      { "nvim-lualine/lualine.nvim",
 --      config = function()
 --        require("lualine").setup({
 --          options = {
 --            theme = "catppuccin",  -- match your color scheme
 --            icons_enabled = true,
 --            section_separators = { left = "", right = "" }, -- Nerd Font symbols
 --            component_separators = { left = "│", right = "│" }, -- vertical bars
 --          },
 --        })
 --      end, },         -- status line
 --  })
 --    
 --        -- Example plugin config
 --        require("lualine").setup()
  end



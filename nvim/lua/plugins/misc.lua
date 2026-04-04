return {
  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_italic = false
      require("nord").set()
    end,
    lazy = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Neotree" },
    keys = { "<leader>n" },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = function()
      vim.keymap.set("n", "<leader>n", ':Neotree filesystem reveal left<CR>', {})
      require("neo-tree").setup({
        window = {
          mappings = {
            ["."] = "toggle_hidden",
            ["|"] = "open_vsplit",
            ["_"] = "open_split",
          },
        },
      })
    end,
    lazy=false,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "Telescope",
    keys = { "<leader>f" },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")

      local trouble = require("trouble.sources.telescope")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      --vim.keymap.set("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args(), {})
      --vim.keymap.set("n", "<leader>fg", builtin.grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' } , {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

      telescope.load_extension("live_grep_args")
      telescope.setup({
        defaults = {
          layout_strategy = "flex",
          mappings = {
            i = { ["<c-t>"] = trouble.open },
            n = { ["<c-t>"] = trouble.open },
          },
          --vimgrep_arguments = {
          --  "git", "grep", "--full-name", "--line-number", "--column", "--no-color"
          --},
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                -- freeze the current list and start a fuzzy search in the frozen list
              },
            },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
          }
        }
      })
    end,
  },
  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "f", "t", "t" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  {
    "kylechui/nvim-surround",
    config = true,
    event = "VeryLazy",
  },
  {
    "folke/trouble.nvim",
    config = true,
    cmd = "Trouble",
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
    event = "VeryLazy",
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    event = "BufRead",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = true,
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    keys = { "<Leader>mp" },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>")
    end,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    config = function()
      require("neogen").setup({
        enable = true,
        languages = {
          python = { template = { annotation_convention = "google_docstrings" } } },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({})
    end,
  },
  {
    "stevearc/oil.nvim",
    event = "syntax",
    config = function()
      require("oil").setup({
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    config = function()end,
  },
  --{
  --  name = "vim-edgemotion",
  --  dir = "@vim_edgemotion@",
  --  keys = { "<leader>j", "<leader>k" },
  --  config = function()
  --    vim.keymap.set("n", "<leader>j", "<Plug>(edgemotion-j)")
  --    vim.keymap.set("n", "<leader>k", "<Plug>(edgemotion-k)")
  --  end,
  --},
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup({
        vim.keymap.set("n", "<leader><leader>j", "<cmd>HopLine<CR>");
        vim.keymap.set("v", "<leader><leader>j", "<cmd>HopLine<CR>");
        vim.keymap.set("n", "<leader><leader>k", "<cmd>HopLine<CR>");
        vim.keymap.set("v", "<leader><leader>k", "<cmd>HopLine<CR>");
      })
    end,
    event = "VeryLazy",
  },
  --{
  --  name = "vim-easymotion",
  --  dir = "@vim_easymotion@",

  --  config = function()
  --    vim.g.EasyMotion_use_migemo = 1
  --    vim.keymap.set("n", "<leader><leader>j", "<Plug>(easymotion-overwin-f)")
  --    vim.keymap.set("n", "<leader><leader>j", "<Plug>(easymotion-overwin-line)")
  --    vim.keymap.set("n", "<leader><leader>k", "<Plug>(easymotion-overwin-line)")
  --  end,
  --},
  --{
  --  name = "vim-wakatime",
  --  dir = "@vim_wakatime@",
  --  event = "VeryLazy",
  --},
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_compiler_method = 'latexmk'

    end
  },
  --[[
  {
    "@marp_nvim@",
    ft = "markdown",
    keys = {
      { "<leader>ms", "<cmd>MarpToggle<cr>", desc = "Toggle Marp server" },
      { "<leader>mw", "<cmd>MarpWatch<cr>", desc = "Start Marp watch mode" },
      { "<leader>me", "<cmd>MarpExport<cr>", desc = "Export Marp presentation" },
    },
    config = function()
      require("marp").setup({
        marp_command = vim.fn.exepath("marp"),
        browser = nil, -- auto-detect
        server_mode = false, -- use watch mode by default
      })
    end,
  },
  {
    "@im_select_nvim@",
    event = "InsertEnter",
    config = function()
      require("im_select").setup({
        default_command     = "fcitx5-remote",
        default_im_select   = "keyboard-us",
        set_default_events = { "InsertLeave", "CmdlineLeave" },
        set_previous_events = {},
      })
    end,
  },
  --]]
}

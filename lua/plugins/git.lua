return {
  {
    name = "toggleterm.nvim",
		dir = "akinsho/toggleterm.nvim",
    lazy = false,  -- 起動時にロード
    config = function()
      require("toggleterm").setup({
        direction = "float",
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
      })

      -- グローバル関数として定義
      _G._lazygit_toggle = function()
        lazygit:toggle()
      end

      -- キーマッピングを設定
      vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

      -- 追加のtoggletermキーマッピング
      vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<C-\\><C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
    end,
  },
	{
		name = "diffview.nvim",
		dir = "sindrets/diffview.nvim" ,
		dependencies = { { name = "plenary.nvim", dir = "@plenary_nvim@" } },
		config = true,
		event = "VeryLazy",
	},
	{
		name = "gitlinker.nvim",
		dir = 'ruifm/gitlinker.nvim'``,
		config = true,
		event = "VeryLazy",
	},
	{
		name = "gitsigns.nvim",
		dir = "lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signcolumn = false,
				numhl = true,
				current_line_blame = true,
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
		event = "BufRead",
	},
	{
		name = "octo.nvim",
		dir = "pwntester/octo.nvim",
		dependencies = {
			{ name = "plenary.nvim", dir = "@plenary_nvim@" },
			{ name = "telescope.nvim", dir = "@telescope_nvim@" },
			{ name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
		},
		cmd = { "Octo" },
		config = function()
			require("octo").setup({
				ssh_aliases = { ["github.com-emu"] = "github.com" },
			})
		end,
	},
}

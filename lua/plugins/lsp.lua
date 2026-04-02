return {
  {
    name = "nvim-lspconfig",
    dir = "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- エラーハンドリング付きでモジュールを読み込む
      local lspconfig_ok = pcall(require, "lspconfig")
      if not lspconfig_ok then
        vim.notify("Failed to load lspconfig", vim.log.levels.ERROR)
        return
      end

      local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not cmp_nvim_lsp_ok then
        vim.notify("Failed to load cmp_nvim_lsp", vim.log.levels.WARN)
      end

      -- 共通のcapabilities設定
      vim.lsp.config("*", {
        capabilities = cmp_nvim_lsp_ok and cmp_nvim_lsp.default_capabilities() or {},
      })

      -- 診断関連のキーマップ
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist with diagnostics" })

      -- LSPアタッチ時のキーマップとオプション設定
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local opts = { buffer = ev.buf }
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
          end

          -- ナビゲーション
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gr", vim.lsp.buf.references, "Show references")
          map("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")

          -- 情報表示
          map("n", "K", vim.lsp.buf.hover, "Show hover information")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")

          -- ワークスペース操作
          map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
          map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
          map("n", "<space>ws", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace folders")

          -- コード編集
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format buffer")
        end,
      })

      local servers = {
        "bashls",
        "biome",
        "docker_compose_language_service",
        "gopls",
        "lua_ls",
        "nil_ls",
        "pyright",
        "ruff",
        "taplo",
        "terraformls",
        "tinymist",
        "ts_ls",
        "typos_lsp",
        "yamlls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    name = "none-ls.nvim",
    dir = "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls_ok, null_ls = pcall(require, "null-ls")
      if not null_ls_ok then
        vim.notify("Failed to load none-ls.nvim", vim.log.levels.ERROR)
        return
      end

      null_ls.setup({
        sources = {
          -- Diagnostics
          null_ls.builtins.diagnostics.hadolint,

          -- Formatting
          null_ls.builtins.formatting.nixfmt,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
        },
      })
    end,
  },
  {
    name = "lspsaga.nvim",
    dir = "nvimdev/lspsaga.nvim",
    event = "BufRead",
    config = function()
      local lspsaga_ok, lspsaga = pcall(require, "lspsaga")
      if not lspsaga_ok then
        vim.notify("Failed to load lspsaga.nvim", vim.log.levels.ERROR)
        return
      end

      lspsaga.setup({
        lightbulb = {
          sign = false,
        },
      })
    end,
  },
}

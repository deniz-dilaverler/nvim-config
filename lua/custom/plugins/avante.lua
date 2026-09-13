-- Avante needs to build its native component after installation/update.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name == "avante.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  {
    src = "https://github.com/avante-corp/avante.nvim",
    version = "main",
  },

  -- Required dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",

  -- Optional dependencies
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/HakonHarnes/img-clip.nvim",
  "https://github.com/folke/snacks.nvim",
})

require("render-markdown").setup({
  file_types = { "markdown", "Avante" },
})

require("avante").setup({
  provider = "codex",

  acp_providers = {
    codex = {
      command = "codex-acp",
      args = {},
      env = {
        NODE_NO_WARNINGS = "1",
        HOME = os.getenv("HOME"),
        PATH = os.getenv("PATH"),
      },
    },
  },

  behaviour = {
    auto_approve_tool_permissions = false,
  },

  input = {
    provider = "snacks",
  },
})
vim.opt.autoread = true

vim.api.nvim_create_autocmd({
  "FocusGained",
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
}, {
  command = "checktime",
})

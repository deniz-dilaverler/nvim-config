-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local plugins = {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

if vim.g.have_nerd_font then
  table.insert(plugins, 'https://github.com/nvim-tree/nvim-web-devicons') -- not strictly required, but recommended
end

vim.pack.add(plugins)

-- Changed mapping to <Space>e
vim.keymap.set('n', '<Space>e', '<Cmd>Neotree toggle<CR>', { desc = 'NeoTree toggle', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        -- Changed to <Space>e to close the window when focus is inside neo-tree
        ['<Space>e'] = 'close_window',
      },
    },
  },
}

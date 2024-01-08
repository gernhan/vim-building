return {
  "phaazon/hop.nvim",
  branch = "v2", -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('n', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('n', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('n', 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    vim.keymap.set('n', 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })
    vim.keymap.set('n', '<leader>j', vim.cmd.HopChar1, { desc = "HopChar1: go to any location with 1 characters" })
    vim.keymap.set('n', '<leader>J', vim.cmd.HopChar2, { desc = "HopChar2: go to any location with 2 characters" })
  end,
}

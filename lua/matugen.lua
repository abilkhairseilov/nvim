 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#181616',
    base01 = '#282727',
    base02 = '#323131',
    base03 = '#67635e',
    base04 = '#c8c093',
    base05 = '#c5c9c5',
    base06 = '#c5c9c5',
    base07 = '#c5c9c5',
    base08 = '#c4746e',
    base09 = '#c4746e',
    base0A = '#8ea4a2',
    base0B = '#8a9a7b',
    base0C = '#e99c96',
    base0D = '#bee996',
    base0E = '#96e9e1',
    base0F = '#64201b',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#c5c9c5',          bg = '#181616' })
  hi('TelescopeBorder',         { fg = '#67635e',             bg = '#181616' })
  hi('TelescopePromptNormal',   { fg = '#c5c9c5',          bg = '#181616' })
  hi('TelescopePromptBorder',   { fg = '#67635e',             bg = '#181616' })
  hi('TelescopePromptPrefix',   { fg = '#8a9a7b',             bg = '#181616' })
  hi('TelescopePromptCounter',  { fg = '#c8c093',  bg = '#181616' })
  hi('TelescopePromptTitle',    { fg = '#181616',             bg = '#8a9a7b' })
  hi('TelescopePreviewTitle',   { fg = '#181616',             bg = '#8ea4a2' })
  hi('TelescopeResultsTitle',   { fg = '#181616',             bg = '#c4746e' })
  hi('TelescopeSelection',      { fg = '#c5c9c5',          bg = '#323131' })
  hi('TelescopeSelectionCaret', { fg = '#8a9a7b',             bg = '#323131' })
  hi('TelescopeMatching',       { fg = '#8a9a7b',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M

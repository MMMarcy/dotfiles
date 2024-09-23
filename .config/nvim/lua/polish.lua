-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
vim.api.nvim_create_autocmd("FocusLost", {
  group = vim.api.nvim_create_augroup("FocusLostStuff", { clear = true }),
  callback = function(ev)
    vim.cmd.stopinsert()
    vim.cmd.wall { mods = { silent = true } }
  end,
})

-- TODO: remove this once the configuration file for neovide works.
if vim.g.neovide then vim.o.guifont = "Source Code Pro:h10" end

-- Set up custom filetypes

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  -- { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.yaml" },
  -- import/override with your plugins folder
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.workflow.hardtime-nvim" },
}

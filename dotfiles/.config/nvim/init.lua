---------------------------------------------------------------------------
--
--               ██╗███╗  ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
--               ██║████╗ ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
--               ██║██╔██╗██║██║   ██║   ██║   ██║██║██╔████╔██║
--               ██║██║╚████║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
--               ██║██║ ╚███║██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
--               ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
--
---------------------------------------------------------------------------

-- Core Settings
vim.opt.compatible = false
vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"
vim.opt.filetype.plugin = "indent"

-- UI Settings
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Indentation & Tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Scrolling & Wrapping
vim.opt.scrolloff = 10
vim.opt.wrap = false

-- Command Display
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true

-- History & Wildmenu
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest" }
vim.opt.wildignore = { "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf", "*.pyc", "*.exe", "*.flv", "*.img", "*.xlsx" }

-- Mouse & Swapfile
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backupcopy = "yes"
vim.opt.backup = false

-- Encoding
vim.opt.encoding = "utf-8"

-- Terminal Colors
-- vim.opt.t_co = 256

-- Load Plugins
-- require('plugins')
require("config.lazy")

-- Load Key Mappings
require("maps")

-- Colorschema
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[highlight Normal ctermbg=NONE guibg=NONE]])
vim.cmd([[highlight NonText ctermbg=NONE guibg=NONE]])

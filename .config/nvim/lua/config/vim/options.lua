local o = vim.opt

-- sane defaults
o.timeout = true
o.timeoutlen = 300
o.updatetime = 100
o.guicursor = ""
o.showmode = true
o.mouse = ""
o.number = true
o.relativenumber = true

o.completeopt = "menu,menuone,noselect,preview"
o.backspace = "indent,eol,nostop"
o.wildmode = "longest:full,full"

-- search
o.hlsearch = false
o.ignorecase = true
o.incsearch = true
o.smartcase = true

-- indent
o.smartindent = true
o.expandtab = true
o.shiftround = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- visuals
o.termguicolors = true
o.cmdheight = 2
o.winminwidth = 4

o.colorcolumn = "80,120"
o.signcolumn = "yes"

o.list = true
o.listchars:append("eol:")
o.listchars:append("space:⋅")

o.scrolloff = 8
o.sidescrolloff = 8
o.wrap = false

-- buffers
o.autoread = true
o.autowrite = true
o.confirm = true

-- history
o.undofile = true
o.undolevels = 10000

-- sessions
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- natural spawn
o.splitright = true
o.splitbelow = true

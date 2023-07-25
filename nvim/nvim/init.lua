-- Setup Clipboard
in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
  vim.g.clipboard = {
    name = 'wsl clipboard',
    copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
    paste = { ["+"] = { "win32yank.exe" }, ["*"] = { "win32yank.exe" } },
    cache_enabled = true
  }
end

vim.cmd([[
set clipboard+=unnamedplus
]])

-- turn off macro recording
vim.cmd([[
map q <Nop>
]])

-- Speed Up Loading Lua Modules
vim.loader.enable()

-- Imports
require('plugins') -- Plugins

-- Format on Autosave
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Neoscroll
require('neoscroll').setup()

-- Autopairs
require("nvim-autopairs").setup()

-- Hop
require 'hop'.setup {
  keys = 'etovxqpdygfblzhckisuran',
  jump_on_sole_occurrence = false,
}

-- Oil
require('oil').setup({
  columns = {
    "icon",
    -- "permissions",
    "size",
    "mtime",
  },
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
  },
})

-- Global Configuration
local global = vim.g
local o = vim.o
vim.scriptencoding = "utf-8"

-- Editor options
o.number = true            -- Print the line number in front of each line
o.relativenumber = true    -- Show the line number relative to the line with the cursor in front of each line.
o.clipboard = ""           -- uses the clipboard register for all operations except yank.
o.syntax = "on"            -- When this option is set, the syntax with this name is loaded.
o.autoindent = true        -- Copy indent from current line when starting a new line.
o.expandtab = true         -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 2           -- Number of spaces to use for each step of (auto)indent.
o.tabstop = 2              -- Number of spaces that a <Tab> in the file counts for.
o.encoding = "utf-8"       -- Sets the character encoding used inside Vim.
o.fileencoding = "utf-8"   -- Sets the character encoding for the file of this buffer.
o.ruler = true             -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "nv"             -- Enable the use of the mouse. "a" you can use on all modes
o.title = true             -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true            -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0          -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.ignorecase = true        -- bool: Ignore case in search patterns
o.smartcase = true         -- bool: Override ignorecase if search contains capitals
o.incsearch = true         -- bool: Use incremental search
o.hlsearch = false         -- bool: Highlight search matches
o.scrolloff = 8            -- min num lines of context
o.signcolumn = "yes"       -- show the sign column
o.numberwidth = 4          -- gutter width
o.cursorline = true        -- display cursor line
o.cursorlineopt = 'number' --
o.background = "dark"      -- dark themes
o.termguicolors = false


-- Map <leader>
global.mapleader = ","
global.maplocalleader = ","

-- Color theme
require("monokai-pro").setup({
  transparent_background = true,
  filter = 'pro',
  styles = {
    comment = { italic = true },
    keyword = { italic = true },      -- any other keyword
    type = { italic = false },        -- (preferred) int, long, char, etc
    storageclass = { italic = true }, -- static, register, volatile, etc
    structure = { italic = true },    -- struct, union, enum, etc
    parameter = { italic = true },    -- parameter pass in function
    annotation = { italic = true },
    tag_attribute = { italic = false },
  },
  background_clear = {
    "telescope",
    "lualine"
  },
})
vim.cmd([[colorscheme monokai-pro]])

-- Lua line
require('lualine').setup {
  options = {
    theme = 'monokai-pro',
    fmt = string.lower,
    -- component_separators = { left = '', right = '' },
    component_separators = { left = '-', right = '-' },
    section_separators = { left = '', right = '' },
  },
}

-- Barbecue
require('barbecue').setup {
  theme = 'monokai-pro'
}

-- Fidget
require "fidget".setup {
  window = {
    relative = "editor",
    blend = 10,
  },
}

-- Better escape
require("better_escape").setup {
  mapping = { "jk", "kj", "jj" }, -- a table with mappings to use
  timeout = vim.o.timeoutlen,     -- the time in which the keys must be hit in ms. Use option timeoutlen by default
  clear_empty_lines = false,      -- clear line after escaping if there is only whitespace
  keys = "<Esc>",                 -- keys used for escaping, if it is a function will use the result everytime
}

-- Comment Setup
require('Comment').setup({
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  },
})


---------------------------------------------------------------------
--    LSP Servers Configurations
---------------------------------------------------------------------

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()


-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end
sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    border = 'single',
    source = 'always',
    header = '',
    prefix = '-> ',
  },
})
-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
-- vim.o.updatetime = 550
-- vim.opt.signcolumn = 'yes'
-- vim.cmd([[
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])

-- Deno and TS
local nvim_lsp = require("lspconfig");
nvim_lsp.denols.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false,
}

-- Deno
-- require("lspconfig").denols.setup {
--   root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")
-- }

-- TypeScript
-- require("lspconfig").tsserver.setup {
--   on_attach = on_attach,
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
--   cmd = { "typescript-language-server", "--stdio" },
--   root_dir = nvim_lsp.util.root_pattern("package.json")
-- }

-- Resolve Deno & Typescript LSP conflict

-- HTML
require("lspconfig").html.setup {
  on_attach = on_attach,
  filetypes = { "html" },
  cmd = { "vscode-html-language-server", "--stdio" }
}

-- Svelte
require 'lspconfig'.svelte.setup {}



-- Lua
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Rust
local rt = require("rust-tools")

rt.setup({
  tools = {
    inlay_hints = {
      only_current_line = true,
      parameter_hints_prefix = " <-- ",
      other_hints_prefix = " --> ",
      highlight = "Comment"
    }
  },
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})



-- Zig
local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('completion').on_attach()
end
local servers = { 'zls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
  }
end



-- TreeSitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "comment", "c", "cpp", "css", "diff", "dockerfile", "elixir", "fish", "git_config",
    "git_rebase", "gitattributes", "gitcommit", "gitignore", "html", "http", "javascript", "json", "lua", "markdown",
    "python", "regex", "rust", "scss", "sql", "toml", "typescript", "vim", "vimdoc", "query", "yaml", "zig" },
  autotag = {
    enable = true,
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<S-Tab>",  -- normal mode
      node_incremental = "<Tab>",  -- visual mode
      node_decremental = "<S-Tab", -- visual mode
    },
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
  }
}


---------------------------------------------------------------------
--    Completion Configuration
---------------------------------------------------------------------

require('lspkind').init({
  -- mode = 'symbol_text'
})


vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 350)

local lspkind = require('lspkind')
local cmp = require 'cmp'

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For 'vsnip' users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = false }
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                                                       -- file paths
    { name = 'nvim_lsp',                keyword_length = 1, priority = 10 }, -- from language server
    { name = 'crates',                  keyword_length = 1, priority = 10 },
    { name = 'nvim_lsp_signature_help', priority = 8 },                      -- display function signatures with current parameter emphasized
    { name = 'nvim_lua',                keyword_length = 1, priority = 8 },  -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer',                  keyword_length = 1, priority = 5 },  -- source current buffer
    -- { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    { name = 'calc' },                                                       -- source for math calculation
  },
  window = {
    completion = {
      cmp.config.window.bordered(),
      col_offset = 3,
      side_padding = 1,
    },
    documentation = cmp.config.window.bordered(),

  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 60,        -- prevent the popup from showing more than provided characters
      -- The function below will be called before any actual modifications from lspkind:
      before = function(entry, vim_item)
        local menu_icon = {
          nvim_lsp = 'λ ',
          buffer = 'Ω ',
          luasnip = '⋗ ',
          path = '🖫 ',
        }
        vim_item.menu = menu_icon[entry.source.name]
        return vim_item
      end,
    })

  },
  preselect = cmp.PreselectMode.None,
  confirmation = {
    get_commit_characters = function(commit_characters)
      return {}
    end
  },
})

-- Trouble
require('trouble').setup {
  position = 'bottom',
  padding = true,
  auto_preview = false,
}

-- Telescope
local builtin = require('telescope.builtin')
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "^./.git/",
      "^./target/",
      "LICENSE*",
      "Cargo.lock",
      "yarn.lock",
      "target",
      "git"
    }
  }
}


-- Nvim Tree Setup
require('nvim-tree').setup {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = false,
  },
  renderer = {
    group_empty = true,
    icons = {
      git_placement = "after",
      glyphs = {
        git = {
          unstaged = "-",
          staged = "s",
          untracked = "u",
          renamed = "r",
          deleted = "d",
          ignored = "i",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
}


---------------------------------------------------------------------
--    Key Bindings
---------------------------------------------------------------------

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Visual Block
map("n", "<leader>v", "<C-v>")

-- Quit buffer
map("n", "qq", ":q<cr>")
map("n", "qa", ":qa<cr>")

-- Save and exit
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":wq<CR>")
map("n", "<leader>qa", ":wqa<CR>")

-- Nvim Tree
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', 'me', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'mE', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>i', vim.diagnostic.open_float)
-- vim.keymap.set('n', 'I', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>t', ':TroubleToggle<cr>')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'mD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'md', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'mi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>fa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>fr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>fl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Navigate buffers
map('n', '<leader>bp', ':bprevious<CR>', {})
map('n', '<leader>bn', ':bnext<CR>', {})
map('n', '<leader>bf', ':bfirst<CR>', {})
map('n', '<leader>bl', ':blast<CR>', {})
map('n', '<leader>bd', ':bdelete<CR>', {})

-- Trouble


-- Telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})


-- Comment.nvim configuration
-- current line
vim.keymap.set('n', 'cc', '<Plug>(comment_toggle_linewise_current)')
vim.keymap.set('n', 'cb', '<Plug>(comment_toggle_blockwise_current)')

-- Toggle in VISUAL mode
vim.keymap.set('x', 'cc', '<Plug>(comment_toggle_linewise_visual)')
vim.keymap.set('x', 'cb', '<Plug>(comment_toggle_blockwise_visual)')


-- Hop
map('n', 'mj', ":HopWord<cr>")

-- Oil
-- vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open parent directory" })


-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

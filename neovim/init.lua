----------------------------------------
--                                    --
--           USEFUL ALIASES           --
--                                    --
----------------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options



----------------------------------------
--                                    --
--         PACKAGE MANAGEMENT         --
--                                    --
----------------------------------------
require "paq" {
    -- Let Paq manage itself
    "savq/paq-nvim";
    'haishanh/night-owl.vim';
    "neovim/nvim-lspconfig";
    "hrsh7th/nvim-compe";
    "tpope/vim-fugitive";
    'tpope/vim-surround';
    'nvim-lua/plenary.nvim';
    'jose-elias-alvarez/null-ls.nvim';
    'jose-elias-alvarez/nvim-lsp-ts-utils';
    'kosayoda/nvim-lightbulb';
    'lewis6991/gitsigns.nvim';
    'idanarye/vim-merginal';
    {'neovim/nvim-lspconfig'};
    {'junegunn/fzf', run = fn['fzf#install']};
    {'junegunn/fzf.vim'};
    {'ojroques/nvim-lspfuzzy'};
    "justinmk/vim-sneak";
    { "neoclide/coc.nvim", branch = 'release' };
    'tribela/vim-transparent';
    'christoomey/vim-tmux-navigator';
    'terrortylor/nvim-comment';
    'preservim/nerdtree';
    'ryanoasis/vim-devicons'; -- Always load this as the last one
}
require('nvim_comment').setup()




----------------------------------------
--                                    --
--         EDITOR GENERAL CFG         --
--                                    --
----------------------------------------
cmd 'colorscheme night-owl'
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
-- highlight yanked text disabled in visual mode
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
-- show a lightbulb if a code action is available at the current cursor position
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
g['sneak#label'] = 1
cmd 'let mapleader = " "'




----------------------------------------
--                                    --
--              MAPPINGS              --
--                                    --
----------------------------------------

-- Configures mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- The function is called `t` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end


map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights

cmd('nnoremap <expr> <C-p> (len(system(\'git rev-parse\')) ? \':Files\' : \':GFiles --exclude-standard --others --cached\')."\\<cr>"')
map('', '<C-o>', '<cmd>Rg<CR>')   -- Search in all files



----------------------------------------
--                                    --
--                 LSP                --
--                                    --
----------------------------------------
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

-- enable null-ls integration (optional)
require("null-ls").setup {}

-- We use the default settings for ccls and pylsp: the option table can stay empty
lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        -- disable tsserver formatting if you plan on formatting via null-ls
        client.resolved_capabilities.document_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            import_all_priorities = {
                buffers = 4, -- loaded buffer names
                buffer_content = 3, -- loaded buffer content
                local_files = 2, -- git files or files with relative path markers
                same_file = 1, -- add to existing import statement
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- eslint
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true,
            eslint_bin = "eslint",
            eslint_config_fallback = nil,
            eslint_enable_diagnostics = false,

            -- formatting
            enable_formatting = false,
            formatter = "prettier",
            formatter_config_fallback = nil,

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,
        }

        -- required to fix code action ranges
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts = {silent = true}
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gq", ":TSLspFixCurrent<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
    end
}
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

cmd "map f <Plug>Sneak_s"
cmd "map F <Plug>Sneak_S"

cmd "command! -nargs=0 Prettier :CocCommand prettier.formatFile"

map('n', '<silent>gd', t'<Plug>(coc-definition)')
map('n', '<silent>grn', t'<Plug>(coc-rename)')

-- cmd "nmap <silent> gd <Plug>(coc-definition)"
-- cmd "nmap <silent> grn <Plug>(coc-rename)"

-- Copy to clipboard
map('v', '<leader>y', '"+y', {noremap = true})
map('n', '<leader>Y', '"+yg_', {noremap = true})
map('n', '<leader>y', '"+y', {noremap = true})
map('n', '<leader>yy', '"+yy', {noremap = true})

-- Paste from clipboard
map('n', '<leader>p', '"+p', {noremap = true})
map('n', '<leader>P', '"+P', {noremap = true})
map('v', '<leader>p', '"+p', {noremap = true})
map('v', '<leader>P', '"+P', {noremap = true})

-- File tree
map('n', '<leader>pt', "<cmd>NERDTreeToggle<CR>")

-- Git
map('n', '<leader>gs', "<cmd>G<CR>")
map('n', '<leader>gp', "<cmd>G push<CR>")
map('n', '<leader>gb', "<cmd>Merginal<CR>")

-- Reload config
map('n', '<leader>hr', '<cmd>source $MYVIMRC<CR>')

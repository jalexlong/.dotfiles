" =============================================================================
" 1. GENERAL SETTINGS
" =============================================================================
" Set relative line numbers
set number relativenumber

" Automatically save to system clipboard
" Note: Requires vim compiled with +clipboard feature
set clipboard=unnamedplus

" =============================================================================
" 2. VIM-PLUG AUTO-INSTALLATION
" =============================================================================
" Detects if the plugin manager is missing and installs it automatically.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =============================================================================
" 3. PLUGINS
" =============================================================================
call plug#begin('~/.vim/plugged')

" --- General Utilities ---
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Installs the binary
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" --- IDE Features (LSP & Linting) ---
" CoC works in both Vim and Neovim (Requires Node.js installed)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Installs Pyright for CoC automatically
Plug 'fannheyward/coc-pyright'

" ALE for Linting/Fixing (Works in both)
Plug 'dense-analysis/ale'

" --- Hacker Tools ---
" Allows you to edit binary files directly in Vim.
" Usage: Open a binary, type :%xxd to view hex, edit it, then :%xxd -r to revert.
Plug 'Shougo/vinarise.vim'

" Debugging (DGB/Python integration)
Plug 'puremourning/vimspector'

" Cheatsheets
" Usage: :Cheat python/requests or :Cheat amd64/registers
Plug 'dbeniamine/cheat.sh-vim'

" Docker
Plug 'neoclide/coc-yaml'
Plug 'neoclide/coc-docker'

" --- Neovim Exclusives ---
" We must wrap Treesitter in an 'if' block because it crashes standard Vim
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

call plug#end()

" =============================================================================
" 4. UI & COLORS
" =============================================================================
" Enable True Color support
if (has("termguicolors"))
  set termguicolors
endif

" Fix for opacity in certain terminals (Alacritty/Kitty/etc)
if &term =~ '256color'
    " These escape sequences allow TrueColor in standard Vim
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set background to transparent
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

" =============================================================================
" 5. PLUGIN CONFIGURATION
" =============================================================================

" --- ALE Settings (Python) ---
" Disabling ALE's LSP features so it doesn't conflict with CoC
let g:ale_disable_lsp = 1

" Linters
let g:ale_linters = { 'python': ['ruff'] }

" Fixers
let g:ale_fixers = { 'python': ['ruff', 'ruff_format'] }

" Fix on save
let g:ale_fix_on_save = 1

" =============================================================================
" 6. COC.NVIM CONFIGURATION
" =============================================================================

" --- 1. Autocomplete Logic ---
" Use <Tab> to trigger completion and navigate through the list
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <Enter> to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Helper function for <Tab> logic (checks if cursor is at beginning of line)
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" --- 2. Navigation (Go to Definition) ---
" Go to definition
nmap <silent> gd <Plug>(coc-definition)
" Go to type definition
nmap <silent> gy <Plug>(coc-type-definition)
" Go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Find references (where is this function used?)
nmap <silent> gr <Plug>(coc-references)

" --- 3. Documentation ---
" Use K to show documentation in preview window (like hovering mouse)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" --- 4. Renaming ---
" Rename symbol (variable/function) across the whole project
nmap <leader>rn <Plug>(coc-rename)

" --- 5. Prettier/Formatting ---
" Make CoC format the current buffer
command! -nargs=0 Format :call CocActionAsync('format')

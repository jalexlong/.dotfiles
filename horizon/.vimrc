" Set background opacity
if has("termguicolors")
	set t_8f=\[[38;2;%lu;%lu;%lum
	set t_8b=\[[48;2;%lu;%lu;%lum
	set termguicolors
endif
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

" Turn on syntax highlighting
syntax on

" Number of spaces a tab counts for
set tabstop=4

" Number of spaces for auto-indent
set shiftwidth=4

" Convert tabs to spaces
set expandtab

" Number of spaces a tab counts for while editing
set softtabstop=4

" Set relative line numbers
set nu rnu

" Automatically save to system clipboard
set clipboard=unnamedplus

" Case-insensitive search
set ignorecase

" Case-sensitive if uppercase letters are used
set smartcase

" Highlight search matches
set hlsearch

" Incremental search
set incsearch

" Enable mouse support
set mouse=a

" Enable filetype detection and plugin loading
filetype plugin indent on


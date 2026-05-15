if exists('$TMUX')
    " This tells Vim how to send 24-bit colors through tmux
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if has("termguicolors")
	set termguicolors
endif

" Set bg color to transparent
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


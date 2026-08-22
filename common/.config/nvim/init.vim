" nvim reads this file, not ~/.vimrc. Rather than keep a second copy of the same
" settings -- which had already drifted: this file set termguicolors
" unconditionally while ~/.vimrc guarded it on $COLORTERM -- source the vim
" config and keep only what is genuinely nvim-specific below.
if filereadable(expand('~/.vimrc'))
    source ~/.vimrc
endif

" nvim-only: let the terminal's background_opacity show through instead of
" painting nvim's own background over it. Left commented in ~/.vimrc because
" plain vim is usually launched over an opaque background (sudo, TTY).
hi Normal ctermbg=None guibg=None
hi NonText ctermbg=None guibg=None

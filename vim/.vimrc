" Set relative line numbers
set nu rnu

" Automatically save to system clipboard
set clipboard=unnamedplus

" Set background opacity
if has("termguicolors")
	set t_8f=\[[38;2;%lu;%lu;%lum
	set t_8b=\[[48;2;%lu;%lu;%lum
	set termguicolors
endif
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

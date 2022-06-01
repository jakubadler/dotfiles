set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required

set nojoinspaces
set nu
filetype indent on
filetype plugin off
"set guifont=Terminus\ 8
"set guifont=Inconsolata\ 9
set guifont=DejaVu\ Sans\ Mono\ 8
set printfont=DejaVu\ Sans\ Mono\ 8

"Tab highlighting
"set lcs=tab\:\|- list

"function! HiTabs()
"    syntax match TAB /\t/
"    hi TAB ctermbg=blue ctermfg=red
"endfunction
"au BufEnter,BufRead * call HiTabs()

if has("eval") && has("autocmd")
	fun! <SID>check_pager_mode()
		if exists("g:loaded_less") && g:loaded_less
			" we're in vimpager / less.sh / man mode
			set laststatus=0
			set ruler
			set foldmethod=manual
			set foldlevel=99
			set nolist
			set nu!
		endif
	endfun
	autocmd VimEnter * :call <SID>check_pager_mode()
endif

syntax on
set list listchars=tab:»·,trail:·
colorscheme kuba
set nomodeline

set noexpandtab
set tabstop=8
set softtabstop=8
set shiftwidth=8
set smartindent

let g:ycm_confirm_extra_conf = 0

let mapleader=","
noremap <leader>gl :YcmCompleter GoToDeclaration<CR>
noremap <leader>gf :YcmCompleter GoToDefinition<CR>
noremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


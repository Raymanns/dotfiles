" =========================
" ~/.vimrc - Myles Offord
" =========================

" Automatic Reloading of the .vimrc file
autocmd! BufWritePost .vimrc source %

" Make copy/paste work properly in tmux/iterm2
set clipboard=unnamed

" Plugin infection
execute pathogen#infect()
syntax on
filetype plugin indent on

" Color set up
set t_Co=256
set term=xterm-256color

" Solarized Set up
syntax enable
set background=dark

" Solarized options
colorscheme solarized

" 80 line marker
let &colorcolumn=join(range(80,81),",")

" Make Backspace kill indents and tabs in one press
set bs=2

" Display Airline linestatus ALL the time
set laststatus=2

" Airline Config
" let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'solarized'

set background=dark
let g:airline_solarized_bg = "dark"
let g:airline_theme = "solarized"

let g:vim_markdown_folding_disabled=1

" Clears the white space from the specified file types when :w is issued
" Can list multiple files types inside of { *.md, *.txt  } I think.
autocmd BufWritePre *.md :%s/\s\+$//e

" Adds a command <SPACE>op to generate the .md file out to a .pdf file using
" pandoc and LaTex. The function will add a folder in the same directory as
" the file called ./pdf if it isn't there, delete any existing pdf files with
" the same name and then generate and open the file in preview.
let mapleader = " " " Binds <Leader> to SPACE
function! OpenMarkdownPreview()
	:silent !clear
	if filereadable(./pdf/'%:r'.pdf)
		:silent !rm '%:r'.pdf
	endif

	if !isdirectory('./pdf')
		:silent !mkdir './pdf'
	endif

	:silent !pandoc '%:p' -o ./pdf/'%:r'.pdf
	:silent !open ./pdf/'%:r'.pdf
	:redraw!
endfunction

map <Leader>op :call OpenMarkdownPreview()<CR>

set spell spelllang=en_gb

" size of a hard tab stop
set tabstop=4

"size of an indent
set shiftwidth=4

"a combination of spaces and tabs are used to simulate tab stops at a width
"other than the (hard) tab stop
set softtabstop=4

set expandtab " Always uses spaces instead of tab chars
set smarttab " Inserts indents instead of tabs at the start of the line

:set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
:set list

" Set Toggle Line number to Ctrl-N twice
:nmap <C-N><C-N> :set invnumber<CR>

" Configuration for Syntastic
" Recommended Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ignore ng- attributes in html
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

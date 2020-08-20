
"filetype plugin indent on " filetype detection(on) plugin(on) indent(on)
syntax on
set autoread " autoreload files changed on disk
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set cursorline
set shortmess+=c
set signcolumn=yes
set clipboard+=unnamedplus " Clipboard
let &colorcolumn=join(range(80,81),",")

" Make hidden characters visible
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" Remove whitespace from the end of the line for all filetypes
autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType make setlocal noexpandtab " Makefiles require hard tabs

" setup spelling for editing markdown files
set spelllang=en_gb

au BufRead,BufNewFile *.Rmd set filetype=markdown
augroup markdownSpell
  autocmd!
  autocmd FileType markdown setlocal spell
augroup END

let g:tex_flavor = "latex"
autocmd FileType tex setlocal spell

call plug#begin('~/.vim/plugged')

" General Editing

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script

" Colors & Theming
Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " Enables repeat of vim-surround
Plug 'tpope/vim-markdown'
" Plug 'tpope/vim-classpath'
" Plug 'tpope/vim-fireplace' " Clojure, uses vim-classpath
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'ledger/vim-ledger' " Plaintext Accounting

" " Markdown
" " Rust
" Plug 'rust-lang/rust.vim'
" Plug 'cespare/vim-toml' " config format used frequenly in the rust toolchain
" " Erlang / Elixir
" Plug 'elixir-editors/vim-elixir'
" " Go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" " JVM based
" Web
" Language pack

call plug#end()

let mapleader = "\<Space>" " Leader

" quick save
nmap <leader>w :w<CR>
" Toggle buffers
nnoremap <leader><leader> <c-^>
" Use <leader>t for 'jump to tag'.
nnoremap <Leader>] <C-]>
" Removes highlighting until the next search is made
nnoremap <Leader>n :noh<CR>
" Removes the last char from the current word
nnoremap <Leader>x exb
nnoremap <Leader>m :make<CR><CR>

" theme
colorscheme gruvbox
set background=dark

let g:airline_solarized_bg = "dark"
let g:airline_theme = "gruvbox"

" Use ag (the_silver_searcher) to find files, using git metadata too if it
" exists
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" Binds leader-p to bring up fzf file finder
nnoremap <leader>p :Files<CR>
" FZF the list of open buffers
nnoremap <leader>; :Buffer<CR>

" CoC setup
autocmd FileType json syntax match Comment +\/\/.\+$+

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible()? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart

" ale (linter) configuration
let g:ale_linters = { 'rust': ['rls', 'cargo', 'rustc'] }


" Base

" General
set nocompatible
filetype plugin indent on " filetype detection(on) plugin(on) indent(on)
syntax enable " Enable sytax highlighting

" Cursor & Line
set number
let &colorcolumn=join(range(80,81),",")
set cursorline

" Files
set autoread " autoreload files changed on disk

" Vim diff
set diffopt=filler,vertical

" Wrapping
set nowrap

" Leader
let mapleader = ','
let maplocalleader = ','

" Clipboard
set clipboard+=unnamedplus

" Use ,t for 'jump to tag'.
nnoremap <Leader>t <C-]>


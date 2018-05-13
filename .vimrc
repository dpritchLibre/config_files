" easy exit from insert mode
inoremap jk <Esc>
tnoremap jk <C-\><C-n> 

" select theme
colorscheme lightning

" perform filetype-specific auto-indentation.  See stackoverflow.com/q/234564
filetype plugin indent on

" set up tab and indentation behavior.  `tabstop` defines the frequency of the
" tabstops, and `expandtab` causes a tab key press to insert the necessary
" number of spaces to reach the next tab stop. `shiftwidth defines the shift
" size when shifting with `<<` or `>>`.
set tabstop=4
set shiftwidth=4
set expandtab

" switch buffers without being forced to save current buffer first
set hidden

" always show the status line
set laststatus=2

" prevent visual line wrapping
set nowrap

" allow mouse support in the terminal
set mouse=a

" highligh search matches.  <C-L> is redefined to perform an additional call
" to `nohlsearch` in addition to its usual behavior of redrawing the screen,
" which has the effect of removing the highlighting after the search.  See
" https://stackoverflow.com/a/25569434/5518304
set hlsearch
nnoremap <C-L> :nohlsearch<CR><C-L>

" construct the statusline.  Based on https://shapeshed.com/vim-statuslines/
set statusline=
set statusline+=%#PmenuSel#                                 " change background
set statusline+=\ %f\                                       " filename
set statusline+=%#LineNr#                                   " change background
set statusline+=\ \ %p%%\ (%l:%c)\ \                        " cursor position
set statusline+=%m                                          " modified status
set statusline+=%=                                          " right-justify
set statusline+=%#CursorColumn#                             " change background
set statusline+=\ %y                                        " filteype
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}  " file encoding
set statusline+=\[%{&fileformat}\]\                         " line endings

" alias <Tab> and <S-Tab> to the auto-completion list scroll up and down for the
" Nvim Completion Manager.  Allows for a tab to complete the word when the
" completion is unique.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" begin vim-plug section -------------------------------------------------------

" see https://github.com/junegunn/vim-plug for details on using the vim-plug
" package manager.  In brief, a command like `Plug 'jalvesaq/Nvim-R'` fetches
" https://github.com/jalvesaq/Nvim-R.  Make sure that you use single (not
" double) quotes.

" specify a directory for plugins.  Avoid using standard Vim directory names
" like `plugin`.
call plug#begin('~/.vim/plugged')

" provides an R IDE.  See
" https://raw.githubusercontent.com/jalvesaq/Nvim-R/master/doc/Nvim-R.txt for
" details.
Plug 'jalvesaq/Nvim-R'

" auto-completion facilities.  Requires prior installation of of `neovim` and
" `jedi` Python3 modules.  See https://github.com/roxma/nvim-completion-manager
" for details.
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-completion-manager'

" add R completion library for nvim-completion-manager
Plug 'gaalcaras/ncm-R'

" initialize plugin system
call plug#end()

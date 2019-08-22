" nvim config
" sneaky

" vim plug {{{
call plug#begin('~/.config/nvim/plugged')

" browsing
Plug 'yuratomo/w3m.vim'

" Plug 'hhsnopek/vim-firewatch'
" development
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'chrisbra/Colorizer'

" parentheses
Plug 'tpope/vim-surround', { 'for': ['clojure', 'javascript', 'javascript.jsx'] }

" sql
" Plug 'has2k1/sql.vim', { 'for': 'sql' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }

" clojure
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
" Plug 'tpope/vim-salve', { 'for': 'clojure' }

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}

" linter
Plug 'w0rp/ale', {'for': ['javascript', 'javascript.jsx', 'elixir', 'clojure']}

" javascript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug 'flowtype/vim-flow', {'for': ['javascript', 'javascript.jsx']}

" elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim', {'for': 'elixir'}
Plug 'digitaltoad/vim-pug'

" docker
" Plug 'ekalinin/Dockerfile.vim', {'for': 'dockerfile'}

call plug#end()
" }}}
" gruvbox {{{
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_improved_string = 1
" }}}
" vim-deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}
" vim-go {{{
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
" }}}
" javascript & jsx {{{
let g:javascript_plugin_flow = 1

" colorscheme
hi! link jsClassProperty GruvboxGreen
" }}}
" clojure {{{
let g:clojure_maxlines = 333
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let'
      \, '^go'
      \, '^query$', '^render$', '^ident$', '^initLocalState$'
      \, '^componentWill', '^componentDid'
      \, 'context$', 'resource$'
      \, '^action$']


let g:clojure_syntax_keywords = {
      \  'clojureDefine': ["defui"]
      \, 'clojureConst': ["ident", "query", "render"]}

" autocmd BufRead *.clj* setlocal foldmethod=syntax foldnestmax=1
" }}}
" elixir {{{
let g:alchemist_compile_basepath = '/app/'
" }}}
" pgsql {{{
let g:sql_type_default = 'pgsql'
" }}}
" FZF {{{
let $FZF_DEFAULT_COMMAND = 'fd --type f'
" let $FZF_DEFAULT_OPTS .= '--inline-info'
" bugfix maybe fixed
" let g:fzf_layout = { 'window': 'enew' }
let g:fzf_buffers_jump = 1
" }}}
" ale {{{
let g:ale_linters = {
      \'javascript': ['eslint'],
      \'javascript.jsx': ['eslint'],
      \'elixir': ['mix']}
      " \'elixir': ['mix', 'elixir-ls']}
let g:ale_fixers = {
      \'javascript': ['prettier_eslint', 'eslint'],
      \'elixir': ['mix_format']}

let g:ale_set_balloons = 1
let g:ale_fix_on_save = 1
" let g:ale_elixir_elixir_ls_release = '/home/j/.elixir_ls/rel'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}
" env {{{
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}
" vars {{{
syntax on
filetype indent plugin on
set termguicolors
fu! SetColor(group, attr, color)
  let gui = a:color =~ '^#'
  let text = printf('hi %s %s%s=%s', a:group, gui ? 'gui' : 'cterm', a:attr, a:color)
  echo text
endf

" cursor blinking
set guicursor=a:blinkon1

set clipboard+=unnamedplus
set fdm=marker
set bg=dark
set shiftwidth=2
set sts=2
set ts=2
set laststatus=1
set so=3
set magic
set et
set sta
set tgc
set rnu
set cul
set ai
set si
set nu
set undofile
" }}}
" foldtext {{{
function! CustomFoldtext()
    " remove comments
    let line = substitute(getline(v:foldstart),
          \'\v\s*(' . substitute(&cms, '\s*%s', '', '') . '+)\s*', '', 'g')
    " remove marker
    let line = substitute(line, '\s*' . split(&foldmarker, ',')[0] . '\s*', '', 'g')
    let line = repeat(v:folddashes, 2) . ' ' . line
    let w = get(g:, 'custom_foldtext_max_width', winwidth(0)) - &foldcolumn - (&number ? 4 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat(" ", 4)
    let lineCount = line("$")
    let expansionString = repeat(' ', w - strwidth(foldSizeStr.line.foldLevelStr))
    return line . expansionString . foldSizeStr . foldLevelStr
endf
set foldtext=CustomFoldtext()
" }}}
" colorscheme {{{
" overrides
function! s:patch_colorscheme()
  hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
endfunction

autocmd! Colorscheme gruvbox call s:patch_colorscheme()

colorscheme gruvbox
" }}}
" key bindings {{{
" normal mode {{{
nnoremap <silent><F11> :Goyo<CR>
nnoremap <silent><S-P> :Ag<CR>
nnoremap <silent><C-P> :FZF<CR>
nnoremap <silent><ESC> :nohl<CR>
nnoremap <silent><F4> :qa<CR>

" highlight binding
nnoremap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
" insert mode {{{
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
" terminal mode {{{
" tnoremap <Esc> <C-\><C-n>
" }}}

" }}}
" autocmd {{{

" restore last position
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif


" remove whitespace
function TrimWhitespace()
  let s:will_edit = search('s*$', 'ncpw')
  if s:will_edit > 0
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfunction
autocmd BufWritePre * call TrimWhitespace()


" }}}


" --- BASIC SETTINGS ---
let mapleader=" "
set ruler incsearch hlsearch wildmenu
set number relativenumber 
set history=100
set showcmd
set ignorecase smartcase 
set autoindent smartindent  
set termguicolors
set background=dark
set hidden
set expandtab
set tabstop=4
set mouse=a
syntax enable
colorscheme desert 

" --- KEYMAPS ---
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR> 
nnoremap <leader>e :Ex<CR> 
" load copilot with <Leader>cp 
nnoremap <Leader>cp :packadd copilot.vim<CR>:echo "Copilot loaded!"<CR>
" Auto-compelete setup 
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" display vscode like for diagnostics
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': '✖'}
let g:lsp_diagnostics_signs_warning = {'text': '⚠'}
let g:lsp_diagnostics_signs_hint = {'text': '💡'}
" Reset the LSP highlight groups to be more subtle
highlight LspErrorText guifg=#ff5555 gui=underline ctermfg=Red cterm=underline
highlight LspWarningText guifg=#ffb86c gui=underline ctermfg=Yellow cterm=underline
highlight LspInformationText guifg=#8be9fd gui=underline ctermfg=Cyan cterm=underline
highlight LspHintText guifg=#50fa7b gui=underline ctermfg=Green cterm=underline

" Link the virtual text (the yellow line) to a dimmer color
highlight link LspErrorVirtualText Comment
highlight link LspWarningVirtualText Comment


" --- VIM-LSP KEYMAPS ---
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    
    " Hover documentation (Shift+K)
    nmap <buffer> K <plug>(lsp-hover)
   
    " Go to definition (gd)
    nmap <buffer> gd <plug>(lsp-definition)
    
    " Go to implementation (gi)
    nmap <buffer> gi <plug>(lsp-implementation)
    
    " Go to references (gr)
    nmap <buffer> gr <plug>(lsp-references)
    
    " Rename symbol (Leader + rn)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
endfunction

augroup lsp_install
    au!
    " Attach these keymaps only when an LSP server is active for the buffer
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

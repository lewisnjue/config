#!/usr/bin/env bash

set -euo pipefail

# Base directory (current directory by default)
BASE_DIR="${1:-.}"

# Create directory structure
mkdir -p \
  "$BASE_DIR/ai/opt" \
  "$BASE_DIR/ai/start" \
  "$BASE_DIR/git/start" \
  "$BASE_DIR/lsp/start" \
  "$BASE_DIR/utils/start"

# AI
git clone https://github.com/github/copilot.vim.git \
  "$BASE_DIR/ai/opt/copilot.vim"

# Git
git clone https://github.com/tpope/vim-fugitive.git \
  "$BASE_DIR/git/start/fugitive"

git clone https://github.com/tpope/vim-fugitive.git \
  "$BASE_DIR/git/start/vim-fugitive"

# LSP
git clone https://github.com/prabirshrestha/asyncomplete.vim.git \
  "$BASE_DIR/lsp/start/asyncomplete.vim"

git clone https://github.com/prabirshrestha/asyncomplete-lsp.vim.git \
  "$BASE_DIR/lsp/start/asyncomplete-lsp.vim"

git clone https://github.com/prabirshrestha/vim-lsp.git \
  "$BASE_DIR/lsp/start/vim-lsp"

git clone https://github.com/mattn/vim-lsp-settings.git \
  "$BASE_DIR/lsp/start/vim-lsp-settings"

# Utils
git clone https://github.com/tpope/vim-surround.git \
  "$BASE_DIR/utils/start/surround"

echo "Done."

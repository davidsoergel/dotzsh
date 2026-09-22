#!/bin/sh
# Install the Homebrew-provided zsh plugins and tools this config expects.
#
# zshrc/handy sources the two plugins from $(brew --prefix)/share, and zshrc/fnm
# and zshrc/handy look for fnm and zoxide on PATH -- so all four must come from
# Homebrew. Cloning the plugins into ~/.zsh does nothing, because nothing on the
# source path points there.
#
# (This script was previously clone-dependencies.sh and `git clone`d the two
# plugins over git://, a protocol GitHub disabled in 2022. Those clones were
# never sourced, so the script had been dead for years.)
#
# Counterpart: update-dependencies.sh upgrades the same set.

brew install zsh-syntax-highlighting zsh-history-substring-search fnm zoxide

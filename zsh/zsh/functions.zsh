autoload -Uz clean-up-swap-files
autoload -Uz usbtethering

load() {
  autoload -Uz $1
  zle -N $1
}

load pdf
load pid2wid
if which fzf > /dev/null; then
  load fcp
  load fcpt
  load fdf
  load fif
  load fmv
  load fmvt
  load frm

  load fzf-history-search
  load fzf-git-add
  load fzf-git-unstage
  load fzf-git-checkout-branch
  load fzf-git-ls-files-editor
fi

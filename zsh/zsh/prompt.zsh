autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%s: %b'
zstyle ':vcs_info:*' actionformats '%s: %b (%a)'

function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            PROMPT="
%F{blue}[%~]%f %1(v|%F{green}%1v%f|)
%F{cyan}-- INSERT --%f
%(?.%F{yellow}%}.%F{red})$%f "
            ;;
        vicmd)
            PROMPT="
%F{blue}[%~]%f %1(v|%F{green}%1v%f|)
%F{white}-- NORMAL --%f
%(?.%F{yellow}%}.%F{red})$%f "
            ;;
        vivis|vivli)
            PROMPT="
%F{blue}[%~]%f %1(v|%F{green}%1v%f|)
%F{yellow}-- VISUAL --%f
%(?.%F{yellow}%}.%F{red})$%f "
            ;;
    esac
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

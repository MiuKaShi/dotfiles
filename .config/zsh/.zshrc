# Z-jump:
eval "$(lua /usr/share/zsh/plugins/z.lua/z.lua --init zsh enhanced once)"

# Change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}%{$fg[blue]%} %{$fg[green]%}%~%{$fg[cyan]%}  %b "

# zsh misc
setopt auto_cd               # simply type dir name to cd
setopt auto_pushd            # make cd behave like pushd
setopt pushd_ignore_dups     # don't pushd duplicates
setopt pushd_minus           # exchange the meanings of `+` and `-` in pushd
setopt interactive_comments  # comments in interactive shells
unsetopt nomatch             # Fix url quote
stty stop undef		         # Disable ctrl-s to freeze terminal.

# ZSH History:
setopt hist_ignore_all_dups  # no duplicates
setopt hist_save_no_dups     # don't save duplicates
setopt hist_ignore_space     # no commands starting with space
setopt hist_reduce_blanks    # remove all unneccesary spaces
setopt share_history         # share history between sessions
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
[[ ! -d ${HISTFILE:h} ]] && mkdir -pm700 ${HISTFILE:h}
HISTORY_IGNORE="(ls|cd|history|lf|exit|reboot)"
HISTSIZE=10000
SAVEHIST=10000

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/fzf-notes" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/fzf-notes"

# export LS_COLORS="$(vivid generate gruvbox-dark)"

# Basic auto/tab complete:
autoload -Uz compinit
_comp_options+=(globdots)		# Include hidden files.
for dump in ~/.config/zsh/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist

# see https://github.com/TheLocehiliosan/yadm/issues/355
__git_files () { 
    _wanted files expl 'local files' _files     
}

#ZSH_HISTORY
# https://github.com/ellie/atuin
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' _atuin_search_widget

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-l
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^l' '^ulfcd\n'
bindkey -s '^t' '^umyyt\n'
bindkey -s '^o' '^uchopin-open\n'
bindkey -s '^p' '^uchopin-paper\n'
#bindkey -s '^a' '^ubc -lq\n'
bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh 2>/dev/null

# fast-syntax-highlighting
unset 'FAST_HIGHLIGHT[chroma-man]'  # chroma-man will stuck history browsing

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND='1'

# eval "$(starship init zsh)"

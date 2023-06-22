# Configuration for fzf

if ! command -v fzf &> /dev/null; then
    echo "fzf not installed - not setting it up"
else
    # Recommended to install: fzf fd ripgrep bat git-delta
    export FZF_DEFAULT_COMMAND="fd --hidden --color=always --follow --exclude '*~' --exclude '.git'"
    export FZF_DEFAULT_OPTS="--height 50% --border --ansi"
    alias fzpv="${FZF_DEFAULT_COMMAND} --type f | fzf --preview 'bat --style=plain --color=always --line-range :100 {}'"

    # Use fd instead of the default find command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    _fzf_compgen_path() {
        fd --color=always --hidden --follow --exclude '*~' --exclude '.git' . "$1"
    }

    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
        fd --type d --color=always --hidden --follow --exclude '*~' --exclude '.git' . "$1"
    }

    # Opens file with vim upon ctrl-t (fzf)
    fzf_editor() {
        local file=$(fzpv)
        # Open the file if it exists
        if [ -n "$file" ]; then
            # Use the default editor if it's defined, otherwise Vim
            ${EDITOR:-vi} "$file"
        fi
    }
    bindkey -s '^t' 'fzf_editor\n'

    # for conda auto-completion
    autoload -U compinit && compinit

    # bind UP and DOWN arrow keys
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

    # bind UP and DOWN arrow keys (compatibility fallback
    # for Ubuntu 12.04, Fedora 21, and MacOSX users)
    #bindkey '^[[A' history-substring-search-up
    #bindkey '^[[B' history-substring-search-down

    # bind P and N for EMACS mode
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down

    # bind k and j for VI mode
    #bindkey -M vicmd 'k' history-substring-search-up
    #bindkey -M vicmd 'j' history-substring-search-down
fi

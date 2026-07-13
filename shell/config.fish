set fish_greeting ""
if status is-interactive
    fish_add_path "$HOME/.local/bin"
    fastfetch
    alias hx helix
    zoxide init fish | source
    starship init fish | source
end

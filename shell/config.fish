set fish_greeting ""
if status is-interactive
    fastfetch
    alias hx helix
    zoxide init fish | source
    starship init fish | source
end

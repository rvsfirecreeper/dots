# config.nu
#
# Installed by:
# version = "0.108.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
$env.config.show_banner = false
$env.NO_AT_BRIDGE = 1
$env.config.buffer_editor = 'nvim'
use std/util "path add"
path add "~/.local/bin"
path add "~/.cargo/bin"
path add "./.venv/bin"
$env.config.edit_mode = 'vi'
sleep 0.1sec
fastfetch
mkdir ($nu.data-dir | path join "vendor/autoload")
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.GPG_TTY = (tty)

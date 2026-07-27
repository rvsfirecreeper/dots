. /etc/os-release
case "$ID" in
  nixos) os="" ;;
  arch) os="" ;;
  fedora) os="󰣛";;
  opensuse*) os="";;
  ubuntu) os="GET OUT YOU FILTHY PROPRIETARY UBUNTU USER";;
  *) os="󰌽" ;;
esac
echo "$os"

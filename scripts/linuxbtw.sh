. /etc/os-release
case "$ID" in
  nixos) os="" ;;
  arch) os="" ;;
  *) os="󰌽" ;;
esac
echo "$os"

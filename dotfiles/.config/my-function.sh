# https://medium.com/@u.mair/15-practical-bash-functions-you-will-end-up-writing-anyway-b0b0fbd12275



# Create a directory and enter it
mkcd() { mkdir -p "$1" && cd "$1"; }

# cd ../ * n times
up() {
  local d=""
  for ((i=1;i<=$1;i++)); do
    d+="../"
  done
  cd "$d"
}

# Find files
ff() {
  find . -type f -iname "*$1*"
}

# Find folder
fd() {
  find . -type d -iname "*$1*"
}

# Find process
psg() {
  ps aux | grep -i "$1" | grep -v grep
}

# Search in history
hg() {
  history | grep "$1"
}

# Extract
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "unknown archive" ;;
    esac
  fi
}

# HTTP Server ???
serve() {
  python3 -m http.server "${1:-8000}"
}

# My IP
myip() {
  curl -s ifconfig.me
}

# Find out the IP address of a domain
ipinfo() {
  dig +short "$1"
}

# Show opened port
ports() {
  ss -tuln
}

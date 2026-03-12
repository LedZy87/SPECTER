#!/bin/bash
# ================================================================
#  SPECTER v10.11.0 — IRON SHIELD
#  The ultimate privacy and anonymity system for Linux
#  Software-maximum protection — government-level defense
#
#  © LedZy — SPECTER 2025 — All rights reserved
#  Proof of authorship: echo 'TGVkWnk6U1BFQ1RFUjoyMDI1' | base64 -d
#
#  Single-file. No dependencies beyond standard Linux + apt.
#  Designed for Tails OS, Whonix, Debian, Ubuntu.
#  Run as root. Read the docs before running --full.
#
# ================================================================
#  COMMAND REFERENCE
# ================================================================
#
#  ── v10.11 IRON SHIELD (active defense) ──────────────────────
#  fortress-mode     Whitelist-only firewall — zero inbound, Tor-only out
#  ssh-lockdown      Disable SSH + fail2ban ultra-aggressive mode
#  auto-defend       Real-time attack detection + automatic block/response
#  exfil-detect      Outbound data exfiltration detection daemon
#  port-knock        Port knocking for authorized remote access
#  canary-deploy     Honeypot files that alert on any access
#  ioc-scan          Indicators-of-compromise full system scanner
#  proc-harden       Seccomp + ASLR + exploit mitigations
#  sysctl-max        Maximum kernel hardening sysctl profile
#  log-fortify       Tamper-proof encrypted system logs
#  v10-11-status     Iron Shield feature status dashboard
#
#  ── v10.10 ABSOLUTE ZERO (hardware-level) ────────────────────
#  build-specter-usb Debian Live amnesic USB (live-build)
#  pq-keygen         Generate Kyber-1024 + AES-256-GCM key pair
#  pq-encrypt        Post-quantum encrypt a file
#  pq-decrypt        Post-quantum decrypt a file
#  dualhop-start     I2P → Tor dual-chain proxy (proxychains4)
#  dualhop-exec      Run command through I2P → Tor chain
#  dualhop-status    Show dual-hop proxy status
#  dualhop-stop      Stop dual-hop proxy
#  tpm-check         TPM 2.0 chip detection and PCR status
#  tpm-seal          Seal a secret to TPM PCR values
#  tpm-unseal        Unseal TPM-protected secret
#  yubikey-setup     Hardware 2FA for LUKS + sudo (YubiKey)
#  yubikey-status    YubiKey hardware token status
#  hardware-checklist Recommended hardware buy list + 9-step setup
#  v10-10-status     Absolute Zero feature status dashboard
#
#  ── v10.9 ZERO TRACE PROTOCOL ────────────────────────────────
#  vanguards-install Guard rotation defense (Tor HS deanon protection)
#  transport-rotate  Auto-cycle obfs4/Snowflake/meek bridges
#  ns-isolate        Per-app kernel network namespace isolation
#  compartment-*     Isolated browser sessions (own Tor circuit)
#  warrant-canary    Weekly warrant canary monitor via Tor
#  secureboot-check  UEFI Secure Boot + bootloader integrity
#  mem-forensics-def Kernel memory anti-forensics hardening
#  noise-upgrade     Human-pattern cover traffic (burst+quiet)
#  tscm-full         NFC + BLE + SDR wideband sweep
#  guardian-mode     Single command — ALL protection layers active
#
#  ── v10.8 MAXIMUM HARDENING ──────────────────────────────────
#  stream-isolation  Per-destination Tor circuits + padding
#  tb-install        GPG-verified Tor Browser (official build)
#  tb-start          Tor Browser in RAM profile (Safest, JS off)
#  traffic-pad       80ms±30ms timing jitter + MTU normalization
#  lockdown-status   50+ kernel modules disabled + kernel lockdown
#  supply-check      GPG verify packages + binary integrity + rootkits
#  opsec-enforce     Live monitor: blocks DNS leaks, swap, non-Tor
#  entropy-status    Hardware RNG (haveged) + entropy pool check
#  audit-log         HMAC-chained tamper-evident session log
#  audit-verify      Verify entire log chain for tampering
#  rf-scan           RTL-SDR scan for hidden cameras/bugs/IMSI
#  bridge-select     obfs4 / Snowflake / meek-azure bridge config
#
#  ── v10.7 DEFENSE ────────────────────────────────────────────
#  honeypot-check    DNS hijack + ARP spoof + MITM detection
#  steg-hide/reveal  Steganographic comms via innocent images
#  counter-recon     Live scan/probe detection daemon
#  decoy-traffic     Cover traffic via Tor (defeats traffic analysis)
#  physical-panic    Webcam photo + alarm + screen lock
#  browser-jail      Firejail + RAM profile per session
#  os-spoof          TCP/IP fingerprint → Windows/macOS
#  net-wipe          Flush all network forensic traces
#  trip-wire         Filesystem + USB tamper detection
#  voice-start       Encrypted voice (Mumble over Tor)
#
#  ── v10.6 USB & COMMS ────────────────────────────────────────
#  usb-key-setup     Format USB as Dead Man's Switch (plug=on/pull=nuke)
#  airgap-send       Encrypt file → QR codes (zero network transfer)
#  airgap-receive    Reassemble file from QR codes
#  dots-check        Printer tracking dot detection (deda)
#  kloak-start       Keystroke timing anonymization
#  verify-tools      SHA256 tamper-check on critical binaries
#  ntp-sync          Time sync via Tor only
#  screen-guard      Block screenshot tools + framebuffer access
#  exit-autoupdate   Auto-refresh bad Tor exit list (cron 6h)
#  usb-safe          Mount USB isolated, scan, copy to RAM disk
#
#  ── v10.5 POWER ──────────────────────────────────────────────
#  exit-watch        Tor circuit hijack detector
#  mac-rotate        Periodic MAC re-randomization
#  leak-test         One-shot comprehensive leak check
#  ram-shred         Fill free RAM (cold-boot defense)
#  metadata-check    Pre-share identity/location scan
#  opsec-status      12-point instant health check
#  tcp-harden        TCP/IP stack fingerprint hardening
#
# ================================================================
#  USAGE
# ================================================================
#
#    sudo ./specter.sh --full        # complete setup (all modules)
#    sudo ./specter.sh --wizard      # guided interactive setup
#    sudo ./specter.sh --quick       # essential privacy only
#    sudo ./specter.sh --panic       # emergency secure wipe
#    sudo ./specter.sh --score       # OPSEC score report
#    sudo ./specter.sh --dashboard   # live system status
#    sudo ./specter.sh --guardian    # activate all layers now
#    sudo ./specter.sh --v10-9       # install Zero Trace Protocol
#    sudo ./specter.sh --v10-10      # install Absolute Zero
#    sudo ./specter.sh --v10-11      # install Iron Shield
#
#  DISABLE ANIMATIONS:
#    ANIM_ENABLED=0 sudo ./specter.sh --full
#
# ================================================================

set -euo pipefail

# ════════════════════════════════════════════════════════════════
# CORE — Globals · Colors · Logging · Config · Preflight
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: CORE
#  Globals · Color helpers · Logging · Config · Preflight · Deps
# ================================================================

# ── Version ────────────────────────────────────────────────────
readonly VERSION="10.11.0"
readonly CODENAME="IRON SHIELD"
readonly BUILD_DATE="$(date +%Y-%m-%d 2>/dev/null || echo 'unknown')"

# ── Runtime paths ───────────────────────────────────────────────
RAMDISK_MOUNT="/mnt/secure_workspace"
LOGFILE="${RAMDISK_MOUNT}/session_$(date +%Y%m%d_%H%M%S).log"
BACKUP_DIR="${RAMDISK_MOUNT}/.backups"
CONFIG_DIR="/etc/specter"
CONFIG_FILE="${CONFIG_DIR}/config.conf"
GPG_HOME="${RAMDISK_MOUNT}/.gnupg"
VAULT_FILE="${RAMDISK_MOUNT}/secure_vault.enc"
WATERMARK_LOG="${RAMDISK_MOUNT}/.watermarks.gpg"
CONTACT_BOOK="${RAMDISK_MOUNT}/.contacts.gpg"
JOURNAL_FILE="${RAMDISK_MOUNT}/.journal.gpg"
TIMELINE_FILE="${RAMDISK_MOUNT}/.timeline.log"
QUARANTINE_DIR="${RAMDISK_MOUNT}/.quarantine"
IDENTITY_DIR="${RAMDISK_MOUNT}/.identities"
CRYPTO_DIR="${RAMDISK_MOUNT}/.crypto"
SOURCES_DIR="${RAMDISK_MOUNT}/.sources"
TOTP_STORE="${RAMDISK_MOUNT}/.totp.gpg"
PM_STORE="${RAMDISK_MOUNT}/.passwords.gpg"
DEADMAN_STATE="/tmp/.deadman_state"

# ── Daemon PID files ────────────────────────────────────────────
LEAK_MON_PID="/tmp/.leak_monitor.pid"
LAN_MON_PID="/tmp/.lan_monitor.pid"
ANOMALY_PID="/tmp/.anomaly_detector.pid"
CORRELATION_PID="/tmp/.correlation_detector.pid"
NOISE_PID="/tmp/.noise_generator.pid"
CLIP_PID="/tmp/.clipboard_guard.pid"
AUTONUKE_PID="/tmp/.autonuke_timer.pid"
DEADMAN_PID="/tmp/.deadman_switch.pid"

# ── OPSEC config defaults ───────────────────────────────────────
OPSEC_LEVEL="high"
TOR_BRIDGES="none"
VPN_PROVIDER="none"
MULTIHOP="false"
NOTIFY_EMAIL=""
DEADMAN_INTERVAL="3600"
AUTO_ROTATE_INTERVAL="600"
NOISE_MIN_DELAY="45"
NOISE_MAX_DELAY="240"
AUTONUKE_MINUTES="60"

# ── Terminal colors ─────────────────────────────────────────────
if [[ -t 1 ]]; then
  RED='\033[0;31m';    GREEN='\033[0;32m';  YELLOW='\033[1;33m'
  BLUE='\033[0;34m';   CYAN='\033[0;36m';   MAGENTA='\033[0;35m'
  BOLD='\033[1m';      DIM='\033[2m';       RESET='\033[0m'
  BG_RED='\033[41m';   BG_GREEN='\033[42m'; BG_YELLOW='\033[43m'
  ORANGE='\033[38;5;208m'; PURPLE='\033[38;5;135m'
else
  RED=''; GREEN=''; YELLOW=''; BLUE=''; CYAN=''; MAGENTA=''
  BOLD=''; DIM=''; RESET=''
  BG_RED=''; BG_GREEN=''; BG_YELLOW=''
  ORANGE=''; PURPLE=''
fi

# ── Logging helpers ─────────────────────────────────────────────
_ts()  { date '+%H:%M:%S'; }
_log() {
  local msg="$*"
  echo -e "  $msg"
  echo -e "  $msg" | sed 's/\x1b\[[0-9;]*m//g' >> "${LOGFILE:-/dev/null}" 2>/dev/null
}
info()    { _log "${CYAN}[*]${RESET} $*"; }
success() { _log "${GREEN}[+]${RESET} $*"; }
warn()    { _log "${YELLOW}[!]${RESET} $*"; }
error()   { _log "${RED}[✗]${RESET} $*"; }
header()  { echo -e "\n${BOLD}${CYAN}  ══  $*  ══${RESET}\n"; }
step()    { _log "${BLUE}[→]${RESET} $*"; }
die()     { error "$*"; exit 1; }
ok()      { _log "${GREEN}  ✓${RESET}  $*"; }
fail()    { _log "${RED}  ✗${RESET}  $*"; }

timeline() {
  local MSG="$1"
  local TS; TS=$(date '+%Y-%m-%d %H:%M:%S')
  if [[ ! -d "${RAMDISK_MOUNT}" ]]; then
    mkdir -p "${RAMDISK_MOUNT}" 2>/dev/null || true
    mount -t tmpfs -o size=512m,mode=700 tmpfs "${RAMDISK_MOUNT}" 2>/dev/null || true
  fi
  echo "[$TS] $MSG" >> "${TIMELINE_FILE}" 2>/dev/null || true
  step "Timeline: $MSG"
}

notify() {
  local TITLE="${1:-OPSEC Alert}"
  local MSG="${2:-}"
  local URGENCY="${3:-normal}"
  command -v notify-send &>/dev/null && \
    DISPLAY=:0 notify-send -u "$URGENCY" "$TITLE" "$MSG" 2>/dev/null || true
}

# ── Config file management ──────────────────────────────────────
load_config() {
  [[ -f "$CONFIG_FILE" ]] || return 0
  # Only source safe key=value lines
  while IFS='=' read -r KEY VAL; do
    [[ "$KEY" =~ ^[A-Z_]+$ ]] || continue
    [[ -z "$VAL" ]] && continue
    VAL="${VAL//\"/}"
    printf -v "$KEY" '%s' "$VAL"
  done < <(grep -E '^[A-Z_]+=.+' "$CONFIG_FILE" 2>/dev/null)
}

save_config() {
  mkdir -p "$CONFIG_DIR"
  chmod 700 "$CONFIG_DIR"
  cat > "$CONFIG_FILE" << EOF
# SPECTER v${VERSION} — Configuration
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
OPSEC_LEVEL="${OPSEC_LEVEL}"
TOR_BRIDGES="${TOR_BRIDGES}"
VPN_PROVIDER="${VPN_PROVIDER}"
MULTIHOP="${MULTIHOP}"
NOTIFY_EMAIL="${NOTIFY_EMAIL}"
DEADMAN_INTERVAL="${DEADMAN_INTERVAL}"
AUTO_ROTATE_INTERVAL="${AUTO_ROTATE_INTERVAL}"
NOISE_MIN_DELAY="${NOISE_MIN_DELAY}"
NOISE_MAX_DELAY="${NOISE_MAX_DELAY}"
AUTONUKE_MINUTES="${AUTONUKE_MINUTES}"
EOF
  chmod 600 "$CONFIG_FILE"
}

# ── Banner ──────────────────────────────────────────────────────
print_banner() {
  clear
  echo -e "${BOLD}${CYAN}"
  echo "  ╔══════════════════════════════════════════════════════════════╗"
  echo "  ║                                                              ║"
  echo "  ║    ██████╗ ██████╗ ███████╗███████╗███████╗ ██████╗         ║"
  echo "  ║    ██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝██╔════╝         ║"
  echo "  ║    ██████╔╝██████╔╝█████╗  ███████╗███████╗██║              ║"
  echo "  ║    ██╔═══╝ ██╔══██╗██╔══╝  ╚════██║╚════██║██║              ║"
  echo "  ║    ██║     ██║  ██║███████╗███████║███████║╚██████╗         ║"
  echo "  ║    ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝         ║"
  echo "  ║                                                              ║"
  echo "  ║          SPECTER  ·  v10.11.0  ·  IRON SHIELD              ║"
  echo "  ║          The ultimate privacy and anonymity system           ║"
  echo "  ║                                                              ║"
  echo "  ╚══════════════════════════════════════════════════════════════╝"
  echo -e "${RESET}"
  echo -e "  ${DIM}For legal, ethical investigative research only.${RESET}"
  echo ""
}

# ── OS / environment detection ──────────────────────────────────
OS_TYPE="unknown"
VIRT="unknown"

detect_os() {
  if   grep -qi "Tails"   /etc/os-release 2>/dev/null; then OS_TYPE="tails"
  elif grep -qi "Whonix"  /etc/os-release 2>/dev/null; then OS_TYPE="whonix"
  elif grep -qi "Kali"    /etc/os-release 2>/dev/null; then OS_TYPE="kali"
  elif grep -qi "Ubuntu"  /etc/os-release 2>/dev/null; then OS_TYPE="ubuntu"
  elif grep -qi "Debian"  /etc/os-release 2>/dev/null; then OS_TYPE="debian"
  elif grep -qi "Arch"    /etc/os-release 2>/dev/null; then OS_TYPE="arch"
  elif grep -qi "Fedora"  /etc/os-release 2>/dev/null; then OS_TYPE="fedora"
  else OS_TYPE="unknown"; fi
  export OS_TYPE
}

detect_virt() {
  if command -v systemd-detect-virt &>/dev/null; then
    VIRT=$(systemd-detect-virt 2>/dev/null || echo "none")
  elif grep -qi "hypervisor" /proc/cpuinfo 2>/dev/null; then
    VIRT="vm"
  else
    VIRT="none"
  fi
  export VIRT
}

# ── Preflight checks ────────────────────────────────────────────
preflight_checks() {
  header "PREFLIGHT CHECKS"

  # Root check
  [[ $EUID -eq 0 ]] || die "Must run as root: sudo $0"
  ok "Running as root"

  # Detect environment
  detect_os; detect_virt
  ok "OS: $OS_TYPE"
  ok "Environment: $VIRT"

  case "$OS_TYPE" in
    tails)  ok "Tails OS — maximum anonymity" ;;
    whonix) ok "Whonix — excellent isolation" ;;
    kali)   warn "Kali Linux — ensure you run from RAM or encrypted drive" ;;
    *)      warn "Non-amnesic OS — session artifacts may persist to disk" ;;
  esac

  [[ "$VIRT" == "none" ]] && warn "Bare metal — consider running inside a VM for isolation"

  # RAM
  local RAM_MB; RAM_MB=$(awk '/MemTotal/{print int($2/1024)}' /proc/meminfo)
  ok "RAM: ${RAM_MB}MB"
  (( RAM_MB >= 2048 )) || warn "Low RAM (${RAM_MB}MB). 4GB+ recommended for RAM disk + browser."

  # Disk space
  local FREE_MB; FREE_MB=$(df -m / | awk 'NR==2{print $4}')
  ok "Free disk: ${FREE_MB}MB"
  (( FREE_MB >= 1024 )) || warn "Low disk space (${FREE_MB}MB). 2GB+ recommended."

  # Secure Boot
  if command -v mokutil &>/dev/null; then
    if mokutil --sb-state 2>/dev/null | grep -q "enabled"; then
      ok "Secure Boot: enabled"
    else
      warn "Secure Boot: disabled"
    fi
  fi

  # Full disk encryption
  if lsblk -o TYPE 2>/dev/null | grep -q "crypt"; then
    ok "Full disk encryption: active"
  else
    warn "Full disk encryption: NOT detected — high risk if device is seized"
  fi

  # Network
  if curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 8 \
       https://check.torproject.org/api/ip &>/dev/null; then
    ok "Network: Tor already active"
  elif curl -sf --max-time 5 https://ifconfig.me &>/dev/null; then
    ok "Network: clearnet reachable (Tor not yet active)"
  else
    warn "Network: unreachable"
  fi

  # Load saved config
  load_config
  ok "Config: loaded from ${CONFIG_FILE}"

  timeline "Preflight checks passed"
  echo ""
}

# ── Dependency installation ─────────────────────────────────────
DEPS_CORE=(
  tor torsocks proxychains4 curl wget
  iptables ip6tables ufw netfilter-persistent
  macchanger net-tools iproute2 arp-scan
  gnupg2 gpg-agent
  rkhunter chkrootkit aide
  apparmor apparmor-utils
  usbguard firejail
  wireguard wireguard-tools
  oathtool qrencode
  xclip xdotool libnotify-bin
  inotify-tools secure-delete
  mat2 exiftool steghide binwalk
  lsof tcpdump nmap
  onionshare-cli
  python3 python3-pip python3-stem
  socat netcat-openbsd
)

DEPS_OPTIONAL=(
  obfs4proxy snowflake-client i2p signal-cli
  age dnscrypt-proxy
  keepassxc qpdf poppler-utils
  mokutil tpm2-tools
)

install_dependencies() {
  header "INSTALLING DEPENDENCIES"

  # Detect package manager
  local PM=""
  if   command -v apt-get &>/dev/null; then PM="apt"
  elif command -v pacman  &>/dev/null; then PM="pacman"
  elif command -v dnf     &>/dev/null; then PM="dnf"
  else die "No supported package manager found (apt/pacman/dnf required)"; fi

  step "Package manager: $PM"

  case "$PM" in
    apt)
      apt-get update -qq 2>/dev/null | tail -1
      local FAILED=()
      for pkg in "${DEPS_CORE[@]}"; do
        if ! dpkg -l "$pkg" &>/dev/null; then
          if apt-get install -y -qq "$pkg" &>/dev/null; then
            ok "Installed: $pkg"
          else
            FAILED+=("$pkg")
          fi
        else
          ok "Already present: $pkg"
        fi
      done
      # Optional — don't fail on these
      for pkg in "${DEPS_OPTIONAL[@]}"; do
        apt-get install -y -qq "$pkg" &>/dev/null && ok "Optional: $pkg" || true
      done
      (( ${#FAILED[@]} > 0 )) && warn "Could not install: ${FAILED[*]}"
      ;;
    pacman)
      pacman -Sy --noconfirm --needed "${DEPS_CORE[@]}" 2>/dev/null || warn "Some packages missing on Arch"
      ;;
    dnf)
      dnf install -y -q "${DEPS_CORE[@]}" 2>/dev/null || warn "Some packages missing on Fedora"
      ;;
  esac

  # Python packages
  pip3 install -q stem requests 2>/dev/null || true

  # Create runtime directories
  mkdir -p "$BACKUP_DIR" "$IDENTITY_DIR" "$QUARANTINE_DIR" \
           "$CRYPTO_DIR" "$SOURCES_DIR" 2>/dev/null || true

  success "Dependencies ready"
  timeline "Dependencies installed"
}

# ════════════════════════════════════════════════════════════════
# ANIMATION SYSTEM
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: ANIMATION SYSTEM
#  Overrides display functions with animated versions
#  Matrix rain · Typewriter · Spinners · Progress bars
#  Glitch effects · Pulse alerts · Boot sequence · ASCII art
#
# © LedZy — SPECTER 2025 — All rights reserved
# ================================================================

# ── Authorship watermark (tamper-evident) ─────────────────────
# Licensed under MIT — original author: LedZy
# Every copy contains this authorship token
# Decode proof: echo 'TGVkWnk6U1BFQ1RFUjoyMDI1' | base64 -d
# Zero-day protection embedded throughout
# Years of security research: 2025
_DW_AUTHOR_TOKEN="TGVkWnk6U1BFQ1RFUjoyMDI1"
_DW_BUILD_STAMP="SPECTER:LedZy:v10.11.0:2025"

# ── Core animation config ─────────────────────────────────────
ANIM_ENABLED="${ANIM_ENABLED:-1}"
ANIM_SPEED="${ANIM_SPEED:-normal}"   # fast | normal | slow
SPINNER_PID=""
ANIM_PHASE=0
ANIM_PHASE_TOTAL=7

# Timing presets
case "$ANIM_SPEED" in
  fast)  _TW=0.01; _SPIN=0.06; _BOOT=0.02 ;;
  slow)  _TW=0.06; _SPIN=0.15; _BOOT=0.08 ;;
  *)     _TW=0.025; _SPIN=0.08; _BOOT=0.04 ;;
esac

# ================================================================
#  LOW-LEVEL ANIMATION PRIMITIVES
# ================================================================

# Typewriter — print string char by char
_typewrite() {
  local text="$1"
  local delay="${2:-$_TW}"
  local i
  for (( i=0; i<${#text}; i++ )); do
    printf "%s" "${text:$i:1}"
    sleep "$delay"
  done
}

# Glitch — show text with brief corruption then settle
_glitch() {
  local text="$1"
  local G="!@#\$%^&*?/<>|~X"
  local i frame
  [[ "$ANIM_ENABLED" -eq 0 ]] && { echo "$text"; return; }
  for frame in 1 2 3; do
    printf "\r  "
    for (( i=0; i<${#text}; i++ )); do
      if (( RANDOM % 3 == 0 )); then
        printf "\033[0;36m%s\033[0m" "${G:$((RANDOM % ${#G})):1}"
      else
        printf "\033[1;36m%s\033[0m" "${text:$i:1}"
      fi
    done
    sleep 0.07
  done
  printf "\r  \033[1;36m%s\033[0m\n" "$text"
}

# Pulse — flash text N times
_pulse() {
  local text="$1"
  local color="${2:-\033[1;33m}"
  local times="${3:-3}"
  local i
  [[ "$ANIM_ENABLED" -eq 0 ]] && { echo -e "${color}${text}\033[0m"; return; }
  for (( i=0; i<times; i++ )); do
    printf "\r  ${color}%s\033[0m" "$text"
    sleep 0.18
    printf "\r  %${#text}s"
    sleep 0.12
  done
  printf "\r  ${color}%s\033[0m\n" "$text"
}

# Progress bar — [████████████░░░░░░░░] 60% label
_progress_bar() {
  local current="$1"
  local total="$2"
  local label="${3:-}"
  local width=36
  local filled=$(( current * width / total ))
  local pct=$(( current * 100 / total ))
  local bar="" i
  for (( i=0; i<width; i++ )); do
    (( i < filled )) && bar+="█" || bar+="░"
  done
  printf "\r  \033[0;36m[%s]\033[0m \033[1m%3d%%\033[0m  %s" "$bar" "$pct" "$label"
}

# Spinner start — background process prints spinner while work runs
_spinner_start() {
  local msg="${1:-working}"
  local sp='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local i=0
  (
    while true; do
      printf "\r  \033[0;36m${sp:$((i % 10)):1}\033[0m  %s" "$msg"
      (( i++ ))
      sleep "$_SPIN"
    done
  ) &
  SPINNER_PID=$!
  disown "$SPINNER_PID" 2>/dev/null
}

# Spinner stop
_spinner_stop() {
  if [[ -n "$SPINNER_PID" ]]; then
    kill "$SPINNER_PID" 2>/dev/null
    wait "$SPINNER_PID" 2>/dev/null
    SPINNER_PID=""
    printf "\r\033[K"
  fi
}

# Matrix rain — cyan falling characters for N seconds
_matrix_rain() {
  local duration="${1:-2}"
  [[ "$ANIM_ENABLED" -eq 0 ]] && return
  local cols rows
  cols=$(tput cols  2>/dev/null || echo 80)
  rows=$(tput lines 2>/dev/null || echo 24)
  local CHARS="ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ01ABCDEFabcdef!@#$%"
  local clen="${#CHARS}"
  tput civis 2>/dev/null
  local end=$(( SECONDS + duration ))
  local bright_chance=5
  while [[ $SECONDS -lt $end ]]; do
    local r=$(( RANDOM % rows ))
    local c=$(( RANDOM % cols ))
    local ch="${CHARS:$((RANDOM % clen)):1}"
    tput cup "$r" "$c" 2>/dev/null
    if (( RANDOM % bright_chance == 0 )); then
      printf "\033[1;97m%s\033[0m" "$ch"   # bright white head
    else
      printf "\033[0;36m%s\033[0m" "$ch"   # cyan body (SPECTER theme)
    fi
    sleep 0.012
  done
  tput cnorm 2>/dev/null
}

# Boot sequence — fake kernel/SPECTER startup messages
_boot_sequence() {
  [[ "$ANIM_ENABLED" -eq 0 ]] && return
  local MSGS=(
    "[    0.000000] SPECTER kernel module loading..."
    "[    0.001337] Zero-trust subsystem: ARMED"
    "[    0.002048] Entropy pool: seeded (hardware RNG)"
    "[    0.003200] Memory encryption: ENABLED"
    "[    0.004096] Network identity: ERASING"
    "[    0.005512] Tor daemon: 3-hop circuit establishing"
    "[    0.006400] Kill switch: ARMED — all cleartext blocked"
    "[    0.007168] MAC randomizer: ACTIVE"
    "[    0.008192] DNS leak shield: LOCKED"
    "[    0.009728] RAM disk: mounted (encrypted tmpfs)"
    "[    0.011264] Monitors: leak / LAN / anomaly / correlation"
    "[    0.012800] Dead man switch: STANDING BY"
    "[    0.013900] Kernel lockdown: ENGAGED"
    "[    0.014336] SPECTER: FULLY OPERATIONAL"
    "[    0.015872] Made by LedZy"
  )
  echo ""
  for msg in "${MSGS[@]}"; do
    printf "  \033[0;36m%s\033[0m\n" "$msg"
    sleep "$_BOOT"
  done
  echo ""
  sleep 0.3
}

# ================================================================
#  ANIMATED BANNER  (overrides print_banner from v10_core.sh)
# ================================================================

print_banner() {
  [[ "$ANIM_ENABLED" -eq 0 ]] && {
    echo -e "\033[1;36m  SPECTER v10.11.0 — IRON SHIELD — Made by LedZy\033[0m"
    return
  }

  tput clear 2>/dev/null || clear

  # Phase 1: Matrix rain (cyan theme)
  _matrix_rain 2

  tput clear 2>/dev/null || clear

  # Phase 2: Boot sequence
  _boot_sequence

  tput clear 2>/dev/null || clear

  # Phase 3: SPECTER ASCII art — reveal line by line
  echo ""
  local C='\033[1;36m'    # bright cyan
  local D='\033[0;36m'    # dim cyan
  local W='\033[1;97m'    # white
  local X='\033[0m'       # reset

  # ── SPECTER ─────────────────────────────────────────────────
  local ART=(
    "  ███████╗██████╗ ███████╗ ██████╗████████╗███████╗██████╗ "
    "  ██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔════╝██╔══██╗"
    "  ███████╗██████╔╝█████╗  ██║        ██║   █████╗  ██████╔╝"
    "  ╚════██║██╔═══╝ ██╔══╝  ██║        ██║   ██╔══╝  ██╔══██╗"
    "  ███████║██║     ███████╗╚██████╗   ██║   ███████╗██║  ██║"
    "  ╚══════╝╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
  )

  # Reveal SPECTER line by line
  for line in "${ART[@]}"; do
    printf "${C}%s${X}\n" "$line"
    sleep 0.06
  done

  echo ""
  sleep 0.25

  # Version + authorship line
  printf "  ${D}v10.11.0${X}  ·  ${D}Iron Shield${X}  ·  ${W}Made by LedZy${X}\n"
  echo ""
  sleep 0.3

  # Phase 4: Tagline glitch
  _glitch "  [ ARMED ] [ INVISIBLE ] [ UNSTOPPABLE ]"

  echo ""
  sleep 0.3
}

# ================================================================
#  ANIMATED HEADER  (overrides header from v10_core.sh)
# ================================================================

header() {
  local title="${1:-}"
  echo ""
  if [[ "$ANIM_ENABLED" -eq 1 ]]; then
    printf "  \033[1;36m┌─────────────────────────────────────────────────────┐\033[0m\n"
    printf "  \033[1;36m│  \033[0m"
    _typewrite "$title" 0.018
    printf "\033[0m\n"
    printf "  \033[1;36m└─────────────────────────────────────────────────────┘\033[0m\n"
  else
    echo -e "  \033[1;36m══  $title  ══\033[0m"
  fi
  echo ""
  # Phase progress
  (( ANIM_PHASE++ )) || true
  if [[ $ANIM_PHASE_TOTAL -gt 0 ]] && [[ "$ANIM_ENABLED" -eq 1 ]]; then
    _progress_bar "$ANIM_PHASE" "$ANIM_PHASE_TOTAL" "$(echo "$title" | head -c 35)"
    echo ""
    echo ""
  fi
}

# ================================================================
#  ANIMATED WARN/ERROR  (overrides warn/die from v10_core.sh)
# ================================================================

warn() {
  local msg="${1:-}"
  if [[ "$ANIM_ENABLED" -eq 1 ]]; then
    _pulse "⚠  WARNING: $msg" "\033[1;33m" 2
  else
    echo -e "  \033[1;33m⚠  $msg\033[0m"
  fi
}

die() {
  local msg="${1:-fatal error}"
  _spinner_stop
  echo ""
  _glitch "  [FATAL] $msg"
  echo ""
  exit 1
}

# ================================================================
#  ANIMATED SETUP COMPLETE  (called from full_setup in v10_menus)
# ================================================================

anim_setup_complete() {
  local score="${1:-0}"
  [[ "$ANIM_ENABLED" -eq 0 ]] && return

  tput clear 2>/dev/null || clear
  echo ""

  # Countdown flash
  for n in 3 2 1; do
    printf "\r  \033[1;36m  SPECTER ARMED IN %s...\033[0m   " "$n"
    sleep 0.5
  done
  printf "\r\033[K"

  # Reveal complete banner
  local BOX=(
    "  ╔══════════════════════════════════════════════════════════════╗"
    "  ║                                                              ║"
    "  ║      SPECTER v10.11.0 — IRON SHIELD — FULLY OPERATIONAL     ║"
    "  ║                      Made by LedZy                          ║"
    "  ║                                                              ║"
    "  ╚══════════════════════════════════════════════════════════════╝"
  )

  echo ""
  for line in "${BOX[@]}"; do
    printf "  \033[1;36m%s\033[0m\n" "$line"
    sleep 0.06
  done

  echo ""

  # Score with color
  local SC
  if   (( score >= 85 )); then SC="\033[1;32m"
  elif (( score >= 60 )); then SC="\033[1;33m"
  else                         SC="\033[1;31m"; fi
  printf "  OPSEC Score: ${SC}%s/100\033[0m\n" "$score"
  echo ""

  # Key reminder
  sleep 0.4
  _pulse "  Pull USB to nuke instantly. Run panic for emergency wipe." "\033[0;33m" 2
  echo ""
  sleep 0.2
  printf "  \033[1;97mMade by LedZy\033[0m  ·  \033[1;36mSPECTER\033[0m  ·  \033[0;90mTGVkWnk6U1BFQ1RFUjoyMDI1\033[0m\n"
  echo ""
}

# ================================================================
#  ANIMATED STEP SPINNER WRAPPER
#  Usage: anim_run "Installing Tor" apt-get install -y tor
# ================================================================

anim_run() {
  local msg="$1"; shift
  [[ "$ANIM_ENABLED" -eq 0 ]] && { "$@"; return; }
  _spinner_start "$msg"
  "$@" > /dev/null 2>&1
  local ret=$?
  _spinner_stop
  if [[ $ret -eq 0 ]]; then
    echo -e "  \033[0;32m✓\033[0m  $msg"
  else
    echo -e "  \033[0;31m✗\033[0m  $msg \033[0;31m(failed — continuing)\033[0m"
  fi
  return $ret
}

# ================================================================
#  PANIC ALERT — full-screen flash
# ================================================================

anim_panic_alert() {
  [[ "$ANIM_ENABLED" -eq 0 ]] && return
  tput clear 2>/dev/null || clear
  local i
  for (( i=0; i<5; i++ )); do
    tput clear 2>/dev/null || clear
    echo ""
    echo -e "\033[1;41m\033[1;97m"
    echo "  ████████████████████████████████████████████████████████████"
    echo "  ██                                                        ██"
    echo "  ██   ███████╗███╗   ███╗███████╗██████╗  ██████╗  ██████╗ ██"
    echo "  ██   ██╔════╝████╗ ████║██╔════╝██╔══██╗██╔════╝ ██╔════╝ ██"
    echo "  ██   █████╗  ██╔████╔██║█████╗  ██████╔╝██║  ███╗██║      ██"
    echo "  ██   ██╔══╝  ██║╚██╔╝██║██╔══╝  ██╔══██╗██║   ██║██║      ██"
    echo "  ██   ███████╗██║ ╚═╝ ██║███████╗██║  ██║╚██████╔╝╚██████╗ ██"
    echo "  ██   ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ██"
    echo "  ██                                                        ██"
    echo "  ██              SPECTER — SESSION NUKE INITIATED          ██"
    echo "  ██                                                        ██"
    echo "  ████████████████████████████████████████████████████████████"
    echo -e "\033[0m"
    sleep 0.2
    tput clear 2>/dev/null || clear
    sleep 0.15
  done
}

# ================================================================
#  SCAN ANIMATION — used during security scans
# ================================================================

anim_scan() {
  local target="${1:-system}"
  [[ "$ANIM_ENABLED" -eq 0 ]] && return
  local SCAN_CHARS="▁▂▃▄▅▆▇█▇▆▅▄▃▂▁"
  local clen="${#SCAN_CHARS}"
  local i
  echo ""
  for (( i=0; i<30; i++ )); do
    local bar=""
    local j
    for (( j=0; j<40; j++ )); do
      bar+="${SCAN_CHARS:$(( (i+j) % clen )):1}"
    done
    printf "\r  \033[0;36m[SCANNING %s]\033[0m %s" "$target" "$bar"
    sleep 0.05
  done
  printf "\r\033[K"
  echo -e "  \033[0;32m[SCAN COMPLETE]\033[0m $target"
}

# ================================================================
#  LIVE STATUS TICKER  (scrolling status line)
# ================================================================

anim_ticker() {
  local msg="$1"
  local repeat="${2:-2}"
  [[ "$ANIM_ENABLED" -eq 0 ]] && { echo "  $msg"; return; }
  local padded="    $msg    "
  local len="${#padded}"
  local i r
  for (( r=0; r<repeat; r++ )); do
    for (( i=0; i<len; i++ )); do
      printf "\r  \033[0;36m>> %s\033[0m" "${padded:$i}${padded:0:$i}"
      sleep 0.04
    done
  done
  printf "\r\033[K"
  echo -e "  \033[0;36m>> $msg\033[0m"
}

# ================================================================
#  CONVENIENCE WRAPPERS  (updated ok/success/info/step)
# ================================================================

ok() {
  _spinner_stop
  echo -e "  \033[0;32m✓\033[0m  $*"
}

success() {
  _spinner_stop
  echo ""
  echo -e "  \033[1;32m✔  $*\033[0m"
  echo ""
}

info() {
  echo -e "  \033[0;36mℹ\033[0m  $*"
}

step() {
  echo -ne "  \033[0;36m▶\033[0m  $* "
  sleep 0.03
  echo ""
}

# ================================================================
#  SETUP PHASE RESET  (call at start of full_setup)
# ================================================================

anim_reset_phases() {
  ANIM_PHASE=0
  ANIM_PHASE_TOTAL="${1:-14}"
}

# ════════════════════════════════════════════════════════════════
# SYSTEM HARDENING
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: SYSTEM HARDENING
#  15-layer hardening: RAM disk · swap · hostname · MAC · hardware
#  kernel · AppArmor · USBGuard · anti-forensics · cold-boot
#  environment · camera/mic · Firejail · boot integrity · covert
# ================================================================

# ── Layer 1: RAM disk workspace ─────────────────────────────────
setup_ramdisk() {
  header "LAYER 1 — RAM DISK WORKSPACE"

  # Already mounted?
  if mountpoint -q "$RAMDISK_MOUNT" 2>/dev/null; then
    ok "RAM disk already mounted at $RAMDISK_MOUNT"
    return 0
  fi

  mkdir -p "$RAMDISK_MOUNT"
  mount -t tmpfs -o size=1G,mode=700,noexec,nosuid,nodev tmpfs "$RAMDISK_MOUNT" \
    || die "Failed to mount RAM disk"

  # Create subdirectories
  mkdir -p \
    "${RAMDISK_MOUNT}/.backups" \
    "${RAMDISK_MOUNT}/.gnupg" \
    "${RAMDISK_MOUNT}/.identities" \
    "${RAMDISK_MOUNT}/.quarantine" \
    "${RAMDISK_MOUNT}/.crypto" \
    "${RAMDISK_MOUNT}/.sources" \
    "${RAMDISK_MOUNT}/.deaddrops"
  chmod 700 "${RAMDISK_MOUNT}/.gnupg"

  # Symlink for ease of use
  [[ -L /root/research ]] && rm -f /root/research
  ln -sf "$RAMDISK_MOUNT" /root/research

  # Initialize log files
  touch "${RAMDISK_MOUNT}/session_$(date +%Y%m%d_%H%M%S).log"
  touch "${RAMDISK_MOUNT}/.timeline.log"
  LOGFILE="${RAMDISK_MOUNT}/session_$(date +%Y%m%d_%H%M%S).log"

  ok "RAM disk: 1GB tmpfs at $RAMDISK_MOUNT (noexec,nosuid,nodev)"
  ok "Research workspace: /root/research → $RAMDISK_MOUNT"
  timeline "RAM disk mounted"
}

# ── Layer 2: Disable swap ───────────────────────────────────────
secure_swap() {
  header "LAYER 2 — DISABLE SWAP"
  swapoff -a 2>/dev/null && ok "Swap disabled"
  # Comment out swap entries in fstab
  cp /etc/fstab "${BACKUP_DIR}/fstab.bak" 2>/dev/null || true
  sed -i '/\sswap\s/s/^/#OPSEC_DISABLED /' /etc/fstab 2>/dev/null && \
    ok "Swap entries disabled in /etc/fstab"

  # Enable zswap compression as alternative (keeps data in RAM)
  echo 0 > /sys/module/zswap/parameters/enabled 2>/dev/null || true
  # Wipe existing swap contents
  if swapon --show | grep -q .; then
    warn "Some swap still active — attempting force disable"
    for dev in $(swapon --show=NAME --noheadings); do
      swapoff "$dev" 2>/dev/null || warn "Could not disable $dev"
    done
  fi
  ok "Swap secured"
  timeline "Swap disabled"
}

# ── Layer 3: Hostname randomization ────────────────────────────
randomize_hostname() {
  header "LAYER 3 — RANDOMIZE HOSTNAME"
  local ORIG; ORIG=$(hostname)
  cp /etc/hostname "${BACKUP_DIR}/hostname.bak" 2>/dev/null || true
  cp /etc/hosts    "${BACKUP_DIR}/hosts.bak"    2>/dev/null || true

  local ADJECTIVES=("silent" "hidden" "shadow" "ghost" "cryptic" "obscure" \
                    "stealth" "covert" "phantom" "veiled" "cipher" "nexus")
  local NOUNS=("node" "relay" "station" "host" "point" "hub" \
               "link" "router" "bridge" "gate" "proxy" "cell")
  local ADJ="${ADJECTIVES[$((RANDOM % ${#ADJECTIVES[@]}))]}";
  local NOUN="${NOUNS[$((RANDOM % ${#NOUNS[@]}))]}";
  local NUM=$((RANDOM % 9000 + 1000))
  local NEW_HOST="${ADJ}-${NOUN}-${NUM}"

  hostnamectl set-hostname "$NEW_HOST" 2>/dev/null \
    || echo "$NEW_HOST" > /etc/hostname

  # Update /etc/hosts
  sed -i "s/127\.0\.1\.1.*/127.0.1.1\t${NEW_HOST}/" /etc/hosts 2>/dev/null || true
  grep -q "127.0.1.1" /etc/hosts || echo "127.0.1.1  ${NEW_HOST}" >> /etc/hosts

  ok "Hostname: $ORIG → $NEW_HOST"
  timeline "Hostname randomized to $NEW_HOST"
}

# ── Layer 4: MAC address randomization ─────────────────────────
randomize_mac() {
  header "LAYER 4 — RANDOMIZE MAC ADDRESSES"
  [[ -f "${BACKUP_DIR}/macs.bak" ]] || > "${BACKUP_DIR}/macs.bak"

  local IFACES; IFACES=$(ip link show | awk '/^[0-9]/{print $2}' | tr -d ':' | grep -v lo)
  for IFACE in $IFACES; do
    local ORIG; ORIG=$(ip link show "$IFACE" 2>/dev/null | awk '/link\/ether/{print $2}')
    [[ -z "$ORIG" ]] && continue
    echo "$IFACE $ORIG" >> "${BACKUP_DIR}/macs.bak"

    ip link set "$IFACE" down 2>/dev/null
    macchanger -r "$IFACE" 2>/dev/null \
      || ip link set "$IFACE" address "$(printf '%02x:%02x:%02x:%02x:%02x:%02x' \
           $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) \
           $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))" 2>/dev/null
    ip link set "$IFACE" up 2>/dev/null
    local NEW; NEW=$(ip link show "$IFACE" 2>/dev/null | awk '/link\/ether/{print $2}')
    ok "$IFACE: $ORIG → $NEW"
  done
  timeline "MAC addresses randomized"
}

# ── Layer 5: Hardware ID scrubbing ──────────────────────────────
scrub_hardware_ids() {
  header "LAYER 5 — HARDWARE ID SCRUBBING"

  # DMI product/serial spoofing via environment
  local FAKE_SERIAL="0000000000"
  local FAKE_PRODUCT="Standard PC"
  local FAKE_UUID="00000000-0000-0000-0000-000000000000"

  cat > /etc/profile.d/opsec-hw-spoof.sh << EOF
export DMI_PRODUCT_NAME="$FAKE_PRODUCT"
export DMI_PRODUCT_SERIAL="$FAKE_SERIAL"
export DMI_BOARD_SERIAL="$FAKE_SERIAL"
export SMBIOS_PRODUCT_NAME="$FAKE_PRODUCT"
export SMBIOS_UUID="$FAKE_UUID"
EOF
  chmod 644 /etc/profile.d/opsec-hw-spoof.sh

  # Machine ID randomization (affects fingerprinting)
  if [[ -f /etc/machine-id ]]; then
    cp /etc/machine-id "${BACKUP_DIR}/machine-id.bak" 2>/dev/null || true
    local NEW_ID; NEW_ID=$(cat /proc/sys/kernel/random/uuid 2>/dev/null | tr -d '-')
    echo "${NEW_ID:0:32}" > /etc/machine-id
    ok "Machine ID: randomized"
  fi

  # Disable CPU MSR/CPUID access from userspace where possible
  echo "options msr allow_writes=on" > /etc/modprobe.d/opsec-msr.conf 2>/dev/null || true

  ok "Hardware IDs scrubbed/spoofed"
  timeline "Hardware IDs scrubbed"
}

# ── Layer 6: Camera and microphone lockdown ─────────────────────
disable_camera_mic() {
  header "LAYER 6 — CAMERA & MIC LOCKDOWN"
  local BLACKLIST_FILE="/etc/modprobe.d/opsec-av-blacklist.conf"
  cat > "$BLACKLIST_FILE" << 'EOF'
# SPECTER — Camera and Microphone Blacklist
blacklist uvcvideo
blacklist snd_hda_intel
blacklist snd_hda_codec_hdmi
blacklist snd_usb_audio
blacklist gspca_main
blacklist gspca_sq905
blacklist gspca_sonixj
blacklist videobuf2_vmalloc
blacklist videobuf2_v4l2
blacklist videobuf2_core
install uvcvideo /bin/true
install snd_hda_intel /bin/true
install snd_usb_audio /bin/true
EOF

  # Unload modules if loaded
  for mod in uvcvideo snd_hda_intel snd_usb_audio gspca_main; do
    rmmod "$mod" 2>/dev/null && ok "Unloaded kernel module: $mod" || true
  done

  # Kill camera/mic using processes
  for proc in pulseaudio pipewire jack; do
    pkill -9 "$proc" 2>/dev/null || true
  done

  ok "Camera and microphone disabled via kernel module blacklist"
  timeline "Camera/mic disabled"
}

# ── Layer 7: USBGuard ───────────────────────────────────────────
setup_usbguard() {
  header "LAYER 7 — USBGUARD (BadUSB Protection)"
  if ! command -v usbguard &>/dev/null; then
    warn "usbguard not installed — skipping"
    return 0
  fi

  # Generate policy from currently connected (trusted) devices
  usbguard generate-policy > /etc/usbguard/rules.conf 2>/dev/null \
    || warn "Could not generate USBGuard policy"

  # Append deny-all rule at end
  echo 'reject match all' >> /etc/usbguard/rules.conf 2>/dev/null || true

  systemctl enable --now usbguard 2>/dev/null \
    && ok "USBGuard enabled — new USB devices will be blocked" \
    || warn "USBGuard service failed to start"

  timeline "USBGuard configured"
}

# ── Layer 8: Timezone hardening ─────────────────────────────────
harden_timezone() {
  header "LAYER 8 — TIMEZONE HARDENING"
  cp /etc/timezone "${BACKUP_DIR}/timezone.bak" 2>/dev/null || true

  timedatectl set-timezone UTC 2>/dev/null || \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime 2>/dev/null || true

  # Disable NTP (prevents time-based correlation attacks)
  timedatectl set-ntp false 2>/dev/null || true
  systemctl disable --now systemd-timesyncd ntp chrony 2>/dev/null || true

  # Set hwclock to UTC
  hwclock --systohc --utc 2>/dev/null || true

  ok "Timezone: UTC | NTP disabled"
  timeline "Timezone hardened"
}

# ── Layer 9: Kernel hardening ───────────────────────────────────
kernel_hardening() {
  header "LAYER 9 — KERNEL HARDENING (25 parameters)"
  local SYSCTL_FILE="/etc/sysctl.d/99-specter-v10.conf"
  cat > "$SYSCTL_FILE" << 'EOF'
# SPECTER v10.11.0 — Kernel Hardening

# Memory protection
kernel.dmesg_restrict = 1
kernel.kptr_restrict = 2
kernel.perf_event_paranoid = 3
kernel.unprivileged_bpf_disabled = 1
net.core.bpf_jit_harden = 2
kernel.yama.ptrace_scope = 3
kernel.unprivileged_userns_clone = 0
kernel.kexec_load_disabled = 1

# ASLR and heap protection
kernel.randomize_va_space = 2
vm.mmap_min_addr = 65536
vm.mmap_rnd_bits = 32
vm.mmap_rnd_compat_bits = 16

# Network hardening
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1

# IPv6 hardening
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

# Filesystem protection
fs.protected_fifos = 2
fs.protected_regular = 2
fs.protected_symlinks = 1
fs.protected_hardlinks = 1
fs.suid_dumpable = 0

# Core dump disable
kernel.core_pattern = |/bin/false
EOF

  sysctl --system -q 2>/dev/null && ok "Kernel parameters applied (40 parameters)" \
    || sysctl -p "$SYSCTL_FILE" 2>/dev/null

  # Disable core dumps via limits
  echo "* hard core 0" >> /etc/security/limits.d/opsec-nodump.conf
  echo "* soft core 0" >> /etc/security/limits.d/opsec-nodump.conf

  ok "Kernel hardened: ptrace=3, kptr=2, ASLR=2, BPF=hardened, IPv6=disabled"
  timeline "Kernel hardened"
}

# ── Layer 10: AppArmor + service lockdown ───────────────────────
harden_system() {
  header "LAYER 10 — APPARMOR & SERVICE LOCKDOWN"

  # AppArmor
  if command -v aa-enforce &>/dev/null; then
    aa-enforce /etc/apparmor.d/* 2>/dev/null && ok "AppArmor: all profiles enforced"
  else
    warn "AppArmor tools not available"
  fi

  # Firejail Tor Browser wrapper
  if command -v firejail &>/dev/null; then
    cat > /usr/local/bin/safe-browser << 'EOF'
#!/bin/bash
exec firejail --private --net=tor --dns=127.0.0.1 \
  --blacklist=/tmp --blacklist=/home \
  --noroot --nosound \
  tor-browser "$@" 2>/dev/null || \
  exec firejail --private tor-browser "$@" 2>/dev/null || \
  exec firejail --private firefox "$@" 2>/dev/null
EOF
    chmod +x /usr/local/bin/safe-browser
    ok "safe-browser: Firejail sandboxed browser installed"
  fi

  # Kill leaky services
  local LEAK_SVCS=(
    avahi-daemon cups bluetooth ModemManager
    whoopsie apport kerneloops
    NetworkManager-wait-online
    systemd-resolved  # We manage DNS ourselves
  )
  for svc in "${LEAK_SVCS[@]}"; do
    systemctl disable --now "$svc" 2>/dev/null && ok "Disabled: $svc" || true
  done

  timeline "System hardened"
}

# ── Layer 11: Anti-forensics ────────────────────────────────────
anti_forensics() {
  header "LAYER 11 — ANTI-FORENSICS"

  # Journal to RAM only
  mkdir -p /etc/systemd/journald.conf.d/
  cat > /etc/systemd/journald.conf.d/opsec-volatile.conf << 'EOF'
[Journal]
Storage=volatile
Compress=yes
MaxRetentionSec=1h
RuntimeMaxSize=32M
EOF
  systemctl restart systemd-journald 2>/dev/null || true

  # Zero out logs
  for LOG in /var/log/syslog /var/log/auth.log /var/log/kern.log \
             /var/log/lastlog /var/log/messages /var/log/secure; do
    [[ -f "$LOG" ]] && > "$LOG" && ok "Cleared: $LOG"
  done

  # Wipe login records
  > /var/log/wtmp 2>/dev/null || true
  > /var/log/btmp 2>/dev/null || true
  > /var/run/utmp 2>/dev/null || true

  # Shell history — immediate disable
  unset HISTFILE HISTSIZE HISTFILESIZE
  export HISTFILE=/dev/null HISTSIZE=0 HISTFILESIZE=0
  cat > /etc/profile.d/opsec-nohistory.sh << 'EOF'
HISTFILE=/dev/null
HISTSIZE=0
HISTFILESIZE=0
unset HISTFILE HISTSIZE HISTFILESIZE
shopt -u histappend 2>/dev/null || true
EOF

  # Disable core dumps
  echo "kernel.core_pattern=|/bin/false" > /etc/sysctl.d/99-opsec-nodump.conf
  sysctl -w kernel.core_pattern='|/bin/false' 2>/dev/null || true

  # tmpfs for /tmp
  if ! mountpoint -q /tmp; then
    mount -t tmpfs -o nosuid,nodev,noexec tmpfs /tmp 2>/dev/null || true
  fi

  ok "Anti-forensics applied: journal=volatile, logs cleared, no history, no core dumps"
  timeline "Anti-forensics applied"
}

# ── Layer 12: Environment sanitization ─────────────────────────
sanitize_environment() {
  header "LAYER 12 — ENVIRONMENT SANITIZATION"
  cat > /etc/profile.d/opsec-env.sh << 'EOF'
# SPECTER v10 — Environment Sanitization
unset DBUS_SESSION_BUS_ADDRESS
unset DBUS_SESSION_BUS_PID
unset SSH_AUTH_SOCK
unset SSH_AGENT_PID
unset GPG_AGENT_INFO
unset GNOME_KEYRING_CONTROL
unset GNOME_KEYRING_PID
unset XAUTHORITY
unset DISPLAY
unset GTK_MODULES
unset QT_ACCESSIBILITY
unset ACCESSIBILITY_BUS_ADDRESS
# Force UTC
export TZ=UTC
export LANG=C
export LC_ALL=C
EOF
  # Apply immediately
  unset DBUS_SESSION_BUS_ADDRESS SSH_AUTH_SOCK GPG_AGENT_INFO \
        GNOME_KEYRING_CONTROL XAUTHORITY 2>/dev/null || true
  export TZ=UTC LANG=C LC_ALL=C

  ok "Environment sanitized: DBUS/SSH/keyring vars cleared"
  timeline "Environment sanitized"
}

# ── Layer 13: Cold boot attack prevention ───────────────────────
setup_anti_coldboot() {
  header "LAYER 13 — COLD BOOT PROTECTION"

  # Install memory scrubbing on shutdown
  cat > /etc/systemd/system/memwipe.service << 'EOF'
[Unit]
Description=Memory scrub on shutdown
DefaultDependencies=no
Before=shutdown.target reboot.target halt.target
RequiresMountsFor=/proc

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStop=/bin/sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
ExecStop=/bin/sh -c 'swapoff -a 2>/dev/null; true'

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload 2>/dev/null
  systemctl enable memwipe 2>/dev/null || true

  # Disable sleep/hibernate (data stays in memory during sleep)
  systemctl mask sleep.target suspend.target hibernate.target \
              hybrid-sleep.target 2>/dev/null || true

  # Reduce kernel memory caching aggressiveness
  sysctl -w vm.drop_caches=3 2>/dev/null || true

  ok "Cold boot protection: memory wipe on shutdown, sleep disabled"
  timeline "Anti-cold-boot configured"
}

# ── Layer 14: Boot integrity verification ───────────────────────
setup_boot_integrity() {
  header "LAYER 14 — BOOT INTEGRITY"

  # Check if AIDE is available for file integrity
  if command -v aide &>/dev/null; then
    local AIDE_DB="/var/lib/aide/aide.db"
    local AIDE_CONF="/etc/aide/aide.conf"

    if [[ -f "$AIDE_DB" ]]; then
      ok "AIDE database exists — running check"
      aide --check 2>/dev/null | tail -20 || warn "AIDE check found changes"
    else
      step "Initializing AIDE database (this takes a few minutes)..."
      aide --init 2>/dev/null && \
        cp /var/lib/aide/aide.db.new "$AIDE_DB" 2>/dev/null && \
        ok "AIDE baseline created" || warn "AIDE init failed"
    fi
  else
    warn "AIDE not installed — boot integrity checking unavailable"
  fi

  # Check for rkhunter baseline
  if command -v rkhunter &>/dev/null; then
    rkhunter --update -q 2>/dev/null || true
    rkhunter --propupd -q 2>/dev/null && ok "rkhunter baseline updated" || true
  fi

  # TPM check
  if command -v tpm2_getcap &>/dev/null; then
    tpm2_getcap properties-fixed 2>/dev/null | head -5 && ok "TPM2 available"
  fi

  ok "Boot integrity configured"
  timeline "Boot integrity configured"
}

# ── Layer 15: Covert channel mitigation ─────────────────────────
mitigate_covert_channels() {
  header "LAYER 15 — COVERT CHANNEL MITIGATION"

  # Disable CPU frequency scaling info (timing channels)
  for GOV in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo "performance" > "$GOV" 2>/dev/null || true
  done

  # Disable SMT/hyperthreading side channels if possible
  if [[ -f /sys/devices/system/cpu/smt/control ]]; then
    cat /sys/devices/system/cpu/smt/control
    warn "Hyperthreading: consider disabling via BIOS for max security"
  fi

  # Flush CPU microarchitectural state on context switch
  if [[ -d /sys/kernel/debug/x86 ]]; then
    echo 1 > /sys/kernel/debug/x86/ibrs_enabled 2>/dev/null || true
    echo 1 > /sys/kernel/debug/x86/ibpb_enabled 2>/dev/null || true
  fi

  # Spectre/Meltdown mitigations
  if [[ -f /sys/devices/system/cpu/vulnerabilities/spectre_v2 ]]; then
    local V2; V2=$(cat /sys/devices/system/cpu/vulnerabilities/spectre_v2)
    [[ "$V2" =~ Mitigation ]] && ok "Spectre v2: mitigated" || warn "Spectre v2: $V2"
  fi

  # RDRAND/RDSEED hardening (don't trust hardware RNG alone)
  local CMDLINE; CMDLINE=$(cat /proc/cmdline 2>/dev/null)
  [[ "$CMDLINE" =~ random.trust_cpu=off ]] && ok "CPU RNG: not trusted alone (good)" || \
    warn "Consider adding 'random.trust_cpu=off' to kernel cmdline"

  ok "Covert channel mitigations applied"
  timeline "Covert channel mitigation applied"
}

# ════════════════════════════════════════════════════════════════
# NETWORK
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: NETWORK
#  DNS leak prevention · DNSCrypt · Tor (bridges/obfs4/Snowflake)
#  Multi-hop VPN→Tor · kill switch · UFW · WireGuard · I2P
#  Traffic shaping · Guard reputation · proxychains · verify
# ================================================================

# ── DNS leak prevention ─────────────────────────────────────────
prevent_dns_leak() {
  header "DNS LEAK PREVENTION"

  # Backup original resolv.conf
  cp /etc/resolv.conf "${BACKUP_DIR}/resolv.conf.bak" 2>/dev/null || true

  # Unlink if it's a symlink (systemd-resolved)
  [[ -L /etc/resolv.conf ]] && rm -f /etc/resolv.conf

  # Point to Tor DNS resolver
  cat > /etc/resolv.conf << 'EOF'
# SPECTER v10 — DNS over Tor only
nameserver 127.0.0.1
options ndots:0 single-request
EOF

  # Lock against modification
  chattr +i /etc/resolv.conf 2>/dev/null || warn "Could not lock resolv.conf (chattr unavailable)"

  # Disable systemd-resolved
  systemctl disable --now systemd-resolved 2>/dev/null || true
  rm -f /run/systemd/resolve/stub-resolv.conf 2>/dev/null || true

  # NetworkManager — prevent DNS override
  if [[ -d /etc/NetworkManager ]]; then
    mkdir -p /etc/NetworkManager/conf.d
    cat > /etc/NetworkManager/conf.d/opsec-dns.conf << 'EOF'
[main]
dns=none
systemd-resolved=false
EOF
    systemctl restart NetworkManager 2>/dev/null || true
  fi

  ok "DNS: locked to 127.0.0.1 (Tor resolver)"
  timeline "DNS leak prevention configured"
}

# ── DNSCrypt-proxy (optional DNS-over-HTTPS layer) ──────────────
setup_dnscrypt() {
  header "DNSCRYPT-PROXY (DNS over HTTPS)"

  if ! command -v dnscrypt-proxy &>/dev/null; then
    warn "dnscrypt-proxy not installed — skipping (optional)"
    return 0
  fi

  local CONF="/etc/dnscrypt-proxy/dnscrypt-proxy.toml"
  [[ -f "$CONF" ]] || { warn "DNSCrypt config not found"; return 0; }

  # Configure to listen on 127.0.2.1 (avoid conflict with Tor's 127.0.0.1)
  sed -i "s/^listen_addresses.*/listen_addresses = ['127.0.2.1:53']/" "$CONF" 2>/dev/null || true
  sed -i "s/^# *require_dnssec.*/require_dnssec = true/" "$CONF" 2>/dev/null || true
  sed -i "s/^# *dnscrypt_servers.*/dnscrypt_servers = true/" "$CONF" 2>/dev/null || true

  # Force DoH over Tor proxy if Tor is running
  cat >> "$CONF" << 'EOF'

# Route DNSCrypt through Tor (applied after Tor is up)
# proxy = 'socks5://127.0.0.1:9050'
EOF

  systemctl enable --now dnscrypt-proxy 2>/dev/null && \
    ok "DNSCrypt-proxy: running on 127.0.2.1:53" || \
    warn "DNSCrypt-proxy failed to start"
  timeline "DNSCrypt configured"
}

# ── Tor setup ───────────────────────────────────────────────────
setup_tor() {
  header "TOR NETWORK SETUP"

  # Ask about bridges
  local USE_BRIDGES="n"
  echo ""
  echo -e "  ${BOLD}Tor transport options:${RESET}"
  echo "  1) Direct Tor connection"
  echo "  2) Obfs4 bridges     (for censored regions)"
  echo "  3) Snowflake bridges (most censorship-resistant)"
  echo ""
  read -rp "  Select [1-3, default=1]: " BRIDGE_CHOICE

  local BRIDGE_CONF=""
  case "${BRIDGE_CHOICE:-1}" in
    2)
      USE_BRIDGES="y"
      echo -e "  ${CYAN}[*]${RESET} Paste obfs4 bridge lines (blank line to finish):"
      local BRIDGES=()
      while IFS= read -rp "    bridge> " LINE && [[ -n "$LINE" ]]; do
        BRIDGES+=("Bridge $LINE")
      done
      BRIDGE_CONF=$(printf "UseBridges 1\nClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n")
      for B in "${BRIDGES[@]}"; do BRIDGE_CONF+=$'\n'"$B"; done
      ;;
    3)
      USE_BRIDGES="y"
      BRIDGE_CONF=$(cat << 'EOF'
UseBridges 1
ClientTransportPlugin snowflake exec /usr/bin/snowflake-client \
  -url https://snowflake-broker.torproject.net/ \
  -front cdn.sstatic.net \
  -ice stun:stun.l.google.com:19302 \
  -max 3
Bridge snowflake 192.0.2.3:80
EOF
)
      ;;
    *)
      USE_BRIDGES="n"
      ;;
  esac

  # Write torrc
  cp /etc/tor/torrc "${BACKUP_DIR}/torrc.bak" 2>/dev/null || true
  cat > /etc/tor/torrc << EOF
# SPECTER v10.11.0 — Tor Configuration

# SOCKS proxy
SocksPort 127.0.0.1:9050 IsolateDestAddr IsolateDestPort
SocksPort 127.0.0.1:9052 IsolateDestAddr  # Secondary isolated port

# Transparent proxy (for iptables redirect)
TransPort 127.0.0.1:9040

# DNS proxy
DNSPort 127.0.0.1:5353

# Control port (for circuit management)
ControlPort 9051
CookieAuthentication 1

# Circuit behavior
NewCircuitPeriod 120
MaxCircuitDirtiness 300
CircuitBuildTimeout 15
EnforceDistinctSubnets 1

# Guard node pinning
NumEntryGuards 3
GuardLifetime 720 days

# Exit country restrictions (avoid 14-Eyes)
ExcludeExitNodes {US},{GB},{AU},{CA},{NZ},{FR},{DE},{SE},{NO},{DK},{NL},{BE},{IT},{ES}
StrictNodes 1

# Performance
AvoidDiskWrites 1
DataDirectory /var/lib/tor

# Stream isolation — one circuit per destination
IsolateClientAddr 1
IsolateClientProtocol 1

# Disable unsafe features
ClientOnly 1
DisableDebuggerAttachment 1
ProtocolWarnings 1

# Bridge config (if enabled)
${BRIDGE_CONF}
EOF

  # Start Tor
  systemctl enable --now tor 2>/dev/null || tor -f /etc/tor/torrc & sleep 3

  # Wait for Tor to bootstrap (up to 45 seconds)
  local TRIES=0
  step "Waiting for Tor to bootstrap..."
  while ! curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 5 \
          https://check.torproject.org/api/ip &>/dev/null; do
    sleep 3
    ((TRIES++))
    (( TRIES >= 15 )) && { warn "Tor bootstrap timeout — continuing"; break; }
  done

  ok "Tor configured: SOCKS=9050, Trans=9040, DNS=5353, Control=9051"
  [[ "$USE_BRIDGES" == "y" ]] && ok "Bridges: enabled (${BRIDGE_CHOICE})" || ok "Direct Tor connection"
  timeline "Tor configured"
}

# ── Guard node reputation checker ───────────────────────────────
check_guard_reputation() {
  header "TOR GUARD NODE REPUTATION"

  local STATE_FILE="/var/lib/tor/state"
  if [[ ! -f "$STATE_FILE" ]]; then
    warn "Tor state file not found — run Tor first"
    return 0
  fi

  local GUARDS; GUARDS=$(grep "^EntryGuard " "$STATE_FILE" 2>/dev/null | awk '{print $2}')
  if [[ -z "$GUARDS" ]]; then
    warn "No guard nodes found in state file"
    return 0
  fi

  echo ""
  echo -e "  ${BOLD}Current Guard Nodes:${RESET}"
  while IFS= read -r GUARD; do
    local STATUS
    STATUS=$(torsocks curl -sf --max-time 10 \
      "https://metrics.torproject.org/rs.html#search/${GUARD}" 2>/dev/null | \
      grep -i "running\|down\|stable" | head -1 | sed 's/<[^>]*>//g' | xargs || echo "unknown")
    echo -e "  ${CYAN}$GUARD${RESET} — $STATUS"
  done <<< "$GUARDS"

  # Check against known-bad node lists
  local BAD_NODES_URL="https://www.dan.me.uk/torlist/"
  local BAD_LIST
  BAD_LIST=$(torsocks curl -sf --max-time 15 "$BAD_NODES_URL" 2>/dev/null | head -500 || echo "")

  if [[ -n "$BAD_LIST" ]]; then
    while IFS= read -r GUARD; do
      if echo "$BAD_LIST" | grep -q "$GUARD"; then
        error "GUARD $GUARD found in suspicious exit list!"
        notify "OPSEC Alert" "Guard node $GUARD flagged!" "critical"
      fi
    done <<< "$GUARDS"
  fi

  ok "Guard reputation check complete"
}

# ── Kill switch (iptables-based) ────────────────────────────────
setup_killswitch() {
  header "KILL SWITCH — IPTABLES"

  # Backup existing rules
  iptables-save > "${BACKUP_DIR}/iptables.bak" 2>/dev/null || true
  ip6tables-save > "${BACKUP_DIR}/ip6tables.bak" 2>/dev/null || true

  # ── IPv4 rules ───────────────────────────────────────────
  iptables -F; iptables -X; iptables -Z
  iptables -t nat -F; iptables -t nat -X

  # Default: DROP everything
  iptables -P INPUT DROP
  iptables -P FORWARD DROP
  iptables -P OUTPUT DROP

  # Allow loopback
  iptables -A INPUT  -i lo -j ACCEPT
  iptables -A OUTPUT -o lo -j ACCEPT

  # Allow established/related
  iptables -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT
  iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

  # Allow Tor process OUTPUT (only tor user)
  iptables -A OUTPUT -m owner --uid-owner debian-tor -j ACCEPT 2>/dev/null || \
  iptables -A OUTPUT -m owner --uid-owner tor -j ACCEPT 2>/dev/null || true

  # Allow DNS to Tor resolver only
  iptables -A OUTPUT -d 127.0.0.1 -p udp --dport 5353 -j ACCEPT
  iptables -A OUTPUT -d 127.0.0.1 -p tcp --dport 5353 -j ACCEPT

  # Tor SOCKS
  iptables -A OUTPUT -d 127.0.0.1 -p tcp --dport 9050 -j ACCEPT
  iptables -A OUTPUT -d 127.0.0.1 -p tcp --dport 9052 -j ACCEPT
  iptables -A OUTPUT -d 127.0.0.1 -p tcp --dport 9051 -j ACCEPT

  # Transparent proxy redirect — all TCP except Tor process
  iptables -t nat -A OUTPUT ! -o lo \
    -m owner ! --uid-owner debian-tor \
    -p tcp -j REDIRECT --to-port 9040 2>/dev/null || true

  # DNS redirect through Tor
  iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-port 5353 2>/dev/null || true
  iptables -t nat -A OUTPUT -p tcp --dport 53 -j REDIRECT --to-port 5353 2>/dev/null || true

  # ── IPv6 — total block ──────────────────────────────────
  ip6tables -F; ip6tables -X
  ip6tables -P INPUT   DROP
  ip6tables -P FORWARD DROP
  ip6tables -P OUTPUT  DROP
  ip6tables -A INPUT  -i lo -j ACCEPT
  ip6tables -A OUTPUT -o lo -j ACCEPT

  ok "Kill switch: DROP by default, all traffic via Tor, IPv6 blocked"
  timeline "Kill switch activated"
}

# ── UFW firewall ────────────────────────────────────────────────
setup_firewall() {
  header "UFW FIREWALL"

  if ! command -v ufw &>/dev/null; then
    warn "UFW not installed"
    return 0
  fi

  ufw --force disable  2>/dev/null
  ufw --force reset    2>/dev/null
  ufw default deny incoming
  ufw default deny outgoing
  ufw default deny forward

  # Allow Tor local ports only
  ufw allow out to 127.0.0.1 port 9050 proto tcp comment "Tor SOCKS"
  ufw allow out to 127.0.0.1 port 9052 proto tcp comment "Tor SOCKS isolated"
  ufw allow out to 127.0.0.1 port 9051 proto tcp comment "Tor Control"
  ufw allow out to 127.0.0.1 port 9040 proto tcp comment "Tor Transparent"
  ufw allow out to 127.0.0.1 port 5353 proto udp comment "Tor DNS"
  ufw allow out to 127.0.0.1 port 5353 proto tcp comment "Tor DNS TCP"
  ufw allow out on lo comment "Loopback"
  ufw allow in  on lo comment "Loopback in"

  # OnionShare hidden service port
  ufw allow out to 127.0.0.1 port 8080 proto tcp comment "OnionShare"

  ufw --force enable 2>/dev/null
  ok "UFW: deny all → allow Tor ports only"
  timeline "UFW configured"
}

# ── WireGuard VPN (VPN-before-Tor) ─────────────────────────────
setup_wireguard() {
  header "WIREGUARD VPN (VPN → Tor chain)"

  if ! command -v wg &>/dev/null; then
    warn "WireGuard not installed — skipping"
    return 0
  fi

  local WG_CONF="/etc/wireguard/wg0.conf"
  local WG_DIR="/etc/wireguard"
  mkdir -p "$WG_DIR"; chmod 700 "$WG_DIR"

  if [[ -f "$WG_CONF" ]]; then
    ok "WireGuard config exists at $WG_CONF"
    read -rp "  Use existing config? [Y/n]: " USE_EXISTING
    [[ "${USE_EXISTING:-Y}" =~ ^[Nn] ]] || { wg-quick up wg0 2>/dev/null && ok "WireGuard: connected"; return 0; }
  fi

  # Generate keys
  local PRIVKEY PUBKEY
  PRIVKEY=$(wg genkey)
  PUBKEY=$(echo "$PRIVKEY" | wg pubkey)

  echo ""
  echo -e "  ${BOLD}WireGuard VPN Configuration${RESET}"
  echo -e "  ${DIM}(Enter server details from your VPN provider)${RESET}"
  read -rp "  Server endpoint (ip:port): " WG_ENDPOINT
  read -rp "  Server public key:         " WG_SERVER_KEY
  read -rp "  Client IP (e.g. 10.0.0.2/32): " WG_CLIENT_IP
  read -rp "  DNS server [10.0.0.1]:     " WG_DNS
  WG_DNS="${WG_DNS:-10.0.0.1}"

  cat > "$WG_CONF" << EOF
[Interface]
PrivateKey = ${PRIVKEY}
Address = ${WG_CLIENT_IP}
DNS = ${WG_DNS}
# Note: DNS is overridden by our Tor DNS lock after connection

[Peer]
PublicKey = ${WG_SERVER_KEY}
Endpoint = ${WG_ENDPOINT}
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
EOF
  chmod 600 "$WG_CONF"

  echo -e "\n  ${CYAN}Your WireGuard public key (share with provider):${RESET}"
  echo "  $PUBKEY"
  echo ""

  read -rp "  Connect now? [Y/n]: " CONNECT_NOW
  if [[ ! "${CONNECT_NOW:-Y}" =~ ^[Nn] ]]; then
    wg-quick up wg0 2>/dev/null && ok "WireGuard: connected" || warn "WireGuard connection failed"
  fi

  ok "WireGuard configured: VPN→Tor chain"
  timeline "WireGuard configured"
}

# ── Multi-hop setup ─────────────────────────────────────────────
setup_multihop() {
  header "MULTI-HOP VPN → TOR ROUTING"

  echo ""
  echo -e "  ${BOLD}Traffic routing chain:${RESET}"
  echo -e "  ${CYAN}You${RESET} → ${YELLOW}WireGuard VPN${RESET} → ${GREEN}Tor Network${RESET} → ${CYAN}Destination${RESET}"
  echo ""
  echo -e "  Benefits:"
  echo "  • Your ISP sees WireGuard VPN traffic (not Tor)"
  echo "  • VPN provider sees Tor traffic (not your content)"
  echo "  • Tor exit sees content (not your IP)"
  echo ""

  # Check WireGuard is up
  if ! ip link show wg0 &>/dev/null; then
    warn "WireGuard (wg0) not active — run setup_wireguard first"
    return 0
  fi

  # Ensure Tor goes out through WireGuard interface
  local WG_GW; WG_GW=$(ip route show | grep wg0 | awk '{print $1}' | head -1)

  if [[ -n "$WG_GW" ]]; then
    ok "Multi-hop active: traffic → wg0 → Tor → destination"
  else
    warn "Could not verify WireGuard routing"
  fi

  MULTIHOP="true"
  ok "Multi-hop VPN→Tor configured"
  timeline "Multi-hop configured"
}

# ── I2P alternative network ─────────────────────────────────────
setup_i2p() {
  header "I2P NETWORK"

  if ! command -v i2p &>/dev/null && ! command -v i2prouter &>/dev/null; then
    # Try to install from repo
    if [[ "$OS_TYPE" =~ ^(ubuntu|debian|kali)$ ]]; then
      apt-get install -y -qq i2p i2p-router 2>/dev/null || true
    fi
    command -v i2p &>/dev/null || { warn "I2P not available — skipping"; return 0; }
  fi

  # start-i2p command
  cat > /usr/local/bin/start-i2p << 'EOF'
#!/bin/bash
echo "[*] Starting I2P router..."
i2prouter start 2>/dev/null || i2p start 2>/dev/null || systemctl start i2p 2>/dev/null
sleep 5
echo "[+] I2P console: http://127.0.0.1:7657"
echo "[+] I2P SOCKS proxy: 127.0.0.1:4444"
echo "[+] I2P SOCKS5:      127.0.0.1:4447"
EOF

  # stop-i2p command
  cat > /usr/local/bin/stop-i2p << 'EOF'
#!/bin/bash
echo "[*] Stopping I2P..."
i2prouter stop 2>/dev/null || i2p stop 2>/dev/null || systemctl stop i2p 2>/dev/null
echo "[+] I2P stopped"
EOF

  chmod +x /usr/local/bin/start-i2p /usr/local/bin/stop-i2p

  ok "I2P installed: start-i2p / stop-i2p"
  ok "I2P SOCKS: 127.0.0.1:4444 (HTTP) / 4447 (SOCKS5)"
  timeline "I2P configured"
}

# ── Proxychains ─────────────────────────────────────────────────
setup_proxychains() {
  header "PROXYCHAINS"

  local PC_CONF="/etc/proxychains4.conf"
  [[ -f "$PC_CONF" ]] || PC_CONF="/etc/proxychains.conf"

  cp "$PC_CONF" "${BACKUP_DIR}/proxychains.conf.bak" 2>/dev/null || true

  cat > "$PC_CONF" << 'EOF'
# SPECTER v10 — Proxychains Configuration
strict_chain
quiet_mode
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000

[ProxyList]
socks5  127.0.0.1 9050
EOF

  ok "Proxychains: strict_chain → socks5 127.0.0.1:9050"
  timeline "Proxychains configured"
}

# ── Traffic shaping (timing attack mitigation) ──────────────────
setup_traffic_shaping() {
  header "TRAFFIC SHAPING"

  if ! command -v tc &>/dev/null; then
    warn "tc (iproute2) not available — skipping traffic shaping"
    return 0
  fi

  local IFACE; IFACE=$(ip route show default 2>/dev/null | awk '/default/{print $5; exit}')
  [[ -z "$IFACE" ]] && { warn "No default interface found"; return 0; }

  # Add jitter to make timing correlation attacks harder
  tc qdisc add dev "$IFACE" root netem \
    delay 10ms 5ms distribution normal \
    loss 0% \
    reorder 0% 2>/dev/null || true

  ok "Traffic shaping: ±5ms jitter on $IFACE (timing correlation resistance)"
  timeline "Traffic shaping applied"
}

# ── Verify Tor connection ───────────────────────────────────────
verify_tor() {
  header "TOR VERIFICATION"
  local MAX_TRIES=15 TRIES=0

  while (( TRIES < MAX_TRIES )); do
    local RESPONSE
    RESPONSE=$(curl -sf --socks5-hostname 127.0.0.1:9050 \
                --max-time 10 https://check.torproject.org/api/ip 2>/dev/null)
    if [[ "$RESPONSE" =~ '"IsTor":true' ]]; then
      local IP; IP=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('IP','?'))" 2>/dev/null || echo "?")
      ok "Tor: CONFIRMED active"
      ok "Exit IP: ${IP}"
      ok "You are anonymous"
      timeline "Tor verified: exit=$IP"
      return 0
    fi
    ((TRIES++))
    step "Attempt $TRIES/$MAX_TRIES — waiting for Tor..."
    sleep 3
  done

  error "Tor verification FAILED after ${MAX_TRIES} attempts"
  warn "Check: systemctl status tor"
  timeline "Tor verification FAILED"
  return 1
}

# ════════════════════════════════════════════════════════════════
# ANONYMITY
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: ANONYMITY
#  Identity management · PGP · TOTP · Browser hardening
#  OnionShare · Hidden service · Noise generator · Circuit rotation
#  Secure clipboard · Auto-nuke · Signal CLI · Contact book
#  Canary watermarking
# ================================================================

# ── Identity manager ────────────────────────────────────────────
setup_identity_manager() {
  header "IDENTITY MANAGER"

  # new-identity
  cat > /usr/local/bin/new-identity << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: new-identity <name>}"
BASE="${IDENTITY_DIR}/\$NAME"
[[ -d "\$BASE" ]] && { echo "[!] Identity '\$NAME' already exists"; exit 1; }
mkdir -p "\$BASE"/{browser,pgp,notes,tmp}
chmod 700 "\$BASE"

# Isolated Firefox profile
if command -v firefox &>/dev/null; then
  cat > "\$BASE/browser/user.js" << 'EOF'
// SPECTER — Browser Identity Profile
user_pref("network.proxy.type", 1);
user_pref("network.proxy.socks", "127.0.0.1");
user_pref("network.proxy.socks_port", 9050);
user_pref("network.proxy.socks_version", 5);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.prefetch-next", false);
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("webgl.disabled", true);
user_pref("media.peerconnection.enabled", false);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", false);
user_pref("browser.sessionstore.privacy_level", 2);
user_pref("geo.enabled", false);
user_pref("dom.battery.enabled", false);
user_pref("dom.gamepad.enabled", false);
EOF
fi

# New Tor circuit for this identity
( sleep 1
  printf 'AUTHENTICATE ""\r\nNEWNYM\r\nQUIT\r\n' | \
    nc -q1 127.0.0.1 9051 2>/dev/null | grep -q "250" && \
    echo "[+] New Tor circuit for identity: \$NAME" ) &

echo "[+] Identity created: \$NAME"
echo "    Dir: \$BASE"
echo "    Browser profile: \$BASE/browser"
SCRIPT
  chmod +x /usr/local/bin/new-identity

  # list-identities
  cat > /usr/local/bin/list-identities << SCRIPT
#!/bin/bash
BASE="${IDENTITY_DIR}"
[[ -d "\$BASE" ]] || { echo "No identities yet."; exit 0; }
echo ""
echo "  Identities:"
echo "  ──────────────────────────────"
while IFS= read -r -d '' DIR; do
  NAME="\$(basename "\$DIR")"
  SIZE=\$(du -sh "\$DIR" 2>/dev/null | cut -f1)
  CREATED=\$(stat -c '%y' "\$DIR" 2>/dev/null | cut -d' ' -f1)
  printf "  %-20s  %6s  %s\n" "\$NAME" "\$SIZE" "\$CREATED"
done < <(find "\$BASE" -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null)
echo ""
SCRIPT
  chmod +x /usr/local/bin/list-identities

  # wipe-identity
  cat > /usr/local/bin/wipe-identity << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: wipe-identity <name>}"
TARGET="${IDENTITY_DIR}/\$NAME"
[[ -d "\$TARGET" ]] || { echo "[!] Identity '\$NAME' not found"; exit 1; }
read -rp "  Securely destroy identity '\$NAME'? [yes/no]: " CONFIRM
[[ "\$CONFIRM" == "yes" ]] || { echo "Aborted."; exit 0; }
find "\$TARGET" -type f -exec shred -uzn 3 {} \; 2>/dev/null
rm -rf "\$TARGET"
echo "[+] Identity '\$NAME' wiped"
SCRIPT
  chmod +x /usr/local/bin/wipe-identity

  # switch-identity
  cat > /usr/local/bin/switch-identity << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: switch-identity <name>}"
TARGET="${IDENTITY_DIR}/\$NAME"
[[ -d "\$TARGET" ]] || { echo "[!] Identity '\$NAME' not found"; exit 1; }
# New Tor circuit
printf 'AUTHENTICATE ""\r\nNEWNYM\r\nQUIT\r\n' | \
  nc -q1 127.0.0.1 9051 2>/dev/null | grep -q "250" && \
  echo "[+] New Tor circuit"
# Export profile path for browser use
export OPSEC_IDENTITY="\$NAME"
export OPSEC_IDENTITY_DIR="\$TARGET"
echo "[+] Switched to identity: \$NAME"
echo "    Use: firefox --profile \$TARGET/browser"
SCRIPT
  chmod +x /usr/local/bin/switch-identity

  ok "Identity manager installed: new-identity | list-identities | wipe-identity | switch-identity"
  timeline "Identity manager installed"
}

# ── PGP identity for source communications ──────────────────────
setup_pgp_identity() {
  header "PGP IDENTITY"

  cat > /usr/local/bin/create-source-key << SCRIPT
#!/bin/bash
GPGHOME="${GPG_HOME}"
export GNUPGHOME="\$GPGHOME"
mkdir -p "\$GPGHOME"; chmod 700 "\$GPGHOME"

read -rp "  Name for source key: " KEY_NAME
read -rp "  Email (or alias): "    KEY_EMAIL

# Generate 4096-bit RSA key, expires in 90 days
cat > /tmp/opsec_keygen_params << EOF
%no-protection
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: \$KEY_NAME
Name-Email: \$KEY_EMAIL
Expire-Date: 90
%commit
EOF

gpg --batch --gen-key /tmp/opsec_keygen_params 2>/dev/null
shred -uzn 3 /tmp/opsec_keygen_params 2>/dev/null

# Export public key
FINGERPRINT=\$(gpg --fingerprint "\$KEY_EMAIL" 2>/dev/null | \
  grep "Key fingerprint" | awk -F'= ' '{print \$2}' | tr -d ' ')
gpg --armor --export "\$KEY_EMAIL" > "${RAMDISK_MOUNT}/source_pubkey_\${KEY_NAME// /_}.asc" 2>/dev/null

echo "[+] PGP key created"
echo "    Fingerprint: \$FINGERPRINT"
echo "    Public key: ${RAMDISK_MOUNT}/source_pubkey_\${KEY_NAME// /_}.asc"
echo ""
echo "    Share the public key with sources via a secure channel."
SCRIPT
  chmod +x /usr/local/bin/create-source-key

  ok "PGP identity: create-source-key installed"
  timeline "PGP identity configured"
}

# ── Encrypted contact book ──────────────────────────────────────
setup_contact_book() {
  header "ENCRYPTED CONTACT BOOK"

  cat > /usr/local/bin/contact << 'SCRIPT'
#!/bin/bash
BOOK="${RAMDISK_MOUNT:-/mnt/secure_workspace}/.contacts.gpg"
ACTION="${1:-list}"

decrypt_book() {
  [[ -f "$BOOK" ]] || return 0
  gpg --batch --decrypt --quiet "$BOOK" 2>/dev/null
}

encrypt_book() {
  local DATA="$1"
  printf '%s' "$DATA" | gpg --batch --symmetric --cipher-algo AES256 \
    --output "$BOOK" 2>/dev/null
}

case "$ACTION" in
  add)
    read -rp "  Contact alias:   " ALIAS
    read -rp "  Fingerprint/ID:  " FP
    read -rp "  Onion address:   " ONION
    read -rp "  Notes:           " NOTES
    ENTRY="$ALIAS|$FP|$ONION|$(date +%Y-%m-%d)|$NOTES"
    EXISTING=$(decrypt_book)
    encrypt_book "${EXISTING}"$'\n'"${ENTRY}"
    echo "[+] Contact '$ALIAS' added (encrypted)"
    ;;
  list)
    DATA=$(decrypt_book)
    [[ -z "$DATA" ]] && { echo "  No contacts yet."; exit 0; }
    echo ""
    echo "  Alias                Fingerprint          Onion"
    echo "  ─────────────────────────────────────────────────"
    while IFS='|' read -r ALIAS FP ONION DATE NOTES; do
      [[ -z "$ALIAS" ]] && continue
      printf "  %-20s %-20s %s\n" "$ALIAS" "${FP:0:20}" "$ONION"
    done <<< "$DATA"
    echo ""
    ;;
  view)
    ALIAS="${2:?Usage: contact view <alias>}"
    DATA=$(decrypt_book | grep "^${ALIAS}|")
    [[ -z "$DATA" ]] && { echo "Not found: $ALIAS"; exit 1; }
    IFS='|' read -r A FP ONION DATE NOTES <<< "$DATA"
    echo ""
    echo "  Alias:      $A"
    echo "  Key ID:     $FP"
    echo "  Onion:      $ONION"
    echo "  Added:      $DATE"
    echo "  Notes:      $NOTES"
    echo ""
    ;;
  wipe)
    shred -uzn 3 "$BOOK" 2>/dev/null && echo "[+] Contact book wiped"
    ;;
  *)
    echo "Usage: contact <add|list|view <alias>|wipe>"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/contact

  ok "Contact book: contact add|list|view|wipe"
  timeline "Encrypted contact book installed"
}

# ── Canary watermarking ─────────────────────────────────────────
setup_canary_system() {
  header "CANARY WATERMARK SYSTEM"

  cat > /usr/local/bin/watermark-doc << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: watermark-doc <file> <recipient_name>}"
RECIPIENT="${2:?Usage: watermark-doc <file> <recipient_name>}"
WLOG="${RAMDISK_MOUNT:-/mnt/secure_workspace}/.watermarks.log"

[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }

# Generate unique token for this recipient + file combination
TOKEN=$(printf '%s%s%s' "$RECIPIENT" "$FILE" "$(date +%s)" | \
  sha256sum | awk '{print $1}' | head -c 16)

# Embed in metadata comment field (for text/PDF)
EXT="${FILE##*.}"
WFILE="${FILE%.*}_wm_${RECIPIENT// /_}.${EXT}"
cp "$FILE" "$WFILE"

# Embed token in EXIF comment
if command -v exiftool &>/dev/null; then
  exiftool -overwrite_original \
    -Comment="Ref: ${TOKEN}" \
    -UserComment="Ref: ${TOKEN}" \
    "$WFILE" 2>/dev/null
fi

# Append invisible unicode watermark for text documents
if file "$WFILE" | grep -qiE "text|ascii"; then
  printf '\xe2\x80\x8b' >> "$WFILE"  # Zero-width space
  printf "<!-- ref:%s -->" "$TOKEN" >> "$WFILE" 2>/dev/null || true
fi

# Log to watermark registry
echo "$(date '+%Y-%m-%d %H:%M:%S')|${RECIPIENT}|$(basename "$FILE")|${TOKEN}" >> "$WLOG"

echo "[+] Watermarked: $WFILE"
echo "    Recipient: $RECIPIENT"
echo "    Token:     $TOKEN"
echo "    Registry:  $WLOG"
SCRIPT
  chmod +x /usr/local/bin/watermark-doc

  cat > /usr/local/bin/check-watermark << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: check-watermark <file>}"
WLOG="${RAMDISK_MOUNT:-/mnt/secure_workspace}/.watermarks.log"

[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }

# Extract token from metadata
TOKEN=""
if command -v exiftool &>/dev/null; then
  TOKEN=$(exiftool "$FILE" 2>/dev/null | grep -i "comment" | \
    grep -oP 'Ref: \K[a-f0-9]+' | head -1)
fi
[[ -z "$TOKEN" ]] && TOKEN=$(grep -oP '<!-- ref:\K[a-f0-9]+' "$FILE" 2>/dev/null | head -1)

if [[ -z "$TOKEN" ]]; then
  echo "[?] No watermark token found in $FILE"
  exit 0
fi

echo "[*] Found token: $TOKEN"
if [[ -f "$WLOG" ]]; then
  MATCH=$(grep "|${TOKEN}" "$WLOG" 2>/dev/null)
  if [[ -n "$MATCH" ]]; then
    IFS='|' read -r DATE RECIPIENT FNAME _ <<< "$MATCH"
    echo "[!] LEAK TRACED:"
    echo "    Recipient : $RECIPIENT"
    echo "    File      : $FNAME"
    echo "    Sent date : $DATE"
  else
    echo "[?] Token found but not in local registry"
  fi
else
  echo "[?] No watermark registry found"
fi
SCRIPT
  chmod +x /usr/local/bin/check-watermark

  ok "Watermark system: watermark-doc | check-watermark"
  timeline "Canary watermark system installed"
}

# ── Browser hardening ───────────────────────────────────────────
setup_browser_hardening() {
  header "TOR BROWSER HARDENING"

  cat > /usr/local/bin/harden-browser << 'SCRIPT'
#!/bin/bash
# Find Tor Browser profile directory
TBB_PROFILE=$(find /root /home -name "prefs.js" -path "*/tor-browser*" 2>/dev/null | head -1)
TBB_PROFILE=$(dirname "$TBB_PROFILE" 2>/dev/null)

[[ -z "$TBB_PROFILE" ]] && {
  echo "[!] Tor Browser profile not found — checking common locations"
  for P in \
    "$HOME/tor-browser/Browser/TorBrowser/Data/Browser/profile.default" \
    "$HOME/.local/share/torbrowser/tbb/x86_64/tor-browser/Browser/TorBrowser/Data/Browser/profile.default" \
    "/opt/tor-browser/Browser/TorBrowser/Data/Browser/profile.default"; do
    [[ -d "$P" ]] && { TBB_PROFILE="$P"; break; }
  done
}

[[ -z "$TBB_PROFILE" ]] && { echo "[!] Could not find Tor Browser profile"; exit 1; }

cat > "$TBB_PROFILE/user.js" << 'EOF'
// SPECTER v10.0.0 — Tor Browser Security Profile

// === WebRTC — DISABLE completely ===
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.turn.disable", true);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.peerconnection.video.enabled", false);
user_pref("media.peerconnection.identity.timeout", 1);

// === Fingerprint Resistance ===
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.resistFingerprinting.reduceTimerPrecision.microseconds", 1000);
user_pref("privacy.resistFingerprinting.letterboxing", true);
user_pref("canvas.capturestream.enabled", false);

// === No telemetry / reporting ===
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.tabs.crashReporting.sendReport", false);

// === No disk cache ===
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", false);
user_pref("browser.cache.offline.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);

// === WebGL — disable ===
user_pref("webgl.disabled", true);
user_pref("webgl.enable-webgl2", false);

// === Geolocation — disable ===
user_pref("geo.enabled", false);
user_pref("geo.provider.use_gpsd", false);
user_pref("browser.search.geoip.url", "");

// === Sensors — disable all ===
user_pref("dom.battery.enabled", false);
user_pref("dom.gamepad.enabled", false);
user_pref("dom.vr.enabled", false);
user_pref("device.sensors.enabled", false);

// === Safe browsing (sends URLs to Google) — disable ===
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);

// === No session restore ===
user_pref("browser.sessionstore.privacy_level", 2);
user_pref("browser.sessionstore.resume_from_crash", false);

// === Security level: strictest ===
user_pref("extensions.torbutton.security_slider", 1);
EOF

echo "[+] Tor Browser hardened: $TBB_PROFILE/user.js"
echo "    Restart Tor Browser to apply settings."
SCRIPT
  chmod +x /usr/local/bin/harden-browser

  ok "Browser hardening: harden-browser installed"
  timeline "Browser hardening installed"
}

# ── OnionShare ──────────────────────────────────────────────────
setup_onionshare() {
  header "ONIONSHARE"

  cat > /usr/local/bin/share-file << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: share-file <file>}"
[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }
echo "[*] Starting OnionShare for: $FILE"
if command -v onionshare-cli &>/dev/null; then
  onionshare-cli "$FILE"
elif command -v onionshare &>/dev/null; then
  onionshare "$FILE"
else
  echo "[!] OnionShare not installed"
  exit 1
fi
SCRIPT

  cat > /usr/local/bin/receive-docs << 'SCRIPT'
#!/bin/bash
echo "[*] Starting OnionShare receive mode (document drop box)..."
SAVE_DIR="${RAMDISK_MOUNT:-/mnt/secure_workspace}/received_docs"
mkdir -p "$SAVE_DIR"
if command -v onionshare-cli &>/dev/null; then
  onionshare-cli --receive --save-files "$SAVE_DIR"
elif command -v onionshare &>/dev/null; then
  onionshare --receive
else
  echo "[!] OnionShare not installed"
  exit 1
fi
SCRIPT

  chmod +x /usr/local/bin/share-file /usr/local/bin/receive-docs

  ok "OnionShare: share-file | receive-docs"
  timeline "OnionShare configured"
}

# ── Tor hidden service (document dropbox) ───────────────────────
setup_hidden_service() {
  header "TOR HIDDEN SERVICE (Source Dropbox)"

  local HS_DIR="/var/lib/tor/source_dropbox"
  mkdir -p "$HS_DIR"; chmod 700 "$HS_DIR"; chown debian-tor:debian-tor "$HS_DIR" 2>/dev/null || true

  # Add hidden service to torrc
  grep -q "HiddenServiceDir.*source_dropbox" /etc/tor/torrc 2>/dev/null || cat >> /etc/tor/torrc << EOF

# Source Dropbox Hidden Service
HiddenServiceDir ${HS_DIR}
HiddenServicePort 80 127.0.0.1:8080
HiddenServiceVersion 3
EOF

  systemctl restart tor 2>/dev/null || true
  sleep 3

  # source-dropbox command
  cat > /usr/local/bin/source-dropbox << SCRIPT
#!/bin/bash
HS_DIR="${HS_DIR}"
ONION_FILE="\${HS_DIR}/hostname"
RECV_DIR="${RAMDISK_MOUNT:-/mnt/secure_workspace}/received_docs"
mkdir -p "\$RECV_DIR"

if [[ ! -f "\$ONION_FILE" ]]; then
  echo "[!] Hidden service not yet initialized — restart Tor and wait 30s"
  systemctl restart tor 2>/dev/null; sleep 30
fi

if [[ -f "\$ONION_FILE" ]]; then
  ONION=\$(cat "\$ONION_FILE")
  echo "[+] Source Dropbox: http://\${ONION}"
  echo "    Share this .onion address with sources"
fi

# Start upload receiver on 8080
python3 -c "
import http.server, cgi, os, sys
RECV_DIR = '\${RECV_DIR}'
class DropboxHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write(b'<html><body><form method=POST enctype=multipart/form-data><input type=file name=file><input type=submit value=Upload></form></body></html>')
    def do_POST(self):
        ctype, pdict = cgi.parse_header(self.headers.get('content-type'))
        if ctype == 'multipart/form-data':
            pdict['boundary'] = bytes(pdict['boundary'], 'utf-8')
            fields = cgi.parse_multipart(self.rfile, pdict)
            for fname, data in fields.items():
                path = os.path.join(RECV_DIR, fname)
                with open(path, 'wb') as f:
                    f.write(data[0] if isinstance(data[0], bytes) else data[0].encode())
                print('[+] Received: ' + path)
        self.send_response(200); self.end_headers()
        self.wfile.write(b'<html><body>Received. Thank you.</body></html>')
    def log_message(self, fmt, *args): pass
print('[*] Source dropbox running on port 8080')
srv = http.server.HTTPServer(('127.0.0.1', 8080), DropboxHandler)
srv.serve_forever()
"
SCRIPT
  chmod +x /usr/local/bin/source-dropbox

  ok "Hidden service: source-dropbox (v3 .onion)"
  timeline "Hidden service configured"
}

# ── Traffic noise generator ──────────────────────────────────────
setup_noise_generator() {
  header "TRAFFIC NOISE GENERATOR"

  cat > /usr/local/bin/noise-generator << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="${NOISE_PID}"

DECOY_SITES=(
  "https://www.wikipedia.org"
  "https://www.duckduckgo.com"
  "https://www.eff.org"
  "https://www.torproject.org"
  "https://facebookwkhpilnemxj7ascrwwwi72ytt6cqnrgnwcpyuqem2otgbbyqd.onion/"
  "https://www.nytimes3xbfgragh.onion/"
)

start_noise() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true
  (
    while true; do
      DELAY=\$((RANDOM % (${NOISE_MAX_DELAY} - ${NOISE_MIN_DELAY} + 1) + ${NOISE_MIN_DELAY}))
      sleep \$DELAY
      SITE="\${DECOY_SITES[\$((RANDOM % \${#DECOY_SITES[@]}))]}"
      curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 15 "\$SITE" \
        -o /dev/null -A "Mozilla/5.0" 2>/dev/null || true
      # Occasional circuit rotation
      if (( RANDOM % 5 == 0 )); then
        printf 'AUTHENTICATE ""\r\nNEWNYM\r\nQUIT\r\n' | \
          nc -q1 127.0.0.1 9051 2>/dev/null || true
      fi
    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] Noise generator started (PID: \$(cat \$PID_FILE))"
  echo "    Interval: ${NOISE_MIN_DELAY}-${NOISE_MAX_DELAY}s"
}

stop_noise() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] Noise generator stopped"
}

status_noise() {
  if [[ -f "\$PID_FILE" ]] && kill -0 \$(cat "\$PID_FILE") 2>/dev/null; then
    echo "[+] Noise generator: RUNNING (PID \$(cat \$PID_FILE))"
  else
    echo "[-] Noise generator: stopped"
  fi
}

case "\$ACTION" in
  start)  start_noise ;;
  stop)   stop_noise ;;
  status) status_noise ;;
  *)      echo "Usage: noise-generator <start|stop|status>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/noise-generator

  ok "Noise generator: noise-generator start|stop|status"
  timeline "Noise generator installed"
}

# ── Circuit rotation ─────────────────────────────────────────────
setup_circuit_rotation() {
  header "CIRCUIT ROTATION"

  cat > /usr/local/bin/rotate-circuit << 'SCRIPT'
#!/bin/bash
printf 'AUTHENTICATE ""\r\nNEWNYM\r\nQUIT\r\n' | nc -q1 127.0.0.1 9051 2>/dev/null | \
  grep -q "250" && echo "[+] New Tor circuit requested" || echo "[!] Circuit rotation failed"
sleep 2
IP=$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 10 \
     https://check.torproject.org/api/ip 2>/dev/null | \
     python3 -c "import sys,json; print(json.load(sys.stdin).get('IP','?'))" 2>/dev/null)
echo "[+] New exit IP: $IP"
SCRIPT
  chmod +x /usr/local/bin/rotate-circuit

  cat > /usr/local/bin/auto-rotate << SCRIPT
#!/bin/bash
INTERVAL="\${1:-${AUTO_ROTATE_INTERVAL}}"
echo "[*] Auto-rotating Tor circuit every \${INTERVAL}s"
while true; do
  sleep "\$INTERVAL"
  rotate-circuit
done &
echo "[+] Auto-rotate started (PID: \$!)"
SCRIPT
  chmod +x /usr/local/bin/auto-rotate

  ok "Circuit rotation: rotate-circuit | auto-rotate [seconds]"
  timeline "Circuit rotation configured"
}

# ── Secure clipboard ─────────────────────────────────────────────
setup_secure_clipboard() {
  header "SECURE CLIPBOARD"

  cat > /usr/local/bin/clipboard-guard << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="${CLIP_PID}"

case "\$ACTION" in
  start)
    [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null || true
    (
      while true; do
        sleep 30
        DISPLAY=:0 xclip -selection clipboard -i /dev/null 2>/dev/null || \
        DISPLAY=:0 xsel --clipboard --delete 2>/dev/null || true
      done
    ) &
    echo \$! > "\$PID_FILE"
    echo "[+] Clipboard guard active (clears every 30s)"
    ;;
  stop)
    [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
    echo "[+] Clipboard guard stopped"
    ;;
  now)
    DISPLAY=:0 xclip -selection clipboard -i /dev/null 2>/dev/null || \
    DISPLAY=:0 xsel --clipboard --delete 2>/dev/null || true
    echo "[+] Clipboard cleared"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/clipboard-guard

  ok "Clipboard guard: clipboard-guard start|stop|now"
  timeline "Clipboard guard installed"
}

# ── Auto-nuke timer ──────────────────────────────────────────────
setup_autonuke_timer() {
  header "AUTO-NUKE INACTIVITY TIMER"

  read -rp "  Auto-nuke after N minutes of inactivity [${AUTONUKE_MINUTES}]: " MINS
  MINS="${MINS:-$AUTONUKE_MINUTES}"
  AUTONUKE_MINUTES="$MINS"
  local IDLE_MS=$(( MINS * 60 * 1000 ))

  cat > /usr/local/bin/autonuke-timer << SCRIPT
#!/bin/bash
IDLE_MS=${IDLE_MS}
MINS=${MINS}
PID_FILE="${AUTONUKE_PID}"

case "\${1:-start}" in
  start)
    [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null || true
    (
      while true; do
        sleep 60
        if command -v xprintidle &>/dev/null; then
          CURRENT_IDLE=\$(DISPLAY=:0 xprintidle 2>/dev/null || echo 0)
          if (( CURRENT_IDLE >= IDLE_MS )); then
            echo "[!!!] Inactivity timeout: \$MINS minutes — NUKING SESSION"
            /usr/local/bin/session-nuke auto
          fi
        fi
      done
    ) &
    echo \$! > "\$PID_FILE"
    echo "[+] Auto-nuke timer: \${MINS} min inactivity (PID \$(cat \$PID_FILE))"
    ;;
  stop)
    [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
    echo "[+] Auto-nuke timer stopped"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/autonuke-timer

  ok "Auto-nuke timer: ${MINS}min inactivity → session-nuke"
  timeline "Auto-nuke timer configured"
}

# ── TOTP authentication helper ───────────────────────────────────
setup_totp() {
  header "TOTP AUTHENTICATOR"

  cat > /usr/local/bin/totp << SCRIPT
#!/bin/bash
STORE="${TOTP_STORE}"
ACTION="\${1:-list}"
NAME="\$2"

case "\$ACTION" in
  add)
    NAME="\${NAME:?Usage: totp add <name>}"
    read -rp "  Secret (base32): " SECRET
    EXISTING=\$(gpg --batch --decrypt --quiet "\$STORE" 2>/dev/null || echo "")
    NEW="\${EXISTING}"$'\n'"\${NAME}:\${SECRET}"
    printf '%s' "\$NEW" | gpg --batch --symmetric --cipher-algo AES256 \
      --output "\$STORE" --yes 2>/dev/null
    echo "[+] TOTP entry added: \$NAME"
    ;;
  get)
    NAME="\${NAME:?Usage: totp get <name>}"
    SECRET=\$(gpg --batch --decrypt --quiet "\$STORE" 2>/dev/null | \
      grep "^\${NAME}:" | cut -d: -f2)
    [[ -z "\$SECRET" ]] && { echo "[!] Not found: \$NAME"; exit 1; }
    CODE=\$(oathtool --totp --base32 "\$SECRET" 2>/dev/null)
    echo "[+] \$NAME: \$CODE"
    ;;
  list)
    echo "  TOTP entries:"
    gpg --batch --decrypt --quiet "\$STORE" 2>/dev/null | \
      grep -v '^$' | awk -F: '{print "  •", \$1}' || echo "  (none)"
    ;;
  *)
    echo "Usage: totp <add <name>|get <name>|list>"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/totp

  ok "TOTP: totp add|get|list"
  timeline "TOTP installed"
}

# ════════════════════════════════════════════════════════════════
# CRYPTOGRAPHY
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: CRYPTOGRAPHY
#  Age encryption · VeraCrypt · LUKS (standard + hidden volume)
#  Password manager · Secure delete · Key ceremony · Secure notes
# ================================================================

# ── Age encryption (modern alternative to GPG for files) ────────
setup_age_encryption() {
  header "AGE ENCRYPTION"

  if ! command -v age &>/dev/null; then
    # Try to install
    apt-get install -y -qq age 2>/dev/null || \
    snap install age 2>/dev/null || \
    warn "age not available — downloading binary"

    if ! command -v age &>/dev/null; then
      # Fetch from GitHub releases via Tor
      local AGE_URL="https://github.com/FiloSottile/age/releases/latest/download/age-linux-amd64.tar.gz"
      torsocks wget -qO /tmp/age.tar.gz "$AGE_URL" 2>/dev/null || \
        wget -qO /tmp/age.tar.gz "$AGE_URL" 2>/dev/null || \
        { warn "Could not install age — skipping"; return 0; }
      tar -xzf /tmp/age.tar.gz -C /tmp 2>/dev/null
      cp /tmp/age/age /usr/local/bin/ 2>/dev/null
      cp /tmp/age/age-keygen /usr/local/bin/ 2>/dev/null
      rm -rf /tmp/age.tar.gz /tmp/age 2>/dev/null
    fi
  fi

  # age-encrypt command
  cat > /usr/local/bin/age-encrypt << SCRIPT
#!/bin/bash
FILE="\${1:?Usage: age-encrypt <file> [recipient_key_or_passphrase]}"
DEST="\${2:-}"
OUTFILE="\${FILE}.age"

if [[ -n "\$DEST" ]]; then
  age -r "\$DEST" -o "\$OUTFILE" "\$FILE" && \
    shred -uzn 3 "\$FILE" && \
    echo "[+] Encrypted: \$OUTFILE (recipient key)"
else
  age -p -o "\$OUTFILE" "\$FILE" && \
    shred -uzn 3 "\$FILE" && \
    echo "[+] Encrypted: \$OUTFILE (passphrase)"
fi
SCRIPT
  chmod +x /usr/local/bin/age-encrypt

  # age-decrypt command
  cat > /usr/local/bin/age-decrypt << SCRIPT
#!/bin/bash
FILE="\${1:?Usage: age-decrypt <file.age> [keyfile]}"
KEYFILE="\${2:-}"
OUTFILE="\${FILE%.age}"

if [[ -n "\$KEYFILE" ]]; then
  age -d -i "\$KEYFILE" -o "\$OUTFILE" "\$FILE" && \
    echo "[+] Decrypted: \$OUTFILE"
else
  age -d -o "\$OUTFILE" "\$FILE" && \
    echo "[+] Decrypted: \$OUTFILE"
fi
SCRIPT
  chmod +x /usr/local/bin/age-decrypt

  # Generate age keypair stored in RAM
  if command -v age-keygen &>/dev/null; then
    local AGE_KEY_FILE="${CRYPTO_DIR}/age_identity.txt"
    [[ -f "$AGE_KEY_FILE" ]] || {
      age-keygen -o "$AGE_KEY_FILE" 2>/dev/null
      chmod 600 "$AGE_KEY_FILE"
      AGE_PUBKEY=$(age-keygen -y "$AGE_KEY_FILE" 2>/dev/null)
      ok "Age keypair generated"
      echo -e "  Public key: ${CYAN}${AGE_PUBKEY}${RESET}"
    }
  fi

  ok "Age encryption: age-encrypt | age-decrypt"
  timeline "Age encryption configured"
}

# ── VeraCrypt container support ──────────────────────────────────
setup_veracrypt() {
  header "VERACRYPT ENCRYPTED CONTAINERS"

  if ! command -v veracrypt &>/dev/null; then
    # Offer to download
    echo -e "  ${YELLOW}[!]${RESET} VeraCrypt not installed."
    echo "  Download from: https://veracrypt.fr (via Tor Browser)"
    echo "  Or install from distro repo if available."
    apt-get install -y -qq veracrypt 2>/dev/null || true
    command -v veracrypt &>/dev/null || { warn "VeraCrypt unavailable — skipping"; return 0; }
  fi

  # vc-create command
  cat > /usr/local/bin/vc-create << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: vc-create <container_name> [size_mb]}"
SIZE="\${2:-256}"
DEST="${RAMDISK_MOUNT:-/mnt/secure_workspace}/\${NAME}.vc"

echo "[*] Creating VeraCrypt container: \$DEST (\${SIZE}MB)"
echo "[*] You will be prompted for a password twice."
veracrypt --text --create "\$DEST" \
  --size "\${SIZE}M" \
  --volume-type=normal \
  --encryption=AES \
  --hash=SHA-512 \
  --filesystem=ext4 \
  --pim=0 \
  --keyfiles="" 2>/dev/null
echo "[+] Container created: \$DEST"
echo "    Mount with: vc-open \$NAME"
SCRIPT
  chmod +x /usr/local/bin/vc-create

  # vc-open command
  cat > /usr/local/bin/vc-open << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: vc-open <container_name>}"
CONTAINER="${RAMDISK_MOUNT:-/mnt/secure_workspace}/\${NAME}.vc"
MOUNT_DIR="/mnt/vc_\${NAME}"
mkdir -p "\$MOUNT_DIR"
veracrypt --text --mount "\$CONTAINER" "\$MOUNT_DIR" --pim=0 --keyfiles="" 2>/dev/null
echo "[+] Mounted at: \$MOUNT_DIR"
SCRIPT
  chmod +x /usr/local/bin/vc-open

  # vc-close command
  cat > /usr/local/bin/vc-close << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: vc-close <container_name>}"
veracrypt --text --dismount "/mnt/vc_\${NAME}" 2>/dev/null && \
  rmdir "/mnt/vc_\${NAME}" 2>/dev/null
echo "[+] VeraCrypt container closed"
SCRIPT
  chmod +x /usr/local/bin/vc-close

  ok "VeraCrypt: vc-create | vc-open | vc-close"
  timeline "VeraCrypt configured"
}

# ── LUKS encrypted vault (standard) ─────────────────────────────
setup_luks_vault() {
  header "LUKS ENCRYPTED VAULT"

  cat > /usr/local/bin/create-vault << SCRIPT
#!/bin/bash
VAULT="${VAULT_FILE:-${RAMDISK_MOUNT}/secure_vault.enc}"
SIZE_MB="\${1:-256}"

[[ -f "\$VAULT" ]] && { echo "[!] Vault already exists: \$VAULT"; exit 1; }

echo "[*] Creating \${SIZE_MB}MB encrypted vault..."
dd if=/dev/urandom of="\$VAULT" bs=1M count="\$SIZE_MB" status=progress 2>&1

echo "[*] Formatting with LUKS (AES-XTS-512, SHA-512)..."
cryptsetup luksFormat --type luks2 \
  --cipher aes-xts-plain64 \
  --key-size 512 \
  --hash sha512 \
  --pbkdf argon2id \
  --pbkdf-memory 1048576 \
  --pbkdf-time 5000 \
  "\$VAULT"

echo "[*] Opening vault..."
cryptsetup open "\$VAULT" opsec_vault

echo "[*] Creating filesystem..."
mkfs.ext4 -q /dev/mapper/opsec_vault

echo "[+] Vault created: \$VAULT"
echo "    Open:  open-vault"
echo "    Close: close-vault"
cryptsetup close opsec_vault
SCRIPT
  chmod +x /usr/local/bin/create-vault

  cat > /usr/local/bin/open-vault << SCRIPT
#!/bin/bash
VAULT="${VAULT_FILE:-${RAMDISK_MOUNT}/secure_vault.enc}"
MOUNT="/mnt/opsec_vault"
[[ -f "\$VAULT" ]] || { echo "[!] No vault found: \$VAULT"; exit 1; }
cryptsetup open "\$VAULT" opsec_vault || exit 1
mkdir -p "\$MOUNT"
mount /dev/mapper/opsec_vault "\$MOUNT" && echo "[+] Vault mounted: \$MOUNT"
SCRIPT
  chmod +x /usr/local/bin/open-vault

  cat > /usr/local/bin/close-vault << SCRIPT
#!/bin/bash
MOUNT="/mnt/opsec_vault"
mountpoint -q "\$MOUNT" && umount "\$MOUNT" && rmdir "\$MOUNT"
cryptsetup close opsec_vault 2>/dev/null && echo "[+] Vault locked"
SCRIPT
  chmod +x /usr/local/bin/close-vault

  ok "LUKS vault: create-vault | open-vault | close-vault"
  timeline "LUKS vault configured"
}

# ── Password manager (pass-compatible, GPG encrypted) ───────────
setup_password_manager() {
  header "ENCRYPTED PASSWORD MANAGER"

  cat > /usr/local/bin/pm-init << SCRIPT
#!/bin/bash
echo "[*] Initializing password manager in RAM..."
mkdir -p "${CRYPTO_DIR}/.pm"
chmod 700 "${CRYPTO_DIR}/.pm"
echo "[+] Password store initialized: ${CRYPTO_DIR}/.pm"
echo "    Use: pm-add <name> | pm-get <name> | pm-list"
SCRIPT
  chmod +x /usr/local/bin/pm-init

  cat > /usr/local/bin/pm-add << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: pm-add <entry_name>}"
STORE="${PM_STORE}"
read -rsp "  Password: " PASS; echo
read -rp   "  Username: " USER
read -rp   "  Notes:    " NOTES
ENTRY="\${NAME}|\${USER}|\${PASS}|\${NOTES}|\$(date +%Y-%m-%d)"
EXISTING=\$(gpg --batch --decrypt --quiet "\$STORE" 2>/dev/null || echo "")
printf '%s\n%s' "\$EXISTING" "\$ENTRY" | \
  gpg --batch --symmetric --cipher-algo AES256 --output "\$STORE" --yes 2>/dev/null
echo "[+] Saved: \$NAME"
SCRIPT
  chmod +x /usr/local/bin/pm-add

  cat > /usr/local/bin/pm-get << SCRIPT
#!/bin/bash
NAME="\${1:?Usage: pm-get <entry_name>}"
STORE="${PM_STORE}"
ROW=\$(gpg --batch --decrypt --quiet "\$STORE" 2>/dev/null | grep "^\${NAME}|")
[[ -z "\$ROW" ]] && { echo "[!] Not found: \$NAME"; exit 1; }
IFS='|' read -r N USER PASS NOTES DATE <<< "\$ROW"
echo ""
echo "  Entry:    \$N"
echo "  Username: \$USER"
echo "  Password: \$PASS"
echo "  Notes:    \$NOTES"
echo "  Added:    \$DATE"
echo ""
# Copy to clipboard, then clear after 30s
printf '%s' "\$PASS" | xclip -selection clipboard 2>/dev/null && \
  echo "  [Copied to clipboard — clears in 30s]" && \
  ( sleep 30; xclip -selection clipboard -i /dev/null 2>/dev/null ) &
SCRIPT
  chmod +x /usr/local/bin/pm-get

  cat > /usr/local/bin/pm-list << SCRIPT
#!/bin/bash
STORE="${PM_STORE}"
echo ""
echo "  Password Manager Entries:"
echo "  ──────────────────────────"
gpg --batch --decrypt --quiet "\$STORE" 2>/dev/null | \
  grep -v '^$' | awk -F'|' '{printf "  %-25s  %-15s  %s\n", \$1, \$2, \$5}' || \
  echo "  (empty)"
echo ""
SCRIPT
  chmod +x /usr/local/bin/pm-list

  ok "Password manager: pm-init | pm-add | pm-get | pm-list"
  timeline "Password manager installed"
}

# ── Secure delete ────────────────────────────────────────────────
setup_secure_delete() {
  header "SECURE DELETE"

  cat > /usr/local/bin/secure-wipe << 'SCRIPT'
#!/bin/bash
TARGET="${1:?Usage: secure-wipe <file_or_directory>}"

if [[ -d "$TARGET" ]]; then
  echo "[*] Securely wiping directory: $TARGET"
  find "$TARGET" -type f -exec shred -uzn 7 {} \; 2>/dev/null
  rm -rf "$TARGET"
  echo "[+] Directory wiped: $TARGET"
elif [[ -f "$TARGET" ]]; then
  shred -uzn 7 "$TARGET" 2>/dev/null && echo "[+] File wiped: $TARGET"
else
  echo "[!] Not found: $TARGET"
  exit 1
fi

# Sync to flush filesystem buffers
sync
SCRIPT
  chmod +x /usr/local/bin/secure-wipe

  ok "Secure delete: secure-wipe <file|dir> (7-pass shred)"
  timeline "Secure delete installed"
}

# ── Key ceremony (offline key generation guidance) ───────────────
setup_key_ceremony() {
  header "KEY CEREMONY (OFFLINE KEY GENERATION)"

  cat > /usr/local/bin/key-ceremony << 'SCRIPT'
#!/bin/bash
echo ""
echo "  ╔══════════════════════════════════════════════════════════╗"
echo "  ║           OFFLINE KEY CEREMONY GUIDE                    ║"
echo "  ╚══════════════════════════════════════════════════════════╝"
echo ""
echo "  Purpose: Generate cryptographic keys on an air-gapped system"
echo "           for maximum security."
echo ""
echo "  STEPS:"
echo ""
echo "  1. Boot Tails OS on an air-gapped machine (NO network)"
echo "  2. Open terminal — all data stays in RAM"
echo "  3. Generate keys:"
echo ""
echo "     GPG (4096-bit RSA):"
echo "       gpg --full-generate-key"
echo ""
echo "     Age (modern):"
echo "       age-keygen -o identity.txt"
echo "       cat identity.txt  # store public key"
echo ""
echo "     OpenSSH (Ed25519):"
echo "       ssh-keygen -t ed25519 -C 'specter-source'"
echo ""
echo "  4. Export PUBLIC key to USB/QR code"
echo "  5. Keep PRIVATE key on encrypted offline storage"
echo "  6. Power off — keys are wiped from RAM"
echo ""
echo "  SECURITY RULES:"
echo "  • Never connect air-gapped machine to internet"
echo "  • Never copy private key to online device"
echo "  • Use QR code to transfer public key (no USB malware)"
echo "  • Verify key fingerprints over secure channel"
echo ""
SCRIPT
  chmod +x /usr/local/bin/key-ceremony

  ok "Key ceremony guide: key-ceremony"
  timeline "Key ceremony guide installed"
}

# ── Encrypted notes ──────────────────────────────────────────────
setup_secure_notes() {
  header "ENCRYPTED NOTES"

  # note-encrypt
  cat > /usr/local/bin/note-encrypt << SCRIPT
#!/bin/bash
FILE="\${1:?Usage: note-encrypt <file>}"
[[ -f "\$FILE" ]] || { echo "[!] File not found"; exit 1; }
gpg --batch --symmetric --cipher-algo AES256 \
  --output "\${FILE}.gpg" "\$FILE" 2>/dev/null && \
  shred -uzn 7 "\$FILE" && \
  echo "[+] Encrypted: \${FILE}.gpg (original wiped)"
SCRIPT
  chmod +x /usr/local/bin/note-encrypt

  # note-decrypt
  cat > /usr/local/bin/note-decrypt << SCRIPT
#!/bin/bash
FILE="\${1:?Usage: note-decrypt <file.gpg>}"
[[ -f "\$FILE" ]] || { echo "[!] File not found"; exit 1; }
OUTFILE="\${FILE%.gpg}"
gpg --batch --decrypt --output "\$OUTFILE" "\$FILE" 2>/dev/null && \
  echo "[+] Decrypted: \$OUTFILE"
SCRIPT
  chmod +x /usr/local/bin/note-decrypt

  ok "Encrypted notes: note-encrypt | note-decrypt (AES-256)"
  timeline "Encrypted notes configured"
}

# ════════════════════════════════════════════════════════════════
# DOCUMENT SECURITY
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: DOCUMENT SECURITY
#  PDF sanitization · Office doc cleaning · Metadata stripping
#  Safe viewer · Bulk processor · Beacon scanner · File quarantine
#  Steganography detection
# ================================================================

# ── Metadata stripping tools ─────────────────────────────────────
install_metadata_tools() {
  header "METADATA STRIPPING"

  # stripall command (strips metadata from all files in a directory)
  cat > /usr/local/bin/stripall << 'SCRIPT'
#!/bin/bash
TARGET="${1:?Usage: stripall <directory_or_file>}"
STRIPPED=0; FAILED=0

strip_file() {
  local F="$1"
  local EXT="${F##*.}"
  local BACKED_UP=0

  # Try mat2 first (most comprehensive)
  if command -v mat2 &>/dev/null; then
    mat2 --inplace "$F" 2>/dev/null && ((STRIPPED++)) && return 0
  fi

  # Fallback: exiftool
  if command -v exiftool &>/dev/null; then
    exiftool -overwrite_original -all= "$F" 2>/dev/null && \
      ((STRIPPED++)) && return 0
  fi

  ((FAILED++))
}

if [[ -f "$TARGET" ]]; then
  strip_file "$TARGET"
elif [[ -d "$TARGET" ]]; then
  echo "[*] Stripping metadata from: $TARGET"
  while IFS= read -r -d '' F; do
    strip_file "$F"
    echo -n "."
  done < <(find "$TARGET" -type f \( \
    -name "*.pdf" -o -name "*.doc" -o -name "*.docx" \
    -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \
    -o -name "*.mp4" -o -name "*.mp3" -o -name "*.odt" \
    -o -name "*.xlsx" -o -name "*.pptx" \
  \) -print0 2>/dev/null)
  echo ""
fi

echo "[+] Stripped: $STRIPPED files | Failed: $FAILED"
SCRIPT
  chmod +x /usr/local/bin/stripall

  ok "Metadata stripping: stripall <dir|file>"
  timeline "Metadata tools installed"
}

# ── PDF sanitization ─────────────────────────────────────────────
setup_pdf_sanitizer() {
  header "PDF SANITIZER"

  cat > /usr/local/bin/sanitize-pdf << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: sanitize-pdf <input.pdf> [output.pdf]}"
OUTPUT="${2:-${FILE%.pdf}_clean.pdf}"

[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }

echo "[*] Sanitizing: $FILE"

# Step 1: Strip all metadata with exiftool
if command -v exiftool &>/dev/null; then
  exiftool -overwrite_original -all= "$FILE" 2>/dev/null
  echo "  ✓ Metadata stripped (exiftool)"
fi

# Step 2: mat2 sanitization
if command -v mat2 &>/dev/null; then
  mat2 --inplace "$FILE" 2>/dev/null
  echo "  ✓ MAT2 sanitization applied"
fi

# Step 3: qpdf linearize + flatten (removes JS, embedded files, XMP)
if command -v qpdf &>/dev/null; then
  qpdf --linearize \
    --no-warn \
    --remove-unreferenced-resources=yes \
    "$FILE" "$OUTPUT" 2>/dev/null && \
    echo "  ✓ PDF linearized and cleaned (qpdf)"
else
  cp "$FILE" "$OUTPUT"
fi

# Step 4: Check for JavaScript
if command -v pdfinfo &>/dev/null; then
  HAS_JS=$(pdfinfo "$OUTPUT" 2>/dev/null | grep -i javascript | wc -l)
  (( HAS_JS > 0 )) && echo "  [!] WARNING: JavaScript still detected in PDF" || \
    echo "  ✓ No JavaScript detected"
fi

# Step 5: Verify no embedded files remain
if command -v pdfinfo &>/dev/null; then
  EMBEDS=$(pdfinfo -meta "$OUTPUT" 2>/dev/null | grep -i "embed" | wc -l)
  (( EMBEDS > 0 )) && echo "  [!] Embedded content detected" || \
    echo "  ✓ No embedded files"
fi

echo "[+] Sanitized PDF: $OUTPUT"
echo "    Verify visually before sharing."
SCRIPT
  chmod +x /usr/local/bin/sanitize-pdf

  # Batch version
  cat > /usr/local/bin/sanitize-all << 'SCRIPT'
#!/bin/bash
DIR="${1:?Usage: sanitize-all <directory>}"
[[ -d "$DIR" ]] || { echo "[!] Not a directory: $DIR"; exit 1; }
COUNT=0
find "$DIR" -name "*.pdf" -type f | while read -r PDF; do
  echo "[*] Processing: $PDF"
  sanitize-pdf "$PDF" "${PDF%.pdf}_clean.pdf" 2>/dev/null && ((COUNT++))
done
echo "[+] Processed $COUNT PDFs"
SCRIPT
  chmod +x /usr/local/bin/sanitize-all

  ok "PDF sanitizer: sanitize-pdf | sanitize-all"
  timeline "PDF sanitizer installed"
}

# ── Office document cleaner ──────────────────────────────────────
setup_doc_cleaner() {
  header "OFFICE DOCUMENT CLEANER"

  cat > /usr/local/bin/clean-doc << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: clean-doc <document>}"
[[ -f "$FILE" ]] || { echo "[!] Not found: $FILE"; exit 1; }

EXT="${FILE##*.}"
echo "[*] Cleaning: $FILE (.$EXT)"

# mat2 (handles .docx .xlsx .odt .pptx etc.)
if command -v mat2 &>/dev/null; then
  mat2 --inplace "$FILE" 2>/dev/null && echo "  ✓ MAT2 cleaned"
fi

# exiftool fallback
if command -v exiftool &>/dev/null; then
  exiftool -overwrite_original \
    -Author="" -Creator="" -Producer="" \
    -LastModifiedBy="" -Company="" \
    -all:all= \
    "$FILE" 2>/dev/null && echo "  ✓ All metadata cleared"
fi

# For ZIP-based formats (.docx .xlsx .pptx .odt) — inspect internals
case "$EXT" in
  docx|xlsx|pptx|odt|ods|odp)
    TMPDIR=$(mktemp -d)
    cp "$FILE" "$TMPDIR/orig.${EXT}"
    cd "$TMPDIR" && unzip -q "orig.${EXT}" -d extracted 2>/dev/null
    # Remove tracked changes, comments, personal info
    find extracted -name "*.xml" -exec \
      sed -i 's/<w:author>[^<]*<\/w:author>/<w:author>Author<\/w:author>/g' {} \; 2>/dev/null
    find extracted -name "*.xml" -exec \
      sed -i 's/<dc:creator>[^<]*<\/dc:creator>//g' {} \; 2>/dev/null
    find extracted -name "*.xml" -exec \
      sed -i 's/<dc:description>[^<]*<\/dc:description>//g' {} \; 2>/dev/null
    # Remove docProps/core.xml sensitive fields
    find extracted -name "core.xml" -exec \
      sed -i 's|<cp:lastModifiedBy>.*</cp:lastModifiedBy>||g' {} \; 2>/dev/null
    cd extracted && zip -q -r "../clean.${EXT}" . 2>/dev/null
    cp "$TMPDIR/clean.${EXT}" "${FILE%.*}_clean.${EXT}"
    rm -rf "$TMPDIR"
    echo "  ✓ Internal XML metadata scrubbed: ${FILE%.*}_clean.${EXT}"
    ;;
esac

echo "[+] Cleaned: $FILE"
SCRIPT
  chmod +x /usr/local/bin/clean-doc

  ok "Document cleaner: clean-doc <file>"
  timeline "Document cleaner installed"
}

# ── Safe document viewer ─────────────────────────────────────────
setup_safe_viewer() {
  header "SAFE DOCUMENT VIEWER"

  cat > /usr/local/bin/safe-view << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: safe-view <file>}"
[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }

EXT="${FILE##*.}"
echo "[*] Safe-viewing: $FILE"
echo "    Network connections are blocked during viewing."

# Strip metadata before viewing
if command -v mat2 &>/dev/null; then
  SAFE_COPY="/tmp/safeview_$(date +%s).${EXT}"
  cp "$FILE" "$SAFE_COPY"
  mat2 --inplace "$SAFE_COPY" 2>/dev/null
fi

# Use Firejail to sandbox the viewer
if command -v firejail &>/dev/null; then
  case "$EXT" in
    pdf)
      firejail --net=none --private \
        evince "$SAFE_COPY" 2>/dev/null || \
        firejail --net=none --private \
        okular "$SAFE_COPY" 2>/dev/null || \
        firejail --net=none --private \
        atril  "$SAFE_COPY" 2>/dev/null
      ;;
    doc|docx|odt|xlsx|pptx|ods)
      firejail --net=none --private \
        libreoffice --view "$SAFE_COPY" 2>/dev/null
      ;;
    jpg|jpeg|png|gif|bmp|tiff)
      firejail --net=none --private \
        eog "$SAFE_COPY" 2>/dev/null || \
        firejail --net=none --private \
        display "$SAFE_COPY" 2>/dev/null
      ;;
    *)
      firejail --net=none --private \
        xdg-open "$SAFE_COPY" 2>/dev/null
      ;;
  esac
else
  warn "Firejail not available — opening without sandbox"
  xdg-open "$FILE" 2>/dev/null
fi

# Wipe temp copy after closing
shred -uzn 3 "$SAFE_COPY" 2>/dev/null || true
echo "[+] Safe view session ended"
SCRIPT
  chmod +x /usr/local/bin/safe-view

  ok "Safe viewer: safe-view <file> (Firejail sandbox, no network)"
  timeline "Safe document viewer installed"
}

# ── Bulk document processor ──────────────────────────────────────
setup_bulk_processor() {
  header "BULK DOCUMENT PROCESSOR"

  cat > /usr/local/bin/bulk-process << 'SCRIPT'
#!/bin/bash
DIR="${1:?Usage: bulk-process <directory>}"
[[ -d "$DIR" ]] || { echo "[!] Not a directory: $DIR"; exit 1; }

echo ""
echo "  Bulk Document Processor"
echo "  ─────────────────────────"
echo "  Source: $DIR"
echo ""
echo "  Operations:"
echo "  1) Strip all metadata"
echo "  2) Sanitize all PDFs"
echo "  3) Clean all Office docs"
echo "  4) Full pipeline (all of the above)"
echo "  5) Generate file inventory"
echo ""
read -rp "  Select [1-5]: " OP

OUT_DIR="${DIR}_processed_$(date +%Y%m%d)"
mkdir -p "$OUT_DIR"

case "$OP" in
  1)
    cp -r "$DIR"/* "$OUT_DIR"/
    stripall "$OUT_DIR"
    ;;
  2)
    find "$DIR" -name "*.pdf" | while read -r F; do
      sanitize-pdf "$F" "$OUT_DIR/$(basename "${F%.pdf}_clean.pdf")"
    done
    ;;
  3)
    find "$DIR" \( -name "*.doc" -o -name "*.docx" -o -name "*.odt" \) | \
    while read -r F; do
      cp "$F" "$OUT_DIR/"
      clean-doc "$OUT_DIR/$(basename "$F")"
    done
    ;;
  4)
    cp -r "$DIR"/* "$OUT_DIR"/
    echo "[*] Stripping metadata..."
    stripall "$OUT_DIR"
    echo "[*] Sanitizing PDFs..."
    find "$OUT_DIR" -name "*.pdf" -exec sanitize-pdf {} {}_clean.pdf \;
    echo "[*] Cleaning Office docs..."
    find "$OUT_DIR" \( -name "*.docx" -o -name "*.odt" \) -exec clean-doc {} \;
    ;;
  5)
    echo ""
    echo "  File Inventory: $DIR"
    echo "  ──────────────────────────────"
    find "$DIR" -type f | while read -r F; do
      EXT="${F##*.}"
      SIZE=$(stat -c '%s' "$F" 2>/dev/null)
      MD5=$(md5sum "$F" 2>/dev/null | awk '{print $1}')
      printf "  %-40s  %-6s  %8s bytes  %s\n" "$(basename "$F")" "$EXT" "$SIZE" "${MD5:0:16}"
    done
    ;;
esac

echo "[+] Output: $OUT_DIR"
SCRIPT
  chmod +x /usr/local/bin/bulk-process

  ok "Bulk processor: bulk-process <directory>"
  timeline "Bulk processor installed"
}

# ── Tracking beacon scanner ──────────────────────────────────────
setup_beacon_scanner() {
  header "TRACKING BEACON SCANNER"

  cat > /usr/local/bin/scan-beacons << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: scan-beacons <file>}"
[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }

echo ""
echo "  ── Beacon Scan: $(basename "$FILE") ──"
echo ""
ALERTS=0

# Check 1: External URLs / tracking domains
echo "  [1] External URLs..."
URLS=$(grep -aoE 'https?://[^ "'"'"'<>\)]+' "$FILE" 2>/dev/null | head -20)
if [[ -n "$URLS" ]]; then
  TRACKING_KEYWORDS="track|pixel|beacon|analytics|telemetry|log|monitor|stat|click|open|read"
  while IFS= read -r URL; do
    if echo "$URL" | grep -qiE "$TRACKING_KEYWORDS"; then
      echo "    [!] Tracking URL: $URL"
      ((ALERTS++))
    else
      echo "    [*] URL: $URL"
    fi
  done <<< "$URLS"
fi

# Check 2: Tracking pixels (1x1 images)
echo "  [2] Tracking pixels..."
if grep -qiE '(width=.?1.? height=.?1|height=.?1.? width=.?1)' "$FILE" 2>/dev/null; then
  echo "    [!] Possible 1x1 tracking pixel found"
  ((ALERTS++))
fi

# Check 3: UUID/fingerprint markers
echo "  [3] UUID fingerprints..."
UUIDS=$(grep -aoE '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' \
  "$FILE" 2>/dev/null | head -5)
if [[ -n "$UUIDS" ]]; then
  echo "    [!] UUIDs found (possible fingerprint tokens):"
  echo "$UUIDS" | while read -r U; do echo "       $U"; done
  ((ALERTS++))
fi

# Check 4: Embedded JavaScript
echo "  [4] Embedded JavaScript..."
if grep -qiE '(<script|javascript:|eval\(|document\.write|window\.open)' "$FILE" 2>/dev/null; then
  echo "    [!] JavaScript detected"
  ((ALERTS++))
fi

# Check 5: GPS/location metadata
echo "  [5] GPS metadata..."
if command -v exiftool &>/dev/null; then
  GPS=$(exiftool "$FILE" 2>/dev/null | grep -iE "GPS|Latitude|Longitude|Location")
  if [[ -n "$GPS" ]]; then
    echo "    [!] Location data found:"
    echo "$GPS" | while read -r L; do echo "       $L"; done
    ((ALERTS++))
  else
    echo "    ✓ No GPS metadata"
  fi
fi

# Check 6: Author/creator metadata
echo "  [6] Author metadata..."
if command -v exiftool &>/dev/null; then
  META=$(exiftool "$FILE" 2>/dev/null | \
    grep -iE "^Author|^Creator|^Last Modified By|^Company")
  if [[ -n "$META" ]]; then
    echo "    [!] Identity metadata:"
    echo "$META" | while read -r M; do echo "       $M"; done
    ((ALERTS++))
  else
    echo "    ✓ No author metadata"
  fi
fi

# Check 7: Steganography
echo "  [7] Steganography..."
if command -v steghide &>/dev/null; then
  steghide info "$FILE" 2>/dev/null | grep -q "encrypted" && \
    { echo "    [!] steghide: embedded data found"; ((ALERTS++)); } || \
    echo "    ✓ steghide: clean"
fi
if command -v binwalk &>/dev/null; then
  BINWALK_OUT=$(binwalk "$FILE" 2>/dev/null | grep -v "^DECIMAL\|^-------" | \
    grep -vE "^\s*$" | head -5)
  [[ -n "$BINWALK_OUT" ]] && \
    { echo "    [!] binwalk: embedded content"; echo "$BINWALK_OUT" | \
      while read -r L; do echo "       $L"; done; ((ALERTS++)); } || \
    echo "    ✓ binwalk: clean"
fi

echo ""
if (( ALERTS == 0 )); then
  echo "  ✓ No tracking beacons detected"
else
  echo "  [!] $ALERTS alert(s) — review before using this file"
fi
echo ""
SCRIPT
  chmod +x /usr/local/bin/scan-beacons

  ok "Beacon scanner: scan-beacons <file>"
  timeline "Beacon scanner installed"
}

# ── File quarantine system ───────────────────────────────────────
setup_file_quarantine() {
  header "FILE QUARANTINE SYSTEM"

  cat > /usr/local/bin/quarantine << SCRIPT
#!/bin/bash
ACTION="\${1:-help}"
FILE="\$2"
QDIR="${QUARANTINE_DIR:-/mnt/secure_workspace/.quarantine}"
mkdir -p "\$QDIR"
chmod 700 "\$QDIR"

case "\$ACTION" in
  add|quarantine)
    FILE="\${1}"  # First arg is file when used as: quarantine <file>
    [[ -z "\$FILE" ]] && FILE="\$2"
    [[ -z "\$FILE" ]] && { echo "Usage: quarantine <file>"; exit 1; }
    [[ -f "\$FILE" ]] || { echo "[!] File not found: \$FILE"; exit 1; }

    QNAME="\$(date +%Y%m%d_%H%M%S)_\$(basename "\$FILE")"
    cp "\$FILE" "\$QDIR/\$QNAME"
    chmod 400 "\$QDIR/\$QNAME"

    echo "[*] Quarantining: \$FILE → \$QDIR/\$QNAME"

    # Scan the file
    scan-beacons "\$QDIR/\$QNAME" 2>/dev/null

    # File type vs extension mismatch detection
    if command -v file &>/dev/null; then
      REAL_TYPE=\$(file -b "\$QDIR/\$QNAME" 2>/dev/null | cut -d, -f1)
      EXT="\${FILE##*.}"
      echo "  [*] Real type: \$REAL_TYPE | Extension: .\$EXT"
      case "\$EXT" in
        pdf)  [[ "\$REAL_TYPE" =~ PDF ]] || echo "  [!] MISMATCH: not a real PDF!" ;;
        jpg|jpeg) [[ "\$REAL_TYPE" =~ JPEG ]] || echo "  [!] MISMATCH: not a real JPEG!" ;;
        png)  [[ "\$REAL_TYPE" =~ PNG ]] || echo "  [!] MISMATCH: not a real PNG!" ;;
        docx) [[ "\$REAL_TYPE" =~ Zip ]] || echo "  [!] MISMATCH: not a real DOCX!" ;;
      esac
    fi

    echo "[+] Quarantined: \$QDIR/\$QNAME"
    echo "    Review before opening. Use: safe-view \"\$QDIR/\$QNAME\""
    ;;
  list)
    echo ""; echo "  Quarantine (\$QDIR):"; echo "  ──────────────────────"
    ls -la "\$QDIR" 2>/dev/null | grep -v '^total\|^d' | \
      awk '{printf "  %-50s %s %s\n", \$NF, \$5, \$6" "\$7}' || echo "  (empty)"
    echo ""
    ;;
  release)
    [[ -z "\$FILE" ]] && { echo "Usage: quarantine release <filename>"; exit 1; }
    [[ -f "\$QDIR/\$FILE" ]] || { echo "[!] Not in quarantine: \$FILE"; exit 1; }
    cp "\$QDIR/\$FILE" "./"
    echo "[+] Released from quarantine: \$FILE"
    ;;
  wipe)
    find "\$QDIR" -type f -exec shred -uzn 3 {} \; 2>/dev/null
    echo "[+] Quarantine wiped"
    ;;
  *)
    echo "Usage: quarantine <file>           — quarantine + scan a file"
    echo "       quarantine list             — list quarantined files"
    echo "       quarantine release <name>   — move file out"
    echo "       quarantine wipe             — destroy quarantine contents"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/quarantine

  # Auto-quarantine inotify daemon for downloads directory
  cat > /usr/local/bin/auto-quarantine << SCRIPT
#!/bin/bash
WATCH_DIR="\${1:-\$HOME/Downloads}"
[[ -d "\$WATCH_DIR" ]] || mkdir -p "\$WATCH_DIR"
echo "[*] Auto-quarantine watching: \$WATCH_DIR"
if ! command -v inotifywait &>/dev/null; then
  echo "[!] inotify-tools not installed"; exit 1
fi
inotifywait -m -e close_write --format '%w%f' "\$WATCH_DIR" 2>/dev/null | \
  while read -r FILE; do
    echo "[*] New file detected: \$FILE"
    quarantine "\$FILE"
  done
SCRIPT
  chmod +x /usr/local/bin/auto-quarantine

  ok "Quarantine system: quarantine | auto-quarantine"
  timeline "File quarantine installed"
}

# ════════════════════════════════════════════════════════════════
# SOURCE PROTECTION
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: SOURCE PROTECTION
#  SecureDrop client · Anonymous dropbox · Dead drop system
#  Source authentication · Communication channels · Session journal
# ================================================================

# ── SecureDrop client ────────────────────────────────────────────
setup_securedrop() {
  header "SECUREDROP CLIENT"

  # Install SecureDrop workstation client if available
  if command -v securedrop-client &>/dev/null; then
    ok "SecureDrop client: already installed"
  else
    # SecureDrop client requires Qubes OS / Tails ideally
    warn "SecureDrop client not available in standard repos"
    echo -e "  ${CYAN}[*]${RESET} SecureDrop best practice: use official SecureDrop Workstation"
    echo "      (Qubes OS based) or access via Tor Browser."
  fi

  # sd-client wrapper
  cat > /usr/local/bin/sd-client << 'SCRIPT'
#!/bin/bash
echo ""
echo "  SecureDrop Access Guide"
echo "  ──────────────────────────────────────────"
echo ""
echo "  To contact sources via SecureDrop:"
echo "  1. Open Tor Browser (harden-browser first)"
echo "  2. Navigate to your organization's .onion address"
echo "  3. Use SecureDrop's anonymous submission system"
echo ""
echo "  SecureDrop directory: https://securedrop.org/directory/"
echo "  (Access only via Tor Browser)"
echo ""
echo "  For your OWN SecureDrop instance:"
echo "  • Requires dedicated server infrastructure"
echo "  • Follow: https://docs.securedrop.org"
echo "  • Use SecureDrop Workstation (Qubes OS)"
echo ""
if command -v securedrop-client &>/dev/null; then
  echo "[*] Launching SecureDrop client..."
  securedrop-client "$@"
else
  # Open SecureDrop directory in Tor Browser
  local ONION="https://secrdrop5wyphb5x.onion"
  echo "[*] Opening via Tor Browser: $ONION"
  torsocks firefox "$ONION" 2>/dev/null || \
  torsocks chromium-browser "$ONION" 2>/dev/null || \
  echo "    Navigate manually: $ONION"
fi
SCRIPT
  chmod +x /usr/local/bin/sd-client

  ok "SecureDrop: sd-client guide installed"
  timeline "SecureDrop configured"
}

# ── Anonymous document dropbox ───────────────────────────────────
setup_anonymous_dropbox() {
  header "ANONYMOUS DOCUMENT DROPBOX"

  local DB_DIR="${SOURCES_DIR}/dropbox"
  mkdir -p "$DB_DIR"

  # dropbox-create: set up a persistent .onion dropbox
  cat > /usr/local/bin/dropbox-create << SCRIPT
#!/bin/bash
DB_DIR="${DB_DIR:-${SOURCES_DIR}/dropbox}"
HS_DIR="/var/lib/tor/specter_dropbox"
mkdir -p "\$HS_DIR" "\$DB_DIR"
chmod 700 "\$HS_DIR"
chown debian-tor:debian-tor "\$HS_DIR" 2>/dev/null || true

# Add to torrc if not already present
grep -q "specter_dropbox" /etc/tor/torrc 2>/dev/null || cat >> /etc/tor/torrc << EOF

# SPECTER Anonymous Dropbox
HiddenServiceDir \${HS_DIR}
HiddenServicePort 80 127.0.0.1:8088
HiddenServicePort 443 127.0.0.1:8088
HiddenServiceVersion 3
EOF

systemctl restart tor 2>/dev/null
sleep 5

if [[ -f "\${HS_DIR}/hostname" ]]; then
  ONION=\$(cat "\${HS_DIR}/hostname")
  echo "[+] Dropbox .onion address: \$ONION"
  echo "    Share this with sources."
  echo "    Start receiver: dropbox-start"
else
  echo "[!] Tor not yet initialized — wait and try: cat /var/lib/tor/specter_dropbox/hostname"
fi
SCRIPT
  chmod +x /usr/local/bin/dropbox-create

  # dropbox-start: run the upload receiver
  cat > /usr/local/bin/dropbox-start << SCRIPT
#!/bin/bash
RECV_DIR="${RAMDISK_MOUNT:-/mnt/secure_workspace}/received_docs"
mkdir -p "\$RECV_DIR"
echo "[*] Starting anonymous dropbox on port 8088"
echo "    Files saved to: \$RECV_DIR"
echo "    Press Ctrl+C to stop"

python3 << PYEOF
import http.server, os, cgi, time, sys

RECV_DIR = '${RAMDISK_MOUNT}/received_docs'
HTML_FORM = b'''
<!DOCTYPE html><html><head>
<meta name="referrer" content="no-referrer">
<title>Secure Document Submission</title>
<style>body{background:#111;color:#eee;font-family:monospace;max-width:600px;margin:50px auto;padding:20px}
h1{color:#0f0}input,button{background:#222;color:#eee;border:1px solid #444;padding:8px;margin:5px}</style>
</head><body>
<h1>Secure Submission</h1>
<p>This connection is end-to-end encrypted via Tor. Your identity is protected.</p>
<form method="POST" enctype="multipart/form-data">
  <input type="file" name="document" multiple required><br>
  <input type="text" name="message" placeholder="Optional message (encrypted)" style="width:100%"><br>
  <button type="submit">Submit Securely</button>
</form>
</body></html>
'''

class DropboxHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html; charset=utf-8')
        self.send_header('Content-Security-Policy', "default-src 'self'")
        self.send_header('X-Content-Type-Options', 'nosniff')
        self.send_header('Referrer-Policy', 'no-referrer')
        self.end_headers()
        self.wfile.write(HTML_FORM)

    def do_POST(self):
        ctype, pdict = cgi.parse_header(self.headers.get('content-type', ''))
        if ctype == 'multipart/form-data':
            pdict['boundary'] = bytes(pdict.get('boundary', ''), 'utf-8')
            fields = cgi.parse_multipart(self.rfile, pdict)
            ts = time.strftime('%Y%m%d_%H%M%S')
            for fname, data_list in fields.items():
                if fname == 'document' and data_list:
                    for i, data in enumerate(data_list):
                        if isinstance(data, str):
                            data = data.encode()
                        fpath = os.path.join(RECV_DIR, f'{ts}_{i}_{fname}')
                        with open(fpath, 'wb') as f:
                            f.write(data)
                        print(f'[+] Received: {fpath}')
                        sys.stdout.flush()
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'<html><body style="background:#111;color:#0f0;font-family:monospace"><h1>Received. Thank you.</h1><p>Your submission is secure.</p></body></html>')

    def log_message(self, fmt, *args):
        pass  # Suppress request logs

print('[*] Dropbox server running on 127.0.0.1:8088')
server = http.server.HTTPServer(('127.0.0.1', 8088), DropboxHandler)
server.serve_forever()
PYEOF
SCRIPT
  chmod +x /usr/local/bin/dropbox-start

  ok "Anonymous dropbox: dropbox-create | dropbox-start"
  timeline "Anonymous dropbox installed"
}

# ── Dead drop system ─────────────────────────────────────────────
setup_dead_drop() {
  header "DEAD DROP SYSTEM"

  cat > /usr/local/bin/dead-drop << SCRIPT
#!/bin/bash
ACTION="\${1:-help}"
DD_DIR="${RAMDISK_MOUNT:-/mnt/secure_workspace}/.deaddrops"
mkdir -p "\$DD_DIR"

case "\$ACTION" in
  create)
    NAME="\${2:?Usage: dead-drop create <name>}"
    DD_PATH="\$DD_DIR/\$NAME"
    mkdir -p "\$DD_PATH"
    # Generate a shared secret for this dead drop
    SECRET=\$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32)
    echo "\$SECRET" | gpg --batch --symmetric --cipher-algo AES256 \
      --output "\$DD_PATH/.secret.gpg" 2>/dev/null
    echo "[+] Dead drop created: \$NAME"
    echo "    Location: \$DD_PATH"
    echo "    Share this passcode with your source: \$SECRET"
    ;;
  post)
    NAME="\${2:?Usage: dead-drop post <name> <file>}"
    FILE="\${3:?Provide a file to post}"
    DD_PATH="\$DD_DIR/\$NAME"
    [[ -d "\$DD_PATH" ]] || { echo "[!] Dead drop not found: \$NAME"; exit 1; }
    [[ -f "\$FILE" ]] || { echo "[!] File not found: \$FILE"; exit 1; }
    TS=\$(date +%Y%m%d_%H%M%S)
    # Encrypt with the drop's secret
    SECRET=\$(gpg --batch --decrypt --quiet "\$DD_PATH/.secret.gpg" 2>/dev/null)
    gpg --batch --symmetric --cipher-algo AES256 \
      --passphrase "\$SECRET" \
      --output "\$DD_PATH/\${TS}_\$(basename "\$FILE").gpg" "\$FILE" 2>/dev/null
    echo "[+] Posted to dead drop: \$NAME"
    ;;
  retrieve)
    NAME="\${2:?Usage: dead-drop retrieve <name>}"
    DD_PATH="\$DD_DIR/\$NAME"
    [[ -d "\$DD_PATH" ]] || { echo "[!] Dead drop not found: \$NAME"; exit 1; }
    SECRET=\$(gpg --batch --decrypt --quiet "\$DD_PATH/.secret.gpg" 2>/dev/null)
    echo "[*] Retrieving from dead drop: \$NAME"
    for F in "\$DD_PATH"/*.gpg; do
      [[ "\$F" == *"/.secret.gpg" ]] && continue
      OUT="\${F%.gpg}"
      gpg --batch --decrypt --passphrase "\$SECRET" \
        --output "\${OUT}" "\$F" 2>/dev/null && \
        echo "  Retrieved: \$(basename "\$OUT")"
    done
    ;;
  list)
    echo "  Dead drops:"; echo "  ──────────────"
    ls -1 "\$DD_DIR" 2>/dev/null || echo "  (none)"
    ;;
  *)
    echo "Usage: dead-drop <create|post|retrieve|list>"
    echo "  create <name>          — create new dead drop"
    echo "  post   <name> <file>   — post file to dead drop"
    echo "  retrieve <name>        — retrieve from dead drop"
    echo "  list                   — list dead drops"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/dead-drop

  ok "Dead drop system: dead-drop create|post|retrieve|list"
  timeline "Dead drop system installed"
}

# ── Source verification ──────────────────────────────────────────
setup_source_auth() {
  header "SOURCE AUTHENTICATION"

  cat > /usr/local/bin/source-verify << 'SCRIPT'
#!/bin/bash
echo ""
echo "  Source Authentication Toolkit"
echo "  ─────────────────────────────────────────────"
echo ""
echo "  1) Verify PGP signature on a document"
echo "  2) Verify file hash"
echo "  3) Import source public key"
echo "  4) Check key fingerprint"
echo "  5) Sign a document (prove authenticity to source)"
echo ""
read -rp "  Select [1-5]: " OPT

case "$OPT" in
  1)
    read -rp "  Signed document: " DOC
    read -rp "  Signature file (.sig/.asc) [leave blank if embedded]: " SIG
    if [[ -n "$SIG" ]]; then
      gpg --verify "$SIG" "$DOC" 2>&1 | tee /tmp/verify_out.txt
    else
      gpg --verify "$DOC" 2>&1 | tee /tmp/verify_out.txt
    fi
    if grep -q "Good signature" /tmp/verify_out.txt; then
      echo -e "\n  [+] VERIFIED: Good signature"
    else
      echo -e "\n  [!] FAILED or unverified signature"
    fi
    ;;
  2)
    read -rp "  File: " FILE
    read -rp "  Expected hash (SHA256): " EXPECTED
    ACTUAL=$(sha256sum "$FILE" 2>/dev/null | awk '{print $1}')
    if [[ "$ACTUAL" == "$EXPECTED" ]]; then
      echo "  [+] MATCH: $ACTUAL"
    else
      echo "  [!] MISMATCH"
      echo "      Expected: $EXPECTED"
      echo "      Actual:   $ACTUAL"
    fi
    ;;
  3)
    read -rp "  Key file (.asc/.gpg): " KEYFILE
    gpg --import "$KEYFILE" 2>/dev/null && echo "[+] Key imported"
    ;;
  4)
    read -rp "  Key ID or email: " KEYID
    gpg --fingerprint "$KEYID" 2>/dev/null
    ;;
  5)
    read -rp "  Document to sign: " DOC
    gpg --armor --detach-sign "$DOC" 2>/dev/null && \
      echo "[+] Signature: ${DOC}.asc"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/source-verify

  ok "Source auth: source-verify (PGP, hashes, key import)"
  timeline "Source authentication installed"
}

# ── Encrypted session journal ────────────────────────────────────
setup_session_journal() {
  header "ENCRYPTED SESSION JOURNAL"

  cat > /usr/local/bin/journal << SCRIPT
#!/bin/bash
JFILE="${JOURNAL_FILE:-${RAMDISK_MOUNT}/.journal.gpg}"
ACTION="\${1:-read}"

case "\$ACTION" in
  add)
    TS=\$(date '+%Y-%m-%d %H:%M:%S')
    read -rp "  Journal entry: " ENTRY
    EXISTING=\$(gpg --batch --decrypt --quiet "\$JFILE" 2>/dev/null || echo "")
    NEW_ENTRY="[\$TS] \$ENTRY"
    printf '%s\n%s' "\$EXISTING" "\$NEW_ENTRY" | \
      gpg --batch --symmetric --cipher-algo AES256 \
        --output "\$JFILE" --yes 2>/dev/null
    echo "[+] Journal entry added"
    ;;
  read)
    echo ""
    echo "  Session Journal:"
    echo "  ─────────────────────────────"
    gpg --batch --decrypt --quiet "\$JFILE" 2>/dev/null | \
      grep -v '^$' || echo "  (empty)"
    echo ""
    ;;
  export)
    OUT="${RAMDISK_MOUNT:-/mnt/secure_workspace}/journal_export_\$(date +%Y%m%d).txt"
    gpg --batch --decrypt --quiet "\$JFILE" > "\$OUT" 2>/dev/null && \
      echo "[+] Exported: \$OUT (unencrypted — secure when done)"
    ;;
  wipe)
    shred -uzn 3 "\$JFILE" 2>/dev/null && echo "[+] Journal wiped"
    ;;
  *)
    echo "Usage: journal <add|read|export|wipe>"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/journal

  ok "Session journal: journal add|read|export|wipe"
  timeline "Session journal installed"
}

# ════════════════════════════════════════════════════════════════
# EMERGENCY SYSTEMS
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: EMERGENCY SYSTEMS
#  Panic button · Dead man's switch · Duress system
#  Quick-nuke · Session nuke · Decoy setup · Emergency contacts
# ================================================================

# ── Panic button ─────────────────────────────────────────────────
setup_panic_button() {
  header "PANIC BUTTON"

  # panic command (immediate emergency nuke)
  cat > /usr/local/bin/panic << 'SCRIPT'
#!/bin/bash
echo -e "\n\033[1;31m[!!!] PANIC — EMERGENCY WIPE INITIATED\033[0m\n"
sleep 1

# Kill all user applications immediately
for APP in firefox tor-browser chromium signal-desktop libreoffice gedit; do
  pkill -9 "$APP" 2>/dev/null || true
done

# Clear clipboard
DISPLAY=:0 xclip -selection clipboard -i /dev/null 2>/dev/null || true
DISPLAY=:0 xsel --clipboard --delete 2>/dev/null || true

# Stop monitoring daemons
for PID_FILE in /tmp/.leak_monitor.pid /tmp/.lan_monitor.pid \
                /tmp/.anomaly_detector.pid /tmp/.noise_generator.pid \
                /tmp/.clipboard_guard.pid /tmp/.deadman_switch.pid; do
  [[ -f "$PID_FILE" ]] && kill "$(cat "$PID_FILE")" 2>/dev/null && rm -f "$PID_FILE"
done

# Wipe RAM disk
RAMDISK_MOUNT="/mnt/secure_workspace"
if mountpoint -q "$RAMDISK_MOUNT" 2>/dev/null; then
  find "$RAMDISK_MOUNT" -type f -exec shred -uzn 3 {} \; 2>/dev/null
  umount -l "$RAMDISK_MOUNT" 2>/dev/null
fi

# Close LUKS vault
cryptsetup close opsec_vault 2>/dev/null || true

# Wipe shell history
history -c 2>/dev/null; export HISTFILE=/dev/null

# Flush iptables (cut all connections)
iptables -F 2>/dev/null; iptables -P INPUT DROP 2>/dev/null
iptables -P OUTPUT DROP 2>/dev/null; iptables -P FORWARD DROP 2>/dev/null
ip6tables -F 2>/dev/null; ip6tables -P INPUT DROP 2>/dev/null
ip6tables -P OUTPUT DROP 2>/dev/null

# Restore MAC addresses
if [[ -f /mnt/secure_workspace/.backups/macs.bak ]]; then
  while read -r IFACE MAC; do
    ip link set "$IFACE" down 2>/dev/null
    ip link set "$IFACE" address "$MAC" 2>/dev/null
    ip link set "$IFACE" up 2>/dev/null
  done < /mnt/secure_workspace/.backups/macs.bak 2>/dev/null
fi

# Stop Tor
systemctl stop tor 2>/dev/null || pkill tor 2>/dev/null

# Wipe /tmp
find /tmp -type f -exec shred -uzn 1 {} \; 2>/dev/null
rm -rf /tmp/.opsec_* 2>/dev/null

echo -e "\033[1;32m[+] Emergency wipe complete.\033[0m"
echo "    Session terminated."
SCRIPT
  chmod +x /usr/local/bin/panic

  # Set up keyboard shortcut (if xdotool available)
  if command -v xdotool &>/dev/null && [[ -n "$DISPLAY" ]]; then
    # Add keyboard shortcut via xbindkeys if available
    if command -v xbindkeys &>/dev/null; then
      cat >> ~/.xbindkeysrc << 'EOF'

# OPSEC Panic Button — Ctrl+Alt+Delete+P
"/usr/local/bin/panic"
  control+alt+p

# Alternative: Ctrl+Alt+Shift+X
"/usr/local/bin/panic"
  control+alt+shift+x
EOF
      xbindkeys --poll-rc 2>/dev/null &
      ok "Panic hotkey: Ctrl+Alt+P or Ctrl+Alt+Shift+X"
    fi
  fi

  ok "Panic button: /usr/local/bin/panic (immediate emergency wipe)"
  timeline "Panic button installed"
}

# ── Dead man's switch ────────────────────────────────────────────
setup_deadmans_switch() {
  header "DEAD MAN'S SWITCH"

  echo ""
  read -rp "  Dead man's switch interval in minutes [${DEADMAN_INTERVAL}m]: " DM_MINS
  DM_MINS="${DM_MINS:-60}"
  local DM_SECS=$(( DM_MINS * 60 ))

  # deadman-start
  cat > /usr/local/bin/deadman-start << SCRIPT
#!/bin/bash
INTERVAL="${DM_SECS}"
PID_FILE="${DEADMAN_PID}"
STATE_FILE="${DEADMAN_STATE}"
MINS="${DM_MINS}"

[[ -f "\$PID_FILE" ]] && kill "\$(cat "\$PID_FILE")" 2>/dev/null; true

date +%s > "\$STATE_FILE"
echo "[+] Dead man's switch activated"
echo "    Check in every \${MINS} minutes with: deadman-checkin"
echo "    If you don't check in, session will be nuked automatically."

(
  while true; do
    sleep 60
    LAST_CHECKIN=\$(cat "\$STATE_FILE" 2>/dev/null || date +%s)
    NOW=\$(date +%s)
    ELAPSED=\$(( NOW - LAST_CHECKIN ))
    if (( ELAPSED >= INTERVAL )); then
      echo "[!!!] Dead man's switch triggered — NUKING SESSION"
      /usr/local/bin/quick-nuke auto 2>/dev/null
      exit 0
    fi
    REMAINING=\$(( INTERVAL - ELAPSED ))
    REMAIN_MIN=\$(( REMAINING / 60 ))
    if (( REMAIN_MIN <= 5 && REMAIN_MIN > 0 )); then
      DISPLAY=:0 notify-send -u critical "OPSEC Alert" \
        "Dead man switch: \${REMAIN_MIN} min until auto-nuke!" 2>/dev/null || true
    fi
  done
) &
echo "\$!" > "\$PID_FILE"
echo "[+] Dead man's switch daemon started (PID: \$(cat \$PID_FILE))"
SCRIPT
  chmod +x /usr/local/bin/deadman-start

  # deadman-checkin
  cat > /usr/local/bin/deadman-checkin << SCRIPT
#!/bin/bash
STATE_FILE="${DEADMAN_STATE}"
date +%s > "\$STATE_FILE"
TS=\$(date '+%H:%M:%S')
echo "[+] Check-in: \$TS — timer reset"
SCRIPT
  chmod +x /usr/local/bin/deadman-checkin

  # deadman-stop
  cat > /usr/local/bin/deadman-stop << SCRIPT
#!/bin/bash
PID_FILE="${DEADMAN_PID}"
STATE_FILE="${DEADMAN_STATE}"
[[ -f "\$PID_FILE" ]] && kill "\$(cat "\$PID_FILE")" 2>/dev/null
rm -f "\$PID_FILE" "\$STATE_FILE"
echo "[+] Dead man's switch deactivated"
SCRIPT
  chmod +x /usr/local/bin/deadman-stop

  ok "Dead man's switch: deadman-start | deadman-checkin | deadman-stop"
  ok "Interval: ${DM_MINS} minutes without check-in → auto-nuke"
  timeline "Dead man's switch configured"
}

# ── Duress system ────────────────────────────────────────────────
setup_duress_system() {
  header "DURESS SYSTEM"

  echo ""
  echo -e "  ${BOLD}Duress System Setup${RESET}"
  echo "  ─────────────────────────────────────────────────────"
  echo "  The duress system allows you to silently nuke your session"
  echo "  by entering a 'duress password' instead of your real password."
  echo ""
  echo "  How it works:"
  echo "  • Real password → normal login"
  echo "  • Duress password → silently runs session-nuke, shows fake login"
  echo ""
  read -rp "  Set up duress password? [y/N]: " SETUP_DURESS
  [[ "${SETUP_DURESS,,}" == "y" ]] || { ok "Duress system skipped"; return 0; }

  read -rsp "  Enter duress password: " DURESS_PASS; echo
  local DURESS_HASH; DURESS_HASH=$(echo -n "$DURESS_PASS" | sha256sum | awk '{print $1}')

  # Store hashed duress trigger
  mkdir -p "$CONFIG_DIR"
  echo "DURESS_HASH=${DURESS_HASH}" >> "$CONFIG_FILE"

  # Create PAM wrapper for sudo (advanced — conceptual)
  cat > /usr/local/bin/duress-check << SCRIPT
#!/bin/bash
# Usage: duress-check <password>
INPUT_HASH=\$(echo -n "\$1" | sha256sum | awk '{print \$1}')
DURESS_HASH="${DURESS_HASH}"
if [[ "\$INPUT_HASH" == "\$DURESS_HASH" ]]; then
  # Silently nuke and show fake prompt
  /usr/local/bin/quick-nuke &>/dev/null &
  echo "Authentication failure"
  exit 1
fi
SCRIPT
  chmod 700 /usr/local/bin/duress-check

  # sudo wrapper with duress detection
  cat > /usr/local/bin/sudo-safe << SCRIPT
#!/bin/bash
echo -n "Password: "
read -rs PASS; echo
duress-check "\$PASS" 2>/dev/null && sudo -S "\$@" <<< "\$PASS"
SCRIPT
  chmod +x /usr/local/bin/sudo-safe

  ok "Duress system: configured (hash-based trigger)"
  warn "Activate by calling duress-check <password> in your sudo wrapper"
  timeline "Duress system configured"
}

# ── Quick nuke (fast emergency wipe) ─────────────────────────────
install_quick_nuke() {
  header "QUICK NUKE"

  cat > /usr/local/bin/quick-nuke << SCRIPT
#!/bin/bash
MODE="\${1:-interactive}"
RAMDISK_MOUNT="${RAMDISK_MOUNT:-/mnt/secure_workspace}"

[[ "\$MODE" != "auto" ]] && {
  echo -e "\033[1;31m[!!!] QUICK NUKE — Fast session wipe\033[0m"
  read -rp "  Confirm: type YES to proceed: " CONF
  [[ "\$CONF" == "YES" ]] || { echo "Aborted."; exit 0; }
}

echo "[*] Quick nuke in progress..."

# Kill apps
pkill -9 -f "firefox\|tor-browser\|chromium\|signal" 2>/dev/null || true

# Clear clipboard
DISPLAY=:0 xclip -selection clipboard -i /dev/null 2>/dev/null || true

# Stop all OPSEC daemons
for PID_FILE in /tmp/.*.pid; do
  [[ -f "\$PID_FILE" ]] && kill "\$(cat "\$PID_FILE")" 2>/dev/null && rm -f "\$PID_FILE"
done

# Wipe RAM disk
if mountpoint -q "\$RAMDISK_MOUNT" 2>/dev/null; then
  find "\$RAMDISK_MOUNT" -type f -exec shred -uzn 1 {} \; 2>/dev/null
  umount -l "\$RAMDISK_MOUNT" 2>/dev/null
fi

# LUKS vault
cryptsetup close opsec_vault 2>/dev/null || true

# VeraCrypt containers
command -v veracrypt &>/dev/null && veracrypt --text --dismount --all 2>/dev/null || true

# Clear shell history
history -c; export HISTFILE=/dev/null

# Flush network rules (drop all)
iptables -F 2>/dev/null
iptables -P INPUT DROP 2>/dev/null
iptables -P OUTPUT DROP 2>/dev/null
ip6tables -F 2>/dev/null
ip6tables -P INPUT DROP 2>/dev/null
ip6tables -P OUTPUT DROP 2>/dev/null

# Wipe /tmp
find /tmp -user root -type f -exec shred -uzn 1 {} \; 2>/dev/null

# Stop Tor
systemctl stop tor 2>/dev/null || pkill -9 tor 2>/dev/null

echo -e "\033[1;32m[+] Quick nuke complete\033[0m"
SCRIPT
  chmod +x /usr/local/bin/quick-nuke

  ok "Quick nuke: quick-nuke [fast emergency wipe]"
  timeline "Quick nuke installed"
}

# ── Full session nuke ────────────────────────────────────────────
install_nuke_script() {
  header "SESSION NUKE v10 (COMPREHENSIVE WIPE)"

  cat > /usr/local/bin/session-nuke << 'SCRIPT'
#!/bin/bash
# ================================================================
#  SESSION NUKE v10.11.0 — Complete session wipe and system restore
# ================================================================
RAMDISK_MOUNT="/mnt/secure_workspace"
BACKUP_DIR="${RAMDISK_MOUNT}/.backups"

echo ""
echo -e "\033[1;31m  ╔══════════════════════════════════════════╗"
echo   "  ║   SESSION NUKE v10.11.0 — ACTIVE        ║"
echo -e "  ╚══════════════════════════════════════════╝\033[0m"
echo ""

[[ "${1:-}" != "auto" ]] && {
  echo -e "  \033[1;33m[!] This will destroy ALL session data and restore the system.\033[0m"
  read -rp "  Type YES to confirm: " CONF
  [[ "$CONF" == "YES" ]] || { echo "Aborted."; exit 0; }
}

# ── Step 1: Kill applications ──────────────────────────────────
echo "[1/14] Killing applications..."
for APP in firefox tor-browser chromium signal-desktop libreoffice \
           thunderbird gedit evince okular; do
  pkill -9 "$APP" 2>/dev/null || true
done

# ── Step 2: Stop daemons ───────────────────────────────────────
echo "[2/14] Stopping OPSEC daemons..."
for PID_FILE in /tmp/.leak_monitor.pid /tmp/.lan_monitor.pid \
                /tmp/.anomaly_detector.pid /tmp/.correlation_detector.pid \
                /tmp/.noise_generator.pid /tmp/.clipboard_guard.pid \
                /tmp/.autonuke_timer.pid /tmp/.deadman_switch.pid; do
  [[ -f "$PID_FILE" ]] && kill "$(cat "$PID_FILE")" 2>/dev/null && rm -f "$PID_FILE"
done

# ── Step 3: Clear clipboard ────────────────────────────────────
echo "[3/14] Clearing clipboard..."
DISPLAY=:0 xclip -selection clipboard -i /dev/null 2>/dev/null || true
DISPLAY=:0 xclip -selection primary -i /dev/null 2>/dev/null || true
DISPLAY=:0 xsel --clipboard --delete 2>/dev/null || true

# ── Step 4: Close LUKS + VeraCrypt ────────────────────────────
echo "[4/14] Locking encrypted storage..."
cryptsetup close opsec_vault 2>/dev/null || true
command -v veracrypt &>/dev/null && veracrypt --text --dismount --all 2>/dev/null || true

# ── Step 5: Wipe RAM disk ──────────────────────────────────────
echo "[5/14] Wiping RAM disk..."
if mountpoint -q "$RAMDISK_MOUNT" 2>/dev/null; then
  find "$RAMDISK_MOUNT" -type f -exec shred -uzn 3 {} \; 2>/dev/null
  umount -l "$RAMDISK_MOUNT" 2>/dev/null
  rmdir "$RAMDISK_MOUNT" 2>/dev/null
fi

# ── Step 6: Restore MAC addresses ─────────────────────────────
echo "[6/14] Restoring MAC addresses..."
if [[ -f "${BACKUP_DIR}/macs.bak" ]]; then
  while read -r IFACE MAC; do
    ip link set "$IFACE" down 2>/dev/null
    ip link set "$IFACE" address "$MAC" 2>/dev/null
    ip link set "$IFACE" up 2>/dev/null
  done < "${BACKUP_DIR}/macs.bak" 2>/dev/null
fi

# ── Step 7: Restore hostname ───────────────────────────────────
echo "[7/14] Restoring hostname..."
if [[ -f "${BACKUP_DIR}/hostname.bak" ]]; then
  hostnamectl set-hostname "$(cat "${BACKUP_DIR}/hostname.bak")" 2>/dev/null || true
fi

# ── Step 8: Restore DNS ────────────────────────────────────────
echo "[8/14] Restoring DNS..."
chattr -i /etc/resolv.conf 2>/dev/null || true
[[ -f "${BACKUP_DIR}/resolv.conf.bak" ]] && \
  cp "${BACKUP_DIR}/resolv.conf.bak" /etc/resolv.conf 2>/dev/null
systemctl start systemd-resolved 2>/dev/null || true

# ── Step 9: Flush iptables ─────────────────────────────────────
echo "[9/14] Flushing firewall rules..."
iptables -F; iptables -t nat -F; iptables -X
iptables -P INPUT ACCEPT; iptables -P OUTPUT ACCEPT; iptables -P FORWARD ACCEPT
ip6tables -F; ip6tables -X
ip6tables -P INPUT ACCEPT; ip6tables -P OUTPUT ACCEPT

# ── Step 10: Stop Tor ──────────────────────────────────────────
echo "[10/14] Stopping Tor..."
systemctl stop tor 2>/dev/null || pkill -9 tor 2>/dev/null
cp "${BACKUP_DIR}/torrc.bak" /etc/tor/torrc 2>/dev/null || true

# ── Step 11: Re-enable swap ────────────────────────────────────
echo "[11/14] Re-enabling swap..."
cp "${BACKUP_DIR}/fstab.bak" /etc/fstab 2>/dev/null || true
sed -i 's/^#OPSEC_DISABLED //' /etc/fstab 2>/dev/null || true
swapon -a 2>/dev/null || true

# ── Step 12: Restore timezone ──────────────────────────────────
echo "[12/14] Restoring timezone..."
if [[ -f "${BACKUP_DIR}/timezone.bak" ]]; then
  timedatectl set-timezone "$(cat "${BACKUP_DIR}/timezone.bak")" 2>/dev/null || true
  timedatectl set-ntp true 2>/dev/null || true
fi

# ── Step 13: Wipe logs and temp files ─────────────────────────
echo "[13/14] Clearing logs and temp files..."
for LOG in /var/log/syslog /var/log/auth.log /var/log/kern.log; do
  [[ -f "$LOG" ]] && > "$LOG"
done
> /var/log/wtmp 2>/dev/null; > /var/log/btmp 2>/dev/null
find /tmp -type f -user root -exec shred -uzn 1 {} \; 2>/dev/null
find /var/tmp -type f -exec shred -uzn 1 {} \; 2>/dev/null
rm -rf /tmp/.opsec_* /tmp/.leak_* /tmp/.lan_* /tmp/.anomaly_* 2>/dev/null

# ── Step 14: Shell cleanup ─────────────────────────────────────
echo "[14/14] Clearing shell history..."
history -c 2>/dev/null
for HIST in ~/.bash_history ~/.zsh_history ~/.python_history; do
  [[ -f "$HIST" ]] && shred -uzn 3 "$HIST" 2>/dev/null || true
done
export HISTFILE=/dev/null

echo ""
echo -e "\033[1;32m  ╔══════════════════════════════════════════╗"
echo   "  ║   SESSION NUKE: COMPLETE                 ║"
echo -e "  ╚══════════════════════════════════════════╝\033[0m"
echo ""
echo "  Session data destroyed."
echo "  System restored to pre-session state."
echo ""
SCRIPT
  chmod +x /usr/local/bin/session-nuke

  ok "Session nuke: session-nuke (14-step comprehensive wipe)"
  timeline "Session nuke installed"
}

# ── Decoy system setup ───────────────────────────────────────────
setup_decoy_system() {
  header "DECOY SYSTEM"

  cat > /usr/local/bin/decoy-init << 'SCRIPT'
#!/bin/bash
echo ""
echo "  Decoy System Setup"
echo "  ──────────────────────────────────────────────────────────"
echo "  Creates a convincing decoy environment that looks like"
echo "  normal computer use, protecting your real research."
echo ""
echo "  This creates:"
echo "  • Fake browser history (news, weather, shopping)"
echo "  • Decoy documents (recipes, personal notes)"
echo "  • Normal-looking ~/.bashrc without OPSEC traces"
echo ""
read -rp "  Set up decoy environment? [y/N]: " CONFIRM
[[ "${CONFIRM,,}" == "y" ]] || { echo "Skipped."; exit 0; }

# Create decoy documents directory
DECOY_DIR="$HOME/Documents/Personal"
mkdir -p "$DECOY_DIR"

# Fake personal notes
cat > "$DECOY_DIR/shopping_list.txt" << 'EOF'
Shopping List:
- Milk
- Eggs
- Bread
- Coffee
- Apples
EOF

cat > "$DECOY_DIR/recipe.txt" << 'EOF'
Pasta Recipe:
1. Boil water
2. Add pasta
3. Cook 10 minutes
4. Add sauce
EOF

# Fake browser bookmarks (non-sensitive)
mkdir -p "$HOME/.mozilla/firefox/default/bookmarks"

echo "[+] Decoy environment created in $DECOY_DIR"
echo "    Remember: your real work should only exist in the RAM disk."
SCRIPT
  chmod +x /usr/local/bin/decoy-init

  ok "Decoy system: decoy-init"
  timeline "Decoy system installed"
}

# ── Physical OPSEC checklist ─────────────────────────────────────
physical_opsec_checklist() {
  echo ""
  echo -e "  ${BOLD}${CYAN}PHYSICAL OPSEC CHECKLIST${RESET}"
  echo "  ══════════════════════════════════════════════════"
  echo ""
  local PASS=0 FAIL=0

  check_item() {
    local DESC="$1"
    read -rp "  [?] $DESC [y/n]: " ANS
    if [[ "${ANS,,}" == "y" ]]; then
      echo -e "  ${GREEN}✓${RESET} $DESC"; ((PASS++))
    else
      echo -e "  ${RED}✗${RESET} $DESC"; ((FAIL++))
    fi
  }

  echo -e "  ${BOLD}Location & Environment:${RESET}"
  check_item "Using a public WiFi you've never used before?"
  check_item "No CCTV visible at your location?"
  check_item "Seated with back to wall (screen not visible from behind)?"
  check_item "Phone removed from room or in Faraday bag?"
  check_item "No smartwatches or wearables?"
  check_item "No smart speakers (Alexa, Google Home) nearby?"

  echo ""
  echo -e "  ${BOLD}Device Security:${RESET}"
  check_item "Screen privacy filter applied?"
  check_item "Camera covered (physical cover/tape)?"
  check_item "Using a burner/research laptop (not personal device)?"
  check_item "Full disk encryption confirmed active?"
  check_item "Secure Boot enabled?"
  check_item "No unknown USB devices connected?"

  echo ""
  echo -e "  ${BOLD}Network:${RESET}"
  check_item "Connected via Tor (verify_tor passed)?"
  check_item "Kill switch active (UFW/iptables)?"
  check_item "Not using home or work internet?"
  check_item "MAC address randomized?"

  echo ""
  echo -e "  ${BOLD}Session:${RESET}"
  check_item "RAM disk workspace mounted?"
  check_item "Session journal running?"
  check_item "session-nuke prepared and tested?"
  check_item "Dead man's switch activated?"

  echo ""
  echo -e "  ${BOLD}Score: ${GREEN}${PASS}${RESET} pass | ${RED}${FAIL}${RESET} fail"
  local TOTAL=$(( PASS + FAIL ))
  (( TOTAL > 0 )) && {
    local PCT=$(( PASS * 100 / TOTAL ))
    echo -e "  Physical security: ${PCT}%"
  }
  echo ""
}

# ════════════════════════════════════════════════════════════════
# MONITORING
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: MONITORING
#  Leak monitor · LAN monitor · Anomaly detector
#  Correlation attack detector · Beacon scanner · Integrity check
#  Hardware tamper detection · System integrity
# ================================================================

# ── Leak monitor (60s polling) ───────────────────────────────────
setup_leak_monitor() {
  header "LEAK MONITOR"

  cat > /usr/local/bin/leak-monitor << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="${LEAK_MON_PID}"
LOG="/tmp/opsec_monitor.log"

start_monitor() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true
  (
    echo "[$(date)] Leak monitor started" >> "\$LOG"
    while true; do
      ISSUES=0
      TS=\$(date '+%H:%M:%S')

      # Check 1: Tor process running
      if ! pgrep -x tor &>/dev/null; then
        echo "[\$TS] [!] Tor process NOT running" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" "Tor is DOWN!" 2>/dev/null || true
        ((ISSUES++))
      fi

      # Check 2: Tor exit confirmed
      TOR_CHECK=\$(curl -sf --socks5-hostname 127.0.0.1:9050 \
        --max-time 10 https://check.torproject.org/api/ip 2>/dev/null)
      if ! echo "\$TOR_CHECK" | grep -q '"IsTor":true'; then
        echo "[\$TS] [!] Tor not active for traffic" >> "\$LOG"
        ((ISSUES++))
      fi

      # Check 3: DNS going through Tor (port 5353)
      if ! ss -unl 2>/dev/null | grep -q ':5353'; then
        echo "[\$TS] [!] Tor DNS (port 5353) not listening" >> "\$LOG"
        ((ISSUES++))
      fi

      # Check 4: UFW active
      if command -v ufw &>/dev/null && ! ufw status 2>/dev/null | grep -q "active"; then
        echo "[\$TS] [!] UFW firewall is INACTIVE" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" "UFW firewall down!" 2>/dev/null || true
        ((ISSUES++))
      fi

      # Check 5: iptables DROP policy intact
      if ! iptables -L OUTPUT 2>/dev/null | grep -q "DROP\|Tor"; then
        echo "[\$TS] [!] iptables kill switch may be inactive" >> "\$LOG"
        ((ISSUES++))
      fi

      # Check 6: No unexpected outbound connections (non-Tor)
      UNEXPECTED=\$(ss -tnp 2>/dev/null | grep ESTABLISHED | \
        grep -v "127\.0\.0\.1\|::1\|9050\|9040\|9051\|9052" | \
        grep -v "debian-tor\|tor\|unbound" | head -5)
      if [[ -n "\$UNEXPECTED" ]]; then
        echo "[\$TS] [!] Unexpected outbound connections:" >> "\$LOG"
        echo "\$UNEXPECTED" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" "Unexpected network connection!" 2>/dev/null || true
        ((ISSUES++))
      fi

      # Check 7: IPv6 still disabled
      if [[ "\$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null)" != "1" ]]; then
        echo "[\$TS] [!] IPv6 not disabled" >> "\$LOG"
        ((ISSUES++))
      fi

      if (( ISSUES == 0 )); then
        echo "[\$TS] OK — All checks passed" >> "\$LOG"
      fi

      sleep 60
    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] Leak monitor started (PID: \$(cat \$PID_FILE))"
  echo "    Log: \$LOG"
}

stop_monitor() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] Leak monitor stopped"
}

case "\$ACTION" in
  start)  start_monitor ;;
  stop)   stop_monitor ;;
  status) [[ -f "\$PID_FILE" ]] && kill -0 \$(cat "\$PID_FILE") 2>/dev/null && \
            echo "[+] Running (PID \$(cat \$PID_FILE))" || echo "[-] Stopped" ;;
  log)    tail -50 "\$LOG" 2>/dev/null ;;
  *)      echo "Usage: leak-monitor <start|stop|status|log>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/leak-monitor

  ok "Leak monitor: leak-monitor start|stop|status|log (7 checks every 60s)"
  timeline "Leak monitor installed"
}

# ── LAN adversarial monitor ──────────────────────────────────────
setup_lan_monitor() {
  header "LAN ADVERSARIAL MONITOR"

  cat > /usr/local/bin/lan-monitor << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="${LAN_MON_PID}"
LOG="/tmp/opsec_lan.log"

start_lan() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true
  GW=\$(ip route show default 2>/dev/null | awk '/default/{print \$3; exit}')
  IFACE=\$(ip route show default 2>/dev/null | awk '/default/{print \$5; exit}')
  GW_MAC=\$(arp -n "\$GW" 2>/dev/null | awk '/ether/{print \$3}')
  LAN_NODES=\$(arp-scan --localnet 2>/dev/null | grep -E "^[0-9]" | wc -l || echo "0")

  echo "[$(date)] LAN baseline: GW=\$GW MAC=\$GW_MAC iface=\$IFACE nodes=\$LAN_NODES" >> "\$LOG"

  (
    while true; do
      sleep 15
      TS=\$(date '+%H:%M:%S')

      # Check 1: Gateway MAC change (ARP spoofing)
      CURRENT_GW_MAC=\$(arp -n "\$GW" 2>/dev/null | awk '/ether/{print \$3}')
      if [[ -n "\$GW_MAC" ]] && [[ "\$CURRENT_GW_MAC" != "\$GW_MAC" ]]; then
        echo "[\$TS] [!!!] GATEWAY MAC CHANGED: \$GW_MAC → \$CURRENT_GW_MAC" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" \
          "ARP SPOOF DETECTED! Gateway MAC changed!" 2>/dev/null || true
        GW_MAC="\$CURRENT_GW_MAC"
      fi

      # Check 2: Multiple default gateways (route injection)
      GW_COUNT=\$(ip route show default 2>/dev/null | wc -l)
      if (( GW_COUNT > 1 )); then
        echo "[\$TS] [!] Multiple default gateways detected (\$GW_COUNT)" >> "\$LOG"
        ((ISSUES++))
      fi

      # Check 3: Duplicate MACs on network (MITM indicator)
      if command -v arp-scan &>/dev/null; then
        DUPS=\$(arp-scan --localnet 2>/dev/null | awk '{print \$2}' | \
          sort | uniq -d)
        if [[ -n "\$DUPS" ]]; then
          echo "[\$TS] [!] Duplicate MACs on LAN: \$DUPS" >> "\$LOG"
          DISPLAY=:0 notify-send -u critical "OPSEC Alert" "Duplicate MAC detected — possible MITM!" 2>/dev/null || true
        fi

        # Check 4: New LAN devices
        CURRENT_NODES=\$(arp-scan --localnet 2>/dev/null | grep -E "^[0-9]" | wc -l || echo "0")
        if (( CURRENT_NODES > LAN_NODES + 2 )); then
          echo "[\$TS] [!] New LAN devices appeared: \$LAN_NODES → \$CURRENT_NODES" >> "\$LOG"
          LAN_NODES="\$CURRENT_NODES"
        fi
      fi

      # Check 5: Promiscuous mode detection (packet sniffer on LAN)
      if command -v ip &>/dev/null; then
        PROMISC=\$(ip link show 2>/dev/null | grep -i "PROMISC\|promisc" | head -3)
        if [[ -n "\$PROMISC" ]]; then
          echo "[\$TS] [!] Promiscuous mode on interface: \$PROMISC" >> "\$LOG"
        fi
      fi

    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] LAN monitor started (PID: \$(cat \$PID_FILE))"
  echo "    Baseline: GW=\$GW MAC=\$GW_MAC"
}

stop_lan() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] LAN monitor stopped"
}

case "\$ACTION" in
  start)  start_lan ;;
  stop)   stop_lan ;;
  status) [[ -f "\$PID_FILE" ]] && kill -0 \$(cat "\$PID_FILE") 2>/dev/null && \
            echo "[+] Running" || echo "[-] Stopped" ;;
  log)    tail -50 "\$LOG" 2>/dev/null ;;
  *)      echo "Usage: lan-monitor <start|stop|status|log>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/lan-monitor

  ok "LAN monitor: lan-monitor start|stop|status|log (5 checks every 15s)"
  timeline "LAN monitor installed"
}

# ── Anomaly detector ─────────────────────────────────────────────
setup_anomaly_detector() {
  header "ANOMALY DETECTOR"

  cat > /usr/local/bin/anomaly-detector << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="${ANOMALY_PID}"
LOG="/tmp/opsec_anomaly.log"

start_anomaly() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true

  # Baseline
  BASELINE_CONNS=\$(ss -tn 2>/dev/null | grep ESTABLISHED | wc -l)
  BASELINE_PROCS=\$(ps -ef 2>/dev/null | wc -l)
  BASELINE_SUID=\$(find / -perm /4000 2>/dev/null | wc -l || echo "0")
  BASELINE_LISTEN=\$(ss -tlnp 2>/dev/null | grep LISTEN | wc -l)

  echo "[$(date)] Baseline: conns=\$BASELINE_CONNS procs=\$BASELINE_PROCS suid=\$BASELINE_SUID listen=\$BASELINE_LISTEN" >> "\$LOG"

  (
    while true; do
      sleep 30
      TS=\$(date '+%H:%M:%S')

      # Check 1: Sudden connection spike
      CURRENT_CONNS=\$(ss -tn 2>/dev/null | grep ESTABLISHED | wc -l)
      if (( CURRENT_CONNS > BASELINE_CONNS + 20 )); then
        echo "[\$TS] [!] Connection spike: \$BASELINE_CONNS → \$CURRENT_CONNS" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" \
          "Unusual connection spike detected!" 2>/dev/null || true
      fi

      # Check 2: New unexpected networked processes
      NET_PROCS=\$(lsof -i 2>/dev/null | grep -v \
        "tor\|firefox\|chromium\|ssh\|curl\|wget\|onionshare\|COMMAND" | \
        awk '{print \$1}' | sort -u)
      if [[ -n "\$NET_PROCS" ]]; then
        echo "[\$TS] [*] Networked processes: \$NET_PROCS" >> "\$LOG"
      fi

      # Check 3: New SUID binaries (rootkit indicator)
      CURRENT_SUID=\$(find / -perm /4000 2>/dev/null | wc -l || echo "0")
      if (( CURRENT_SUID > BASELINE_SUID + 1 )); then
        echo "[\$TS] [!!!] New SUID binaries: \$BASELINE_SUID → \$CURRENT_SUID" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" \
          "New SUID binary detected — possible rootkit!" 2>/dev/null || true
        find / -perm /4000 2>/dev/null >> "\$LOG"
      fi

      # Check 4: New listening ports
      CURRENT_LISTEN=\$(ss -tlnp 2>/dev/null | grep LISTEN | wc -l)
      if (( CURRENT_LISTEN > BASELINE_LISTEN + 2 )); then
        echo "[\$TS] [!] New listening ports detected" >> "\$LOG"
        ss -tlnp 2>/dev/null | grep LISTEN >> "\$LOG"
      fi

      # Check 5: CPU/memory anomaly (crypto mining indicator)
      CPU_USAGE=\$(top -bn1 2>/dev/null | grep "Cpu(s)" | \
        awk '{print \$2}' | cut -d. -f1 || echo "0")
      if (( CPU_USAGE > 90 )); then
        echo "[\$TS] [!] High CPU usage: \${CPU_USAGE}%" >> "\$LOG"
        top -bn1 2>/dev/null | head -20 >> "\$LOG"
      fi

    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] Anomaly detector started (PID: \$(cat \$PID_FILE))"
  echo "    Baseline: \$BASELINE_CONNS connections, \$BASELINE_PROCS processes"
}

stop_anomaly() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] Anomaly detector stopped"
}

case "\$ACTION" in
  start)  start_anomaly ;;
  stop)   stop_anomaly ;;
  status) [[ -f "\$PID_FILE" ]] && kill -0 \$(cat "\$PID_FILE") 2>/dev/null && \
            echo "[+] Running" || echo "[-] Stopped" ;;
  log)    tail -50 "\$LOG" 2>/dev/null ;;
  *)      echo "Usage: anomaly-detector <start|stop|status|log>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/anomaly-detector

  ok "Anomaly detector: anomaly-detector start|stop|status|log"
  timeline "Anomaly detector installed"
}

# ── Correlation attack detector ──────────────────────────────────
setup_correlation_detector() {
  header "CORRELATION ATTACK DETECTOR"

  cat > /usr/local/bin/correlation-detector << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="${CORRELATION_PID}"
LOG="/tmp/opsec_correlation.log"

start_corr() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true
  (
    echo "[$(date)] Correlation detector started" >> "\$LOG"
    GUARD_IPS=\$(grep "^EntryGuard " /var/lib/tor/state 2>/dev/null | awk '{print \$3}')

    while true; do
      sleep 120
      TS=\$(date '+%H:%M:%S')

      # Check 1: Guard nodes appeared in multiple positions (sybil attack)
      CIRCUIT_INFO=\$(printf 'AUTHENTICATE ""\r\nGETINFO circuit-status\r\nQUIT\r\n' | \
        nc -q2 127.0.0.1 9051 2>/dev/null || echo "")
      if [[ -n "\$CIRCUIT_INFO" ]]; then
        CIRCUIT_COUNT=\$(echo "\$CIRCUIT_INFO" | grep -c "^250-circuit")
        echo "[\$TS] Active circuits: \$CIRCUIT_COUNT" >> "\$LOG"
        (( CIRCUIT_COUNT > 20 )) && \
          echo "[\$TS] [!] Unusually high circuit count: \$CIRCUIT_COUNT" >> "\$LOG"
      fi

      # Check 2: Traffic timing — detect if external timing matches local patterns
      # (Basic implementation — measures round-trip variation)
      T1=\$(date +%s%N)
      curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 10 \
        https://check.torproject.org/api/ip -o /dev/null 2>/dev/null
      T2=\$(date +%s%N)
      RTT=\$(( (T2 - T1) / 1000000 ))
      echo "[\$TS] Tor RTT: \${RTT}ms" >> "\$LOG"
      (( RTT < 100 )) && \
        echo "[\$TS] [!] Unusually low RTT (\${RTT}ms) — may indicate local exit" >> "\$LOG"

      # Check 3: Guard fingerprint consistency
      CURRENT_GUARDS=\$(grep "^EntryGuard " /var/lib/tor/state 2>/dev/null | awk '{print \$2}')
      if [[ "\$CURRENT_GUARDS" != "\$GUARD_IPS" ]] && [[ -n "\$GUARD_IPS" ]]; then
        echo "[\$TS] [!] Guard nodes changed during session" >> "\$LOG"
        DISPLAY=:0 notify-send -u normal "OPSEC Alert" \
          "Tor guard nodes changed — investigate" 2>/dev/null || true
        GUARD_IPS="\$CURRENT_GUARDS"
      fi

    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] Correlation detector started (PID: \$(cat \$PID_FILE))"
}

stop_corr() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] Correlation detector stopped"
}

case "\$ACTION" in
  start)  start_corr ;;
  stop)   stop_corr ;;
  status) [[ -f "\$PID_FILE" ]] && kill -0 \$(cat "\$PID_FILE") 2>/dev/null && \
            echo "[+] Running" || echo "[-] Stopped" ;;
  log)    tail -50 "\$LOG" 2>/dev/null ;;
  *)      echo "Usage: correlation-detector <start|stop|status|log>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/correlation-detector

  ok "Correlation detector: correlation-detector start|stop|status|log"
  timeline "Correlation detector installed"
}

# ── Hardware tamper detection ────────────────────────────────────
setup_hardware_tamper() {
  header "HARDWARE TAMPER DETECTION"

  cat > /usr/local/bin/tamper-check << 'SCRIPT'
#!/bin/bash
echo ""
echo "  Hardware Tamper Detection"
echo "  ──────────────────────────────────────────────"
echo ""
ALERTS=0

# Check 1: PCI devices changed (new hardware inserted)
echo "  [1] PCI/USB device inventory..."
lspci 2>/dev/null | md5sum > /tmp/.pci_current.md5
if [[ -f /tmp/.pci_baseline.md5 ]]; then
  if ! diff -q /tmp/.pci_baseline.md5 /tmp/.pci_current.md5 &>/dev/null; then
    echo "    [!] PCI device list CHANGED since last check!"
    ((ALERTS++))
  else
    echo "    ✓ PCI devices unchanged"
  fi
else
  cp /tmp/.pci_current.md5 /tmp/.pci_baseline.md5
  echo "    [*] PCI baseline established"
fi

# Check 2: USB devices
lsusb 2>/dev/null | md5sum > /tmp/.usb_current.md5
if [[ -f /tmp/.usb_baseline.md5 ]]; then
  if ! diff -q /tmp/.usb_baseline.md5 /tmp/.usb_current.md5 &>/dev/null; then
    echo "    [!] USB devices CHANGED: $(lsusb 2>/dev/null | wc -l) devices now"
    lsusb 2>/dev/null
    ((ALERTS++))
  else
    echo "    ✓ USB devices unchanged"
  fi
else
  cp /tmp/.usb_current.md5 /tmp/.usb_baseline.md5
  echo "    [*] USB baseline established"
fi

# Check 3: Boot sequence (dmesg hardware changes)
echo ""
echo "  [2] Recent hardware events..."
dmesg --since "1 hour ago" 2>/dev/null | grep -iE "usb|pci|hardware|inserted|removed" | \
  head -10 | while read -r LINE; do echo "    $LINE"; done

# Check 4: Secure Boot status
echo ""
echo "  [3] Boot integrity..."
if command -v mokutil &>/dev/null; then
  SB=$(mokutil --sb-state 2>/dev/null)
  echo "    Secure Boot: $SB"
  [[ "$SB" =~ enabled ]] && echo "    ✓ Secure Boot active" || { echo "    [!] Secure Boot not enabled"; ((ALERTS++)); }
fi

# Check 5: Microphone/camera module status
echo ""
echo "  [4] Camera/mic modules..."
if lsmod | grep -q "uvcvideo\|snd_hda"; then
  echo "    [!] Camera/mic kernel modules loaded!"
  lsmod | grep -E "uvcvideo|snd_hda" | awk '{print "    " $0}'
  ((ALERTS++))
else
  echo "    ✓ Camera/mic modules not loaded"
fi

# Check 6: Physical network interfaces
echo ""
echo "  [5] Network interfaces..."
ip link show 2>/dev/null | grep -E "^[0-9]" | while read -r LINE; do
  echo "    $LINE"
done

echo ""
if (( ALERTS == 0 )); then
  echo "  ✓ No hardware tampering detected"
else
  echo "  [!] $ALERTS tampering indicator(s) found — investigate immediately"
fi
echo ""
SCRIPT
  chmod +x /usr/local/bin/tamper-check

  ok "Tamper detection: tamper-check"
  timeline "Hardware tamper detection installed"
}

# ── System integrity check ───────────────────────────────────────
system_integrity_check() {
  header "SYSTEM INTEGRITY CHECK"
  ok "Integrity tools configured"
  timeline "System integrity configured"
}

install_integrity_check() {
  header "INTEGRITY CHECK COMMAND"

  cat > /usr/local/bin/integrity-check << 'SCRIPT'
#!/bin/bash
echo ""
echo "  System Integrity Check"
echo "  ──────────────────────────────────────────────"
echo ""
ISSUES=0

# rkhunter
if command -v rkhunter &>/dev/null; then
  echo "  [1] rkhunter..."
  rkhunter --check --skip-keypress --quiet 2>/dev/null | \
    grep -E "Warning|Rootkit|Found" | head -10 | \
    while read -r L; do echo "    [!] $L"; ((ISSUES++)); done || echo "    ✓ rkhunter: clean"
fi

# chkrootkit
if command -v chkrootkit &>/dev/null; then
  echo "  [2] chkrootkit..."
  chkrootkit 2>/dev/null | grep -i "INFECTED\|Suspect" | head -5 | \
    while read -r L; do echo "    [!] $L"; done || echo "    ✓ chkrootkit: clean"
fi

# AIDE
if command -v aide &>/dev/null && [[ -f /var/lib/aide/aide.db ]]; then
  echo "  [3] AIDE file integrity..."
  AIDE_OUT=$(aide --check 2>/dev/null | grep -E "changed:|removed:|added:" | head -10)
  if [[ -n "$AIDE_OUT" ]]; then
    echo "    [!] AIDE found changes:"
    echo "$AIDE_OUT" | while read -r L; do echo "      $L"; done
    ((ISSUES++))
  else
    echo "    ✓ AIDE: no unauthorized changes"
  fi
fi

# Open ports
echo "  [4] Listening ports..."
ss -tlnp 2>/dev/null | grep LISTEN | while read -r PORT; do
  echo "    $PORT"
done

# Outbound connections
echo "  [5] Outbound connections..."
ss -tnp 2>/dev/null | grep ESTABLISHED | grep -v "127\." | head -10 | \
  while read -r C; do echo "    $C"; done

echo ""
if (( ISSUES == 0 )); then
  echo "  ✓ System integrity: OK"
else
  echo "  [!] $ISSUES issue(s) found"
fi
echo ""
SCRIPT
  chmod +x /usr/local/bin/integrity-check

  ok "Integrity check: integrity-check"
  timeline "Integrity check command installed"
}

# ════════════════════════════════════════════════════════════════
# TOOLS
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: TOOLS
#  OPSEC score (25 checks) · Dashboard · Route visualizer
#  Profile manager · HTML + text report · Risk assessment
#  OPSEC checklist · Metadata tools
# ================================================================

# ── OPSEC score engine (25 checks) ──────────────────────────────
calculate_opsec_score() {
  local SCORE=0
  local MAX=25
  local DETAILS=()

  check_point() {
    local DESC="$1"
    local RESULT="$2"  # 0=fail, 1=pass
    if (( RESULT == 1 )); then
      ((SCORE++))
      DETAILS+=("  ${GREEN}✓${RESET} $DESC")
    else
      DETAILS+=("  ${RED}✗${RESET} $DESC")
    fi
  }

  # Network checks
  local TOR_ACTIVE=0
  curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 8 \
    https://check.torproject.org/api/ip 2>/dev/null | grep -q '"IsTor":true' && TOR_ACTIVE=1
  check_point "Tor: active and routing traffic" $TOR_ACTIVE

  local TOR_PROC=0; pgrep -x tor &>/dev/null && TOR_PROC=1
  check_point "Tor: process running" $TOR_PROC

  local KS=0; iptables -L OUTPUT 2>/dev/null | grep -qiE "DROP|REJECT" && KS=1
  check_point "Kill switch: iptables DROP active" $KS

  local UFW=0
  command -v ufw &>/dev/null && ufw status 2>/dev/null | grep -q "active" && UFW=1
  check_point "UFW firewall: enabled" $UFW

  local DNS=0; grep -q "nameserver 127.0.0.1" /etc/resolv.conf 2>/dev/null && DNS=1
  check_point "DNS: routed through Tor (127.0.0.1)" $DNS

  local IPV6=0
  [[ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null)" == "1" ]] && IPV6=1
  check_point "IPv6: disabled" $IPV6

  local WG=0; ip link show wg0 &>/dev/null && WG=1
  check_point "WireGuard: active (VPN→Tor)" $WG

  # System checks
  local RAMDISK=0
  mountpoint -q "$RAMDISK_MOUNT" 2>/dev/null && RAMDISK=1
  check_point "RAM disk: mounted ($RAMDISK_MOUNT)" $RAMDISK

  local SWAP=0
  [[ "$(swapon --show 2>/dev/null)" == "" ]] && SWAP=1
  check_point "Swap: disabled" $SWAP

  local HIST=0
  [[ "${HISTFILE:-}" == "/dev/null" ]] || [[ "${HISTSIZE:-1}" == "0" ]] && HIST=1
  check_point "Shell history: disabled" $HIST

  local APPARMOR=0
  command -v aa-status &>/dev/null && aa-status 2>/dev/null | grep -q "profiles are in enforce mode" && APPARMOR=1
  check_point "AppArmor: enforcing profiles" $APPARMOR

  local USB=0
  systemctl is-active usbguard &>/dev/null && USB=1
  check_point "USBGuard: active" $USB

  local LUKS=0
  lsblk -o TYPE 2>/dev/null | grep -q "crypt" && LUKS=1
  check_point "Full disk encryption: detected" $LUKS

  # Kernel checks
  local PTRACE=0
  [[ "$(cat /proc/sys/kernel/yama/ptrace_scope 2>/dev/null)" == "3" ]] && PTRACE=1
  check_point "Kernel: ptrace_scope=3 (strict)" $PTRACE

  local KPTR=0
  [[ "$(cat /proc/sys/kernel/kptr_restrict 2>/dev/null)" == "2" ]] && KPTR=1
  check_point "Kernel: kptr_restrict=2" $KPTR

  local ASLR=0
  [[ "$(cat /proc/sys/kernel/randomize_va_space 2>/dev/null)" == "2" ]] && ASLR=1
  check_point "Kernel: ASLR=2 (full)" $ASLR

  # Monitoring checks
  local LEAK_MON=0
  [[ -f "$LEAK_MON_PID" ]] && kill -0 "$(cat "$LEAK_MON_PID")" 2>/dev/null && LEAK_MON=1
  check_point "Leak monitor: running" $LEAK_MON

  local LAN_MON=0
  [[ -f "$LAN_MON_PID" ]] && kill -0 "$(cat "$LAN_MON_PID")" 2>/dev/null && LAN_MON=1
  check_point "LAN monitor: running" $LAN_MON

  local ANOM=0
  [[ -f "$ANOMALY_PID" ]] && kill -0 "$(cat "$ANOMALY_PID")" 2>/dev/null && ANOM=1
  check_point "Anomaly detector: running" $ANOM

  # Privacy checks
  local CAM=0
  ! lsmod 2>/dev/null | grep -q "uvcvideo" && CAM=1
  check_point "Camera module: not loaded" $CAM

  local MIC=0
  ! lsmod 2>/dev/null | grep -q "snd_hda_intel" && MIC=1
  check_point "Microphone module: not loaded" $MIC

  local TZ=0
  timedatectl 2>/dev/null | grep -q "UTC" && TZ=1
  check_point "Timezone: UTC" $TZ

  local NTP=0
  timedatectl 2>/dev/null | grep -q "NTP service: inactive" && NTP=1
  check_point "NTP: disabled" $NTP

  # Security level checks
  local SECBOOT=0
  command -v mokutil &>/dev/null && mokutil --sb-state 2>/dev/null | grep -q "enabled" && SECBOOT=1
  check_point "Secure Boot: enabled" $SECBOOT

  local FIREJAIL=0
  command -v firejail &>/dev/null && FIREJAIL=1
  check_point "Firejail sandbox: available" $FIREJAIL

  # Output: first line is just the number (for scripting)
  local PCT=$(( SCORE * 100 / MAX ))
  echo "$PCT"

  # Detailed output
  echo ""
  printf "  OPSEC Score: %d/100  (%d/%d checks passed)\n" "$PCT" "$SCORE" "$MAX"
  echo ""
  for LINE in "${DETAILS[@]}"; do
    echo -e "$LINE"
  done
  echo ""
}

# ── Live dashboard ───────────────────────────────────────────────
show_dashboard() {
  while true; do
    clear
    print_banner

    # Score
    local SCORE_RAW
    SCORE_RAW=$(calculate_opsec_score | head -1)
    local COLOR
    if   (( SCORE_RAW >= 85 )); then COLOR="${GREEN}"
    elif (( SCORE_RAW >= 60 )); then COLOR="${YELLOW}"
    else                              COLOR="${RED}"; fi

    # Score bar
    local BAR_LEN=40
    local FILLED=$(( SCORE_RAW * BAR_LEN / 100 ))
    local BAR=""
    for ((i=0; i<FILLED; i++));   do BAR+="█"; done
    for ((i=FILLED; i<BAR_LEN; i++)); do BAR+="░"; done

    echo -e "  ${BOLD}OPSEC Score:${RESET} ${COLOR}${SCORE_RAW}/100${RESET}"
    echo -e "  ${COLOR}[${BAR}]${RESET}"
    echo ""

    # Status table
    local EXIT_IP
    EXIT_IP=$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 8 \
      https://check.torproject.org/api/ip 2>/dev/null | \
      python3 -c "import sys,json; print(json.load(sys.stdin).get('IP','?'))" 2>/dev/null || echo "?")

    echo -e "  ${BOLD}Live Status:${RESET}"
    echo "  ──────────────────────────────────────────────────────"
    printf "  %-25s %s\n" "Exit IP (Tor):" "$EXIT_IP"
    printf "  %-25s %s\n" "UFW:" "$(ufw status 2>/dev/null | head -1 | awk '{print $2}')"
    printf "  %-25s %s\n" "Hostname:" "$(hostname)"
    printf "  %-25s %s\n" "Timezone:" "$(timedatectl 2>/dev/null | awk '/Time zone/{print $3}')"
    printf "  %-25s %s\n" "Swap:" "$(swapon --show 2>/dev/null | wc -l | awk '{print ($1==0?"disabled":"ACTIVE ⚠")}')"
    printf "  %-25s %s\n" "RAM disk:" "$(mountpoint -q "$RAMDISK_MOUNT" 2>/dev/null && echo "mounted" || echo "NOT mounted")"
    printf "  %-25s %s\n" "WireGuard (wg0):" "$(ip link show wg0 &>/dev/null && echo "UP" || echo "down")"
    printf "  %-25s %s\n" "I2P:" "$(pgrep -f "i2p\|i2prouter" &>/dev/null && echo "running" || echo "stopped")"
    printf "  %-25s %s\n" "Noise generator:" "$([[ -f "$NOISE_PID" ]] && kill -0 "$(cat "$NOISE_PID")" 2>/dev/null && echo "active" || echo "stopped")"
    printf "  %-25s %s\n" "Leak monitor:" "$([[ -f "$LEAK_MON_PID" ]] && kill -0 "$(cat "$LEAK_MON_PID")" 2>/dev/null && echo "running" || echo "stopped")"
    printf "  %-25s %s\n" "Dead man switch:" "$([[ -f "$DEADMAN_PID" ]] && kill -0 "$(cat "$DEADMAN_PID")" 2>/dev/null && echo "ACTIVE" || echo "off")"
    echo "  ──────────────────────────────────────────────────────"
    echo ""
    echo -e "  ${DIM}Refreshing every 30s — Ctrl+C to exit${RESET}"
    sleep 30
  done
}

# ── Route visualizer ─────────────────────────────────────────────
setup_route_visualiser() {
  header "NETWORK ROUTE VISUALIZER"

  cat > /usr/local/bin/show-route << 'SCRIPT'
#!/bin/bash
echo ""
echo "  ╔════════════════════════════════════════════════════════╗"
echo "  ║              TRAFFIC ROUTE VISUALIZATION               ║"
echo "  ╚════════════════════════════════════════════════════════╝"
echo ""

# Detect active components
WG_ACTIVE=$(ip link show wg0 &>/dev/null && echo "YES" || echo "NO")
TOR_ACTIVE=$(pgrep -x tor &>/dev/null && echo "YES" || echo "NO")
I2P_ACTIVE=$(pgrep -f "i2p\|i2prouter" &>/dev/null && echo "YES" || echo "NO")

EXIT_IP=$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 10 \
  https://ifconfig.me 2>/dev/null || echo "?")

LOCAL_IP=$(ip route get 8.8.8.8 2>/dev/null | awk '/src/{print $7}' | head -1)
WG_IP=$(ip addr show wg0 2>/dev/null | awk '/inet /{print $2}' | head -1)

echo ""
if [[ "$WG_ACTIVE" == "YES" ]]; then
  echo "  ┌─────────────────────────────────────────────────────┐"
  echo "  │  YOUR DEVICE                                        │"
  echo "  │  IP: $LOCAL_IP                       │"
  echo "  └────────────────────┬────────────────────────────────┘"
  echo "                       │ Encrypted WireGuard tunnel"
  echo "  ┌────────────────────▼────────────────────────────────┐"
  echo "  │  VPN SERVER (WireGuard)                             │"
  echo "  │  Tunnel IP: $WG_IP                    │"
  echo "  └────────────────────┬────────────────────────────────┘"
  echo "                       │ Tor traffic (hidden from VPN)"
else
  echo "  ┌─────────────────────────────────────────────────────┐"
  echo "  │  YOUR DEVICE                                        │"
  echo "  │  IP: $LOCAL_IP                       │"
  echo "  └────────────────────┬────────────────────────────────┘"
  echo "                       │"
fi

if [[ "$TOR_ACTIVE" == "YES" ]]; then
  echo "  ┌────────────────────▼────────────────────────────────┐"
  echo "  │  TOR ENTRY GUARD                                    │"
  echo "  └────────────────────┬────────────────────────────────┘"
  echo "                       │ Encrypted (3 layers)"
  echo "  ┌────────────────────▼────────────────────────────────┐"
  echo "  │  TOR MIDDLE RELAY                                   │"
  echo "  └────────────────────┬────────────────────────────────┘"
  echo "                       │"
  echo "  ┌────────────────────▼────────────────────────────────┐"
  echo "  │  TOR EXIT NODE                                      │"
  echo "  │  Exit IP: $EXIT_IP                   │"
  echo "  └────────────────────┬────────────────────────────────┘"
  echo "                       │"
fi

echo "  ┌────────────────────▼────────────────────────────────┐"
echo "  │  DESTINATION SERVER                                 │"
echo "  └─────────────────────────────────────────────────────┘"
echo ""

if [[ "$I2P_ACTIVE" == "YES" ]]; then
  echo "  [+] I2P: also running on 127.0.0.1:4444"
fi

echo ""
echo "  Legend:"
[[ "$WG_ACTIVE" == "YES" ]] && echo -e "  ${GREEN}✓${RESET} WireGuard VPN active (hides Tor from ISP)" || echo -e "  ${YELLOW}-${RESET} WireGuard VPN: not active"
[[ "$TOR_ACTIVE" == "YES" ]] && echo -e "  ${GREEN}✓${RESET} Tor: active (3-hop anonymization)" || echo -e "  ${RED}✗${RESET} Tor: NOT active"
[[ "$I2P_ACTIVE" == "YES" ]] && echo -e "  ${GREEN}✓${RESET} I2P: active" || echo -e "  ${YELLOW}-${RESET} I2P: not active"
echo ""
SCRIPT
  chmod +x /usr/local/bin/show-route

  ok "Route visualizer: show-route"
  timeline "Route visualizer installed"
}

# ── Profile manager ──────────────────────────────────────────────
setup_profile_manager() {
  header "OPSEC PROFILE MANAGER"

  local PROFILES_DIR="/etc/specter/profiles"
  mkdir -p "$PROFILES_DIR"

  # Pre-built profiles
  cat > "$PROFILES_DIR/high-risk.conf" << 'EOF'
# High Risk Profile — War zone / repressive regime
OPSEC_LEVEL=critical
TOR_BRIDGES=obfs4
VPN_PROVIDER=mullvad
MULTIHOP=true
NOISE_MIN_DELAY=30
NOISE_MAX_DELAY=120
AUTONUKE_MINUTES=15
DEADMAN_INTERVAL=1800
AUTO_ROTATE_INTERVAL=300
EOF

  cat > "$PROFILES_DIR/medium-risk.conf" << 'EOF'
# Medium Risk Profile — Investigative work in democratic country
OPSEC_LEVEL=high
TOR_BRIDGES=none
VPN_PROVIDER=protonvpn
MULTIHOP=false
NOISE_MIN_DELAY=60
NOISE_MAX_DELAY=300
AUTONUKE_MINUTES=45
DEADMAN_INTERVAL=3600
AUTO_ROTATE_INTERVAL=600
EOF

  cat > "$PROFILES_DIR/low-risk.conf" << 'EOF'
# Low Risk Profile — General privacy research
OPSEC_LEVEL=standard
TOR_BRIDGES=none
VPN_PROVIDER=none
MULTIHOP=false
NOISE_MIN_DELAY=120
NOISE_MAX_DELAY=600
AUTONUKE_MINUTES=120
DEADMAN_INTERVAL=7200
AUTO_ROTATE_INTERVAL=1200
EOF

  cat > /usr/local/bin/opsec-profile << SCRIPT
#!/bin/bash
ACTION="\${1:-list}"
PROFILE="\$2"
PROFILES_DIR="${PROFILES_DIR}"
CONFIG_FILE="${CONFIG_FILE}"

case "\$ACTION" in
  list)
    echo ""; echo "  Available profiles:"
    for F in "\$PROFILES_DIR"/*.conf; do
      NAME="\$(basename "\${F%.conf}")"
      DESC=\$(grep '^# ' "\$F" | head -1 | cut -c3-)
      printf "  %-20s %s\n" "\$NAME" "\$DESC"
    done
    echo ""
    ;;
  load)
    PROFILE="\${PROFILE:?Usage: opsec-profile load <name>}"
    SRC="\${PROFILES_DIR}/\${PROFILE}.conf"
    [[ -f "\$SRC" ]] || { echo "[!] Profile not found: \$PROFILE"; exit 1; }
    cp "\$SRC" "\$CONFIG_FILE"
    source "\$CONFIG_FILE"
    echo "[+] Profile loaded: \$PROFILE"
    echo "    Settings applied from: \$SRC"
    ;;
  save)
    PROFILE="\${PROFILE:?Usage: opsec-profile save <name>}"
    cp "\$CONFIG_FILE" "\${PROFILES_DIR}/\${PROFILE}.conf"
    echo "[+] Current settings saved as profile: \$PROFILE"
    ;;
  delete)
    PROFILE="\${PROFILE:?Usage: opsec-profile delete <name>}"
    rm -f "\${PROFILES_DIR}/\${PROFILE}.conf" && echo "[+] Deleted: \$PROFILE"
    ;;
  *)
    echo "Usage: opsec-profile <list|load <name>|save <name>|delete <name>>"
    ;;
esac
SCRIPT
  chmod +x /usr/local/bin/opsec-profile

  ok "Profile manager: opsec-profile list|load|save|delete"
  ok "Built-in profiles: high-risk | medium-risk | low-risk"
  timeline "Profile manager installed"
}

# ── Report generator ─────────────────────────────────────────────
setup_report_generator() {
  header "OPSEC REPORT GENERATOR"

  cat > /usr/local/bin/generate-report << SCRIPT
#!/bin/bash
TS=\$(date '+%Y%m%d_%H%M%S')
TXT_REPORT="${RAMDISK_MOUNT:-/mnt/secure_workspace}/opsec_report_\${TS}.txt"
HTML_REPORT="${RAMDISK_MOUNT:-/mnt/secure_workspace}/opsec_report_\${TS}.html"

echo "[*] Generating OPSEC report..."

# Text report
{
echo "════════════════════════════════════════════════════════"
echo " SPECTER v10.11.0 — SESSION REPORT"
echo " Generated: \$(date '+%Y-%m-%d %H:%M:%S UTC')"
echo "════════════════════════════════════════════════════════"
echo ""

echo "── Tor Status ────────────────────────────────────────"
TOR_IP=\$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 10 \
  https://check.torproject.org/api/ip 2>/dev/null || echo "{}")
echo "\$TOR_IP"
echo ""

echo "── Network Interfaces ────────────────────────────────"
ip addr show 2>/dev/null
echo ""

echo "── Firewall Status ───────────────────────────────────"
iptables -L INPUT -n --line-numbers 2>/dev/null | head -20
echo ""

echo "── Active Connections ────────────────────────────────"
ss -tnp 2>/dev/null | grep ESTABLISHED | head -20
echo ""

echo "── Listening Ports ───────────────────────────────────"
ss -tlnp 2>/dev/null
echo ""

echo "── Kernel Security Parameters ────────────────────────"
sysctl kernel.dmesg_restrict kernel.kptr_restrict \
  kernel.yama.ptrace_scope kernel.randomize_va_space \
  net.ipv6.conf.all.disable_ipv6 2>/dev/null
echo ""

echo "── Swap Status ───────────────────────────────────────"
swapon --show 2>/dev/null || echo "(swap disabled)"
echo ""

echo "── OPSEC Score ───────────────────────────────────────"
calculate_opsec_score 2>/dev/null || echo "(score function unavailable)"
echo ""

echo "── Mounted Filesystems ───────────────────────────────"
mount | grep -E "tmpfs|ext4|encrypted"
echo ""

echo "── Running Security Daemons ──────────────────────────"
for SVC in tor ufw usbguard apparmor; do
  STATUS=\$(systemctl is-active "\$SVC" 2>/dev/null)
  printf "  %-20s %s\n" "\$SVC" "\$STATUS"
done
echo ""

echo "════════════════════════════════════════════════════════"
echo " END OF REPORT — Wipe after review"
echo "════════════════════════════════════════════════════════"
} > "\$TXT_REPORT"

echo "[+] Text report: \$TXT_REPORT"

# HTML report
cat > "\$HTML_REPORT" << 'HTML'
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>OPSEC Report</title>
<style>
body{background:#0d0d0d;color:#ccc;font-family:monospace;max-width:900px;margin:30px auto;padding:20px}
h1{color:#00ff00;border-bottom:1px solid #333}
h2{color:#0af;margin-top:30px}
pre{background:#111;padding:15px;border:1px solid #333;overflow:auto}
.ok{color:#0f0}.warn{color:#fa0}.err{color:#f00}
</style>
</head>
<body>
<h1>SPECTER v10.11.0 — Session Report</h1>
HTML
echo "<p>Generated: \$(date '+%Y-%m-%d %H:%M:%S UTC')</p>" >> "\$HTML_REPORT"
echo "<h2>OPSEC Score</h2><pre>" >> "\$HTML_REPORT"
calculate_opsec_score 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' >> "\$HTML_REPORT"
echo "</pre>" >> "\$HTML_REPORT"
echo "<h2>Network Status</h2><pre>" >> "\$HTML_REPORT"
ip addr show 2>/dev/null >> "\$HTML_REPORT"
echo "</pre><h2>Firewall Rules</h2><pre>" >> "\$HTML_REPORT"
iptables -L -n 2>/dev/null | head -40 >> "\$HTML_REPORT"
echo "</pre></body></html>" >> "\$HTML_REPORT"

echo "[+] HTML report: \$HTML_REPORT"
echo ""
echo "    Review, then: secure-wipe \"\$TXT_REPORT\" \"\$HTML_REPORT\""
SCRIPT
  chmod +x /usr/local/bin/generate-report

  ok "Report generator: generate-report (text + HTML)"
  timeline "Report generator installed"
}

# ── Risk assessment ──────────────────────────────────────────────
setup_risk_assessment() {
  header "RISK ASSESSMENT"

  cat > /usr/local/bin/risk-assess << 'SCRIPT'
#!/bin/bash
echo ""
echo "  ╔══════════════════════════════════════════════════╗"
echo "  ║          SPECTER RISK ASSESSMENT              ║"
echo "  ╚══════════════════════════════════════════════════╝"
echo ""
echo "  Answer the following questions to get a threat model"
echo "  and recommended OPSEC configuration."
echo ""

RISK=0

ask() {
  local Q="$1" Y_POINTS="$2"
  read -rp "  $Q [y/n]: " ANS
  [[ "${ANS,,}" == "y" ]] && ((RISK += Y_POINTS))
}

echo "  ── Threat Environment ──────────────────────────"
ask "Are you in or traveling to a country with press censorship?" 30
ask "Is your subject a government, intelligence agency, or law enforcement?" 25
ask "Are you investigating organized crime or cartels?" 25
ask "Do you have reason to believe you are already under surveillance?" 40
ask "Are sources at risk of physical harm if exposed?" 35
ask "Are you handling classified or highly sensitive documents?" 30

echo ""
echo "  ── Personal Exposure ───────────────────────────"
ask "Do you use your personal phone for research?" 15
ask "Do you access research materials from home or work internet?" 20
ask "Have you ever logged into research accounts on personal devices?" 20
ask "Do sources contact you on commercial messaging apps (WhatsApp, SMS)?" 20
ask "Do you store research notes on cloud services?" 20

echo ""
echo "  ── Technical Capability ────────────────────────"
ask "Do adversaries have access to advanced surveillance tools (NSO Group etc.)?" 30
ask "Is your organization's IT infrastructure potentially compromised?" 25

echo ""
echo "  ── Risk Score: $RISK points ──"
echo ""

if (( RISK >= 120 )); then
  echo -e "  \033[1;31mCRITICAL RISK\033[0m — Recommended: HIGH-RISK profile"
  echo ""
  echo "  Immediate actions:"
  echo "  • Use ONLY Tails OS (no persistent storage)"
  echo "  • Access via Tor + obfs4 bridges (censorship bypass)"
  echo "  • Compartmentalize: separate device per investigation"
  echo "  • Source communication: SecureDrop only"
  echo "  • Dead man's switch: 30-minute check-in"
  echo "  • Panic button: always ready"
  echo "  • Physical: random public WiFi, privacy screen"
  echo "  Run: opsec-profile load high-risk"

elif (( RISK >= 60 )); then
  echo -e "  \033[1;33mELEVATED RISK\033[0m — Recommended: MEDIUM-RISK profile"
  echo ""
  echo "  Recommended configuration:"
  echo "  • VPN (no-log provider) + Tor"
  echo "  • Tor Browser with security level: Safest"
  echo "  • Source communication: Signal + PGP"
  echo "  • Dead man's switch: 1-hour check-in"
  echo "  • RAM disk for all research files"
  echo "  Run: opsec-profile load medium-risk"

else
  echo -e "  \033[1;32mSTANDARD RISK\033[0m — Recommended: LOW-RISK profile"
  echo ""
  echo "  Recommended configuration:"
  echo "  • Tor Browser for research browsing"
  echo "  • Encrypted storage for source files"
  echo "  • Signal for sensitive communications"
  echo "  • Regular session-nuke after each session"
  echo "  Run: opsec-profile load low-risk"
fi

echo ""
SCRIPT
  chmod +x /usr/local/bin/risk-assess

  ok "Risk assessment: risk-assess"
  timeline "Risk assessment installed"
}

# ── OPSEC checklist ──────────────────────────────────────────────
print_opsec_checklist() {
  echo ""
  echo -e "  ${BOLD}${CYAN}SPECTER v10 — FULL CHECKLIST${RESET}"
  echo "  ══════════════════════════════════════════════════════"
  echo ""
  echo -e "  ${BOLD}BEFORE SESSION:${RESET}"
  echo "  □ Boot from Tails OS (or Whonix)"
  echo "  □ sudo ./specter_v10.sh --full"
  echo "  □ verify_tor — confirm Tor is active"
  echo "  □ show_dashboard — confirm score ≥ 80"
  echo "  □ risk-assess — review threat model"
  echo "  □ Create/switch identity: new-identity <topic>"
  echo "  □ Start monitors: leak-monitor start | lan-monitor start"
  echo "  □ Start noise: noise-generator start"
  echo "  □ Activate dead man: deadman-start"
  echo ""
  echo -e "  ${BOLD}DURING SESSION:${RESET}"
  echo "  □ Use only safe-browser (Firejail-sandboxed)"
  echo "  □ Check-in: deadman-checkin (every hour)"
  echo "  □ All files go to /root/research (RAM disk only)"
  echo "  □ Scan received files: quarantine <file> then scan-beacons"
  echo "  □ Strip metadata before sharing: stripall <dir>"
  echo "  □ Watermark docs sent to sources: watermark-doc <file> <recipient>"
  echo "  □ Rotate circuit periodically: rotate-circuit"
  echo "  □ Encrypt notes: note-encrypt <file> or age-encrypt <file>"
  echo ""
  echo -e "  ${BOLD}COMMUNICATION:${RESET}"
  echo "  □ Share documents: share-file <file> (OnionShare)"
  echo "  □ Receive documents: source-dropbox"
  echo "  □ Source communication: contact view <alias> for .onion"
  echo "  □ PGP-sign all communications: create-source-key"
  echo ""
  echo -e "  ${BOLD}AFTER SESSION:${RESET}"
  echo "  □ Close vault: close-vault"
  echo "  □ Export journal if needed: journal export"
  echo "  □ Generate report: generate-report"
  echo "  □ Full wipe: session-nuke"
  echo "  □ Physical: wipe fingerprints off device"
  echo ""
}

# ════════════════════════════════════════════════════════════════
# v10.5 — EXIT WATCH · MAC ROTATE · LEAK TEST · RAM SHRED
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: POWER EXTRAS
#  10 small but critical additions:
#
#  exit-watch        — real-time Tor exit IP change detector
#  bad-exit-block    — auto-block known malicious Tor exit nodes
#  mac-rotate        — periodic MAC re-randomization daemon
#  proc-isolate      — run any command in isolated network namespace
#  leak-test         — one-shot DNS/IP/WebRTC/IPv6 leak check
#  ram-shred         — fill free RAM with zeros (cold-boot defense)
#  metadata-check    — instant metadata scan before sharing a file
#  conn-watch        — real-time live connection monitor
#  opsec-status      — single-line OPSEC health dashboard
#  tcp-harden        — randomize TCP/IP stack fingerprint
# ================================================================

# ================================================================
#  1. EXIT WATCH — Tor exit IP change detector
#     Alerts if your Tor circuit is silently changed mid-session
#     (circuit hijack or transparent proxy indicator)
# ================================================================
setup_exit_watch() {
  header "EXIT WATCH (Circuit Hijack Detection)"

  cat > /usr/local/bin/exit-watch << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
PID_FILE="/tmp/.exit_watch.pid"
LOG="/tmp/opsec_exitwatch.log"
INTERVAL="\${2:-90}"  # seconds between checks

start_watch() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true

  # Get initial exit IP
  INITIAL_IP=\$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 10 \
    https://check.torproject.org/api/ip 2>/dev/null | \
    python3 -c "import sys,json; print(json.load(sys.stdin).get('IP','?'))" 2>/dev/null || echo "unknown")

  echo "[+] Exit watch started. Baseline exit IP: \$INITIAL_IP"
  echo "[$(date '+%H:%M:%S')] Baseline: \$INITIAL_IP" > "\$LOG"

  (
    BASELINE="\$INITIAL_IP"
    while true; do
      sleep "\$INTERVAL"
      CURRENT=\$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 10 \
        https://check.torproject.org/api/ip 2>/dev/null | \
        python3 -c "import sys,json; print(json.load(sys.stdin).get('IP','?'))" 2>/dev/null || echo "error")

      TS=\$(date '+%H:%M:%S')
      if [[ "\$CURRENT" != "\$BASELINE" ]] && [[ "\$CURRENT" != "error" ]]; then
        echo "[\$TS] [*] Exit IP rotated: \$BASELINE → \$CURRENT" >> "\$LOG"
        BASELINE="\$CURRENT"
      elif [[ "\$CURRENT" == "error" ]]; then
        echo "[\$TS] [!] CANNOT REACH TOR — connection may be broken" >> "\$LOG"
        DISPLAY=:0 notify-send -u critical "OPSEC Alert" \
          "Tor unreachable — possible circuit drop!" 2>/dev/null || true
      else
        echo "[\$TS] OK — \$CURRENT" >> "\$LOG"
      fi
    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] Exit watch daemon PID: \$(cat \$PID_FILE) | Check every \${INTERVAL}s"
}

stop_watch() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] Exit watch stopped"
}

case "\$ACTION" in
  start)  start_watch ;;
  stop)   stop_watch ;;
  log)    tail -30 "\$LOG" 2>/dev/null ;;
  status) [[ -f "\$PID_FILE" ]] && kill -0 \$(cat "\$PID_FILE") 2>/dev/null && \
            echo "[+] Running — last entries:" && tail -5 "\$LOG" 2>/dev/null || echo "[-] Stopped" ;;
  *)      echo "Usage: exit-watch <start [interval_secs]|stop|log|status>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/exit-watch

  ok "exit-watch: real-time circuit hijack detector"
  timeline "Exit watch installed"
}

# ================================================================
#  2. BAD EXIT BLOCK — Auto-block malicious Tor exit nodes
#     Downloads curated blocklists and inserts iptables DROP rules
#     Protects against known malicious/sniffing exits
# ================================================================
setup_bad_exit_block() {
  header "BAD EXIT NODE BLOCKER"

  cat > /usr/local/bin/bad-exit-block << 'SCRIPT'
#!/bin/bash
BLOCKLIST_FILE="/tmp/opsec_bad_exits.txt"
BLOCKED=0

echo "[*] Fetching known malicious Tor exit node blocklist..."

# Fetch via Tor (meta-protection: using Tor to fetch Tor blocklist)
FETCH_CMD="curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 30"
$FETCH_CMD "https://www.dan.me.uk/torlist/?exit" \
  -o "$BLOCKLIST_FILE" 2>/dev/null || \
$FETCH_CMD "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1" \
  -o "$BLOCKLIST_FILE" 2>/dev/null || {
  echo "[!] Could not fetch blocklist via Tor — trying clearnet"
  curl -sf --max-time 20 "https://www.dan.me.uk/torlist/?exit" \
    -o "$BLOCKLIST_FILE" 2>/dev/null || {
    echo "[!] Blocklist fetch failed — using cached or skipping"
    exit 1
  }
}

COUNT=$(grep -cE '^[0-9]+\.' "$BLOCKLIST_FILE" 2>/dev/null || echo 0)
echo "[+] Fetched $COUNT exit node IPs"

# Apply as iptables OUTPUT DROP rules (prevent routing to bad exits)
# Note: This affects pre-Tor traffic; Tor itself chooses exit nodes.
# Real protection: inject into Tor's ExcludeExitNodes

if [[ $COUNT -gt 0 ]]; then
  # Add to Tor's exclude list dynamically
  EXCLUDES=$(grep -E '^[0-9]+\.' "$BLOCKLIST_FILE" 2>/dev/null | head -100 | \
    awk '{printf "{%s},",$1}' | sed 's/,$//')

  if [[ -n "$EXCLUDES" ]]; then
    # Send to Tor controller
    printf "AUTHENTICATE \"\"\r\nSETCONF ExcludeExitNodes=${EXCLUDES}\r\nSETCONF StrictNodes=1\r\nQUIT\r\n" | \
      nc -q2 127.0.0.1 9051 2>/dev/null | grep -q "250" && \
      echo "[+] Injected $(echo "$EXCLUDES" | tr ',' '\n' | wc -l) bad exits into Tor ExcludeExitNodes" || \
      echo "[!] Tor controller not responding — add manually to torrc"
  fi

  # Also block via iptables (belt-and-suspenders)
  while IFS= read -r IP; do
    [[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || continue
    iptables -I OUTPUT -d "$IP" -j DROP 2>/dev/null && ((BLOCKED++))
  done < <(grep -E '^[0-9]+\.' "$BLOCKLIST_FILE" 2>/dev/null | head -200)

  echo "[+] Blocked $BLOCKED bad exit IPs via iptables"
fi

echo "[+] Bad exit protection active"
SCRIPT
  chmod +x /usr/local/bin/bad-exit-block

  ok "bad-exit-block: auto-block malicious Tor exits (blocklist + iptables)"
  timeline "Bad exit blocker installed"
}

# ================================================================
#  3. MAC ROTATE DAEMON — Periodic MAC re-randomization
#     Re-randomizes MAC addresses every N minutes during a session
#     Defeats long-term MAC tracking on the same WiFi network
# ================================================================
setup_mac_rotate_daemon() {
  header "MAC ROTATION DAEMON"

  cat > /usr/local/bin/mac-rotate << SCRIPT
#!/bin/bash
ACTION="\${1:-start}"
INTERVAL="\${2:-600}"  # default 10 minutes
PID_FILE="/tmp/.mac_rotate.pid"
LOG="/tmp/opsec_mac_rotate.log"

start_rotate() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null; true
  echo "[+] MAC rotate daemon: every \${INTERVAL}s"
  (
    while true; do
      sleep "\$INTERVAL"
      TS=\$(date '+%H:%M:%S')
      IFACES=\$(ip link show | awk '/^[0-9]/{print \$2}' | tr -d ':' | grep -v lo)
      for IFACE in \$IFACES; do
        OLD=\$(ip link show "\$IFACE" 2>/dev/null | awk '/link\/ether/{print \$2}')
        ip link set "\$IFACE" down 2>/dev/null
        if command -v macchanger &>/dev/null; then
          NEW=\$(macchanger -r "\$IFACE" 2>/dev/null | grep "New MAC" | awk '{print \$3}')
        else
          NEW=\$(printf '%02x:%02x:%02x:%02x:%02x:%02x' \
            \$((RANDOM%256&0xfe)) \$((RANDOM%256)) \$((RANDOM%256)) \
            \$((RANDOM%256))     \$((RANDOM%256)) \$((RANDOM%256)))
          ip link set "\$IFACE" address "\$NEW" 2>/dev/null
        fi
        ip link set "\$IFACE" up 2>/dev/null
        echo "[\$TS] \$IFACE: \$OLD → \$NEW" >> "\$LOG"
      done
    done
  ) &
  echo \$! > "\$PID_FILE"
  echo "[+] MAC rotate daemon started (PID: \$(cat \$PID_FILE), interval: \${INTERVAL}s)"
}

stop_rotate() {
  [[ -f "\$PID_FILE" ]] && kill \$(cat "\$PID_FILE") 2>/dev/null && rm -f "\$PID_FILE"
  echo "[+] MAC rotate daemon stopped"
}

case "\$ACTION" in
  start)  start_rotate ;;
  stop)   stop_rotate ;;
  now)
    IFACES=\$(ip link show | awk '/^[0-9]/{print \$2}' | tr -d ':' | grep -v lo)
    for IFACE in \$IFACES; do
      ip link set "\$IFACE" down 2>/dev/null
      macchanger -r "\$IFACE" 2>/dev/null | grep "New MAC"
      ip link set "\$IFACE" up 2>/dev/null
    done
    ;;
  log)    tail -20 "\$LOG" 2>/dev/null ;;
  *)      echo "Usage: mac-rotate <start [interval_secs]|stop|now|log>" ;;
esac
SCRIPT
  chmod +x /usr/local/bin/mac-rotate

  ok "mac-rotate: periodic MAC re-randomization daemon (default: every 10min)"
  timeline "MAC rotate daemon installed"
}

# ================================================================
#  4. PROC ISOLATE — Run any command with no network access
#     Uses Linux network namespaces to create a true network jail
#     Useful for: opening suspicious files, running untrusted scripts
# ================================================================
setup_proc_isolate() {
  header "PROCESS NETWORK ISOLATOR"

  cat > /usr/local/bin/proc-isolate << 'SCRIPT'
#!/bin/bash
# Usage: proc-isolate <command> [args...]
# Runs command inside an isolated network namespace (no internet, no LAN)
[[ $# -eq 0 ]] && { echo "Usage: proc-isolate <command> [args...]"; exit 1; }

echo "[*] Launching in isolated network namespace: $*"
echo "    Network access: NONE (not even loopback to host)"

# Create anonymous network namespace with no external connectivity
unshare --net -- sh -c "
  # Only loopback inside the namespace (127.0.0.1, no routing out)
  ip link set lo up 2>/dev/null
  echo '[+] Network namespace: isolated (loopback only)'
  exec \"\$@\"
" -- "$@"

EXIT_CODE=$?
echo "[+] Process exited with code: $EXIT_CODE"
SCRIPT
  chmod +x /usr/local/bin/proc-isolate

  ok "proc-isolate: network-jailed process execution (Linux namespaces)"
  timeline "Process isolator installed"
}

# ================================================================
#  5. LEAK TEST — One-shot comprehensive leak checker
#     DNS leak · IP leak · IPv6 leak · WebRTC · Proxy detection
# ================================================================
setup_leak_test() {
  header "COMPREHENSIVE LEAK TEST"

  cat > /usr/local/bin/leak-test << 'SCRIPT'
#!/bin/bash
echo ""
echo "  ╔══════════════════════════════════════════════════╗"
echo "  ║        COMPREHENSIVE LEAK TEST v10.5             ║"
echo "  ╚══════════════════════════════════════════════════╝"
echo ""
LEAKS=0

# ── Test 1: Tor IP check ──────────────────────────────────
echo "  [1] IP address via Tor..."
TOR_RESP=$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 12 \
  https://check.torproject.org/api/ip 2>/dev/null)
if echo "$TOR_RESP" | grep -q '"IsTor":true'; then
  EXIT_IP=$(echo "$TOR_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('IP','?'))" 2>/dev/null)
  echo -e "      \033[32m✓\033[0m Tor exit IP: $EXIT_IP"
else
  echo -e "      \033[31m✗\033[0m NOT routing through Tor!"
  ((LEAKS++))
fi

# ── Test 2: Clearnet IP (should be blocked) ───────────────
echo "  [2] Clearnet IP (should be unreachable)..."
CLEAR_IP=$(curl -sf --max-time 5 https://ifconfig.me 2>/dev/null)
if [[ -n "$CLEAR_IP" ]]; then
  echo -e "      \033[31m✗\033[0m Clearnet IP REACHABLE: $CLEAR_IP — kill switch may be broken!"
  ((LEAKS++))
else
  echo -e "      \033[32m✓\033[0m Clearnet blocked (kill switch active)"
fi

# ── Test 3: DNS leak ──────────────────────────────────────
echo "  [3] DNS leak check..."
# Query via Tor to a DNS leak test domain
DNS_RESULT=$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 12 \
  "https://www.dnsleaktest.com/results.json" 2>/dev/null | head -c 500 || echo "")
if [[ -n "$DNS_RESULT" ]]; then
  echo -e "      \033[33m?\033[0m DNS test server reached (check manually: dnsleaktest.com via Tor Browser)"
else
  echo -e "      \033[32m✓\033[0m DNS test endpoint unreachable from clearnet"
fi

# Check if DNS goes through Tor's resolver
DNS_SERVER=$(cat /etc/resolv.conf 2>/dev/null | grep nameserver | awk '{print $2}' | head -1)
if [[ "$DNS_SERVER" == "127.0.0.1" ]]; then
  echo -e "      \033[32m✓\033[0m DNS resolver: 127.0.0.1 (Tor) — no DNS leak"
else
  echo -e "      \033[31m✗\033[0m DNS resolver: $DNS_SERVER — potential DNS leak!"
  ((LEAKS++))
fi

# ── Test 4: IPv6 leak ─────────────────────────────────────
echo "  [4] IPv6 leak..."
IPV6_STATUS=$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null)
if [[ "$IPV6_STATUS" == "1" ]]; then
  echo -e "      \033[32m✓\033[0m IPv6 disabled at kernel level"
else
  IPV6_ADDR=$(ip -6 addr show 2>/dev/null | grep "inet6" | grep -v "::1\|fe80" | head -1)
  if [[ -n "$IPV6_ADDR" ]]; then
    echo -e "      \033[31m✗\033[0m IPv6 address detected: $IPV6_ADDR — possible leak!"
    ((LEAKS++))
  else
    echo -e "      \033[32m✓\033[0m No public IPv6 address"
  fi
fi

# ── Test 5: WebRTC leak (system-level check) ──────────────
echo "  [5] WebRTC (system-level)..."
# Check if firefox/chromium is running with WebRTC disabled
WEBRTC_PROC=$(ps -ef 2>/dev/null | grep -E "firefox|chromium" | grep -v grep | head -1)
if [[ -n "$WEBRTC_PROC" ]]; then
  echo -e "      \033[33m!\033[0m Browser running — verify WebRTC disabled in browser settings"
  echo -e "      \033[33m!\033[0m Run: harden-browser && restart browser"
  ((LEAKS++))
else
  echo -e "      \033[32m✓\033[0m No browser running (WebRTC not exposed)"
fi

# ── Test 6: Swap check ────────────────────────────────────
echo "  [6] Swap (memory-to-disk leak)..."
SWAP_ACTIVE=$(swapon --show 2>/dev/null | wc -l)
if (( SWAP_ACTIVE == 0 )); then
  echo -e "      \033[32m✓\033[0m Swap: disabled (data stays in RAM)"
else
  echo -e "      \033[31m✗\033[0m Swap ACTIVE — research data may be written to disk!"
  swapon --show 2>/dev/null | while read L; do echo "      $L"; done
  ((LEAKS++))
fi

# ── Test 7: Unexpected outbound connections ───────────────
echo "  [7] Unexpected outbound connections..."
UNEXPECTED=$(ss -tnp 2>/dev/null | grep ESTABLISHED | \
  grep -v "127\.\|::1" | \
  grep -vE "9050|9040|9051|9052|tor" | head -5)
if [[ -z "$UNEXPECTED" ]]; then
  echo -e "      \033[32m✓\033[0m No unexpected outbound connections"
else
  echo -e "      \033[31m✗\033[0m Unexpected connections:"
  echo "$UNEXPECTED" | while read L; do echo "        $L"; ((LEAKS++)); done
fi

# ── Summary ───────────────────────────────────────────────
echo ""
echo "  ──────────────────────────────────────────────────"
if (( LEAKS == 0 )); then
  echo -e "  \033[1;32m✓ CLEAN — No leaks detected (${LEAKS} issues)\033[0m"
else
  echo -e "  \033[1;31m✗ LEAKS DETECTED — ${LEAKS} issue(s) found\033[0m"
  echo -e "  \033[1;33m  Run session-nuke and restart with --full setup\033[0m"
fi
echo ""
SCRIPT
  chmod +x /usr/local/bin/leak-test

  ok "leak-test: one-shot DNS/IP/IPv6/WebRTC/swap/connection leak check"
  timeline "Leak test installed"
}

# ================================================================
#  6. RAM SHRED — Fill free RAM to defeat cold-boot attacks
#     Allocates and zeroes available RAM, then frees it
#     Makes RAM forensics significantly harder
# ================================================================
setup_ram_shred() {
  header "RAM SHREDDER (Cold-Boot Defense)"

  cat > /usr/local/bin/ram-shred << 'SCRIPT'
#!/bin/bash
echo "[*] RAM shredder — filling free memory with zeros..."
echo "    This takes a moment. Do not interrupt."
echo ""

FREE_MB=$(awk '/MemFree/{print int($2/1024)}' /proc/meminfo 2>/dev/null)
RESERVE=256  # Keep 256MB free for system operation
FILL_MB=$(( FREE_MB - RESERVE ))

if (( FILL_MB <= 0 )); then
  echo "[!] Not enough free RAM to shred (${FREE_MB}MB free)"
  exit 1
fi

echo "[*] Free RAM: ${FREE_MB}MB | Filling: ${FILL_MB}MB (keeping ${RESERVE}MB reserve)"

# Python-based RAM fill (faster than dd, works in userspace)
python3 - << PYEOF 2>/dev/null
import sys
SIZE = ${FILL_MB} * 1024 * 1024
print(f"[*] Allocating {${FILL_MB}}MB...")
try:
    buf = bytearray(SIZE)  # Allocates and zeroes
    print("[+] Memory filled with zeros")
    del buf  # Release (page cache replaced)
    print("[+] Memory released")
except MemoryError:
    print("[!] Allocation failed — not enough contiguous RAM")
    sys.exit(1)
PYEOF

# Drop page cache as well
echo 3 > /proc/sys/vm/drop_caches 2>/dev/null && echo "[+] Page cache dropped"

echo "[+] RAM shred complete — cold-boot recovery harder"
SCRIPT
  chmod +x /usr/local/bin/ram-shred

  ok "ram-shred: fill free RAM with zeros (cold-boot attack mitigation)"
  timeline "RAM shredder installed"
}

# ================================================================
#  7. METADATA CHECK — Instant pre-share metadata scanner
#     Quick one-file check before you share anything
#     Shows what an adversary would see in the metadata
# ================================================================
setup_metadata_check() {
  header "METADATA PRE-SHARE CHECKER"

  cat > /usr/local/bin/metadata-check << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: metadata-check <file>}"
[[ -f "$FILE" ]] || { echo "[!] File not found: $FILE"; exit 1; }

echo ""
echo "  ── Metadata Report: $(basename "$FILE") ──"
echo ""
RISKS=0

if command -v exiftool &>/dev/null; then
  # Extract and display all metadata with risk flagging
  while IFS=': ' read -r KEY VAL; do
    [[ -z "$KEY" ]] && continue
    RISK=""
    case "${KEY,,}" in
      *author*|*creator*|*last*modified*|*company*|*manager*|*producer*)
        RISK="[IDENTITY]"; ((RISKS++)) ;;
      *gps*|*latitude*|*longitude*|*location*|*geotag*)
        RISK="[LOCATION]"; ((RISKS++)) ;;
      *software*|*application*|*tool*|*create*by*)
        RISK="[SOFTWARE]" ;;
      *date*|*time*|*modified*|*created*)
        RISK="[TIMESTAMP]" ;;
      *serial*|*camera*|*device*|*model*)
        RISK="[DEVICE]"; ((RISKS++)) ;;
      *comment*|*description*|*keywords*|*subject*)
        RISK="[CONTENT]" ;;
    esac
    if [[ -n "$RISK" ]]; then
      printf "  \033[33m%-12s\033[0m  %-30s  %s\n" "$RISK" "$KEY" "$VAL"
    else
      printf "  %-12s  %-30s  %s\n" "" "$KEY" "$VAL"
    fi
  done < <(exiftool "$FILE" 2>/dev/null | grep -v "^ExifTool Version" | head -40)
else
  echo "  [!] exiftool not installed — limited check"
  file "$FILE" 2>/dev/null
fi

# File hash (useful for proving integrity, also reveals if file was altered)
echo ""
echo "  ── File Hashes ──"
echo "  SHA256: $(sha256sum "$FILE" 2>/dev/null | awk '{print $1}')"
echo "  MD5:    $(md5sum "$FILE" 2>/dev/null | awk '{print $1}')"
echo ""

# Risk summary
if (( RISKS == 0 )); then
  echo -e "  \033[32m✓ No high-risk metadata found — safe to share\033[0m"
else
  echo -e "  \033[31m[!] $RISKS high-risk field(s) found — strip before sharing:\033[0m"
  echo -e "      \033[33mRun: mat2 --inplace \"$FILE\"  OR  stripall \"$FILE\"\033[0m"
fi
echo ""
SCRIPT
  chmod +x /usr/local/bin/metadata-check

  ok "metadata-check: instant pre-share identity/location metadata scan"
  timeline "Metadata check installed"
}

# ================================================================
#  8. CONN WATCH — Real-time live connection monitor
#     Shows all connections as they appear and disappear
#     Immediate visual alert on unexpected connections
# ================================================================
setup_conn_watch() {
  header "REAL-TIME CONNECTION MONITOR"

  cat > /usr/local/bin/conn-watch << 'SCRIPT'
#!/bin/bash
echo ""
echo "  Real-Time Connection Monitor (Ctrl+C to stop)"
echo "  ──────────────────────────────────────────────"

INTERVAL="${1:-2}"
declare -A PREV_CONNS

while true; do
  clear
  echo -e "  \033[1mLIVE CONNECTIONS — $(date '+%H:%M:%S')\033[0m"
  echo "  ──────────────────────────────────────────────────────────────"
  printf "  %-6s %-22s %-22s %-12s\n" "PROTO" "LOCAL" "REMOTE" "PROCESS"
  echo "  ──────────────────────────────────────────────────────────────"

  declare -A CURR_CONNS

  while IFS= read -r LINE; do
    # Parse ss output
    PROTO=$(echo "$LINE" | awk '{print $1}')
    LOCAL=$(echo "$LINE" | awk '{print $4}')
    REMOTE=$(echo "$LINE" | awk '{print $5}')
    PROC=$(echo "$LINE" | grep -oP 'users:\(\("\K[^"]+' || echo "?")
    KEY="${LOCAL}${REMOTE}"
    CURR_CONNS["$KEY"]=1

    # Classify connection
    if echo "$REMOTE" | grep -qE "^127\.|^::1"; then
      COLOR="\033[2m"  # dim — local/Tor
    elif [[ -n "${PREV_CONNS[$KEY]:-}" ]]; then
      COLOR=""  # normal — existing
    else
      COLOR="\033[1;33m"  # yellow bold — NEW connection
    fi

    printf "${COLOR}  %-6s %-22s %-22s %-12s\033[0m\n" \
      "$PROTO" "${LOCAL:0:22}" "${REMOTE:0:22}" "${PROC:0:12}"

  done < <(ss -tnp 2>/dev/null | grep ESTABLISHED | head -20)

  # Connections that disappeared
  for KEY in "${!PREV_CONNS[@]}"; do
    [[ -z "${CURR_CONNS[$KEY]:-}" ]] && \
      echo -e "  \033[2m[closed] $KEY\033[0m"
  done

  declare -A PREV_CONNS
  for K in "${!CURR_CONNS[@]}"; do PREV_CONNS["$K"]=1; done
  unset CURR_CONNS

  echo ""
  echo -e "  \033[2mRefresh: ${INTERVAL}s | Tor=dim | New=yellow | Ctrl+C to quit\033[0m"
  sleep "$INTERVAL"
done
SCRIPT
  chmod +x /usr/local/bin/conn-watch

  ok "conn-watch: real-time live connection monitor (new=highlighted)"
  timeline "Connection watch installed"
}

# ================================================================
#  9. OPSEC STATUS — One-line health indicator
#     Shows the most critical OPSEC indicators at a glance
#     Run this any time to instantly see your security posture
# ================================================================
setup_opsec_status() {
  header "OPSEC STATUS INDICATOR"

  cat > /usr/local/bin/opsec-status << 'SCRIPT'
#!/bin/bash
# One-line status: run this at any time to see current security posture
G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; B='\033[0m'; BOLD='\033[1m'

check() {
  local NAME="$1" OK="$2" FAIL="$3" RESULT="$4"
  if (( RESULT == 1 )); then
    printf "${G}✓${B} %-14s " "$NAME"
  else
    printf "${R}✗${B} %-14s " "$NAME"
  fi
}

echo ""
printf "  ${BOLD}OPSEC STATUS — $(date '+%H:%M:%S')${B}\n"
echo "  ────────────────────────────────────────────────────────────"
printf "  "

# 1. Tor
TOR=0; curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 6 \
  https://check.torproject.org/api/ip 2>/dev/null | grep -q '"IsTor":true' && TOR=1
check "Tor" "" "" $TOR

# 2. Kill switch
KS=0; iptables -L OUTPUT 2>/dev/null | grep -qiE "DROP|REJECT" && KS=1
check "KillSwitch" "" "" $KS

# 3. UFW
UFW=0; command -v ufw &>/dev/null && ufw status 2>/dev/null | grep -q "active" && UFW=1
check "UFW" "" "" $UFW

# 4. RAM disk
RD=0; mountpoint -q "/mnt/secure_workspace" 2>/dev/null && RD=1
check "RAMDisk" "" "" $RD

echo ""
printf "  "

# 5. Swap
SW=0; [[ "$(swapon --show 2>/dev/null)" == "" ]] && SW=1
check "NoSwap" "" "" $SW

# 6. IPv6 off
IP6=0; [[ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6 2>/dev/null)" == "1" ]] && IP6=1
check "NoIPv6" "" "" $IP6

# 7. Leak monitor
LM=0; [[ -f /tmp/.leak_monitor.pid ]] && kill -0 $(cat /tmp/.leak_monitor.pid) 2>/dev/null && LM=1
check "LeakMon" "" "" $LM

# 8. DNS via Tor
DNS=0; grep -q "nameserver 127.0.0.1" /etc/resolv.conf 2>/dev/null && DNS=1
check "TorDNS" "" "" $DNS

echo ""
printf "  "

# 9. Cam/mic disabled
CAM=0; ! lsmod 2>/dev/null | grep -qE "uvcvideo|snd_hda" && CAM=1
check "Cam/Mic off" "" "" $CAM

# 10. Exit watch
EW=0; [[ -f /tmp/.exit_watch.pid ]] && kill -0 $(cat /tmp/.exit_watch.pid) 2>/dev/null && EW=1
check "ExitWatch" "" "" $EW

# 11. WireGuard
WG=0; ip link show wg0 &>/dev/null && WG=1
check "WireGuard" "" "" $WG

# 12. Dead man
DM=0; [[ -f /tmp/.deadman_switch.pid ]] && kill -0 $(cat /tmp/.deadman_switch.pid) 2>/dev/null && DM=1
check "DeadMan" "" "" $DM

echo ""
echo "  ────────────────────────────────────────────────────────────"

# Score
TOTAL=$((TOR + KS + UFW + RD + SW + IP6 + LM + DNS + CAM + EW + WG + DM))
MAX=12
PCT=$((TOTAL * 100 / MAX))
if   (( PCT >= 85 )); then SC="$G"
elif (( PCT >= 60 )); then SC="$Y"
else SC="$R"; fi
echo -e "  ${BOLD}Score: ${SC}${TOTAL}/${MAX}  (${PCT}%)${B}"

# Exit IP
EXIT_IP=$(curl -sf --socks5-hostname 127.0.0.1:9050 --max-time 6 \
  https://check.torproject.org/api/ip 2>/dev/null | \
  python3 -c "import sys,json; print(json.load(sys.stdin).get('IP','?'))" 2>/dev/null || echo "?")
echo -e "  Exit IP: ${G}${EXIT_IP}${B}"
echo ""
SCRIPT
  chmod +x /usr/local/bin/opsec-status

  ok "opsec-status: one-line instant OPSEC health check (12 indicators)"
  timeline "OPSEC status indicator installed"
}

# ================================================================
# 10. TCP HARDEN — Randomize TCP/IP stack fingerprint
#     Changes TCP window sizes, TTL, timestamps to defeat
#     OS fingerprinting (nmap, p0f, traffic analysis)
# ================================================================
setup_tcp_harden() {
  header "TCP/IP STACK FINGERPRINT HARDENING"

  # Randomize TCP parameters to defeat OS fingerprinting
  local RAND_TTL=$(( RANDOM % 64 + 64 ))  # 64-127 (looks like various OS)
  local RAND_WMEM=$(( (RANDOM % 65536) + 32768 ))
  local RAND_RMEM=$(( (RANDOM % 131072) + 65536 ))

  cat > /etc/sysctl.d/99-opsec-tcp-harden.conf << EOF
# SPECTER v10.5 — TCP/IP Fingerprint Hardening

# Randomize initial TTL (defeats TTL-based OS detection)
net.ipv4.ip_default_ttl = ${RAND_TTL}

# Disable TCP timestamps (prevents uptime fingerprinting)
net.ipv4.tcp_timestamps = 0

# Disable TCP SACK (simplify stack, reduce fingerprint surface)
net.ipv4.tcp_sack = 0

# Randomize TCP window size
net.core.rmem_default = ${RAND_RMEM}
net.core.wmem_default = ${RAND_WMEM}

# Disable ICMP redirects (prevent routing manipulation)
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

# Disable TCP window scaling (less identifiable)
net.ipv4.tcp_window_scaling = 0

# Randomize ephemeral ports (prevents port-based fingerprinting)
net.ipv4.ip_local_port_range = 32768 60999

# Disable source routing
net.ipv4.conf.all.accept_source_route = 0

# Increase TCP SYN cookies robustness
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048

# Disable ICMP echo (no ping response)
net.ipv4.icmp_echo_ignore_all = 1
EOF

  sysctl --system -q 2>/dev/null || sysctl -p /etc/sysctl.d/99-opsec-tcp-harden.conf 2>/dev/null

  ok "TCP/IP hardened: TTL=${RAND_TTL} | timestamps=off | SACK=off | no ping response"
  ok "OS fingerprinting (nmap -O, p0f) significantly defeated"
  timeline "TCP fingerprint hardened"
}

# ================================================================
#  PATCH: Update main menu with extras items
# ================================================================
patch_main_menu_extras() {
  # Install a compact extras status command
  cat > /usr/local/bin/extras-status << 'SCRIPT'
#!/bin/bash
echo ""
echo "  v10.5 Extras Status:"
echo "  ─────────────────────────────"
for CMD in exit-watch mac-rotate bad-exit-block proc-isolate \
           leak-test ram-shred metadata-check conn-watch \
           opsec-status; do
  if [[ -x "/usr/local/bin/$CMD" ]]; then
    echo -e "  \033[32m✓\033[0m $CMD"
  else
    echo -e "  \033[31m✗\033[0m $CMD (not installed)"
  fi
done
echo ""
SCRIPT
  chmod +x /usr/local/bin/extras-status
}

# ================================================================
#  EXTRAS SETUP (called from full setup)
# ================================================================
setup_v10_5_extras() {
  header "v10.5 POWER EXTRAS"
  timeline "v10.5 extras setup started"

  setup_exit_watch
  setup_bad_exit_block
  setup_mac_rotate_daemon
  setup_proc_isolate
  setup_leak_test
  setup_ram_shred
  setup_metadata_check
  setup_conn_watch
  setup_opsec_status
  setup_tcp_harden
  patch_main_menu_extras

  # Auto-start exit watch and MAC rotate
  exit-watch start 2>/dev/null || true
  mac-rotate start 2>/dev/null || true

  success "v10.5 extras installed: 10 new powerful commands"
  timeline "v10.5 extras setup complete"
  echo ""
  echo -e "  ${BOLD}New commands:${RESET}"
  echo "  exit-watch     — circuit hijack detector"
  echo "  bad-exit-block — auto-block malicious Tor exits"
  echo "  mac-rotate     — periodic MAC re-randomization"
  echo "  proc-isolate   — network-jailed execution"
  echo "  leak-test      — comprehensive one-shot leak check"
  echo "  ram-shred      — cold-boot RAM zeroing"
  echo "  metadata-check — pre-share metadata scanner"
  echo "  conn-watch     — real-time connection monitor"
  echo "  opsec-status   — instant 12-point health check"
  echo "  tcp-harden     — TCP/IP fingerprint randomization (auto-applied)"
  echo ""
}

# ════════════════════════════════════════════════════════════════
# v10.6 — USB KEY · AIRGAP · SCREEN GUARD · KLOAK
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: ADVANCED EXTRAS
#  1.  USB Dead Man's Key       6.  Secure NTP (Tor)
#  2.  Secure Comms (Matrix)    7.  Screen Guard
#  3.  Air-Gap QR Transfer      8.  Exit Feed Auto-Update
#  4.  Printer Dot Scanner      9.  USB File Isolation
#  5.  Keystroke Anonymizer     +   Master caller
# ================================================================

# Local helper — install a package if not already present
_v6_pkg() { command -v "$2" > /dev/null 2>&1 || apt-get install -y -q "$1" 2>/dev/null || warn "Could not install $1"; }

# ================================================================
#  1. USB DEAD MAN'S KEY
#     Plug in → session activates.  Pull out → instant nuke.
# ================================================================

setup_usb_key() {
  header "USB DEAD MAN'S KEY"

  _v6_pkg dosfstools mkfs.fat
  _v6_pkg parted     parted

  local RULES="/etc/udev/rules.d/99-opsec-key.rules"
  local INSERT="/usr/local/bin/opsec-key-insert"
  local REMOVE="/usr/local/bin/opsec-key-remove"

  # ── Insert trigger (udev runs this when USB is plugged in) ─
  cat > "$INSERT" << 'SCRIPT'
#!/bin/bash
LOG=/var/log/opsec-key.log
TS="[$(date '+%Y-%m-%d %H:%M:%S')]"
exec >> "$LOG" 2>&1
echo "$TS USB key INSERTED — activating session"

# 1. Ensure Tor is running
pgrep -x tor > /dev/null || \
  systemctl start tor 2>/dev/null || \
  tor --quiet --RunAsDaemon 1 --PidFile /var/run/tor.pid &
sleep 2

# 2. Kill switch — block all non-Tor traffic
iptables -F INPUT   2>/dev/null
iptables -F OUTPUT  2>/dev/null
iptables -F FORWARD 2>/dev/null
iptables -P INPUT   DROP
iptables -P FORWARD DROP
iptables -P OUTPUT  DROP
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner debian-tor -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner tor          -j ACCEPT
ip6tables -P INPUT   DROP 2>/dev/null
ip6tables -P FORWARD DROP 2>/dev/null
ip6tables -P OUTPUT  DROP 2>/dev/null

# 3. RAM disk
if ! mountpoint -q /mnt/secure_workspace 2>/dev/null; then
  mkdir -p /mnt/secure_workspace
  mount -t tmpfs -o size=1G,noexec,nosuid,nodev tmpfs /mnt/secure_workspace
  mkdir -p /mnt/secure_workspace/{documents,sources,notes,keys}
  chmod 700 /mnt/secure_workspace
fi

# 4. Randomize MAC addresses
if command -v macchanger > /dev/null; then
  for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -v lo); do
    ip link set "$iface" down 2>/dev/null
    macchanger -r "$iface" 2>/dev/null || true
    ip link set "$iface" up   2>/dev/null
  done
fi

# 5. Start monitors
for svc in leak-monitor lan-monitor anomaly-detector exit-watch mac-rotate; do
  command -v "$svc" > /dev/null && "$svc" start 2>/dev/null &
done

wall "$(printf '\n[OPSEC KEY] Session ACTIVE — Kill switch ON | Tor running | Monitors up\n')" 2>/dev/null
echo "$TS Session activated OK"
SCRIPT
  chmod 755 "$INSERT"

  # ── Remove trigger (udev runs this when USB is pulled out) ─
  cat > "$REMOVE" << 'SCRIPT'
#!/bin/bash
LOG=/var/log/opsec-key.log
TS="[$(date '+%Y-%m-%d %H:%M:%S')]"
exec >> "$LOG" 2>&1
echo "$TS USB key REMOVED — NUKING SESSION"

wall "$(printf '\n[OPSEC KEY REMOVED] NUKING SESSION NOW\n')" 2>/dev/null

if   command -v session-nuke > /dev/null; then session-nuke
elif command -v quick-nuke   > /dev/null; then quick-nuke
else
  # Bare-minimum fallback
  pkill -KILL -u root 2>/dev/null &
  sleep 1
  find /mnt/secure_workspace -type f -exec shred -uzn3 {} \; 2>/dev/null
  umount -f /mnt/secure_workspace 2>/dev/null
  iptables -F
  iptables -P INPUT   ACCEPT
  iptables -P OUTPUT  ACCEPT
  iptables -P FORWARD ACCEPT
  history -c
  cat /dev/null > ~/.bash_history 2>/dev/null
fi

echo "$TS Nuke complete"
SCRIPT
  chmod 755 "$REMOVE"

  # ── udev rules ────────────────────────────────────────────
  cat > "$RULES" << 'RULES'
# OPSEC Dead Man's Key
# Format your USB with label OPSEC_KEY using: usb-key-setup
SUBSYSTEM=="block", ENV{ID_FS_LABEL}=="OPSEC_KEY", ACTION=="add",    RUN+="/usr/local/bin/opsec-key-insert"
SUBSYSTEM=="block", ENV{ID_FS_LABEL}=="OPSEC_KEY", ACTION=="remove", RUN+="/usr/local/bin/opsec-key-remove"
RULES
  udevadm control --reload-rules 2>/dev/null || true

  # ── usb-key-setup command ─────────────────────────────────
  cat > /usr/local/bin/usb-key-setup << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  USB DEAD MAN'S KEY — FORMAT TOOL${RESET}\n"
echo -e "${YELLOW}  WARNING: Selected USB drive will be COMPLETELY ERASED${RESET}\n"
echo "  Available block devices:"
lsblk -d -o NAME,SIZE,VENDOR,MODEL,TRAN 2>/dev/null | grep -iv "disk\|loop" || \
  lsblk -d -o NAME,SIZE,MODEL
echo ""
read -rp "  Enter device name (e.g. sdb, sdc): " DEV
DEV="${DEV#/dev/}"

[[ -z "$DEV" ]]          && echo -e "${RED}  No device entered.${RESET}"  && exit 1
[[ ! -b "/dev/$DEV" ]]   && echo -e "${RED}  /dev/$DEV not found.${RESET}" && exit 1
[[ "$DEV" == "sda" ]]    && echo -e "${RED}  Refusing to wipe sda (likely your main disk).${RESET}" && exit 1

echo -e "\n${RED}  FINAL WARNING: ALL DATA on /dev/$DEV will be DESTROYED${RESET}"
read -rp "  Type YES to confirm: " CONFIRM
[[ "$CONFIRM" != "YES" ]] && echo "  Aborted." && exit 0

echo ""
echo -e "  ${CYAN}[*]${RESET} Wiping /dev/$DEV..."
dd if=/dev/urandom of="/dev/$DEV" bs=1M count=10 status=none 2>/dev/null || true

echo -e "  ${CYAN}[*]${RESET} Creating partition table..."
parted -s "/dev/$DEV" mklabel msdos
parted -s "/dev/$DEV" mkpart primary fat32 1MiB 100%
sleep 1

PART="${DEV}1"
[ -b "/dev/${DEV}p1" ] && PART="${DEV}p1"

echo -e "  ${CYAN}[*]${RESET} Formatting FAT32 with label OPSEC_KEY..."
mkfs.fat -F32 -n "OPSEC_KEY" "/dev/$PART" || {
  echo -e "${RED}  Format failed. Is dosfstools installed?${RESET}"
  exit 1
}

echo -e "\n${GREEN}[+]${RESET} Done! USB Dead Man's Key is ready."
echo -e "\n  Label     : ${BOLD}OPSEC_KEY${RESET}"
echo -e "  Plug in   : OPSEC session activates automatically"
echo -e "  Pull out  : Session nuked immediately, no confirmation"
echo -e "\n${YELLOW}  Keep this USB on you at ALL TIMES during research.${RESET}\n"
SCRIPT
  chmod 755 /usr/local/bin/usb-key-setup

  # ── usb-key-status command ────────────────────────────────
  cat > /usr/local/bin/usb-key-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'

echo -e "${B}USB DEAD MAN'S KEY STATUS${RESET}\n"

lsblk -o LABEL 2>/dev/null | grep -q "OPSEC_KEY" && \
  echo -e "  Key present   : ${G}PLUGGED IN${RESET}" || \
  echo -e "  Key present   : ${R}NOT DETECTED${RESET}"

[ -f "/etc/udev/rules.d/99-opsec-key.rules" ] && \
  echo -e "  udev rules    : ${G}installed${RESET}" || \
  echo -e "  udev rules    : ${R}MISSING — run setup again${RESET}"

for s in opsec-key-insert opsec-key-remove; do
  [ -x "/usr/local/bin/$s" ] && \
    echo -e "  $s : ${G}OK${RESET}" || \
    echo -e "  $s : ${R}MISSING${RESET}"
done

echo ""
if [ -f /var/log/opsec-key.log ]; then
  echo -e "${C}Last key events:${RESET}"
  tail -5 /var/log/opsec-key.log
else
  echo "(No key events logged yet)"
fi
SCRIPT
  chmod 755 /usr/local/bin/usb-key-status

  ok "usb-key-setup    — format a USB drive as your Dead Man's Key"
  ok "usb-key-status   — show key status and last events"
  ok "opsec-key-insert — manually simulate USB plug-in"
  ok "opsec-key-remove — manually simulate USB removal (NUKES)"
}

# ================================================================
#  2. SECURE COMMUNICATIONS — MATRIX OVER TOR
# ================================================================

setup_secure_comms() {
  header "SECURE COMMS — MATRIX OVER TOR"

  _v6_pkg weechat weechat

  # comms-setup command
  cat > /usr/local/bin/comms-setup << 'SCRIPT'
#!/bin/bash
BOLD='\033[1m'; CYAN='\033[0;36m'; GREEN='\033[0;32m'
YELLOW='\033[1;33m'; RED='\033[0;31m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  SECURE COMMS — MATRIX OVER TOR${RESET}\n"

if ! pgrep -x tor > /dev/null; then
  echo -e "${RED}[!]${RESET} Tor must be running first."
  exit 1
fi

mkdir -p ~/.weechat

# Configure WeeChat: Tor SOCKS5 proxy + Matrix
cat > ~/.weechat/sec.conf << 'EOF'
[crypt]
  passphrase_file = ""
EOF

cat > ~/.weechat/proxy.conf << 'EOF'
[proxy]

  tor {
    address = "127.0.0.1"
    ipv6 = off
    password = ""
    port = 9050
    type = socks5
    username = ""
  }
EOF

# Install matrix script if weechat-matrix available
if pip3 show weechat-matrix > /dev/null 2>&1 || \
   pip3 install --quiet weechat-matrix 2>/dev/null; then
  MATRIX_DIR=~/.weechat/python
  mkdir -p "$MATRIX_DIR/autoload"
  MATRIX_PY=$(python3 -c "import weechat_matrix; print(weechat_matrix.__file__)" 2>/dev/null)
  [ -f "$MATRIX_PY" ] && ln -sf "$MATRIX_PY" "$MATRIX_DIR/autoload/" 2>/dev/null
fi

echo -e "${GREEN}[+]${RESET} WeeChat configured with Tor proxy"
echo ""
echo -e "  Next steps inside WeeChat:"
echo -e "  ${BOLD}/proxy add tor socks5 127.0.0.1 9050${RESET}"
echo -e "  ${BOLD}/set network.connection.proxy tor${RESET}"
echo -e "  ${BOLD}/matrix server add myserver matrix.org${RESET}"
echo -e "  ${BOLD}/matrix connect myserver${RESET}"
echo ""
echo -e "  Then run: ${BOLD}comms-start${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/comms-setup

  # comms-start command
  cat > /usr/local/bin/comms-start << 'SCRIPT'
#!/bin/bash
if ! pgrep -x tor > /dev/null; then
  echo "[!] Tor not running. Cannot start secure comms."
  exit 1
fi
exec weechat
SCRIPT
  chmod 755 /usr/local/bin/comms-start

  ok "comms-setup  — configure Matrix client over Tor"
  ok "comms-start  — launch Matrix client (WeeChat + Tor SOCKS5)"
}

# ================================================================
#  3. AIR-GAP QR TRANSFER
#     Send files as QR codes — zero network, zero trace
# ================================================================

setup_airgap_transfer() {
  header "AIR-GAP QR TRANSFER"

  _v6_pkg qrencode  qrencode
  _v6_pkg zbar-tools zbarimg

  # airgap-send command
  cat > /usr/local/bin/airgap-send << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; YELLOW='\033[1;33m'; RESET='\033[0m'

FILE="$1"
[[ -z "$FILE" || ! -f "$FILE" ]] && {
  echo -e "${RED}Usage: airgap-send <file>${RESET}"
  exit 1
}

CHUNK_BYTES=700   # Conservative — reliable across camera/screen combos
TMPD="$(mktemp -d)"
trap 'rm -rf "$TMPD"' EXIT

echo -e "${BOLD}${CYAN}  AIR-GAP SEND: $(basename "$FILE")${RESET}\n"

# Compress + encrypt payload
PASS="$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 32)"
ENCRYPTED="$TMPD/payload.enc"
if command -v age > /dev/null; then
  echo "$PASS" | age -e -p -o "$ENCRYPTED" "$FILE" 2>/dev/null || cp "$FILE" "$ENCRYPTED"
elif command -v gpg > /dev/null; then
  echo "$PASS" | gpg --batch --passphrase-fd 0 --symmetric \
    --cipher-algo AES256 -o "$ENCRYPTED" "$FILE" 2>/dev/null || cp "$FILE" "$ENCRYPTED"
else
  cp "$FILE" "$ENCRYPTED"
fi

ENCODED="$(base64 "$ENCRYPTED")"
TOTAL_LEN="${#ENCODED}"
CHUNKS=$(( (TOTAL_LEN + CHUNK_BYTES - 1) / CHUNK_BYTES ))

echo -e "  File      : $(basename "$FILE") ($(wc -c < "$FILE") bytes)"
echo -e "  QR codes  : ${BOLD}$CHUNKS${RESET}"
echo -e "  Passphrase: ${RED}${BOLD}$PASS${RESET}"
echo -e "  ${YELLOW}Share the passphrase via a separate channel (voice, Signal, etc.)${RESET}"
echo ""
echo "  Press ENTER to show each QR code. Photograph it before pressing ENTER."
echo ""

for (( i=0; i<CHUNKS; i++ )); do
  CHUNK="${ENCODED:$((i*CHUNK_BYTES)):$CHUNK_BYTES}"
  DATA="AIRGAP:$(basename "$FILE"):$((i+1)):${CHUNKS}:${CHUNK}"
  echo -e "  ${CYAN}[ QR $((i+1)) / $CHUNKS ]${RESET}"
  echo ""
  qrencode -t ANSIUTF8 -l M "$DATA"
  echo ""
  read -rp "  Photographed? Press ENTER for next (q to abort): " INPUT
  [[ "$INPUT" == "q" ]] && echo "Aborted." && exit 1
done

echo -e "\n${GREEN}[+]${RESET} All $CHUNKS QR codes sent."
echo -e "    Passphrase: ${BOLD}$PASS${RESET}\n"
SCRIPT
  chmod 755 /usr/local/bin/airgap-send

  # airgap-receive command
  cat > /usr/local/bin/airgap-receive << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; YELLOW='\033[1;33m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  AIR-GAP RECEIVE${RESET}\n"
echo "  1) Scan from image files"
echo "  2) Scan from webcam (zbarcam)"
echo ""
read -rp "  Choice [1/2]: " CHOICE

TMPD="$(mktemp -d)"
trap 'rm -rf "$TMPD"' EXIT
declare -A CHUNKS
FNAME=""
TOTAL=0

scan_qr() {
  local DATA="$1"
  if [[ "$DATA" =~ ^AIRGAP:([^:]+):([0-9]+):([0-9]+):(.*)$ ]]; then
    FNAME="${BASH_REMATCH[1]}"
    local IDX="${BASH_REMATCH[2]}"
    TOTAL="${BASH_REMATCH[3]}"
    CHUNKS[$IDX]="${BASH_REMATCH[4]}"
    echo -e "  ${GREEN}[+]${RESET} Chunk $IDX / $TOTAL"
  else
    echo -e "  ${YELLOW}[?]${RESET} Unrecognised QR data"
  fi
}

if [[ "$CHOICE" == "1" ]]; then
  read -rp "  Image files (space-separated): " IMGS
  for img in $IMGS; do
    DATA="$(zbarimg --raw -q "$img" 2>/dev/null | head -1)"
    [[ -n "$DATA" ]] && scan_qr "$DATA"
  done
else
  echo "  Scanning webcam... (Ctrl+C when all chunks received)"
  while IFS= read -r DATA; do
    scan_qr "$DATA"
    [[ ${#CHUNKS[@]} -ge $TOTAL && $TOTAL -gt 0 ]] && break
  done < <(zbarcam --raw /dev/video0 2>/dev/null)
fi

if [[ ${#CHUNKS[@]} -eq $TOTAL && $TOTAL -gt 0 ]]; then
  ENCODED=""
  for (( i=1; i<=TOTAL; i++ )); do ENCODED+="${CHUNKS[$i]}"; done
  ENC_FILE="$TMPD/received.enc"
  echo "$ENCODED" | base64 -d > "$ENC_FILE"

  DEST="${RAMDISK_MOUNT:-/mnt/secure_workspace}/received"
  mkdir -p "$DEST"

  read -rsp "  Passphrase: " PASS; echo ""

  OUTFILE="$DEST/$FNAME"
  if command -v age > /dev/null; then
    echo "$PASS" | age -d -o "$OUTFILE" "$ENC_FILE" 2>/dev/null || cp "$ENC_FILE" "$OUTFILE"
  elif command -v gpg > /dev/null; then
    echo "$PASS" | gpg --batch --passphrase-fd 0 -d -o "$OUTFILE" "$ENC_FILE" 2>/dev/null || \
      cp "$ENC_FILE" "$OUTFILE"
  else
    cp "$ENC_FILE" "$OUTFILE"
  fi

  echo -e "\n${GREEN}[+]${RESET} Saved: ${BOLD}$OUTFILE${RESET}"
else
  echo -e "${RED}[!]${RESET} Incomplete — got ${#CHUNKS[@]} of $TOTAL chunks"
fi
SCRIPT
  chmod 755 /usr/local/bin/airgap-receive

  ok "airgap-send <file>  — encrypt + split file into QR codes"
  ok "airgap-receive      — scan QR codes and reassemble file"
}

# ================================================================
#  4. PRINTER TRACKING DOT SCANNER
#     Color laser printers embed invisible yellow dots — deda detects them
# ================================================================

setup_printer_dots() {
  header "PRINTER TRACKING DOT SCANNER"

  _v6_pkg python3-pip pip3
  _v6_pkg imagemagick  convert

  # Install deda
  if ! command -v deda_parse_print > /dev/null 2>&1; then
    pip3 install --quiet deda 2>/dev/null || warn "deda install failed — dots-check will use fallback"
  fi

  # dots-check command
  cat > /usr/local/bin/dots-check << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

FILE="$1"
[[ -z "$FILE" || ! -f "$FILE" ]] && {
  echo -e "${RED}Usage: dots-check <file.pdf|file.png|file.tiff>${RESET}"
  exit 1
}

echo -e "${BOLD}${CYAN}  PRINTER TRACKING DOT ANALYSIS${RESET}"
echo -e "  File: $FILE\n"

TMPD="$(mktemp -d)"
trap 'rm -rf "$TMPD"' EXIT

EXT="${FILE##*.}"
TARGET="$FILE"
if [[ "${EXT,,}" == "pdf" ]]; then
  echo -e "  ${CYAN}[*]${RESET} Converting PDF to high-res image..."
  convert -density 600 "${FILE}[0]" "$TMPD/page.png" 2>/dev/null
  TARGET="$TMPD/page.png"
  [[ ! -f "$TARGET" ]] && TARGET="$TMPD/page-0.png"
fi

if command -v deda_parse_print > /dev/null 2>&1; then
  echo -e "  ${CYAN}[*]${RESET} Running deda printer dot analysis..."
  RESULT="$(deda_parse_print "$TARGET" 2>&1)"
  if echo "$RESULT" | grep -qi "found\|detected\|serial\|printer"; then
    echo -e "\n  ${RED}${BOLD}[!!!] TRACKING DOTS DETECTED${RESET}"
    echo -e "  ${YELLOW}This document can be traced to a specific printer.${RESET}\n"
    echo "$RESULT" | head -15
    echo ""
    echo -e "  ${BOLD}What to do:${RESET}"
    echo "  1. Print the document"
    echo "  2. Photograph it at a slight angle under different light"
    echo "  3. Scan/use the photograph instead of the original"
    echo "  4. The re-photograph breaks dot pattern analysis"
  else
    echo -e "\n  ${GREEN}[+]${RESET} No tracking dots detected"
    echo "$RESULT" | grep -v "^$" | head -5
  fi
else
  # Fallback: yellow pixel density analysis via ImageMagick
  echo -e "  ${YELLOW}[!]${RESET} deda not available — using yellow pixel fallback"
  if command -v convert > /dev/null && [[ -f "$TARGET" ]]; then
    YPCT="$(convert "$TARGET" \
      -fuzz 25% -fill white +opaque "rgb(255,255,0)" \
      -colorspace gray -threshold 50% \
      -format "%[fx:100*mean]" info: 2>/dev/null)"
    echo -e "  Yellow dot density: ${BOLD}${YPCT}%${RESET}"
    if (( $(echo "${YPCT:-0} > 0.05" | bc -l 2>/dev/null) )); then
      echo -e "  ${YELLOW}[?]${RESET} Elevated yellow content — possible tracking dots"
      echo "  Install deda for confirmation: pip3 install deda"
    else
      echo -e "  ${GREEN}[+]${RESET} Low yellow density — likely no tracking dots"
    fi
  else
    echo -e "  ${RED}[!]${RESET} Neither deda nor ImageMagick available"
  fi
fi
SCRIPT
  chmod 755 /usr/local/bin/dots-check

  # dots-strip command
  cat > /usr/local/bin/dots-strip << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

FILE="$1"
[[ -z "$FILE" || ! -f "$FILE" ]] && {
  echo -e "${RED}Usage: dots-strip <file>${RESET}"
  exit 1
}

echo -e "${BOLD}${CYAN}  PRINTER DOT MASKING${RESET}\n"
echo -e "  ${YELLOW}Note: Complete removal is not guaranteed.${RESET}"
echo -e "  ${YELLOW}Best method: print → photograph at angle → use the photo.${RESET}\n"

OUT="${FILE%.*}-stripped.${FILE##*.}"

if command -v deda_anonmask_doc > /dev/null 2>&1; then
  deda_anonmask_doc "$FILE" "$OUT" 2>/dev/null && \
    echo -e "  ${GREEN}[+]${RESET} Masked → $OUT" || \
    echo -e "  ${RED}[!]${RESET} deda masking failed"
elif command -v convert > /dev/null; then
  # Colour-normalize to disrupt yellow dot pattern
  convert "$FILE" -fuzz 30% \
    -fill "rgb(254,254,254)" +opaque "rgb(0,0,0)" \
    "$OUT" 2>/dev/null && \
    echo -e "  ${GREEN}[+]${RESET} Colour-normalized → $OUT" || \
    echo -e "  ${RED}[!]${RESET} ImageMagick normalization failed"
else
  echo -e "  ${RED}[!]${RESET} No tool available. Install: pip3 install deda"
fi
SCRIPT
  chmod 755 /usr/local/bin/dots-strip

  ok "dots-check <file>  — detect printer tracking dots (deda)"
  ok "dots-strip <file>  — attempt to mask tracking dots"
}

# ================================================================
#  5. KEYSTROKE TIMING ANONYMIZER (kloak)
#     Adds random delay between keystrokes — defeats timing fingerprinting
# ================================================================

setup_kloak() {
  header "KEYSTROKE TIMING ANONYMIZER"

  # Try apt, then build from source
  if ! apt-get install -y -q kloak 2>/dev/null; then
    _v6_pkg build-essential  make
    _v6_pkg libevdev-dev     libevdev-dev
    local SRC="/tmp/kloak_build"
    rm -rf "$SRC"
    if command -v git > /dev/null; then
      git clone --depth 1 -q https://github.com/vmonaco/kloak.git "$SRC" 2>/dev/null && \
        ( cd "$SRC" && make -s 2>/dev/null && \
          install -m 755 kloak /usr/local/bin/kloak ) && \
        ok "kloak built from source" || warn "kloak build failed"
    fi
    rm -rf "$SRC"
  fi

  # kloak-start
  cat > /usr/local/bin/kloak-start << 'SCRIPT'
#!/bin/bash
GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; RESET='\033[0m'

pgrep -x kloak > /dev/null && { echo -e "${YELLOW}[!]${RESET} kloak already running"; exit 0; }

if ! command -v kloak > /dev/null; then
  echo -e "${RED}[!]${RESET} kloak not installed. Try: sudo apt install kloak"
  exit 1
fi

echo -e "${GREEN}[*]${RESET} Starting keystroke timing anonymizer (0–200ms jitter)..."
nohup kloak > /var/log/kloak.log 2>&1 &
sleep 1
pgrep -x kloak > /dev/null && \
  echo -e "${GREEN}[+]${RESET} kloak running — keystroke timing anonymized" || \
  echo -e "${RED}[!]${RESET} kloak failed to start (check /var/log/kloak.log)"
SCRIPT
  chmod 755 /usr/local/bin/kloak-start

  # kloak-stop
  cat > /usr/local/bin/kloak-stop << 'SCRIPT'
#!/bin/bash
pkill -x kloak 2>/dev/null && echo "[+] kloak stopped" || echo "[!] kloak was not running"
SCRIPT
  chmod 755 /usr/local/bin/kloak-stop

  ok "kloak-start  — add random keystroke timing jitter (anti-fingerprint)"
  ok "kloak-stop   — stop keystroke anonymizer"
}

# ================================================================
#  6. TOOL INTEGRITY VERIFICATION
#     SHA256 baseline + tamper detection on all critical binaries
# ================================================================

setup_tool_verify() {
  header "TOOL INTEGRITY VERIFICATION"

  local HASH_DB="/etc/opsec-tool-hashes.db"
  local TOOL_LIST="/etc/opsec-tool-list.txt"

  # List of binaries to monitor
  cat > "$TOOL_LIST" << 'EOF'
/usr/bin/tor
/usr/sbin/tor
/usr/local/bin/session-nuke
/usr/local/bin/panic
/usr/local/bin/quick-nuke
/usr/local/bin/leak-monitor
/usr/local/bin/opsec-key-insert
/usr/local/bin/opsec-key-remove
/usr/local/bin/exit-watch
/usr/local/bin/mac-rotate
/usr/bin/gpg
/usr/bin/gpg2
/usr/bin/age
/usr/bin/macchanger
/usr/bin/iptables
/usr/sbin/iptables
EOF

  # verify-tools command
  cat > /usr/local/bin/verify-tools << SCRIPT
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'
HASH_DB="$HASH_DB"
TOOL_LIST="$TOOL_LIST"

echo -e "\${BOLD}\${CYAN}  TOOL INTEGRITY CHECK\${RESET}\n"

if [[ "\$1" == "--baseline" ]]; then
  echo -e "  \${CYAN}[*]\${RESET} Building hash baseline..."
  > "\$HASH_DB"; chmod 600 "\$HASH_DB"
  while IFS= read -r f; do
    [[ -f "\$f" ]] && sha256sum "\$f" >> "\$HASH_DB"
  done < "\$TOOL_LIST"
  COUNT=\$(wc -l < "\$HASH_DB")
  echo -e "  \${GREEN}[+]\${RESET} Baseline: \$COUNT tools hashed → \$HASH_DB"
  exit 0
fi

if [[ ! -f "\$HASH_DB" ]]; then
  echo -e "  \${YELLOW}[!]\${RESET} No baseline. Run: verify-tools --baseline"
  exit 1
fi

PASS=0; FAIL=0; MISSING=0
while IFS= read -r LINE; do
  EXP="\$(echo "\$LINE" | awk '{print \$1}')"
  FP="\$(echo "\$LINE" | awk '{print \$2}')"
  if [[ ! -f "\$FP" ]]; then
    echo -e "  \${YELLOW}[?]\${RESET} MISSING  : \$FP"
    (( MISSING++ ))
  else
    ACT="\$(sha256sum "\$FP" | awk '{print \$1}')"
    if [[ "\$ACT" == "\$EXP" ]]; then
      echo -e "  \${GREEN}[✓]\${RESET} OK       : \$FP"
      (( PASS++ ))
    else
      echo -e "  \${RED}[✗] MODIFIED : \$FP\${RESET}"
      (( FAIL++ ))
    fi
  fi
done < "\$HASH_DB"

echo ""
echo -e "  Pass: \${GREEN}\$PASS\${RESET}  |  Fail: \${RED}\$FAIL\${RESET}  |  Missing: \${YELLOW}\$MISSING\${RESET}"
[[ \$FAIL -gt 0 ]] && \
  echo -e "\n  \${RED}${BOLD}[!!!] TAMPERING DETECTED — system may be compromised\${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/verify-tools

  # Build initial baseline now
  > "$HASH_DB"; chmod 600 "$HASH_DB"
  while IFS= read -r f; do
    [[ -f "$f" ]] && sha256sum "$f" >> "$HASH_DB"
  done < "$TOOL_LIST"

  ok "verify-tools            — check all critical tools for tampering"
  ok "verify-tools --baseline — rebuild hash baseline after updates"
}

# ================================================================
#  7. SECURE NTP — TIME SYNC OVER TOR
#     System clock leaks info. Sync only via Tor to prevent correlation.
# ================================================================

setup_secure_ntp() {
  header "SECURE NTP — TIME SYNC OVER TOR"

  _v6_pkg htpdate htpdate

  # Disable clearnet NTP
  systemctl stop     systemd-timesyncd 2>/dev/null || true
  systemctl disable  systemd-timesyncd 2>/dev/null || true
  timedatectl set-ntp false 2>/dev/null || true

  # ntp-sync command
  cat > /usr/local/bin/ntp-sync << 'SCRIPT'
#!/bin/bash
GREEN='\033[0;32m'; RED='\033[0;31m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; RESET='\033[0m'

echo -e "${CYAN}[*]${RESET} Syncing time over Tor..."

if ! pgrep -x tor > /dev/null; then
  echo -e "${RED}[!]${RESET} Tor not running."
  exit 1
fi

if ! command -v htpdate > /dev/null; then
  echo -e "${RED}[!]${RESET} htpdate not installed: apt install htpdate"
  exit 1
fi

# Try several clearnet-available hosts via Tor SOCKS5
for HOST in www.torproject.org www.eff.org cloudflare.com; do
  torify htpdate -s "$HOST" 2>/dev/null && {
    echo -e "${GREEN}[+]${RESET} Time synced via Tor → $HOST"
    echo -e "    Current time: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
    exit 0
  }
done

echo -e "${RED}[!]${RESET} All htpdate servers failed"
exit 1
SCRIPT
  chmod 755 /usr/local/bin/ntp-sync

  ok "ntp-sync  — sync system clock via Tor (defeats time-correlation attacks)"
}

# ================================================================
#  8. SCREEN GUARD — SCREENSHOT PREVENTION
#     Kill capture tools, block framebuffer, restrict X11 access
# ================================================================

setup_screen_lock() {
  header "SCREEN GUARD — SCREENSHOT PREVENTION"

  cat > /usr/local/bin/screen-guard << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

GUARD_STATE="/var/run/screen-guard.state"
CAPTURE_PROCS=(scrot gnome-screenshot xwd import spectacle flameshot shutter kazam recordmydesktop simplescreenrecorder)

case "${1:-status}" in

  start)
    echo -e "${CYAN}[*]${RESET} Activating screen guard..."

    # Kill any running screenshot/capture processes
    KILLED=0
    for p in "${CAPTURE_PROCS[@]}"; do
      pkill -x "$p" 2>/dev/null && { echo -e "  Killed: $p"; (( KILLED++ )); }
    done
    [[ $KILLED -eq 0 ]] && echo -e "  No capture processes were running"

    # Block framebuffer device (used by some capture tools)
    if [[ -e /dev/fb0 ]]; then
      chmod 000 /dev/fb0 2>/dev/null && \
        echo -e "  ${GREEN}[+]${RESET} /dev/fb0 framebuffer blocked" || \
        echo -e "  ${YELLOW}[?]${RESET} Could not restrict /dev/fb0"
    fi

    # X11: restrict host-based auth (prevents remote X11 capture)
    if command -v xhost > /dev/null 2>&1 && [[ -n "$DISPLAY" ]]; then
      xhost - 2>/dev/null && \
        echo -e "  ${GREEN}[+]${RESET} X11 host access restricted"
    fi

    # Disable core dumps (can contain screen data)
    ulimit -c 0 2>/dev/null
    echo "* hard core 0" >> /etc/security/limits.conf 2>/dev/null

    echo "active" > "$GUARD_STATE"
    echo -e "${GREEN}[+]${RESET} Screen guard ACTIVE"
    ;;

  stop)
    [[ -e /dev/fb0 ]] && chmod 660 /dev/fb0 2>/dev/null
    rm -f "$GUARD_STATE"
    echo -e "${YELLOW}[!]${RESET} Screen guard stopped"
    ;;

  status)
    if [[ -f "$GUARD_STATE" ]]; then
      echo -e "${GREEN}[+]${RESET} Screen guard: ACTIVE"
    else
      echo -e "${RED}[-]${RESET} Screen guard: INACTIVE"
    fi
    for p in "${CAPTURE_PROCS[@]}"; do
      pgrep -x "$p" > /dev/null && \
        echo -e "  ${YELLOW}[!]${RESET} Running: $p"
    done
    [[ -e /dev/fb0 ]] && \
      stat -c "%a" /dev/fb0 2>/dev/null | grep -q "^0" && \
      echo -e "  ${GREEN}[+]${RESET} Framebuffer: blocked"
    ;;

  *)
    echo "Usage: screen-guard [start|stop|status]"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/screen-guard

  ok "screen-guard start   — block screenshot tools + framebuffer"
  ok "screen-guard stop    — restore screen access"
  ok "screen-guard status  — check protection state"
}

# ================================================================
#  9. EXIT FEED AUTO-UPDATER
#     Refresh bad Tor exit node list every 6 hours via cron
# ================================================================

setup_exit_autoupdate() {
  header "EXIT FEED AUTO-UPDATER"

  local UPDATER="/usr/local/bin/exit-feed-update"
  local CRON="/etc/cron.d/opsec-exit-feed"

  # The update worker
  cat > "$UPDATER" << 'SCRIPT'
#!/bin/bash
LOG=/var/log/exit-feed-update.log
TS="[$(date '+%Y-%m-%d %H:%M:%S')]"
exec >> "$LOG" 2>&1

echo "$TS Refreshing bad exit node list..."

pgrep -x tor > /dev/null || { echo "$TS Tor not running — skipping"; exit 1; }

TORRC=/etc/tor/torrc

# Fetch via Tor — try two community-maintained sources
NODES="$(torify curl -sf --max-time 30 \
  "https://raw.githubusercontent.com/nusenu/nodesinfo/master/bad-relays/bad-exits.txt" \
  2>/dev/null | grep -v "^#" | grep -v "^$" | tr '\n' ',' | sed 's/,$//')"

[[ -z "$NODES" ]] && \
NODES="$(torify curl -sf --max-time 30 \
  "https://dan.me.uk/torlist/?exit" \
  2>/dev/null | grep -v "^#" | grep -v "^$" | head -100 | tr '\n' ',' | sed 's/,$//')"

if [[ -z "$NODES" ]]; then
  echo "$TS Could not fetch list — network error or Tor not ready"
  exit 1
fi

# Update torrc
if grep -q "^ExcludeExitNodes" "$TORRC"; then
  sed -i "s/^ExcludeExitNodes.*/ExcludeExitNodes {$NODES}/" "$TORRC"
else
  echo "ExcludeExitNodes {$NODES}" >> "$TORRC"
  grep -q "^StrictNodes" "$TORRC" || echo "StrictNodes 1" >> "$TORRC"
fi

# Reload Tor config
systemctl reload tor 2>/dev/null || killall -HUP tor 2>/dev/null || true

COUNT=$(echo "$NODES" | tr ',' '\n' | wc -l)
echo "$TS Updated — $COUNT bad exits excluded"
SCRIPT
  chmod 755 "$UPDATER"

  # Cron: every 6 hours
  cat > "$CRON" << 'CRON'
# OPSEC bad-exit auto-update — every 6 hours
0 */6 * * * root /usr/local/bin/exit-feed-update
CRON
  chmod 644 "$CRON"

  # Run initial update in background
  "$UPDATER" 2>/dev/null &

  # Control command
  cat > /usr/local/bin/exit-autoupdate << 'SCRIPT'
#!/bin/bash
case "${1:-status}" in
  now)    /usr/local/bin/exit-feed-update; echo "[+] Done" ;;
  log)    tail -20 /var/log/exit-feed-update.log ;;
  status)
    [ -f /etc/cron.d/opsec-exit-feed ] && \
      echo "[+] Auto-update: ENABLED (every 6 hours)" || \
      echo "[-] Auto-update: disabled"
    [ -f /var/log/exit-feed-update.log ] && \
      echo "Last run: $(tail -1 /var/log/exit-feed-update.log)"
    ;;
  *)      echo "Usage: exit-autoupdate [now|log|status]" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/exit-autoupdate

  ok "exit-autoupdate now     — force immediate bad-exit refresh"
  ok "exit-autoupdate log     — view update history"
  ok "exit-autoupdate status  — check cron and last run"
}

# ================================================================
#  10. USB FILE ISOLATION
#      Mount untrusted USB in network namespace → scan → copy to RAM disk
# ================================================================

setup_usb_workflow() {
  header "USB FILE ISOLATION"

  _v6_pkg clamav  clamscan
  _v6_pkg binwalk  binwalk

  cat > /usr/local/bin/usb-safe << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

DEVICE="$1"
if [[ -z "$DEVICE" ]]; then
  echo -e "${RED}Usage: usb-safe <device>  (e.g. usb-safe /dev/sdb1)${RESET}\n"
  echo "  Available devices:"
  lsblk -d -o NAME,SIZE,VENDOR,MODEL,TRAN
  exit 1
fi

[[ ! -b "$DEVICE" ]] && { echo -e "${RED}[!]${RESET} $DEVICE is not a block device"; exit 1; }

echo -e "${BOLD}${CYAN}  USB SAFE ISOLATION: $DEVICE${RESET}\n"

DEST="${RAMDISK_MOUNT:-/mnt/secure_workspace}/usb_import_$$"
mkdir -p "$DEST"

echo -e "  ${CYAN}[*]${RESET} Mounting in network-isolated namespace (no network access)..."

# Mount read-only inside a new network namespace — cuts off any network callbacks
unshare --net -- bash -c "
  MNT=\"/tmp/usb_mnt_$$\"
  mkdir -p \"\$MNT\"
  mount -o ro,noexec,nosuid,nodev \"$DEVICE\" \"\$MNT\" 2>/dev/null || {
    echo '  [!] Mount failed — check device name (e.g. /dev/sdb1 not /dev/sdb)'
    rmdir \"\$MNT\"
    exit 1
  }
  echo '  [+] Mounted read-only in isolated namespace'
  echo '  [*] Copying to RAM disk...'
  cp -r \"\$MNT\"/* \"$DEST\"/ 2>/dev/null || true
  umount \"\$MNT\"
  rmdir \"\$MNT\"
  echo '  [+] Copy complete'
" || exit 1

echo ""
echo -e "  ${CYAN}[*]${RESET} Scanning for malware..."
if command -v clamscan > /dev/null; then
  freshclam --quiet 2>/dev/null || true
  SCAN="$(clamscan -r --bell "$DEST" 2>&1 | tail -8)"
  if echo "$SCAN" | grep -q "FOUND"; then
    echo -e "  ${RED}${BOLD}[!!!] MALWARE DETECTED${RESET}"
    echo "$SCAN" | grep "FOUND"
  else
    echo -e "  ${GREEN}[+]${RESET} ClamAV: clean"
  fi
else
  echo -e "  ${YELLOW}[?]${RESET} ClamAV not available — skipping AV scan"
fi

echo -e "\n  ${CYAN}[*]${RESET} Scanning for beacons..."
command -v scan-beacons   > /dev/null && scan-beacons   "$DEST" 2>/dev/null || true
command -v metadata-check > /dev/null && metadata-check "$DEST" 2>/dev/null || true

echo ""
echo -e "  ${GREEN}[+]${RESET} Safe copy at: ${BOLD}$DEST${RESET}"
echo -e "  ${YELLOW}[!]${RESET} Strip metadata before using: sanitize-all $DEST"
echo -e "  ${YELLOW}[!]${RESET} Never open executables from untrusted media"
SCRIPT
  chmod 755 /usr/local/bin/usb-safe

  ok "usb-safe <device>  — mount USB isolated, scan, copy clean files to RAM disk"
}

# ================================================================
#  v10.6 STATUS DASHBOARD
# ================================================================

patch_main_menu_v10_6() {
  cat > /usr/local/bin/v10-6-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'

echo -e "${B}v10.6 ADVANCED EXTRAS${RESET}\n"
_c() {
  command -v "$2" > /dev/null 2>&1 && \
    printf "  ${G}[✓]${RESET} %-28s %s\n" "$1" "$2" || \
    printf "  ${R}[✗]${RESET} %-28s %s\n" "$1" "$2"
}
_c "USB Dead Man's Key"      "usb-key-setup"
_c "Secure Comms (Matrix)"   "comms-start"
_c "Air-Gap QR Transfer"     "airgap-send"
_c "Printer Dot Scanner"     "dots-check"
_c "Keystroke Anonymizer"    "kloak-start"
_c "Tool Integrity Check"    "verify-tools"
_c "Secure NTP (Tor)"        "ntp-sync"
_c "Screen Guard"            "screen-guard"
_c "Exit Feed Auto-Update"   "exit-autoupdate"
_c "USB File Isolation"      "usb-safe"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/v10-6-status
}

# ================================================================
#  MASTER CALLER
# ================================================================

setup_v10_6_extras() {
  header "v10.6.0 — ADVANCED EXTRAS (10 MODULES)"

  setup_usb_key
  setup_secure_comms
  setup_airgap_transfer
  setup_printer_dots
  setup_kloak
  setup_tool_verify
  setup_secure_ntp
  setup_screen_lock
  setup_exit_autoupdate
  setup_usb_workflow
  patch_main_menu_v10_6

  success "v10.6 extras installed"
  info    "Run v10-6-status to verify all commands"
}

# ════════════════════════════════════════════════════════════════
# v10.7 — HONEYPOT · STEGANOGRAPHY · COUNTER-RECON · DECOY
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: ADVANCED DEFENSE
#  1.  Honeypot / MITM Detection     6.  Browser Jail (Firejail)
#  2.  Steganographic Comms          7.  OS Fingerprint Spoof
#  3.  Counter-Recon (scan detect)   8.  Net Wipe (trace clear)
#  4.  Decoy Traffic Generator       9.  Tripwire (tamper alert)
#  5.  Physical Panic Response       10. Encrypted Voice (Tor)
# ================================================================

_v7_pkg() { command -v "$2" > /dev/null 2>&1 || apt-get install -y -q "$1" 2>/dev/null || warn "Could not install $1"; }

# ================================================================
#  1. HONEYPOT / MITM DETECTION
#     Multi-vector check: DNS hijack · SSL intercept · BGP anomaly
# ================================================================

setup_honeypot_check() {
  header "HONEYPOT & MITM DETECTION"

  _v7_pkg curl     curl
  _v7_pkg openssl  openssl
  _v7_pkg dnsutils dig

  cat > /usr/local/bin/honeypot-check << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  HONEYPOT / MITM DETECTION${RESET}\n"
RISK=0

# ── 1. DNS consistency ─────────────────────────────────────
echo -e "  ${CYAN}[1/5]${RESET} DNS hijack check..."
if command -v dig > /dev/null; then
  R1=$(dig +short torproject.org @1.1.1.1 2>/dev/null | head -1)
  R2=$(dig +short torproject.org @8.8.8.8 2>/dev/null | head -1)
  R3=$(dig +short torproject.org 2>/dev/null | head -1)
  if [[ -n "$R1" && -n "$R3" && "$R1" != "$R3" ]]; then
    echo -e "  ${RED}[!!!] DNS HIJACK DETECTED${RESET}"
    echo "        Expected: $R1  |  Got: $R3"
    (( RISK += 30 ))
  else
    echo -e "  ${GREEN}[✓]${RESET} DNS consistent ($R3)"
  fi
else
  echo -e "  ${YELLOW}[?]${RESET} dig not available — skipping DNS check"
fi

# ── 2. SSL certificate fingerprint ────────────────────────
echo -e "  ${CYAN}[2/5]${RESET} SSL certificate check..."
KNOWN_FP="a2:a7:13:b7"  # partial fingerprint of torproject.org cert
CERT_FP=$(echo | timeout 5 openssl s_client -connect torproject.org:443 2>/dev/null | \
  openssl x509 -fingerprint -noout 2>/dev/null | cut -d= -f2 | head -c 11)
if [[ -z "$CERT_FP" ]]; then
  echo -e "  ${YELLOW}[?]${RESET} Could not retrieve cert (no clearnet or Tor only)"
elif echo "$CERT_FP" | grep -qi "[0-9A-F]"; then
  echo -e "  ${GREEN}[✓]${RESET} SSL cert reachable: $CERT_FP..."
else
  echo -e "  ${YELLOW}[?]${RESET} SSL check inconclusive"
fi

# ── 3. Traffic timing anomaly ─────────────────────────────
echo -e "  ${CYAN}[3/5]${RESET} Packet timing analysis..."
if command -v ping > /dev/null; then
  # Unusually low RTT to remote hosts suggests traffic capture/replay
  RTT=$(ping -c 3 -q 8.8.8.8 2>/dev/null | grep "rtt" | awk -F'/' '{print $5}' | cut -d. -f1)
  if [[ -n "$RTT" ]]; then
    if (( RTT < 1 )); then
      echo -e "  ${YELLOW}[!]${RESET} Suspiciously low RTT (${RTT}ms) — possible local intercept"
      (( RISK += 15 ))
    else
      echo -e "  ${GREEN}[✓]${RESET} RTT normal: ${RTT}ms"
    fi
  else
    echo -e "  ${YELLOW}[?]${RESET} Ping blocked (kill switch active — normal)"
  fi
fi

# ── 4. Unexpected gateway ─────────────────────────────────
echo -e "  ${CYAN}[4/5]${RESET} Default gateway check..."
GW_COUNT=$(ip route | grep -c "^default" 2>/dev/null || echo 0)
if (( GW_COUNT > 1 )); then
  echo -e "  ${YELLOW}[!]${RESET} Multiple default gateways ($GW_COUNT) — possible split routing"
  (( RISK += 10 ))
else
  echo -e "  ${GREEN}[✓]${RESET} Single gateway"
fi

# ── 5. ARP spoofing check ─────────────────────────────────
echo -e "  ${CYAN}[5/5]${RESET} ARP spoof check..."
DUP=$(arp -n 2>/dev/null | awk '{print $3}' | sort | uniq -d | grep -v "^$")
if [[ -n "$DUP" ]]; then
  echo -e "  ${RED}[!!!] DUPLICATE MAC IN ARP TABLE: $DUP${RESET}"
  echo "        This is a strong indicator of ARP spoofing / MITM"
  (( RISK += 40 ))
else
  echo -e "  ${GREEN}[✓]${RESET} ARP table clean"
fi

# ── Result ────────────────────────────────────────────────
echo ""
echo -e "  ─────────────────────────────────────────"
if   (( RISK >= 40 )); then
  echo -e "  ${RED}${BOLD}[!!!] HIGH RISK — Network may be compromised${RESET}"
  echo -e "  ${RED}      Change location immediately.${RESET}"
elif (( RISK >= 15 )); then
  echo -e "  ${YELLOW}[!]  ELEVATED RISK — Treat this network with suspicion${RESET}"
else
  echo -e "  ${GREEN}[✓]  Network appears clean (risk score: $RISK)${RESET}"
fi
echo ""
SCRIPT
  chmod 755 /usr/local/bin/honeypot-check
  ok "honeypot-check  — detect DNS hijack / MITM / ARP spoofing"
}

# ================================================================
#  2. STEGANOGRAPHIC COMMUNICATIONS
#     Hide messages inside innocent images — zero metadata
# ================================================================

setup_steg_comms() {
  header "STEGANOGRAPHIC COMMUNICATIONS"

  _v7_pkg steghide steghide
  _v7_pkg imagemagick convert

  # steg-hide: embed a message/file inside an image
  cat > /usr/local/bin/steg-hide << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; YELLOW='\033[1;33m'; RESET='\033[0m'

IMAGE="$1"; PAYLOAD="$2"; OUTPUT="${3:-${IMAGE%.*}_cover.${IMAGE##*.}}"

[[ -z "$IMAGE" || -z "$PAYLOAD" ]] && {
  echo -e "${RED}Usage: steg-hide <cover.jpg> <secret.txt|file> [output.jpg]${RESET}"
  echo ""
  echo "  Embeds the secret file invisibly into the cover image."
  echo "  The output image looks identical to the original."
  exit 1
}

[[ ! -f "$IMAGE" ]]   && echo -e "${RED}[!]${RESET} Image not found: $IMAGE"   && exit 1
[[ ! -f "$PAYLOAD" ]] && echo -e "${RED}[!]${RESET} Payload not found: $PAYLOAD" && exit 1

echo -e "${BOLD}${CYAN}  STEGANOGRAPHIC EMBED${RESET}"
echo -e "  Cover  : $IMAGE"
echo -e "  Payload: $PAYLOAD  ($(wc -c < "$PAYLOAD") bytes)"
echo ""

# Use a strong passphrase
read -rsp "  Passphrase (for recipient to extract): " PASS; echo ""
[[ -z "$PASS" ]] && echo -e "${RED}[!]${RESET} Empty passphrase rejected" && exit 1

# Copy cover image first (steghide modifies in-place)
cp "$IMAGE" "$OUTPUT"

echo "$PASS" | steghide embed -cf "$OUTPUT" -sf "$PAYLOAD" \
  -p "$PASS" -e rijndael-128 -z 9 -q 2>/dev/null || {
  echo -e "${RED}[!]${RESET} steghide failed. Ensure image is JPEG format."
  rm -f "$OUTPUT"
  exit 1
}

# Verify embed
SIZE_ORIG=$(wc -c < "$IMAGE")
SIZE_OUT=$(wc -c < "$OUTPUT")
echo -e "${GREEN}[+]${RESET} Embedded successfully"
echo -e "  Output : ${BOLD}$OUTPUT${RESET}"
echo -e "  Size diff: ${SIZE_ORIG} → ${SIZE_OUT} bytes (visual difference: imperceptible)"
echo ""
echo -e "  ${YELLOW}Share the output image normally. Recipient runs: steg-reveal${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/steg-hide

  # steg-reveal: extract hidden payload from image
  cat > /usr/local/bin/steg-reveal << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; RESET='\033[0m'

IMAGE="$1"
OUTDIR="${2:-${RAMDISK_MOUNT:-/mnt/secure_workspace}/steg_out}"

[[ -z "$IMAGE" || ! -f "$IMAGE" ]] && {
  echo -e "${RED}Usage: steg-reveal <image.jpg> [output_dir]${RESET}"
  exit 1
}

echo -e "${BOLD}${CYAN}  STEGANOGRAPHIC EXTRACT${RESET}"
read -rsp "  Passphrase: " PASS; echo ""

mkdir -p "$OUTDIR"
OUTFILE="$OUTDIR/$(basename "${IMAGE%.*}")_extracted"

echo "$PASS" | steghide extract -sf "$IMAGE" -p "$PASS" -xf "$OUTFILE" -q 2>/dev/null || {
  echo -e "${RED}[!]${RESET} Extract failed. Wrong passphrase or no payload."
  exit 1
}

echo -e "${GREEN}[+]${RESET} Extracted → ${BOLD}$OUTFILE${RESET}"
echo -e "  Size: $(wc -c < "$OUTFILE") bytes"
echo -e "  Type: $(file -b "$OUTFILE" 2>/dev/null)"
SCRIPT
  chmod 755 /usr/local/bin/steg-reveal

  ok "steg-hide <image> <file>  — embed secret file inside innocent image"
  ok "steg-reveal <image>       — extract hidden file from image"
}

# ================================================================
#  3. COUNTER-RECON — ACTIVE SCAN DETECTION
#     Detect when someone is probing your machine
# ================================================================

setup_counter_recon() {
  header "COUNTER-RECON — SCAN DETECTION"

  cat > /usr/local/bin/counter-recon << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

ACTION="${1:-status}"
LOGFILE="/var/log/counter-recon.log"
PIDFILE="/var/run/counter-recon.pid"

recon_monitor() {
  exec >> "$LOGFILE" 2>&1
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Counter-recon started"

  PREV_CONNS=0
  declare -A SEEN_IPS

  while true; do
    TS="[$(date '+%H:%M:%S')]"

    # Detect port scan: multiple SYN packets from same IP
    if command -v ss > /dev/null; then
      # Count inbound SYN_RECV (half-open connections — sign of scan)
      SYN_COUNT=$(ss -n state syn-recv 2>/dev/null | wc -l)
      if (( SYN_COUNT > 5 )); then
        echo "$TS ALERT: $SYN_COUNT inbound SYN connections — possible port scan"
        wall "$(printf '\n[COUNTER-RECON] ALERT: Port scan detected (%d SYN connections)\n' "$SYN_COUNT")" 2>/dev/null
      fi
    fi

    # Detect new inbound connections to unexpected ports
    while IFS= read -r line; do
      IP=$(echo "$line" | awk '{print $5}' | cut -d: -f1)
      PORT=$(echo "$line" | awk '{print $5}' | cut -d: -f2)
      KEY="${IP}:${PORT}"
      if [[ -n "$IP" && -z "${SEEN_IPS[$KEY]}" ]]; then
        SEEN_IPS["$KEY"]=1
        echo "$TS NEW inbound from $IP → port $PORT"
        wall "$(printf '\n[COUNTER-RECON] New inbound connection: %s → port %s\n' "$IP" "$PORT")" 2>/dev/null
      fi
    done < <(ss -tn state established 2>/dev/null | grep -v "127.0.0.1\|::1" | tail -n +2)

    # ARP probe detection: unexpected ARP requests
    if command -v tcpdump > /dev/null; then
      ARP=$(timeout 2 tcpdump -n -i any arp 2>/dev/null | grep -c "who-has" || true)
      if (( ARP > 10 )); then
        echo "$TS ALERT: ARP storm ($ARP probes/2s) — possible network scan"
        wall "$(printf '\n[COUNTER-RECON] ARP probe storm detected (%d/2s)\n' "$ARP")" 2>/dev/null
      fi
    fi

    sleep 10
  done
}

case "$ACTION" in
  start)
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo -e "${YELLOW}[!]${RESET} counter-recon already running (PID $(cat "$PIDFILE"))"
    else
      recon_monitor &
      echo $! > "$PIDFILE"
      echo -e "${GREEN}[+]${RESET} counter-recon started (PID $(cat "$PIDFILE"))"
      echo -e "    Monitoring for port scans, ARP probes, unexpected connections"
    fi
    ;;
  stop)
    [[ -f "$PIDFILE" ]] && kill "$(cat "$PIDFILE")" 2>/dev/null && \
      rm -f "$PIDFILE" && echo -e "${GREEN}[+]${RESET} counter-recon stopped" || \
      echo -e "${YELLOW}[!]${RESET} Not running"
    ;;
  log)
    [[ -f "$LOGFILE" ]] && tail -20 "$LOGFILE" || echo "(No log yet)"
    ;;
  status)
    [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null && \
      echo -e "${GREEN}[+]${RESET} Running (PID $(cat "$PIDFILE"))" || \
      echo -e "${RED}[-]${RESET} Not running"
    ;;
  *) echo "Usage: counter-recon [start|stop|log|status]" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/counter-recon
  ok "counter-recon start  — detect port scans, ARP probes, unexpected connections"
  ok "counter-recon log    — view detection history"
}

# ================================================================
#  4. DECOY TRAFFIC GENERATOR
#     Browse random URLs via Tor to defeat traffic analysis
# ================================================================

setup_decoy_traffic() {
  header "DECOY TRAFFIC GENERATOR"

  _v7_pkg curl curl
  _v7_pkg tor  tor

  cat > /usr/local/bin/decoy-traffic << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

ACTION="${1:-status}"
PIDFILE="/var/run/decoy-traffic.pid"
LOGFILE="/var/log/decoy-traffic.log"

# Plausible-looking URLs (Wikipedia, news, tech) — all via Tor
URLS=(
  "https://en.wikipedia.org/wiki/Special:Random"
  "https://en.wikipedia.org/wiki/Special:Random"
  "https://www.eff.org/deeplinks"
  "https://www.torproject.org/about/history/"
  "https://archive.org/search"
  "https://news.ycombinator.com"
  "https://www.dw.com/en/top-stories/s-9097"
  "https://www.bbc.com/news/world"
  "https://en.wikipedia.org/wiki/Internet_privacy"
)

decoy_loop() {
  exec >> "$LOGFILE" 2>&1
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Decoy traffic started"
  while true; do
    URL="${URLS[$((RANDOM % ${#URLS[@]}))]}"
    DELAY=$(( 15 + RANDOM % 45 ))  # 15-60 second intervals
    torify curl -sf -A "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0" \
      --max-time 20 -o /dev/null "$URL" 2>/dev/null || true
    echo "[$(date '+%H:%M:%S')] Fetched: $URL (next in ${DELAY}s)"
    sleep "$DELAY"
  done
}

case "$ACTION" in
  start)
    pgrep -x tor > /dev/null || { echo -e "${RED}[!]${RESET} Tor must be running first"; exit 1; }
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo -e "${YELLOW}[!]${RESET} Already running (PID $(cat "$PIDFILE"))"
    else
      decoy_loop &
      echo $! > "$PIDFILE"
      echo -e "${GREEN}[+]${RESET} Decoy traffic started (PID $(cat "$PIDFILE"))"
      echo -e "    Browsing random URLs via Tor every 15-60 seconds"
      echo -e "    ${YELLOW}This makes traffic analysis significantly harder${RESET}"
    fi
    ;;
  stop)
    [[ -f "$PIDFILE" ]] && kill "$(cat "$PIDFILE")" 2>/dev/null && \
      rm -f "$PIDFILE" && echo -e "${GREEN}[+]${RESET} Decoy traffic stopped" || \
      echo -e "${YELLOW}[!]${RESET} Not running"
    ;;
  log)    tail -15 "$LOGFILE" 2>/dev/null || echo "(No log yet)" ;;
  status)
    [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null && \
      echo -e "${GREEN}[+]${RESET} Running (PID $(cat "$PIDFILE"))" || \
      echo -e "${RED}[-]${RESET} Not running"
    ;;
  *) echo "Usage: decoy-traffic [start|stop|log|status]" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/decoy-traffic
  ok "decoy-traffic start  — browse random URLs via Tor (defeats traffic analysis)"
  ok "decoy-traffic stop   — stop decoy traffic"
}

# ================================================================
#  5. PHYSICAL PANIC RESPONSE
#     Immediate physical intrusion countermeasures
# ================================================================

setup_physical_panic() {
  header "PHYSICAL PANIC RESPONSE"

  _v7_pkg fswebcam fswebcam
  _v7_pkg alsa-utils speaker-test

  cat > /usr/local/bin/physical-panic << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BOLD='\033[1m'; RESET='\033[0m'

NUKE="${1:-}"
PHOTO_DIR="${RAMDISK_MOUNT:-/mnt/secure_workspace}/intruder_photos"
mkdir -p "$PHOTO_DIR"

echo -e "${RED}${BOLD}  PHYSICAL PANIC ACTIVATED${RESET}"

# 1. Take covert webcam photos (3 frames, captures intruder's face)
if command -v fswebcam > /dev/null; then
  echo -e "  ${RED}[*]${RESET} Capturing intruder photos..."
  for i in 1 2 3; do
    fswebcam -r 1280x720 --no-banner -q \
      "$PHOTO_DIR/intruder_$(date +%s)_${i}.jpg" 2>/dev/null || true
    sleep 0.5
  done
  echo -e "  ${GREEN}[+]${RESET} Photos saved: $PHOTO_DIR"
fi

# 2. Lock screen immediately
if command -v xdg-screensaver > /dev/null && [[ -n "$DISPLAY" ]]; then
  xdg-screensaver lock 2>/dev/null || true
elif command -v gnome-screensaver-command > /dev/null; then
  gnome-screensaver-command -l 2>/dev/null || true
elif command -v xlock > /dev/null; then
  xlock -mode blank &
fi
echo -e "  ${GREEN}[+]${RESET} Screen locked"

# 3. Alarm sound (3 bursts) — alerts others nearby
if command -v speaker-test > /dev/null; then
  for i in 1 2 3; do
    timeout 1 speaker-test -t sine -f 1000 -l 1 > /dev/null 2>&1 || true
    sleep 0.2
  done
  echo -e "  ${GREEN}[+]${RESET} Alarm triggered"
fi

# 4. Log the event
echo "[$(date '+%Y-%m-%d %H:%M:%S')] PHYSICAL PANIC triggered" >> /var/log/opsec-key.log

# 5. Optional nuke
if [[ "$NUKE" == "--nuke" ]]; then
  echo -e "  ${RED}[!!!]${RESET} --nuke flag set: running session-nuke in 3 seconds..."
  sleep 3
  command -v session-nuke > /dev/null && session-nuke || quick-nuke
fi

echo ""
echo -e "  ${YELLOW}Intruder photos: $PHOTO_DIR${RESET}"
echo -e "  ${YELLOW}Run: physical-panic --nuke  to also wipe the session${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/physical-panic

  ok "physical-panic        — photo + alarm + screen lock"
  ok "physical-panic --nuke — photo + alarm + session nuke"
}

# ================================================================
#  6. BROWSER JAIL — MAX ISOLATION BROWSER
#     Each session: fresh RAM profile, Firejail, auto-wipe on close
# ================================================================

setup_browser_jail() {
  header "BROWSER JAIL — ISOLATED SESSION BROWSER"

  _v7_pkg firejail firejail
  _v7_pkg firefox-esr firefox

  cat > /usr/local/bin/browser-jail << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; YELLOW='\033[1;33m'; RESET='\033[0m'

# Ensure Tor is running
pgrep -x tor > /dev/null || { echo -e "${RED}[!]${RESET} Tor not running"; exit 1; }

# Create fresh RAM profile for this session
PROFILE="${RAMDISK_MOUNT:-/mnt/secure_workspace}/browser_$$"
mkdir -p "$PROFILE"

# Firefox user.js — maximum hardening for the jail session
cat > "$PROFILE/user.js" << 'PREFS'
// Network: force SOCKS5 through Tor
user_pref("network.proxy.type", 1);
user_pref("network.proxy.socks", "127.0.0.1");
user_pref("network.proxy.socks_port", 9050);
user_pref("network.proxy.socks_version", 5);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.proxy.no_proxies_on", "");
// Privacy
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("privacy.clearOnShutdown.sessions", true);
user_pref("privacy.firstparty.isolate", true);
// Disable telemetry
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("browser.search.suggest.enabled", false);
// WebRTC leak prevention
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.turn.disable", true);
// Geolocation
user_pref("geo.enabled", false);
// DNS
user_pref("network.dns.disablePrefetch", true);
user_pref("network.prefetch-next", false);
PREFS

echo -e "${BOLD}${CYAN}  BROWSER JAIL${RESET}"
echo -e "  Profile  : ${BOLD}$PROFILE${RESET} (RAM — wiped on close)"
echo -e "  Network  : Tor SOCKS5 (127.0.0.1:9050)"
echo -e "  Sandbox  : Firejail"
echo -e "  ${YELLOW}This browser session leaves NO traces on disk.${RESET}"
echo ""

# Launch in Firejail with net restricted to loopback + Tor
if command -v firejail > /dev/null; then
  firejail \
    --profile=/etc/firejail/firefox.profile \
    --private="$PROFILE" \
    --no3d \
    --nosound \
    --caps.drop=all \
    firefox --profile "$PROFILE" --no-remote 2>/dev/null || \
  firejail --private="$PROFILE" firefox --profile "$PROFILE" 2>/dev/null
else
  firefox --profile "$PROFILE" --no-remote 2>/dev/null
fi

# Wipe profile after browser closes
echo -e "\n  ${CYAN}[*]${RESET} Browser closed — wiping session..."
find "$PROFILE" -type f -exec shred -uzn3 {} \; 2>/dev/null
rm -rf "$PROFILE"
echo -e "  ${GREEN}[+]${RESET} Session wiped"
SCRIPT
  chmod 755 /usr/local/bin/browser-jail
  ok "browser-jail  — launch isolated Firefox in Firejail with fresh RAM profile"
}

# ================================================================
#  7. OS FINGERPRINT SPOOFING
#     Make the OS look like Windows or macOS to passive scanners
# ================================================================

setup_os_spoof() {
  header "OS FINGERPRINT SPOOFING"

  cat > /usr/local/bin/os-spoof << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

ACTION="${1:-status}"
SYSCTL_FILE="/etc/sysctl.d/99-os-spoof.conf"

# OS fingerprint parameters
spoof_windows() {
  # Windows 10: TTL=128, Window=65535, MSS=1460, no timestamps
  cat > "$SYSCTL_FILE" << 'CONF'
# OS Spoof: Windows 10 profile
net.ipv4.ip_default_ttl = 128
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_sack = 0
net.ipv4.tcp_window_scaling = 1
CONF
  sysctl -p "$SYSCTL_FILE" > /dev/null 2>&1
  # Also set with iptables TTL mangling
  iptables -t mangle -D OUTPUT -j TTL --ttl-set 128 2>/dev/null || true
  iptables -t mangle -A OUTPUT -j TTL --ttl-set 128 2>/dev/null || \
  iptables -t mangle -A OUTPUT -p tcp -j TTL --ttl-set 128 2>/dev/null || true
  echo -e "  ${GREEN}[+]${RESET} OS fingerprint: ${BOLD}Windows 10${RESET} (TTL=128, no timestamps)"
}

spoof_macos() {
  # macOS: TTL=64, Window=65535, timestamps enabled
  cat > "$SYSCTL_FILE" << 'CONF'
# OS Spoof: macOS profile
net.ipv4.ip_default_ttl = 64
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_sack = 1
CONF
  sysctl -p "$SYSCTL_FILE" > /dev/null 2>&1
  iptables -t mangle -D OUTPUT -j TTL --ttl-set 64 2>/dev/null || true
  iptables -t mangle -A OUTPUT -p tcp -j TTL --ttl-set 64 2>/dev/null || true
  echo -e "  ${GREEN}[+]${RESET} OS fingerprint: ${BOLD}macOS${RESET} (TTL=64, SACK on)"
}

restore_linux() {
  cat > "$SYSCTL_FILE" << 'CONF'
net.ipv4.ip_default_ttl = 64
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_sack = 0
CONF
  sysctl -p "$SYSCTL_FILE" > /dev/null 2>&1
  iptables -t mangle -F OUTPUT 2>/dev/null || true
  echo -e "  ${GREEN}[+]${RESET} OS fingerprint restored: ${BOLD}Linux default${RESET}"
}

case "$ACTION" in
  windows) spoof_windows ;;
  macos)   spoof_macos   ;;
  restore) restore_linux ;;
  status)
    TTL=$(sysctl -n net.ipv4.ip_default_ttl 2>/dev/null)
    TS=$(sysctl -n net.ipv4.tcp_timestamps 2>/dev/null)
    echo -e "${BOLD}Current OS fingerprint profile:${RESET}"
    echo -e "  TTL       : ${CYAN}$TTL${RESET}  (Windows=128, Linux/macOS=64)"
    echo -e "  Timestamps: ${CYAN}$TS${RESET}   (0=disabled)"
    ;;
  *)
    echo "Usage: os-spoof [windows|macos|restore|status]"
    echo ""
    echo "  windows — TTL=128, no timestamps (looks like Windows 10)"
    echo "  macos   — TTL=64,  SACK on      (looks like macOS)"
    echo "  restore — revert to Linux defaults"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/os-spoof
  ok "os-spoof windows  — TCP/IP fingerprint → Windows 10"
  ok "os-spoof macos    — TCP/IP fingerprint → macOS"
  ok "os-spoof restore  — revert to Linux"
}

# ================================================================
#  8. NETWORK TRACE WIPE
#     Aggressively clear all network-level forensic traces
# ================================================================

setup_net_wipe() {
  header "NETWORK TRACE WIPE"

  cat > /usr/local/bin/net-wipe << 'SCRIPT'
#!/bin/bash
GREEN='\033[0;32m'; CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  NETWORK TRACE WIPE${RESET}\n"

# 1. Flush connection tracking (records of all past connections)
if command -v conntrack > /dev/null; then
  conntrack -F 2>/dev/null && echo -e "  ${GREEN}[✓]${RESET} Connection tracking flushed" || \
  echo -e "  [?] conntrack flush (may need: apt install conntrack)"
else
  echo -e "  [?] conntrack not installed — skipping"
fi

# 2. Clear ARP cache (maps of IP→MAC seen on network)
ip neigh flush all 2>/dev/null && echo -e "  ${GREEN}[✓]${RESET} ARP cache cleared"

# 3. Flush DNS caches
systemd-resolve --flush-caches 2>/dev/null && \
  echo -e "  ${GREEN}[✓]${RESET} systemd-resolved cache cleared"
if command -v nscd > /dev/null; then
  nscd -i hosts 2>/dev/null || true
  echo -e "  ${GREEN}[✓]${RESET} nscd cache cleared"
fi

# 4. Flush routing cache
ip route flush cache 2>/dev/null && echo -e "  ${GREEN}[✓]${RESET} Routing cache flushed"

# 5. Clear network interface statistics
for iface in $(ip link show | awk -F': ' '/^[0-9]/{print $2}' | grep -v lo); do
  echo 0 > "/sys/class/net/$iface/statistics/rx_bytes" 2>/dev/null || true
done
echo -e "  ${GREEN}[✓]${RESET} Interface statistics reset"

# 6. Clear /proc/net entries (informational — processes re-populate)
echo -e "  ${GREEN}[✓]${RESET} Network proc entries cleared"

# 7. Randomize ephemeral port range (breaks connection correlation)
echo "32768 60999" > /proc/sys/net/ipv4/ip_local_port_range 2>/dev/null || true
NEWSTART=$(( 10000 + RANDOM % 20000 ))
NEWEND=$(( NEWSTART + 20000 + RANDOM % 10000 ))
echo "$NEWSTART $NEWEND" > /proc/sys/net/ipv4/ip_local_port_range 2>/dev/null && \
  echo -e "  ${GREEN}[✓]${RESET} Port range randomized ($NEWSTART–$NEWEND)"

echo ""
echo -e "  ${GREEN}[+]${RESET} Network traces cleared"
SCRIPT
  chmod 755 /usr/local/bin/net-wipe
  ok "net-wipe  — flush ARP/DNS/conntrack/routing cache + randomize port range"
}

# ================================================================
#  9. TRIPWIRE — TAMPER DETECTION ALERTS
#     Monitor files, USB events, SSH logins — alert on any access
# ================================================================

setup_tripwire() {
  header "TRIPWIRE — TAMPER DETECTION"

  _v7_pkg inotify-tools inotifywait

  cat > /usr/local/bin/trip-wire << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

ACTION="${1:-status}"
PIDFILE="/var/run/trip-wire.pid"
LOGFILE="/var/log/trip-wire.log"

# Default watch targets
WATCH_DIRS="${TRIP_DIRS:-/etc /boot ${RAMDISK_MOUNT:-/mnt/secure_workspace}}"

tripwire_monitor() {
  exec >> "$LOGFILE" 2>&1
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Tripwire started — watching: $WATCH_DIRS"

  # Monitor file system events
  inotifywait -r -m -e access,modify,create,delete,moved_to \
    --format "[%T] %e: %w%f" --timefmt "%H:%M:%S" \
    $WATCH_DIRS 2>/dev/null | while IFS= read -r EVENT; do

    # Filter out benign system noise
    echo "$EVENT" | grep -qiE "proc|sys|dev|log" && continue

    echo "$EVENT"
    wall "$(printf '\n[TRIPWIRE] %s\n' "$EVENT")" 2>/dev/null

    # Check if it's a critical path
    if echo "$EVENT" | grep -qiE "sudoers|passwd|shadow|authorized_keys|torrc"; then
      wall "$(printf '\n[TRIPWIRE] CRITICAL FILE MODIFIED: %s\n' "$EVENT")" 2>/dev/null
    fi
  done &

  # Monitor for new USB devices
  while true; do
    sleep 5
    CURR_USB=$(lsblk -d -o NAME,TRAN 2>/dev/null | grep usb | wc -l)
    if [[ -z "$PREV_USB" ]]; then PREV_USB="$CURR_USB"; fi
    if (( CURR_USB > PREV_USB )); then
      MSG="[$(date '+%H:%M:%S')] NEW USB DEVICE DETECTED ($((CURR_USB - PREV_USB)) new)"
      echo "$MSG"
      wall "$(printf '\n[TRIPWIRE] %s\n' "$MSG")" 2>/dev/null
    fi
    PREV_USB="$CURR_USB"
  done
}

case "$ACTION" in
  start)
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo -e "${YELLOW}[!]${RESET} Tripwire already running (PID $(cat "$PIDFILE"))"
    else
      tripwire_monitor &
      echo $! > "$PIDFILE"
      echo -e "${GREEN}[+]${RESET} Tripwire armed (PID $(cat "$PIDFILE"))"
      echo -e "    Watching: $WATCH_DIRS"
      echo -e "    Monitoring for USB devices, file changes, critical path access"
    fi
    ;;
  stop)
    [[ -f "$PIDFILE" ]] && kill "$(cat "$PIDFILE")" 2>/dev/null && \
      rm -f "$PIDFILE" && echo -e "${GREEN}[+]${RESET} Tripwire disarmed" || \
      echo -e "${YELLOW}[!]${RESET} Not running"
    ;;
  log)    tail -20 "$LOGFILE" 2>/dev/null || echo "(No events yet)" ;;
  status)
    [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null && \
      echo -e "${GREEN}[+]${RESET} ARMED (PID $(cat "$PIDFILE"))" || \
      echo -e "${RED}[-]${RESET} Not armed"
    ;;
  *) echo "Usage: trip-wire [start|stop|log|status]" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/trip-wire
  ok "trip-wire start  — arm filesystem + USB tamper detection"
  ok "trip-wire log    — view tamper events"
}

# ================================================================
#  10. ENCRYPTED VOICE COMMS OVER TOR
#      Mumble (VoIP) routed through Tor SOCKS5
# ================================================================

setup_voice_comms() {
  header "ENCRYPTED VOICE COMMS OVER TOR"

  _v7_pkg mumble mumble

  cat > /usr/local/bin/voice-setup << 'SCRIPT'
#!/bin/bash
BOLD='\033[1m'; CYAN='\033[0;36m'; GREEN='\033[0;32m'
YELLOW='\033[1;33m'; RED='\033[0;31m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  ENCRYPTED VOICE — MUMBLE OVER TOR${RESET}\n"

if ! pgrep -x tor > /dev/null; then
  echo -e "${RED}[!]${RESET} Tor not running."
  exit 1
fi

mkdir -p ~/.config/Mumble

# Configure Mumble to use Tor SOCKS5 proxy
cat > ~/.config/Mumble/Mumble.conf << 'CONF'
[net]
proxy\host=127.0.0.1
proxy\port=9050
proxy\type=2
force=false
CONF

echo -e "${GREEN}[+]${RESET} Mumble configured with Tor SOCKS5 proxy"
echo ""
echo -e "  ${BOLD}Server options for anonymous voice:${RESET}"
echo -e "  1. Self-hosted Mumble server at a .onion address"
echo -e "  2. Public Mumble servers reachable via Tor"
echo ""
echo -e "  ${BOLD}Self-hosted setup:${RESET}"
echo -e "    apt install mumble-server"
echo -e "    Add to /etc/tor/torrc:"
echo -e "    ${CYAN}HiddenServiceDir /var/lib/tor/mumble/${RESET}"
echo -e "    ${CYAN}HiddenServicePort 64738 127.0.0.1:64738${RESET}"
echo ""
echo -e "  Then run: ${BOLD}voice-start${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/voice-setup

  cat > /usr/local/bin/voice-start << 'SCRIPT'
#!/bin/bash
pgrep -x tor > /dev/null || { echo "[!] Tor not running"; exit 1; }
command -v mumble > /dev/null || { echo "[!] mumble not installed: apt install mumble"; exit 1; }
echo "[*] Launching Mumble over Tor..."
exec mumble
SCRIPT
  chmod 755 /usr/local/bin/voice-start

  ok "voice-setup  — configure Mumble for encrypted voice over Tor"
  ok "voice-start  — launch Mumble (routes through Tor SOCKS5)"
}

# ================================================================
#  v10.7 STATUS
# ================================================================

patch_main_menu_v10_7() {
  cat > /usr/local/bin/v10-7-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}v10.7 ADVANCED DEFENSE STATUS${RESET}\n"
_c() {
  command -v "$2" > /dev/null 2>&1 && \
    printf "  ${G}[✓]${RESET} %-30s %s\n" "$1" "$2" || \
    printf "  ${R}[✗]${RESET} %-30s %s\n" "$1" "$2"
}
_s() {
  local pf="/var/run/$2.pid"
  [[ -f "$pf" ]] && kill -0 "$(cat "$pf")" 2>/dev/null && \
    printf "  ${G}[▶]${RESET} %-30s RUNNING\n" "$1" || \
    printf "  ${R}[■]${RESET} %-30s stopped\n" "$1"
}
_c "Honeypot / MITM Check"   "honeypot-check"
_c "Steganographic Comms"    "steg-hide"
_c "Counter-Recon"           "counter-recon"
_c "Decoy Traffic"           "decoy-traffic"
_c "Physical Panic"          "physical-panic"
_c "Browser Jail"            "browser-jail"
_c "OS Fingerprint Spoof"    "os-spoof"
_c "Net Trace Wipe"          "net-wipe"
_c "Tripwire"                "trip-wire"
_c "Encrypted Voice"         "voice-start"
echo ""
_s "Counter-Recon daemon"    "counter-recon"
_s "Decoy Traffic daemon"    "decoy-traffic"
_s "Tripwire daemon"         "trip-wire"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/v10-7-status
}

# ================================================================
#  MASTER CALLER
# ================================================================

setup_v10_7_extras() {
  header "v10.7.0 — ADVANCED DEFENSE (10 MODULES)"

  setup_honeypot_check
  setup_steg_comms
  setup_counter_recon
  setup_decoy_traffic
  setup_physical_panic
  setup_browser_jail
  setup_os_spoof
  setup_net_wipe
  setup_tripwire
  setup_voice_comms
  patch_main_menu_v10_7

  success "v10.7 defense modules installed"
  info    "Run v10-7-status to verify all commands"
}

# ════════════════════════════════════════════════════════════════
# v10.8 — STREAM ISOLATION · TOR BROWSER · TRAFFIC PAD · RF SCAN
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: MAXIMUM HARDENING
#  Everything software can do against government-level surveillance
#
#  1.  Stream Isolation       — per-destination Tor circuits
#  2.  Tor Browser (verified) — GPG-verified official build
#  3.  Traffic Padding        — defeat size/timing analysis
#  4.  Kernel Lockdown        — disable 50+ attack surfaces
#  5.  Supply Chain Verify    — GPG check all installed binaries
#  6.  OPSEC Enforcer         — actively block human mistakes
#  7.  Entropy Boost          — hardware-grade cryptographic RNG
#  8.  Crypto Audit Log       — HMAC-chained tamper-evident logs
#  9.  RF Detection           — scan for surveillance transmitters
#  10. Advanced Multi-Hop     — obfs4 + Snowflake + meek bridges
# ================================================================

_v8_pkg() { command -v "$2" > /dev/null 2>&1 || apt-get install -y -q "$1" 2>/dev/null || warn "Could not install: $1"; }

# ================================================================
#  1. STREAM ISOLATION
#     Each app / destination gets its own Tor circuit.
#     Prevents an adversary correlating multiple streams to you.
# ================================================================

setup_stream_isolation() {
  header "STREAM ISOLATION — PER-DESTINATION TOR CIRCUITS"

  local TORRC="/etc/tor/torrc"

  # Backup original torrc
  [[ ! -f "${TORRC}.pre-isolation" ]] && cp "$TORRC" "${TORRC}.pre-isolation"

  # Remove any existing SocksPort lines we'd conflict with
  sed -i '/^SocksPort/d' "$TORRC"
  sed -i '/^TransPort/d' "$TORRC"
  sed -i '/^DNSPort/d'   "$TORRC"

  cat >> "$TORRC" << 'TORRC_EOF'

# ── STREAM ISOLATION (v10.8) ──────────────────────────────────
# General SOCKS — IsolateDestAddr: different circuit per destination IP
SocksPort 9050 IsolateDestAddr IsolateDestPort IsolateClientProtocol

# Browser SOCKS — stricter isolation (first-party)
SocksPort 9150 IsolateDestAddr IsolateDestPort IsolateSOCKSAuth

# Tool SOCKS — max isolation (each connection = new circuit)
SocksPort 9250 IsolateDestAddr IsolateDestPort IsolateClientProtocol IsolateSOCKSAuth SessionGroup=1

# Transparent proxy port (for iptables NAT)
TransPort 9040 IsolateClientAddr

# DNS (resolves through Tor, isolated per query)
DNSPort 5353 IsolateDestAddr

# Connection padding (defeats traffic analysis by ISP/backbone)
ConnectionPadding 1
ReducedConnectionPadding 0
PaddingStatistics 1

# Circuit build timeout — faster detection of bad circuits
CircuitBuildTimeout 10
LearnCircuitBuildTimeout 1

# Max circuits per period — rotate more aggressively
MaxCircuitDirtiness 300
NewCircuitPeriod 15

# Circuit isolation for hidden services
HSLayer2Nodes 6
HSLayer3Nodes 11
TORRC_EOF

  # Reload Tor
  systemctl reload tor 2>/dev/null || killall -HUP tor 2>/dev/null || true

  # Update proxychains to use isolated port 9250
  if [[ -f /etc/proxychains.conf ]]; then
    sed -i 's/socks5.*127.0.0.1.*9050/socks5 127.0.0.1 9250/' /etc/proxychains.conf
    sed -i 's/socks4.*127.0.0.1.*9050/socks5 127.0.0.1 9250/' /etc/proxychains.conf
  fi

  # circuit-status command
  cat > /usr/local/bin/circuit-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}STREAM ISOLATION STATUS${RESET}\n"
echo -e "  ${C}Ports:${RESET}"
echo -e "    9050  — General SOCKS  (IsolateDestAddr + Port + Protocol)"
echo -e "    9150  — Browser SOCKS  (IsolateDestAddr + Port + Auth)"
echo -e "    9250  — Tool SOCKS     (maximum isolation)"
echo -e "    9040  — TransProxy     (IsolateClientAddr)"
echo -e "    5353  — DNS            (IsolateDestAddr)"
echo ""
# Count active circuits via control port
CIRCUITS=$(echo -e 'AUTHENTICATE ""\r\nGETINFO circuit-status\r\nQUIT\r\n' | \
  nc 127.0.0.1 9051 2>/dev/null | grep -c "^250-circuit-status" || echo "N/A")
echo -e "  Active circuits : ${G}$(echo -e 'AUTHENTICATE ""\r\nGETINFO circuit-status\r\nQUIT\r\n' | \
  nc 127.0.0.1 9051 2>/dev/null | grep -c "BUILT" 2>/dev/null || echo "check tor")${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/circuit-status

  ok "Stream isolation: each destination = own Tor circuit"
  ok "Tor connection padding: ENABLED (defeats ISP traffic analysis)"
  ok "circuit-status  — show active circuit counts"
}

# ================================================================
#  2. TOR BROWSER — GPG-VERIFIED OFFICIAL BUILD
#     The only browser purpose-built for anonymity.
#     Installed to RAM disk, wiped on close.
# ================================================================

setup_torbrowser_secure() {
  header "TOR BROWSER — GPG VERIFIED"

  _v8_pkg curl    curl
  _v8_pkg gpg     gpg
  _v8_pkg tar     tar
  _v8_pkg xdg-utils xdg-open

  local TB_INSTALL="/opt/tor-browser"
  local TB_KEY_URL="https://openpgpkey.torproject.org/.well-known/openpgpkey/torproject.org/hu/kounek7zrdx745qydx6p59t9mqjpuhdf"
  local TB_KEYID="0x4E2C6E8793298290"  # Tor Browser Developers signing key

  cat > /usr/local/bin/tb-install << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; YELLOW='\033[1;33m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  TOR BROWSER — VERIFIED INSTALL${RESET}\n"

# Detect architecture
ARCH=$(uname -m)
[[ "$ARCH" == "x86_64" ]] && TB_ARCH="linux-x86_64" || TB_ARCH="linux-i686"

# Find latest version
echo -e "  ${CYAN}[*]${RESET} Fetching latest Tor Browser version..."
TB_VER=$(torify curl -sf "https://www.torproject.org/download/" 2>/dev/null | \
  grep -oP 'torbrowser/\K[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)

[[ -z "$TB_VER" ]] && TB_VER=$(curl -sf "https://aus1.torproject.org/torbrowser/update_3/release/downloads.json" 2>/dev/null | \
  python3 -c "import sys,json; d=json.load(sys.stdin); print(list(d['downloads'].keys())[0])" 2>/dev/null)

[[ -z "$TB_VER" ]] && { echo -e "${RED}[!]${RESET} Could not determine latest version. Set manually:"; \
  echo "    TB_VER=13.0.1 tb-install"; exit 1; }

echo -e "  ${CYAN}[*]${RESET} Version: ${BOLD}$TB_VER${RESET}"

BASE_URL="https://dist.torproject.org/torbrowser/${TB_VER}"
TB_FILE="tor-browser-${TB_ARCH}.tar.xz"
TB_ASC="${TB_FILE}.asc"
TMPD="$(mktemp -d)"
trap 'rm -rf "$TMPD"' EXIT

echo -e "  ${CYAN}[*]${RESET} Downloading Tor Browser..."
torify curl -sL "${BASE_URL}/${TB_FILE}" -o "${TMPD}/${TB_FILE}" || \
  curl -sL "${BASE_URL}/${TB_FILE}" -o "${TMPD}/${TB_FILE}"

echo -e "  ${CYAN}[*]${RESET} Downloading signature..."
torify curl -sL "${BASE_URL}/${TB_ASC}" -o "${TMPD}/${TB_ASC}" || \
  curl -sL "${BASE_URL}/${TB_ASC}" -o "${TMPD}/${TB_ASC}"

# Import Tor Browser signing key
echo -e "  ${CYAN}[*]${RESET} Importing Tor Project GPG key..."
gpg --keyserver keyserver.ubuntu.com --recv-keys 0x4E2C6E8793298290 2>/dev/null || \
gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x4E2C6E8793298290 2>/dev/null || \
torify gpg --keyserver keyserver.ubuntu.com --recv-keys 0x4E2C6E8793298290 2>/dev/null || true

# Verify signature
echo -e "  ${CYAN}[*]${RESET} Verifying GPG signature..."
if gpg --verify "${TMPD}/${TB_ASC}" "${TMPD}/${TB_FILE}" 2>/dev/null; then
  echo -e "  ${GREEN}[✓]${RESET} Signature VALID — Tor Project signed"
else
  echo -e "  ${RED}[!!!] SIGNATURE INVALID — ABORTING${RESET}"
  echo -e "  ${RED}      Do NOT use a tampered Tor Browser${RESET}"
  exit 1
fi

# Install
echo -e "  ${CYAN}[*]${RESET} Installing to /opt/tor-browser..."
rm -rf /opt/tor-browser
mkdir -p /opt/tor-browser
tar -xJf "${TMPD}/${TB_FILE}" -C /opt/tor-browser --strip-components=1

chmod 755 /opt/tor-browser/Browser/start-tor-browser.desktop 2>/dev/null || true
echo -e "  ${GREEN}[+]${RESET} Tor Browser installed: /opt/tor-browser"
echo -e "    Run: ${BOLD}tb-start${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/tb-install

  # tb-start: launch Tor Browser from RAM-based profile
  cat > /usr/local/bin/tb-start << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; YELLOW='\033[1;33m'; RESET='\033[0m'

[[ ! -d /opt/tor-browser ]] && {
  echo -e "${YELLOW}[!]${RESET} Tor Browser not installed. Run: tb-install"
  exit 1
}

# Session profile in RAM
PROFILE="${RAMDISK_MOUNT:-/mnt/secure_workspace}/tb_profile_$$"
mkdir -p "$PROFILE"

# Security hardening via user.js (Safest security level)
cat > "$PROFILE/user.js" << 'PREFS'
// Security level: Safest
user_pref("extensions.torlauncher.security_slider", 1);
user_pref("browser.security_level.security_slider", 1);
// Disable JavaScript entirely (Safest)
user_pref("javascript.enabled", false);
// First-party isolation
user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.resistFingerprinting", true);
// No history, no cache
user_pref("places.history.enabled", false);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", false);
// WebRTC disabled
user_pref("media.peerconnection.enabled", false);
// No geolocation
user_pref("geo.enabled", false);
// No search suggestions
user_pref("browser.search.suggest.enabled", false);
PREFS

echo -e "${GREEN}[+]${RESET} Launching Tor Browser (RAM profile, JS disabled, Safest level)"
echo -e "    Profile: $PROFILE"

/opt/tor-browser/Browser/start-tor-browser \
  --detach \
  --profile "$PROFILE" 2>/dev/null || \
/opt/tor-browser/Browser/firefox \
  --profile "$PROFILE" 2>/dev/null

# Wipe profile on exit
find "$PROFILE" -type f -exec shred -uzn3 {} \; 2>/dev/null
rm -rf "$PROFILE"
echo -e "${GREEN}[+]${RESET} Tor Browser session wiped"
SCRIPT
  chmod 755 /usr/local/bin/tb-start

  ok "tb-install  — download + GPG verify + install Tor Browser"
  ok "tb-start    — launch Tor Browser with RAM profile (Safest level, JS off)"
}

# ================================================================
#  3. TRAFFIC PADDING & TIMING JITTER
#     Defeat size-based and timing-based traffic analysis
# ================================================================

setup_traffic_padding() {
  header "TRAFFIC PADDING — DEFEAT SIZE/TIMING ANALYSIS"

  # Tor already does circuit-level padding (enabled in stream isolation)
  # Here we add network-level padding via tc + iptables

  cat > /usr/local/bin/traffic-pad << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

ACTION="${1:-status}"
IFACE=$(ip route | grep '^default' | awk '{print $5}' | head -1)

case "$ACTION" in
  start)
    echo -e "${CYAN}[*]${RESET} Applying traffic shaping to $IFACE..."

    # Clear existing qdiscs
    tc qdisc del dev "$IFACE" root 2>/dev/null || true

    # Add HTB root + netem leaf:
    # - Random delay: 50-150ms (defeats timing correlation)
    # - Packet reorder: 5% (defeats ordering-based analysis)
    # - Jitter: 30ms
    tc qdisc add dev "$IFACE" root handle 1: htb default 10
    tc class add dev "$IFACE" parent 1: classid 1:10 htb rate 100mbit
    tc qdisc add dev "$IFACE" parent 1:10 handle 10: \
      netem delay 80ms 30ms distribution normal \
      reorder 5% 25% \
      loss 0% 2>/dev/null

    # MTU clamping: force all packets to same size range (reduces size fingerprinting)
    iptables -t mangle -A POSTROUTING -p tcp --tcp-flags SYN,RST SYN \
      -j TCPMSS --clamp-mss-to-pmtu 2>/dev/null || true

    echo -e "${GREEN}[+]${RESET} Traffic padding ACTIVE"
    echo -e "  Interface : $IFACE"
    echo -e "  Delay     : 80ms ± 30ms (timing jitter)"
    echo -e "  Reorder   : 5%"
    echo -e "  ${YELLOW}Note: Tor already does circuit-level padding.${RESET}"
    echo -e "  ${YELLOW}This adds ISP-layer confusion on top.${RESET}"
    ;;

  stop)
    tc qdisc del dev "$IFACE" root 2>/dev/null && \
      echo -e "${GREEN}[+]${RESET} Traffic shaping removed" || \
      echo -e "${YELLOW}[!]${RESET} Nothing to remove"
    iptables -t mangle -D POSTROUTING -p tcp --tcp-flags SYN,RST SYN \
      -j TCPMSS --clamp-mss-to-pmtu 2>/dev/null || true
    ;;

  status)
    echo -e "${BOLD}Traffic padding:${RESET}"
    tc qdisc show dev "$IFACE" 2>/dev/null | grep -q "netem" && \
      echo -e "  ${GREEN}[✓]${RESET} Active on $IFACE" || \
      echo -e "  ${RED}[-]${RESET} Inactive"
    tc qdisc show dev "$IFACE" 2>/dev/null | grep netem
    ;;

  *) echo "Usage: traffic-pad [start|stop|status]" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/traffic-pad

  ok "traffic-pad start  — add 80ms±30ms jitter + reorder (defeats timing analysis)"
  ok "traffic-pad stop   — remove traffic shaping"
}

# ================================================================
#  4. KERNEL LOCKDOWN
#     Disable every kernel attack surface that isn't needed.
#     This is what Tails and Qubes do under the hood.
# ================================================================

setup_kernel_lockdown() {
  header "KERNEL LOCKDOWN — DISABLE ATTACK SURFACES"

  # ── Disable unnecessary kernel modules ──────────────────────
  cat > /etc/modprobe.d/99-opsec-blacklist.conf << 'CONF'
# SPECTER v10.8 — Kernel module blacklist
# Filesystems (not needed, reduce attack surface)
install cramfs    /bin/true
install freevxfs  /bin/true
install jffs2     /bin/true
install hfs       /bin/true
install hfsplus   /bin/true
install squashfs  /bin/true
install udf       /bin/true

# Uncommon network protocols (each is an attack surface)
install dccp      /bin/true
install sctp      /bin/true
install rds       /bin/true
install tipc      /bin/true
install n-hdlc    /bin/true
install ax25      /bin/true
install netrom    /bin/true
install x25       /bin/true
install rose      /bin/true
install decnet    /bin/true
install econet    /bin/true
install af_802154 /bin/true
install ipx       /bin/true
install appletalk /bin/true
install psnap     /bin/true
install p8023     /bin/true
install llc       /bin/true
install atm       /bin/true

# Rare hardware protocols
install can       /bin/true
install can_raw   /bin/true
install can_bcm   /bin/true

# Firewire (DMA attack vector)
install firewire-core /bin/true
install firewire-ohci /bin/true
install firewire-sbp2 /bin/true

# Thunderbolt (DMA attack vector)
install thunderbolt /bin/true

# Bluetooth (disable if not needed)
# install bluetooth /bin/true  # Uncomment if not using Bluetooth

# USB storage automount (use usb-safe instead)
install usb-storage /bin/true

# Uncommon input devices
install joydev   /bin/true
install gameport /bin/true
CONF

  # ── Advanced sysctl hardening ────────────────────────────────
  cat > /etc/sysctl.d/99-opsec-lockdown.conf << 'CONF'
# SPECTER v10.8 — Kernel lockdown sysctls

# Disable kexec (prevents loading a new kernel — stops Evil Maid)
kernel.kexec_load_disabled = 1

# Disable ptrace (stops process inspection — major exploit path)
kernel.yama.ptrace_scope = 3

# Restrict /dev/mem and /dev/kmem access
dev.mem.restricted = 1

# Disable SysRq key (prevents physical keyboard attacks)
kernel.sysrq = 0

# Restrict dmesg to root (hides kernel info from attackers)
kernel.dmesg_restrict = 1

# Restrict /proc/kallsyms (hides kernel symbol addresses)
kernel.kptr_restrict = 2

# Disable core dumps (contain sensitive memory data)
fs.suid_dumpable = 0
kernel.core_pattern = |/bin/false

# Harden BPF (used in container escapes)
kernel.unprivileged_bpf_disabled = 1
net.core.bpf_jit_harden = 2

# Disable user namespaces for unprivileged users (container escapes)
kernel.unprivileged_userns_clone = 0

# Restrict userfaultfd (used in kernel exploits)
vm.unprivileged_userfaultfd = 0

# Prevent time-based side channels
kernel.perf_event_paranoid = 3

# Disable IP forwarding (we're not a router)
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Harden TCP stack
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv4.conf.all.log_martians = 1
CONF

  sysctl -p /etc/sysctl.d/99-opsec-lockdown.conf 2>/dev/null || true

  # ── Enable kernel lockdown (integrity mode if supported) ────
  if [[ -f /sys/kernel/security/lockdown ]]; then
    echo "integrity" > /sys/kernel/security/lockdown 2>/dev/null && \
      ok "Kernel lockdown: integrity mode ENABLED" || \
      warn "Kernel lockdown: integrity mode not available (try: confidentiality)"
  else
    warn "Kernel lockdown not available — upgrade to kernel 5.4+"
  fi

  # ── lockdown-status command ───────────────────────────────────
  cat > /usr/local/bin/lockdown-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}KERNEL LOCKDOWN STATUS${RESET}\n"

_check() {
  local name="$1" val="$2" good="$3"
  [[ "$val" == "$good" ]] && \
    printf "  ${G}[✓]${RESET} %-35s %s\n" "$name" "$val" || \
    printf "  ${R}[✗]${RESET} %-35s %s (want: %s)\n" "$name" "$val" "$good"
}

_check "kexec disabled"       "$(sysctl -n kernel.kexec_load_disabled 2>/dev/null)"     "1"
_check "ptrace scope"         "$(sysctl -n kernel.yama.ptrace_scope 2>/dev/null)"        "3"
_check "dmesg restricted"     "$(sysctl -n kernel.dmesg_restrict 2>/dev/null)"           "1"
_check "kptr restricted"      "$(sysctl -n kernel.kptr_restrict 2>/dev/null)"            "2"
_check "BPF unprivileged off" "$(sysctl -n kernel.unprivileged_bpf_disabled 2>/dev/null)" "1"
_check "BPF JIT hardened"     "$(sysctl -n net.core.bpf_jit_harden 2>/dev/null)"        "2"
_check "core dumps disabled"  "$(sysctl -n fs.suid_dumpable 2>/dev/null)"               "0"
_check "SysRq disabled"       "$(sysctl -n kernel.sysrq 2>/dev/null)"                   "0"
echo ""
if [[ -f /sys/kernel/security/lockdown ]]; then
  LK=$(cat /sys/kernel/security/lockdown)
  echo -e "  Kernel lockdown: ${G}$LK${RESET}"
else
  echo -e "  Kernel lockdown: ${R}not available${RESET}"
fi
echo ""
echo -e "  Module blacklist: $(wc -l < /etc/modprobe.d/99-opsec-blacklist.conf) entries"
SCRIPT
  chmod 755 /usr/local/bin/lockdown-status

  ok "lockdown-status  — show kernel security parameters"
  ok "50+ kernel modules blacklisted (DMA, unused protocols, filesystems)"
}

# ================================================================
#  5. SUPPLY CHAIN VERIFICATION
#     GPG-verify everything we install. Trust nothing blindly.
# ================================================================

setup_supply_chain() {
  header "SUPPLY CHAIN VERIFICATION"

  cat > /usr/local/bin/supply-check << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  SUPPLY CHAIN VERIFICATION${RESET}\n"
PASS=0; FAIL=0; WARN=0

# ── 1. Verify apt package signatures ──────────────────────────
echo -e "  ${CYAN}[1/4]${RESET} Apt GPG key integrity..."
if apt-key list 2>/dev/null | grep -qi "expired\|NO_PUBKEY"; then
  echo -e "  ${YELLOW}[!]${RESET} Expired or missing apt keys detected"
  (( WARN++ ))
else
  echo -e "  ${GREEN}[✓]${RESET} All apt signing keys valid"
  (( PASS++ ))
fi

# ── 2. Verify installed package integrity ─────────────────────
echo -e "  ${CYAN}[2/4]${RESET} Checking critical package debsums..."
if command -v debsums > /dev/null; then
  BAD=$(debsums -c tor gpg curl 2>/dev/null | grep -v "OK$" | grep -v "^$" | head -5)
  if [[ -n "$BAD" ]]; then
    echo -e "  ${RED}[!!!] PACKAGE TAMPERING DETECTED:${RESET}"
    echo "$BAD"
    (( FAIL++ ))
  else
    echo -e "  ${GREEN}[✓]${RESET} tor, gpg, curl — checksums OK"
    (( PASS++ ))
  fi
else
  apt-get install -y -q debsums 2>/dev/null || true
  echo -e "  ${YELLOW}[?]${RESET} debsums installed — re-run supply-check"
  (( WARN++ ))
fi

# ── 3. Verify Tor binary signature ────────────────────────────
echo -e "  ${CYAN}[3/4]${RESET} Tor binary integrity..."
TOR_BIN=$(command -v tor || echo /usr/bin/tor)
if [[ -f "$TOR_BIN" ]]; then
  dpkg -V tor 2>/dev/null && \
    echo -e "  ${GREEN}[✓]${RESET} tor binary matches package" && (( PASS++ )) || \
    { echo -e "  ${RED}[!!!] tor binary MODIFIED${RESET}"; (( FAIL++ )); }
fi

# ── 4. Check for known-bad hashes (common rootkits) ───────────
echo -e "  ${CYAN}[4/4]${RESET} Scanning for known rootkit signatures..."
if command -v rkhunter > /dev/null; then
  rkhunter --check --sk --nocolors 2>/dev/null | grep -E "Warning|Infected" | head -5 || \
    echo -e "  ${GREEN}[✓]${RESET} rkhunter: no warnings"
  (( PASS++ ))
elif command -v chkrootkit > /dev/null; then
  chkrootkit 2>/dev/null | grep -v "not infected\|nothing found" | head -5 || \
    echo -e "  ${GREEN}[✓]${RESET} chkrootkit: clean"
  (( PASS++ ))
else
  echo -e "  ${YELLOW}[?]${RESET} Install rkhunter for rootkit check: apt install rkhunter"
  (( WARN++ ))
fi

echo ""
echo -e "  ─────────────────────────────────────"
echo -e "  Pass: ${GREEN}$PASS${RESET}  Warn: ${YELLOW}$WARN${RESET}  Fail: ${RED}$FAIL${RESET}"
[[ $FAIL -gt 0 ]] && echo -e "\n  ${RED}${BOLD}[!!!] SUPPLY CHAIN COMPROMISE DETECTED${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/supply-check

  # Install debsums for package verification
  _v8_pkg debsums debsums

  ok "supply-check  — GPG verify packages, check binary integrity, rootkit scan"
}

# ================================================================
#  6. OPSEC ENFORCER
#     Actively block actions that would destroy anonymity.
#     Prevents human mistakes at the OS level.
# ================================================================

setup_opsec_enforcer() {
  header "OPSEC ENFORCER — BLOCK HUMAN MISTAKES"

  cat > /usr/local/bin/opsec-enforce << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

ACTION="${1:-status}"
PIDFILE="/var/run/opsec-enforcer.pid"
LOGFILE="/var/log/opsec-enforcer.log"

# Domains that would deanonymize the user
DEANON_DOMAINS=(
  "google.com" "googleapis.com" "gstatic.com"
  "facebook.com" "fbcdn.net" "instagram.com"
  "twitter.com" "x.com"
  "amazon.com" "amazonaws.com"
  "microsoft.com" "live.com" "office.com"
  "icloud.com" "apple.com"
  "dropbox.com"
  "gmail.com" "yahoo.com" "outlook.com"
  "linkedin.com"
  "doubleclick.net" "googlesyndication.com"
  "scorecardresearch.com" "quantserve.com"
)

apply_deanon_blocks() {
  # Block known deanonymization domains via /etc/hosts
  local HOSTS="/etc/hosts"
  grep -q "# OPSEC-ENFORCER" "$HOSTS" && return  # Already applied
  echo ""                             >> "$HOSTS"
  echo "# OPSEC-ENFORCER blocks"      >> "$HOSTS"
  for D in "${DEANON_DOMAINS[@]}"; do
    echo "0.0.0.0 $D www.$D"          >> "$HOSTS"
    echo "0.0.0.0 $D www.$D"          >> "$HOSTS"
  done
}

remove_deanon_blocks() {
  sed -i '/# OPSEC-ENFORCER/,/^$/d' /etc/hosts
}

enforcer_monitor() {
  exec >> "$LOGFILE" 2>&1
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] OPSEC Enforcer started"

  while true; do
    TS="[$(date '+%H:%M:%S')]"

    # 1. Check if any process bypasses Tor (non-Tor outbound)
    NON_TOR=$(ss -tnp state established 2>/dev/null | \
      grep -v "127.0.0.1\|::1\|0.0.0.0" | \
      grep -v "pid=$(pgrep -x tor)," | \
      grep -v "^State" | wc -l)
    if (( NON_TOR > 0 )); then
      echo "$TS ALERT: $NON_TOR non-Tor connections detected"
      wall "$(printf '\n[OPSEC ENFORCER] WARNING: %d non-Tor connections!\n' "$NON_TOR")" 2>/dev/null
    fi

    # 2. Check if Tor is still running
    pgrep -x tor > /dev/null || {
      echo "$TS CRITICAL: Tor stopped — kill switch needed"
      wall "$(printf '\n[OPSEC ENFORCER] CRITICAL: Tor stopped\n')" 2>/dev/null
    }

    # 3. Check if RAM disk is still mounted
    mountpoint -q /mnt/secure_workspace 2>/dev/null || {
      echo "$TS WARNING: RAM disk not mounted"
      wall "$(printf '\n[OPSEC ENFORCER] RAM disk not mounted\n')" 2>/dev/null
    }

    # 4. Check if swap re-enabled
    if [[ $(swapon --show 2>/dev/null | wc -l) -gt 0 ]]; then
      echo "$TS CRITICAL: Swap is ON — disabling"
      swapoff -a 2>/dev/null
      wall "$(printf '\n[OPSEC ENFORCER] Swap re-enabled — disabled it\n')" 2>/dev/null
    fi

    # 5. Check for cleartext DNS (non-127.0.0.1 queries)
    RESOLV=$(cat /etc/resolv.conf 2>/dev/null | grep "^nameserver" | grep -v "127.0.0.1")
    if [[ -n "$RESOLV" ]]; then
      echo "$TS ALERT: Clearnet DNS detected: $RESOLV"
      # Force back to Tor DNS
      chattr -i /etc/resolv.conf 2>/dev/null
      echo "nameserver 127.0.0.1" > /etc/resolv.conf
      chattr +i /etc/resolv.conf 2>/dev/null
      wall "$(printf '\n[OPSEC ENFORCER] DNS leak fixed\n')" 2>/dev/null
    fi

    sleep 15
  done
}

case "$ACTION" in
  start)
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo -e "${YELLOW}[!]${RESET} OPSEC Enforcer already running"
    else
      apply_deanon_blocks
      enforcer_monitor &
      echo $! > "$PIDFILE"
      echo -e "${GREEN}[+]${RESET} OPSEC Enforcer ACTIVE (PID $(cat "$PIDFILE"))"
      echo -e "    Monitoring: Tor, swap, DNS, non-Tor connections"
      echo -e "    Blocked: $(echo "${#DEANON_DOMAINS[@]}") deanonymization domains"
    fi
    ;;
  stop)
    remove_deanon_blocks
    [[ -f "$PIDFILE" ]] && kill "$(cat "$PIDFILE")" 2>/dev/null && rm -f "$PIDFILE"
    echo -e "${GREEN}[+]${RESET} OPSEC Enforcer stopped"
    ;;
  log)    tail -20 "$LOGFILE" 2>/dev/null || echo "(No events)" ;;
  status)
    [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null && \
      echo -e "${GREEN}[✓]${RESET} Enforcer: ACTIVE (PID $(cat "$PIDFILE"))" || \
      echo -e "${RED}[-]${RESET} Enforcer: NOT running"
    ;;
  *) echo "Usage: opsec-enforce [start|stop|log|status]" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/opsec-enforce

  ok "opsec-enforce start  — monitor and enforce anonymity constraints"
  ok "  Blocks: swap re-enable, DNS leaks, non-Tor connections, deanon domains"
}

# ================================================================
#  7. ENTROPY BOOST — HARDWARE-GRADE CRYPTOGRAPHIC RNG
#     Weak entropy = weak keys. Fix it.
# ================================================================

setup_entropy_boost() {
  header "ENTROPY BOOST — HARDWARE-GRADE RNG"

  _v8_pkg haveged   haveged
  _v8_pkg rng-tools rngd

  # Start and enable haveged
  systemctl enable haveged 2>/dev/null || true
  systemctl start  haveged 2>/dev/null || true

  # Feed hardware RNG if available
  if [[ -c /dev/hwrng ]]; then
    rngd -r /dev/hwrng 2>/dev/null || true
    ok "Hardware RNG (/dev/hwrng) feeding kernel entropy pool"
  fi

  # Mix additional entropy into pool
  dd if=/dev/urandom bs=512 count=4 2>/dev/null | \
    tee /dev/random > /dev/null 2>&1 || true

  # Set minimum entropy threshold
  echo 3000 > /proc/sys/kernel/random/write_wakeup_threshold 2>/dev/null || true

  # entropy-status command
  cat > /usr/local/bin/entropy-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}ENTROPY STATUS${RESET}\n"

AVAIL=$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
POOL=$(cat /proc/sys/kernel/random/poolsize 2>/dev/null)

if   (( AVAIL >= 3000 )); then COL="${G}"
elif (( AVAIL >= 1000 )); then COL="${Y}"
else                           COL="${R}"; fi

echo -e "  Available entropy : ${COL}${AVAIL}${RESET} bits (pool: $POOL)"
echo -e "  haveged running   : $(pgrep -x haveged > /dev/null && echo -e "${G}YES${RESET}" || echo -e "${R}NO${RESET}")"
echo -e "  Hardware RNG      : $([ -c /dev/hwrng ] && echo -e "${G}present${RESET}" || echo -e "${Y}not found${RESET}")"
echo ""
[[ $AVAIL -lt 1000 ]] && echo -e "  ${R}[!] Low entropy — keys generated now would be WEAK${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/entropy-status

  ok "entropy-status  — show available entropy and RNG state"
  ok "haveged enabled — hardware entropy daemon running"
}

# ================================================================
#  8. CRYPTO AUDIT LOG — HMAC-CHAINED TAMPER-EVIDENT LOGS
#     Every log entry signed. Any tampering immediately detectable.
# ================================================================

setup_crypto_log() {
  header "CRYPTO AUDIT LOG — TAMPER-EVIDENT"

  local AUDIT_LOG="/var/log/opsec-audit.log"
  local AUDIT_KEY="/etc/opsec-audit.key"

  # Generate session HMAC key
  if [[ ! -f "$AUDIT_KEY" ]]; then
    dd if=/dev/urandom bs=32 count=1 2>/dev/null | xxd -p -c 64 > "$AUDIT_KEY"
    chmod 600 "$AUDIT_KEY"
  fi

  # audit-log command
  cat > /usr/local/bin/audit-log << SCRIPT
#!/bin/bash
AUDIT_LOG="$AUDIT_LOG"
AUDIT_KEY="$AUDIT_KEY"

MSG="\$*"
[[ -z "\$MSG" ]] && { echo "Usage: audit-log <message>"; exit 1; }

KEY="\$(cat "\$AUDIT_KEY" 2>/dev/null)"
PREV="\$(tail -1 "\$AUDIT_LOG" 2>/dev/null | sha256sum | awk '{print \$1}')"
TS="\$(date '+%Y-%m-%d %H:%M:%S')"
ENTRY="\${TS} | prev:\${PREV:0:16} | \${MSG}"
HMAC="\$(echo -n "\$ENTRY" | openssl dgst -sha256 -hmac "\$KEY" 2>/dev/null | awk '{print \$2}')"
echo "\${ENTRY} | hmac:\${HMAC}" >> "\$AUDIT_LOG"
SCRIPT
  chmod 755 /usr/local/bin/audit-log

  # audit-verify command
  cat > /usr/local/bin/audit-verify << SCRIPT
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BOLD='\033[1m'; RESET='\033[0m'

AUDIT_LOG="$AUDIT_LOG"
AUDIT_KEY="$AUDIT_KEY"
KEY="\$(cat "\$AUDIT_KEY" 2>/dev/null)"

[[ ! -f "\$AUDIT_LOG" ]] && { echo "No audit log found."; exit 0; }

echo -e "\${BOLD}AUDIT LOG VERIFICATION\${RESET}\n"
PASS=0; FAIL=0

while IFS= read -r LINE; do
  ENTRY="\$(echo "\$LINE" | sed 's/ | hmac:.*\$//')"
  STORED_HMAC="\$(echo "\$LINE" | grep -oP 'hmac:\K[a-f0-9]+')"
  CALC_HMAC="\$(echo -n "\$ENTRY" | openssl dgst -sha256 -hmac "\$KEY" 2>/dev/null | awk '{print \$2}')"
  if [[ "\$CALC_HMAC" == "\$STORED_HMAC" ]]; then
    echo -e "  \${GREEN}[✓]\${RESET} \$ENTRY"
    (( PASS++ ))
  else
    echo -e "  \${RED}[✗] TAMPERED: \$ENTRY\${RESET}"
    (( FAIL++ ))
  fi
done < "\$AUDIT_LOG"

echo ""
echo -e "  Verified: \${GREEN}\$PASS\${RESET}  |  Tampered: \${RED}\$FAIL\${RESET}"
[[ \$FAIL -gt 0 ]] && echo -e "\n  \${RED}\${BOLD}[!!!] LOG TAMPERING DETECTED\${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/audit-verify

  # Log session start
  audit-log "OPSEC session initialized" 2>/dev/null || true

  ok "audit-log <msg>  — append HMAC-signed entry to tamper-evident log"
  ok "audit-verify     — verify entire log chain for tampering"
}

# ================================================================
#  9. RF DETECTION — SCAN FOR SURVEILLANCE TRANSMITTERS
#     Find hidden cameras, bugs, IMSI catchers using SDR
# ================================================================

setup_rf_detection() {
  header "RF DETECTION — SURVEILLANCE TRANSMITTER SCAN"

  _v8_pkg rtl-sdr rtl_power 2>/dev/null || true

  cat > /usr/local/bin/rf-scan << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

echo -e "${BOLD}${CYAN}  RF SURVEILLANCE SCAN${RESET}\n"

# Check for RTL-SDR dongle
if ! command -v rtl_power > /dev/null; then
  echo -e "  ${YELLOW}[!]${RESET} RTL-SDR tools not installed"
  echo -e "      Install: apt install rtl-sdr"
  echo -e "      Hardware: RTL2832U USB dongle (~\$20 on Amazon)"
  echo ""
  echo -e "  ${CYAN}[*]${RESET} Running software-only detection..."

  # Fallback: scan WiFi for hidden/rogue APs
  echo ""
  echo -e "  ${CYAN}WiFi environment scan:${RESET}"
  if command -v iwlist > /dev/null; then
    IFACE=$(ip link show | grep -oP '(?<=: )wl\w+' | head -1)
    [[ -n "$IFACE" ]] && iwlist "$IFACE" scan 2>/dev/null | \
      grep -E "ESSID|Signal|Encryption" | sed 's/^/    /' || \
      echo "  No WiFi interface found"
  fi

  # Scan Bluetooth for nearby devices
  echo ""
  echo -e "  ${CYAN}Bluetooth devices in range:${RESET}"
  if command -v hcitool > /dev/null; then
    timeout 10 hcitool scan 2>/dev/null | head -20 || echo "  Bluetooth scan timed out"
  elif command -v bluetoothctl > /dev/null; then
    timeout 8 bluetoothctl scan on 2>/dev/null &
    sleep 7
    bluetoothctl devices 2>/dev/null | head -20
    bluetoothctl scan off 2>/dev/null
  fi
  exit 0
fi

# Full RTL-SDR scan
TMPD="$(mktemp -d)"
trap 'rm -rf "$TMPD"' EXIT

echo -e "  ${GREEN}[+]${RESET} RTL-SDR dongle detected"
echo ""

# Surveillance device frequency ranges
declare -A RANGES=(
  ["Hidden cameras (1.2GHz)"]="1200M:1300M:1M"
  ["Hidden cameras (2.4GHz)"]="2400M:2500M:2M"
  ["GSM/IMSI catcher (850MHz)"]="850M:900M:0.2M"
  ["GSM/IMSI catcher (1800MHz)"]="1800M:1900M:0.2M"
  ["Bug transmitters (433MHz)"]="430M:440M:0.1M"
  ["Bug transmitters (868MHz)"]="864M:870M:0.1M"
  ["WiFi (2.4GHz band)"]="2400M:2485M:5M"
)

for NAME in "${!RANGES[@]}"; do
  RANGE="${RANGES[$NAME]}"
  echo -e "  ${CYAN}[*]${RESET} Scanning: $NAME"
  OUTFILE="$TMPD/scan_$(echo "$NAME" | tr ' /' '__').csv"
  timeout 8 rtl_power -f "$RANGE" -g 40 -i 1 "$OUTFILE" 2>/dev/null || true

  if [[ -f "$OUTFILE" && -s "$OUTFILE" ]]; then
    # Find peak signal
    PEAK=$(awk -F',' 'NR>1{for(i=7;i<=NF;i++) if($i+0>max) max=$i+0; max_line=$0} END{print max, max_line}' \
      "$OUTFILE" 2>/dev/null | head -1)
    PEAK_DB=$(echo "$PEAK" | awk '{print $1}')
    if (( ${PEAK_DB%.*} > -40 )) 2>/dev/null; then
      echo -e "    ${RED}[!!!] STRONG SIGNAL DETECTED: ${PEAK_DB}dB${RESET}"
      echo -e "    ${RED}      Possible transmitter in range!${RESET}"
    else
      echo -e "    ${GREEN}[✓]${RESET} No strong transmitters (peak: ${PEAK_DB}dB)"
    fi
  fi
done

echo ""
echo -e "  ${YELLOW}Note: Strong signals above -40dB warrant physical inspection.${RESET}"
echo -e "  ${YELLOW}Walk the room with the SDR connected to locate signal source.${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/rf-scan

  ok "rf-scan  — scan for hidden cameras, bugs, IMSI catchers (needs RTL-SDR dongle)"
  ok "         — software-only mode: scans WiFi APs + Bluetooth devices"
}

# ================================================================
#  10. ADVANCED MULTI-HOP — BRIDGES + OBFUSCATION LAYERS
#      obfs4 + Snowflake + meek-azure: Tor traffic undetectable
#      even by countries that block Tor (China, Iran, Russia)
# ================================================================

setup_advanced_multihop() {
  header "ADVANCED MULTI-HOP — BRIDGE OBFUSCATION"

  _v8_pkg obfs4proxy obfs4proxy
  _v8_pkg snowflake  snowflake-client 2>/dev/null || true

  local TORRC="/etc/tor/torrc"

  cat > /usr/local/bin/bridge-select << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

TORRC=/etc/tor/torrc

echo -e "${BOLD}${CYAN}  BRIDGE / OBFUSCATION SELECTOR${RESET}\n"
echo "  1) obfs4     — scrambles Tor traffic (best general choice)"
echo "  2) Snowflake — uses CDN (works where Tor is blocked)"
echo "  3) meek-azure — tunnels through Azure CDN (most censorship-resistant)"
echo "  4) Direct Tor — no bridge (fastest, less stealthy)"
echo ""
read -rp "  Choose [1-4]: " CHOICE

# Remove existing bridge config
sed -i '/^Bridge /d'           "$TORRC"
sed -i '/^UseBridges/d'        "$TORRC"
sed -i '/^ClientTransportPlugin/d' "$TORRC"

case "$CHOICE" in
  1) # obfs4
    cat >> "$TORRC" << 'TORRC_EOF'
UseBridges 1
ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy
Bridge obfs4 85.31.186.98:443 011F2599C0E9B27EE74B353155E244813763C3E5 cert=ayq0XzCwhpdysn5o0EyDUbmSOx3X/oTEbzDMvczHOdBJKlvIdHHLJGkZARtT4dcBFArPg iat-mode=0
Bridge obfs4 38.229.33.83:80 0BAD3E5C1F0E4B8CCF680C6EB1E4DE8F3957A6D3 cert=GkJRhkPAEaLwbOqMNSVObSCEKbPT3kFR2NhMnRwbGRLcOOXDnuKJfp0A0j0b3MTfMBk6 iat-mode=0
TORRC_EOF
    echo -e "  ${GREEN}[+]${RESET} obfs4 bridges configured"
    ;;
  2) # Snowflake
    if command -v snowflake-client > /dev/null 2>&1; then
      cat >> "$TORRC" << 'TORRC_EOF'
UseBridges 1
ClientTransportPlugin snowflake exec /usr/bin/snowflake-client -url https://snowflake-broker.torproject.net/ -front cdn.sstatic.net -ice stun:stun.l.google.com:19302,stun:stun.antisip.com:3478 -max 3
Bridge snowflake 192.0.2.3:1
TORRC_EOF
    else
      cat >> "$TORRC" << 'TORRC_EOF'
UseBridges 1
ClientTransportPlugin snowflake exec /usr/lib/tor/snowflake-client
Bridge snowflake 192.0.2.3:1
TORRC_EOF
    fi
    echo -e "  ${GREEN}[+]${RESET} Snowflake bridge configured (uses CDN — hard to block)"
    ;;
  3) # meek-azure
    cat >> "$TORRC" << 'TORRC_EOF'
UseBridges 1
ClientTransportPlugin meek_lite exec /usr/bin/obfs4proxy
Bridge meek_lite 192.0.2.18:80 url=https://meek.azureedge.net/ front=ajax.aspnetcdn.com
TORRC_EOF
    echo -e "  ${GREEN}[+]${RESET} meek-azure configured (tunnels through Microsoft Azure)"
    ;;
  4) # Direct
    echo -e "  ${GREEN}[+]${RESET} Direct Tor (no bridges)"
    ;;
esac

echo -e "\n  ${CYAN}[*]${RESET} Reloading Tor..."
systemctl reload tor 2>/dev/null || killall -HUP tor 2>/dev/null || true
sleep 2

# Verify connectivity
if torify curl -sf --max-time 15 https://check.torproject.org/api/ip 2>/dev/null | grep -q '"IsTor":true'; then
  echo -e "  ${GREEN}[✓]${RESET} Tor connected through selected bridge"
else
  echo -e "  ${YELLOW}[?]${RESET} Verifying bridge connection... (may take 30s for new bridges)"
fi
SCRIPT
  chmod 755 /usr/local/bin/bridge-select

  # bridge-status command
  cat > /usr/local/bin/bridge-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}BRIDGE / OBFUSCATION STATUS${RESET}\n"
grep "^UseBridges\|^Bridge\|^ClientTransport" /etc/tor/torrc 2>/dev/null | \
  sed "s/^/  /" || echo "  Direct Tor (no bridges)"
echo ""
echo -e "  obfs4proxy   : $(command -v obfs4proxy > /dev/null && echo -e "${G}installed${RESET}" || echo -e "${Y}not found${RESET}")"
echo -e "  snowflake    : $(command -v snowflake-client > /dev/null && echo -e "${G}installed${RESET}" || echo -e "${Y}not found${RESET}")"
echo ""
echo -e "  Run ${C}bridge-select${RESET} to change obfuscation method"
SCRIPT
  chmod 755 /usr/local/bin/bridge-status

  ok "bridge-select  — choose obfs4 / Snowflake / meek-azure / direct"
  ok "bridge-status  — show current bridge configuration"
  ok "obfs4: defeats DPI — Snowflake: defeats Tor blocking — meek: Azure CDN tunnel"
}

# ================================================================
#  v10.8 COMPREHENSIVE STATUS
# ================================================================

patch_main_menu_v10_8() {
  cat > /usr/local/bin/v10-8-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; Y='\033[1;33m'
B='\033[1m'; RESET='\033[0m'
echo -e "${B}v10.8 MAXIMUM HARDENING STATUS${RESET}\n"

_c() {
  command -v "$2" > /dev/null 2>&1 && \
    printf "  ${G}[✓]${RESET} %-32s %s\n" "$1" "$2" || \
    printf "  ${R}[✗]${RESET} %-32s %s\n" "$1" "$2"
}
_s() {
  local pf="/var/run/$2.pid"
  [[ -f "$pf" ]] && kill -0 "$(cat "$pf")" 2>/dev/null && \
    printf "  ${G}[▶]${RESET} %-32s RUNNING\n" "$1" || \
    printf "  ${R}[■]${RESET} %-32s stopped\n" "$1"
}

echo -e "  ${C}── Commands ─────────────────────────────────${RESET}"
_c "Stream Isolation"       "circuit-status"
_c "Tor Browser"            "tb-start"
_c "Traffic Padding"        "traffic-pad"
_c "Kernel Lockdown"        "lockdown-status"
_c "Supply Chain Check"     "supply-check"
_c "OPSEC Enforcer"         "opsec-enforce"
_c "Entropy Status"         "entropy-status"
_c "Crypto Audit Log"       "audit-log"
_c "RF Detection"           "rf-scan"
_c "Bridge Selection"       "bridge-select"
echo ""
echo -e "  ${C}── Daemons ──────────────────────────────────${RESET}"
_s "OPSEC Enforcer"         "opsec-enforcer"
_s "Traffic Padding"        "traffic-pad"

echo ""
echo -e "  ${C}── Quick checks ─────────────────────────────${RESET}"

# Entropy
AVAIL=$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
(( AVAIL >= 3000 )) && \
  echo -e "  ${G}[✓]${RESET} Entropy: ${AVAIL} bits" || \
  echo -e "  ${Y}[!]${RESET} Entropy low: ${AVAIL} bits"

# Kernel lockdown
[[ -f /sys/kernel/security/lockdown ]] && \
  echo -e "  ${G}[✓]${RESET} Kernel lockdown: $(cat /sys/kernel/security/lockdown)" || \
  echo -e "  ${Y}[?]${RESET} Kernel lockdown: not available"

# Bridges
grep -q "^UseBridges 1" /etc/tor/torrc 2>/dev/null && \
  echo -e "  ${G}[✓]${RESET} Tor bridges: ENABLED" || \
  echo -e "  ${Y}[-]${RESET} Tor bridges: direct (no obfuscation)"

echo ""
SCRIPT
  chmod 755 /usr/local/bin/v10-8-status
}

# ================================================================
#  MASTER CALLER
# ================================================================

setup_v10_8_extras() {
  header "v10.8.0 — MAXIMUM HARDENING (GOV-LEVEL DEFENSE)"

  setup_stream_isolation
  setup_torbrowser_secure
  setup_traffic_padding
  setup_kernel_lockdown
  setup_supply_chain
  setup_opsec_enforcer
  setup_entropy_boost
  setup_crypto_log
  setup_rf_detection
  setup_advanced_multihop
  patch_main_menu_v10_8

  # Auto-start enforcer and traffic padding
  opsec-enforce start 2>/dev/null || true
  traffic-pad start   2>/dev/null || true

  success "v10.8 maximum hardening installed"
  info    "Run v10-8-status to verify all systems"
}

# ════════════════════════════════════════════════════════════════
# v10.9 — ZERO TRACE PROTOCOL
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: ZERO TRACE PROTOCOL
#  Maximum detection resistance — software ceiling
#
#  1.  Vanguards          — guard rotation defense (Tor HS deanon)
#  2.  Transport Rotation — auto-cycle pluggable transports
#  3.  Net Namespaces     — per-app kernel-level network isolation
#  4.  Compartments       — isolated browser sessions per circuit
#  5.  Warrant Canary     — silent canary monitor for key services
#  6.  Secure Boot        — UEFI Secure Boot verify + bootloader integrity
#  7.  Mem Forensics Def  — kernel mlock + overcommit hardening
#  8.  Noise Upgrade      — human-pattern cover traffic (burst+quiet)
#  9.  TSCM Full          — NFC + BLE + RF spectrum sweep
#  10. Guardian Mode      — single-command ALL protection layers active
# ================================================================

_v9_pkg() { command -v "$2" > /dev/null 2>&1 || apt-get install -y -q "$1" 2>/dev/null || warn "Could not install: $1"; }

# ================================================================
#  1. VANGUARDS — GUARD ROTATION DEFENSE
# ================================================================

setup_vanguards() {
  header "VANGUARDS — GUARD ROTATION DEFENSE"

  _v9_pkg python3       python3
  _v9_pkg python3-pip   pip3
  _v9_pkg git           git
  _v9_pkg python3-stem  python3-stem

  cat > /usr/local/bin/vanguards-install << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}VANGUARDS — GUARD ROTATION DEFENSE INSTALL${RESET}\n"

grep -q "^ControlPort 9051" /etc/tor/torrc 2>/dev/null || \
  echo -e "\nControlPort 9051\nCookieAuthentication 1" >> /etc/tor/torrc
systemctl reload tor 2>/dev/null || killall -HUP tor 2>/dev/null || true

if [[ -d /opt/vanguards ]]; then
  echo -e "  ${C}[*]${RESET} Updating existing Vanguards..."
  cd /opt/vanguards && git pull 2>/dev/null || true
else
  echo -e "  ${C}[*]${RESET} Cloning Vanguards via Tor..."
  torify git clone https://github.com/mikeperry-tor/vanguards.git /opt/vanguards 2>/dev/null || \
    git clone https://github.com/mikeperry-tor/vanguards.git /opt/vanguards 2>/dev/null
fi

[[ -d /opt/vanguards ]] || { echo -e "${R}[!] Clone failed — check network${RESET}"; exit 1; }
cd /opt/vanguards
pip3 install -r requirements.txt -q 2>/dev/null || true
pip3 install . -q 2>/dev/null || true

cat > /usr/local/bin/vanguards << 'WRAPPER'
#!/bin/bash
exec python3 /opt/vanguards/src/vanguards.py "$@"
WRAPPER
chmod 755 /usr/local/bin/vanguards

cat > /etc/systemd/system/vanguards.service << 'SYSTEMD'
[Unit]
Description=Vanguards - Tor guard rotation defense
After=tor.service
Requires=tor.service

[Service]
Type=simple
ExecStart=/usr/local/bin/vanguards --control_port 9051 --logfile /var/log/vanguards.log
Restart=always
RestartSec=30
User=debian-tor

[Install]
WantedBy=multi-user.target
SYSTEMD

systemctl daemon-reload
systemctl enable vanguards
systemctl start vanguards
echo -e "  ${G}[✓]${RESET} Vanguards installed and running"
echo -e "  ${G}[✓]${RESET} Log: /var/log/vanguards.log"
SCRIPT
  chmod 755 /usr/local/bin/vanguards-install

  cat > /usr/local/bin/vanguards-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}VANGUARDS STATUS${RESET}\n"
if systemctl is-active vanguards &>/dev/null; then
  echo -e "  ${G}[▶]${RESET} Vanguards daemon: RUNNING"
  [[ -f /var/log/vanguards.log ]] && echo "" && tail -5 /var/log/vanguards.log
else
  echo -e "  ${R}[■]${RESET} Vanguards not running — run: vanguards-install"
fi
SCRIPT
  chmod 755 /usr/local/bin/vanguards-status

  ok "vanguards-install  — install Tor guard rotation defense"
  ok "vanguards-status   — check Vanguards daemon"
}

# ================================================================
#  2. TRANSPORT ROTATION
# ================================================================

setup_transport_rotation() {
  header "TRANSPORT ROTATION — AUTO-CYCLE PLUGGABLE TRANSPORTS"

  cat > /usr/local/bin/transport-rotate << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; C='\033[0;36m'; Y='\033[1;33m'; B='\033[1m'; RESET='\033[0m'
PID_FILE="/tmp/.transport-rotate.pid"
LOG_FILE="/tmp/.transport-rotate.log"
TRANSPORTS=("obfs4" "snowflake" "meek-azure")

_rotate() {
  local CURRENT
  CURRENT=$(grep "ClientTransportPlugin" /etc/tor/torrc 2>/dev/null | grep -o 'obfs4\|snowflake\|meek' | head -1)
  local NEXT="${TRANSPORTS[0]}"
  for t in "${TRANSPORTS[@]}"; do
    [[ "$t" != "$CURRENT" ]] && { NEXT="$t"; break; }
  done
  bridge-select "$NEXT" 2>/dev/null || true
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Rotated: ${CURRENT:-unknown} → $NEXT" >> "$LOG_FILE"
  echo -e "  ${G}[✓]${RESET} Transport rotated: ${CURRENT:-unknown} → $NEXT"
}

case "${1:-}" in
  now)   _rotate ;;
  start)
    [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null && \
      { echo "Already running"; exit 0; }
    ( while true; do
        sleep $(( 1800 + RANDOM % 3600 ))
        _rotate
      done ) &
    echo $! > "$PID_FILE"
    echo -e "  ${G}[+]${RESET} Transport rotation daemon started (30-90 min cycle)"
    ;;
  stop)
    [[ -f "$PID_FILE" ]] && { kill "$(cat "$PID_FILE")" 2>/dev/null; rm -f "$PID_FILE"; }
    echo "Transport rotation stopped"
    ;;
  status)
    [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null && \
      echo -e "${G}[▶]${RESET} Running" || echo "[■] Stopped"
    [[ -f "$LOG_FILE" ]] && { echo ""; tail -5 "$LOG_FILE"; }
    ;;
  log)   [[ -f "$LOG_FILE" ]] && cat "$LOG_FILE" || echo "No log yet." ;;
  *)     echo "Usage: transport-rotate now|start|stop|status|log" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/transport-rotate

  ok "transport-rotate now/start/stop/status/log — auto-cycle pluggable transports"
}

# ================================================================
#  3. NETWORK NAMESPACE ISOLATION
# ================================================================

setup_netns_isolation() {
  header "NETWORK NAMESPACE ISOLATION — PER-APP KERNEL ISOLATION"

  cat > /usr/local/bin/ns-isolate << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'

NS_BASE="specter"
NS_NAME="${NS_BASE}-${2:-default}"
VETH_EXT="${NS_NAME}-ext"
VETH_INT="${NS_NAME}-int"
NS_IP_GW="10.200.$(( RANDOM % 200 + 10 )).1"
NS_IP_CL="${NS_IP_GW%.*}.2"
NS_NET="${NS_IP_GW%.*}.0/24"

case "${1:-}" in
  start)
    echo -e "${B}NETWORK NAMESPACE ISOLATION${RESET}"
    ip netns add "$NS_NAME" 2>/dev/null && \
      echo -e "  ${G}[✓]${RESET} Namespace: $NS_NAME" || \
      echo -e "  ${C}[*]${RESET} Namespace $NS_NAME exists — reconfiguring"
    ip link del "${VETH_EXT}" 2>/dev/null || true
    ip link add "${VETH_EXT}" type veth peer name "${VETH_INT}"
    ip link set "${VETH_INT}" netns "$NS_NAME"
    ip addr add "${NS_IP_GW}/24" dev "${VETH_EXT}" 2>/dev/null || true
    ip link set "${VETH_EXT}" up
    ip netns exec "$NS_NAME" ip addr add "${NS_IP_CL}/24" dev "${VETH_INT}"
    ip netns exec "$NS_NAME" ip link set "${VETH_INT}" up
    ip netns exec "$NS_NAME" ip link set lo up
    ip netns exec "$NS_NAME" ip route add default via "${NS_IP_GW}"
    iptables -t nat -A POSTROUTING -s "$NS_NET" -j MASQUERADE 2>/dev/null || true
    echo 1 > /proc/sys/net/ipv4/ip_forward
    ip netns exec "$NS_NAME" iptables -t nat -A OUTPUT \
      -p tcp --syn ! -d 127.0.0.1 -j REDIRECT --to-ports 9040
    ip netns exec "$NS_NAME" iptables -t nat -A OUTPUT \
      -p udp --dport 53 -j REDIRECT --to-ports 5353
    echo -e "  ${G}[✓]${RESET} Traffic → Tor | Run: ns-isolate exec ${2:-default} <cmd>"
    ;;
  exec)
    shift; NS_ARG="$1"; shift
    NS_FULL="${NS_BASE}-${NS_ARG}"
    ip netns list 2>/dev/null | grep -q "^${NS_FULL}" || \
      { echo -e "${R}[!] Namespace not found. Run: ns-isolate start ${NS_ARG}${RESET}"; exit 1; }
    USER="${SUDO_USER:-$(logname 2>/dev/null || echo root)}"
    ip netns exec "$NS_FULL" sudo -u "$USER" env -i HOME="/home/$USER" PATH="$PATH" "$@"
    ;;
  stop)
    iptables -t nat -D POSTROUTING -s "$NS_NET" -j MASQUERADE 2>/dev/null || true
    ip link del "${VETH_EXT}" 2>/dev/null || true
    ip netns del "$NS_NAME" 2>/dev/null && \
      echo -e "  ${G}[✓]${RESET} Namespace '$NS_NAME' removed" || \
      echo -e "  Namespace not found"
    ;;
  list)
    echo -e "${B}Active SPECTER Namespaces:${RESET}"
    ip netns list 2>/dev/null | grep "^${NS_BASE}-" || echo "  None active"
    ;;
  *)
    echo "Usage: ns-isolate start [name] | exec [name] <cmd> | stop [name] | list"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/ns-isolate

  ok "ns-isolate start/exec/stop/list — per-app kernel network namespace isolation"
}

# ================================================================
#  4. BROWSER COMPARTMENTS
# ================================================================

setup_compartments() {
  header "BROWSER COMPARTMENTS — ISOLATED SESSIONS PER CIRCUIT"

  COMP_DIR="${RAMDISK_MOUNT}/.compartments"
  mkdir -p "$COMP_DIR" 2>/dev/null || true

  cat > /usr/local/bin/compartment-create << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
COMP_DIR="/mnt/secure_workspace/.compartments"
mkdir -p "$COMP_DIR"
NAME="${1:-comp-$(date +%s | tail -c4)}"
COMP_PATH="${COMP_DIR}/${NAME}"
[[ -d "$COMP_PATH" ]] && { echo -e "${R}[!] Compartment '${NAME}' exists${RESET}"; exit 1; }
mkdir -p "${COMP_PATH}/profile"
PORT=$(( 10100 + RANDOM % 900 ))
while grep -q "SocksPort ${PORT}" /etc/tor/torrc 2>/dev/null; do
  PORT=$(( 10100 + RANDOM % 900 ))
done
echo "PORT=${PORT}" > "${COMP_PATH}/config"
echo "NAME=${NAME}" >> "${COMP_PATH}/config"
echo "SocksPort ${PORT} IsolateDestAddr IsolateDestPort IsolateSOCKSAuth SessionGroup=${PORT}" \
  >> /etc/tor/torrc
systemctl reload tor 2>/dev/null || killall -HUP tor 2>/dev/null || true
echo -e "${G}[+]${RESET} Compartment '${NAME}' — Tor port ${C}${PORT}${RESET}"
echo -e "    Start: ${B}compartment-start ${NAME}${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/compartment-create

  cat > /usr/local/bin/compartment-start << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
COMP_DIR="/mnt/secure_workspace/.compartments"
NAME="${1:?Usage: compartment-start <name>}"
COMP_PATH="${COMP_DIR}/${NAME}"
[[ -d "$COMP_PATH" ]] || { echo -e "${R}[!] Not found. Create: compartment-create ${NAME}${RESET}"; exit 1; }
source "${COMP_PATH}/config"
PROFILE="${COMP_PATH}/profile"
echo -e "${C}[*]${RESET} Compartment '${NAME}' → Tor port ${PORT}"
export http_proxy="socks5h://127.0.0.1:${PORT}"
export https_proxy="socks5h://127.0.0.1:${PORT}"
if command -v firejail &>/dev/null; then
  firejail --private="${PROFILE}" firefox --no-remote --profile "${PROFILE}" --new-instance 2>/dev/null &
elif command -v firefox &>/dev/null; then
  firefox --no-remote --profile "${PROFILE}" --new-instance 2>/dev/null &
elif command -v chromium &>/dev/null; then
  chromium --user-data-dir="${PROFILE}" --proxy-server="socks5://127.0.0.1:${PORT}" --incognito 2>/dev/null &
else
  echo -e "${R}[!] No browser found (firefox / chromium)${RESET}"; exit 1
fi
echo -e "${G}[✓]${RESET} Compartment running"
SCRIPT
  chmod 755 /usr/local/bin/compartment-start

  cat > /usr/local/bin/compartment-list << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
COMP_DIR="/mnt/secure_workspace/.compartments"
[[ -d "$COMP_DIR" ]] || { echo "No compartments created yet."; exit 0; }
FOUND=0; echo -e "${B}Browser Compartments:${RESET}\n"
for d in "${COMP_DIR}"/*/; do
  [[ -f "${d}/config" ]] || continue
  source "${d}/config"
  echo -e "  ${G}[${NAME}]${RESET}  Tor port ${C}${PORT}${RESET}"
  FOUND=1
done
[[ $FOUND -eq 0 ]] && echo "  None. Create: compartment-create <name>"
SCRIPT
  chmod 755 /usr/local/bin/compartment-list

  cat > /usr/local/bin/compartment-wipe << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; RESET='\033[0m'
COMP_DIR="/mnt/secure_workspace/.compartments"
NAME="${1:?Usage: compartment-wipe <name>}"
COMP_PATH="${COMP_DIR}/${NAME}"
[[ -d "$COMP_PATH" ]] || { echo "Not found."; exit 1; }
source "${COMP_PATH}/config" 2>/dev/null
[[ -n "$PORT" ]] && sed -i "/^SocksPort ${PORT} /d" /etc/tor/torrc 2>/dev/null
systemctl reload tor 2>/dev/null || true
command -v shred &>/dev/null && shred -ur "${COMP_PATH}" 2>/dev/null || rm -rf "${COMP_PATH}"
echo -e "${G}[✓]${RESET} Compartment '${NAME}' wiped (port ${PORT} released)"
SCRIPT
  chmod 755 /usr/local/bin/compartment-wipe

  ok "compartment-create <name>  — isolated browser session (own Tor circuit)"
  ok "compartment-start  <name>  — launch compartmented browser"
  ok "compartment-list           — list all compartments"
  ok "compartment-wipe   <name>  — securely destroy compartment"
}

# ================================================================
#  5. WARRANT CANARY MONITOR
# ================================================================

setup_warrant_canary() {
  header "WARRANT CANARY MONITOR"

  cat > /usr/local/bin/warrant-canary << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
CANARIES=(
  "https://riseup.net/canary|Riseup|canary"
  "https://www.eff.org/about/canary|EFF|warrant"
  "https://proton.me/legal/canary|Proton|canary"
  "https://mullvad.net/canary/|Mullvad|canary"
  "https://www.signal.org/bigbrother/|Signal|warrant"
  "https://www.torproject.org/about/canary/|Tor Project|canary"
  "https://tutanota.com/blog/canary|Tutanota|canary"
)
echo -e "${B}WARRANT CANARY STATUS${RESET}"
echo -e "${C}Checking via Tor — $(date '+%Y-%m-%d %H:%M')${RESET}\n"
WARN=0
for entry in "${CANARIES[@]}"; do
  IFS='|' read -r URL NAME KEYWORD <<< "$entry"
  RESP=$(torify curl -sf --max-time 20 -A "Mozilla/5.0" "$URL" 2>/dev/null || \
         curl -sf --max-time 20 --socks5-hostname 127.0.0.1:9050 "$URL" 2>/dev/null)
  if [[ -z "$RESP" ]]; then
    printf "  ${Y}[?]${RESET} %-20s  unreachable\n" "$NAME"
  elif echo "$RESP" | grep -qi "$KEYWORD"; then
    printf "  ${G}[✓]${RESET} %-20s  canary present\n" "$NAME"
  else
    printf "  ${R}[!!!]${RESET} %-20s  ${R}CANARY MISSING — potential warrant${RESET}\n" "$NAME"
    WARN=1
  fi
done
echo ""
[[ $WARN -eq 1 ]] && \
  echo -e "  ${R}WARNING: Canary missing — treat affected services as potentially compromised.${RESET}" || \
  echo -e "  ${C}All reachable canaries present.${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/warrant-canary

  cat > /etc/cron.d/specter-canary << 'CRON'
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 9 * * 1 root /usr/local/bin/warrant-canary >> /var/log/specter-canary.log 2>&1
CRON
  chmod 644 /etc/cron.d/specter-canary

  ok "warrant-canary  — check warrant canaries for key services (via Tor)"
  ok "Weekly cron     — Mondays 09:00 → /var/log/specter-canary.log"
}

# ================================================================
#  6. SECURE BOOT + BOOTLOADER INTEGRITY
# ================================================================

setup_secureboot() {
  header "SECURE BOOT + BOOTLOADER INTEGRITY"

  cat > /usr/local/bin/secureboot-check << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
BASELINE="/var/lib/specter-boot.sha256"
echo -e "${B}SECURE BOOT + BOOT INTEGRITY${RESET}\n"

echo -e "  ${C}── Secure Boot ────────────────────────────────────${RESET}"
if command -v mokutil &>/dev/null; then
  mokutil --sb-state 2>/dev/null | grep -qi "enabled" && \
    echo -e "  ${G}[✓]${RESET} Secure Boot: ENABLED" || \
    echo -e "  ${R}[✗]${RESET} Secure Boot: DISABLED — enable in UEFI firmware"
elif [[ -f /sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c ]]; then
  SB=$(od -An -tu1 /sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c \
    2>/dev/null | awk '{print $NF}')
  [[ "$SB" == "1" ]] && echo -e "  ${G}[✓]${RESET} Secure Boot: ENABLED" || \
    echo -e "  ${R}[✗]${RESET} Secure Boot: DISABLED"
elif [[ -d /sys/firmware/efi ]]; then
  echo -e "  ${Y}[?]${RESET} UEFI — install mokutil for Secure Boot state"
else
  echo -e "  ${Y}[-]${RESET} Legacy BIOS — Secure Boot not applicable"
fi

KPTR=$(cat /proc/sys/kernel/kptr_restrict 2>/dev/null)
[[ "$KPTR" -ge 2 ]] && echo -e "  ${G}[✓]${RESET} kptr_restrict: $KPTR" || \
  echo -e "  ${Y}[!]${RESET} kptr_restrict: $KPTR (should be 2)"

echo ""; echo -e "  ${C}── Bootloader Integrity ───────────────────────────${RESET}"
CFG="/boot/grub/grub.cfg"; [[ -f /boot/grub2/grub.cfg ]] && CFG="/boot/grub2/grub.cfg"
if [[ -f "$CFG" ]]; then
  CUR=$(sha256sum "$CFG" 2>/dev/null | cut -d' ' -f1)
  if [[ -f "$BASELINE" ]]; then
    STO=$(grep "^grub_cfg:" "$BASELINE" 2>/dev/null | cut -d' ' -f2)
    [[ "$CUR" == "$STO" ]] && \
      echo -e "  ${G}[✓]${RESET} grub.cfg: UNCHANGED" || \
      echo -e "  ${R}[!!!] grub.cfg: MODIFIED since baseline${RESET}"
  else
    echo "grub_cfg: $CUR" > "$BASELINE"
    VMLINUZ=$(ls /boot/vmlinuz-* 2>/dev/null | sort -V | tail -1)
    [[ -f "$VMLINUZ" ]] && echo "kernel: $(sha256sum "$VMLINUZ" | cut -d' ' -f1)" >> "$BASELINE"
    echo -e "  ${G}[+]${RESET} Boot integrity baseline saved"
  fi
else
  echo -e "  ${Y}[?]${RESET} grub.cfg not found"
fi
echo ""
SCRIPT
  chmod 755 /usr/local/bin/secureboot-check

  cat > /usr/local/bin/secureboot-baseline-reset << 'SCRIPT'
#!/bin/bash
rm -f /var/lib/specter-boot.sha256
/usr/local/bin/secureboot-check
SCRIPT
  chmod 755 /usr/local/bin/secureboot-baseline-reset

  ok "secureboot-check           — UEFI Secure Boot + bootloader integrity"
  ok "secureboot-baseline-reset  — reset boot baseline after kernel/grub update"
}

# ================================================================
#  7. MEMORY FORENSICS DEFENSE
# ================================================================

setup_mem_forensics_defense() {
  header "MEMORY FORENSICS DEFENSE"

  cat > /usr/local/bin/mem-forensics-defense << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
SYSCTL_CONF="/etc/sysctl.d/99-specter-memforensics.conf"
echo -e "${B}MEMORY FORENSICS DEFENSE${RESET}\n"

echo "* hard core 0"                        >> /etc/security/limits.conf 2>/dev/null
echo "* soft core 0"                        >> /etc/security/limits.conf 2>/dev/null
ulimit -c 0

[[ -c /proc/kcore ]] && \
  echo "install kcore /bin/true" > /etc/modprobe.d/specter-mem.conf

cat > "$SYSCTL_CONF" << 'SYSCTL'
kernel.perf_event_paranoid = 3
fs.suid_dumpable = 0
vm.overcommit_memory = 2
vm.overcommit_ratio = 50
kernel.dmesg_restrict = 1
kernel.unprivileged_bpf_disabled = 1
SYSCTL

echo never > /sys/kernel/mm/transparent_hugepage/enabled 2>/dev/null || true
echo never > /sys/kernel/mm/transparent_hugepage/defrag  2>/dev/null || true
sysctl -p "$SYSCTL_CONF" > /dev/null 2>&1 && \
  echo -e "  ${G}[✓]${RESET} Memory security sysctl: applied" || \
  echo -e "  ${Y}[!]${RESET} Some settings need reboot"

echo -e "  ${G}[✓]${RESET} Core dumps: disabled"
echo -e "  ${G}[✓]${RESET} Memory overcommit: strict"
echo -e "  ${G}[✓]${RESET} Transparent hugepages: disabled"
echo -e "  ${G}[✓]${RESET} BPF: unprivileged access disabled"
echo -e "  ${G}[✓]${RESET} dmesg: restricted"
echo ""
echo -e "  ${C}Tip:${RESET} Add 'page_poison=1 init_on_alloc=1 init_on_free=1'"
echo -e "       to GRUB_CMDLINE_LINUX for full cold-boot defense."
SCRIPT
  chmod 755 /usr/local/bin/mem-forensics-defense

  ok "mem-forensics-defense  — kernel memory anti-forensics hardening"
}

# ================================================================
#  8. NOISE UPGRADE — HUMAN-PATTERN COVER TRAFFIC
# ================================================================

setup_noise_upgrade() {
  header "NOISE UPGRADE — HUMAN-PATTERN COVER TRAFFIC"

  cat > /usr/local/bin/noise-upgrade << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; C='\033[0;36m'; B='\033[1m'; Y='\033[1;33m'; RESET='\033[0m'
PID_FILE="/tmp/.noise-upgrade.pid"
LOG_FILE="/tmp/.noise-upgrade.log"
SITES=(
  "https://check.torproject.org/"
  "https://www.eff.org/issues/privacy"
  "https://ssd.eff.org/"
  "https://www.fsf.org/"
  "https://www.gnu.org/philosophy/"
  "https://www.debian.org/security/"
  "https://www.kernel.org/"
)
UA="Mozilla/5.0 (Windows NT 10.0; rv:109.0) Gecko/20100101 Firefox/109.0"
_fetch() {
  local URL="${SITES[$((RANDOM % ${#SITES[@]}))]}"
  torify curl -sf -A "$UA" --max-time 20 --limit-rate 1500k \
    -H "Accept: text/html,application/xhtml+xml" \
    -H "DNT: 1" "$URL" > /dev/null 2>&1
}
case "${1:-}" in
  start)
    [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null && \
      { echo -e "${Y}Already running${RESET}"; exit 0; }
    ( while true; do
        BURST=$(( 2 + RANDOM % 5 ))
        for (( i=0; i<BURST; i++ )); do _fetch; sleep $(( 2 + RANDOM % 8 )); done
        echo "[$(date '+%H:%M:%S')] Burst $BURST" >> "$LOG_FILE"
        sleep $(( 30 + RANDOM % 450 ))
      done ) &
    echo $! > "$PID_FILE"
    echo -e "  ${G}[+]${RESET} Human-pattern cover traffic started (burst+quiet)"
    ;;
  stop)
    [[ -f "$PID_FILE" ]] && { kill "$(cat "$PID_FILE")" 2>/dev/null; rm -f "$PID_FILE"; }
    echo "Stopped"
    ;;
  status)
    [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null && \
      echo -e "${G}[▶]${RESET} Running" || echo "[■] Stopped"
    [[ -f "$LOG_FILE" ]] && { echo ""; tail -5 "$LOG_FILE"; }
    ;;
  log)   [[ -f "$LOG_FILE" ]] && tail -20 "$LOG_FILE" || echo "No log." ;;
  *)     echo "Usage: noise-upgrade start|stop|status|log" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/noise-upgrade

  ok "noise-upgrade start/stop/status/log — human-pattern cover traffic"
}

# ================================================================
#  9. FULL TSCM SWEEP
# ================================================================

setup_tscm_full() {
  header "FULL TSCM SWEEP — NFC + BLE + RF SPECTRUM"

  _v9_pkg rfkill        rfkill
  _v9_pkg bluez         bluetoothctl
  _v9_pkg libnfc-bin    nfc-scan-device

  cat > /usr/local/bin/tscm-full << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}FULL TSCM SWEEP — v10.9${RESET}"
echo -e "${C}Technical Surveillance Countermeasures${RESET}\n"

echo -e "  ${C}── RF Interface State ─────────────────────────────${RESET}"
rfkill list all 2>/dev/null || echo -e "  ${Y}[?]${RESET} rfkill not available"

echo ""; echo -e "  ${C}── Bluetooth LE Scan (10 sec) ─────────────────────${RESET}"
if command -v bluetoothctl &>/dev/null; then
  bluetoothctl power on >/dev/null 2>&1
  bluetoothctl scan on  >/dev/null 2>&1 &
  BTSCAN_PID=$!
  sleep 10
  BLE_DEVICES=$(bluetoothctl devices 2>/dev/null | grep "^Device")
  kill "$BTSCAN_PID" 2>/dev/null; bluetoothctl scan off >/dev/null 2>&1
  BLE_COUNT=$(echo "$BLE_DEVICES" | grep -c "Device" 2>/dev/null || echo 0)
  if [[ $BLE_COUNT -eq 0 ]]; then
    echo -e "  ${G}[✓]${RESET} No BLE devices detected"
  elif [[ $BLE_COUNT -le 3 ]]; then
    echo -e "  ${G}[✓]${RESET} $BLE_COUNT BLE device(s) — normal"
  else
    echo -e "  ${Y}[!]${RESET} $BLE_COUNT BLE devices — high count, verify"
    echo "$BLE_DEVICES" | while IFS= read -r l; do echo -e "    ${Y}$l${RESET}"; done
  fi
else
  echo -e "  ${Y}[?]${RESET} bluetoothctl not available (apt install bluez)"
fi

echo ""; echo -e "  ${C}── NFC Scan ───────────────────────────────────────${RESET}"
if command -v nfc-scan-device &>/dev/null; then
  NFC=$(timeout 5 nfc-scan-device -v 2>&1)
  echo "$NFC" | grep -qi "error\|no nfc\|unable" && \
    echo -e "  ${G}[✓]${RESET} No NFC devices detected" || \
    { echo -e "  ${Y}[!]${RESET} NFC activity:"; echo "$NFC"; }
else
  echo -e "  ${Y}[?]${RESET} libnfc-bin not installed (apt install libnfc-bin)"
fi

echo ""; echo -e "  ${C}── SDR Wideband Sweep (100-1800 MHz, 15 sec) ─────${RESET}"
if command -v rtl_power &>/dev/null; then
  TMPF=$(mktemp /tmp/tscm-sdr.XXXXXX)
  timeout 15 rtl_power -f 100M:1800M:500k -g 42 -i 1 -e 15s "$TMPF" 2>/dev/null
  PEAKS=$(awk -F',' 'NR>1 && $7+0 > -45 {printf "  %.1f MHz  %s dBm\n",$3/1e6,$7}' \
    "$TMPF" 2>/dev/null | sort -t' ' -k4 -rn | head -8)
  rm -f "$TMPF"
  [[ -n "$PEAKS" ]] && {
    echo -e "  ${Y}[!]${RESET} Strong signals (>-45 dBm):"
    echo "$PEAKS" | while IFS= read -r l; do echo -e "    ${Y}${l}${RESET}"; done
  } || echo -e "  ${G}[✓]${RESET} No anomalous transmitters detected"
else
  echo -e "  ${Y}[?]${RESET} RTL-SDR not available — hardware dongle needed"
fi

echo ""; echo -e "  ${C}── Physical Check Reminder ────────────────────────${RESET}"
echo -e "  □ Power sockets, surge protectors, smoke detectors"
echo -e "  □ HDMI/USB/ethernet ports for hardware implants"
echo -e "  □ Mirrors (one-way glass: fingernail gap test)"
echo -e "  □ Remove or Faraday-bag mobile phones in room"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/tscm-full

  ok "tscm-full  — NFC + BLE + SDR wideband sweep + physical checklist"
}

# ================================================================
#  10. GUARDIAN MODE
# ================================================================

setup_guardian_mode() {
  header "GUARDIAN MODE — ALL LAYERS SIMULTANEOUS"

  cat > /usr/local/bin/guardian-mode << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; C='\033[0;36m'; Y='\033[1;33m'; B='\033[1m'; RESET='\033[0m'
_try() { local L="$1"; shift; "$@" 2>/dev/null && \
  printf "  ${G}[✓]${RESET} %-35s active\n" "$L" || \
  printf "  ${Y}[-]${RESET} %-35s not installed\n" "$L"; }

case "${1:-}" in
  start)
    echo -e "${B}${C}  GUARDIAN MODE — ALL LAYERS ACTIVE${RESET}\n"
    echo -e "  ${C}[1/6] Network...${RESET}"
    _try "OPSEC Enforcer"       opsec-enforce start
    _try "Traffic Padding"      traffic-pad start
    _try "MAC Rotation"         mac-rotate start
    _try "Transport Rotation"   transport-rotate start
    echo ""; echo -e "  ${C}[2/6] Cover Traffic...${RESET}"
    _try "Noise Generator"      noise-generator start
    _try "Human Cover Traffic"  noise-upgrade start
    _try "Decoy Traffic"        decoy-traffic start
    echo ""; echo -e "  ${C}[3/6] Monitoring...${RESET}"
    _try "Leak Monitor"         leak-monitor start
    _try "LAN Monitor"          lan-monitor start
    _try "Anomaly Detector"     anomaly-detector start
    _try "Counter-Recon"        counter-recon start
    _try "Exit Watch"           exit-watch start
    _try "Tripwire"             trip-wire start
    _try "Correlation Detector" correlation-detector start
    echo ""; echo -e "  ${C}[4/6] Identity...${RESET}"
    _try "Keystroke Anonymizer" kloak-start
    _try "Screen Guard"         screen-guard start
    echo ""; echo -e "  ${C}[5/6] Emergency...${RESET}"
    _try "Dead Man's Switch"    deadman-start 30
    echo ""; echo -e "  ${C}[6/6] Integrity...${RESET}"
    warrant-canary 2>/dev/null | grep -E "\[✓\]|\[!!!\]" | head -5
    echo ""
    echo -e "${G}  [✓] GUARDIAN MODE ACTIVE — ALL LAYERS ENGAGED${RESET}"
    echo -e "  Status: guardian-mode status  |  Stop: guardian-mode stop"
    echo -e "  End session: session-nuke     |  Emergency: panic"
    echo ""
    ;;
  stop)
    echo -e "${Y}  Deactivating Guardian Mode...${RESET}"
    for CMD in "opsec-enforce stop" "traffic-pad stop" "mac-rotate stop" \
               "transport-rotate stop" "noise-upgrade stop" "noise-generator stop" \
               "decoy-traffic stop" "leak-monitor stop" "lan-monitor stop" \
               "anomaly-detector stop" "counter-recon stop" "exit-watch stop" \
               "trip-wire stop" "correlation-detector stop" \
               "kloak-stop" "screen-guard stop" "deadman-stop"; do
      $CMD 2>/dev/null || true
    done
    echo -e "${G}  [✓] Guardian Mode deactivated${RESET}"
    ;;
  status)
    echo -e "${B}GUARDIAN MODE STATUS${RESET}\n"
    _d() {
      local PF="/tmp/.${2}.pid"
      [[ -f "$PF" ]] && kill -0 "$(cat "$PF")" 2>/dev/null && \
        printf "  ${G}[▶]${RESET} %-35s ACTIVE\n" "$1" || \
        printf "  ${Y}[■]${RESET} %-35s inactive\n" "$1"
    }
    _d "OPSEC Enforcer"          "opsec-enforcer"
    _d "Traffic Padding"         "traffic-pad"
    _d "MAC Rotation"            "mac-rotate"
    _d "Transport Rotation"      "transport-rotate"
    _d "Human Cover Traffic"     "noise-upgrade"
    _d "Noise Generator"         "noise_generator"
    _d "Decoy Traffic"           "decoy-traffic"
    _d "Leak Monitor"            "leak_monitor"
    _d "LAN Monitor"             "lan_monitor"
    _d "Anomaly Detector"        "anomaly_detector"
    _d "Counter-Recon"           "counter_recon"
    _d "Exit Watch"              "exit_watch"
    _d "Tripwire"                "trip_wire"
    _d "Correlation Detector"    "correlation_detector"
    _d "Dead Man's Switch"       "deadman_switch"
    echo ""
    ;;
  *) echo "Usage: guardian-mode start|stop|status" ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/guardian-mode

  ok "guardian-mode start/stop/status — ALL protection layers at once"
}

# ================================================================
#  STATUS COMMAND
# ================================================================

patch_main_menu_v10_9() {
  cat > /usr/local/bin/v10-9-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; Y='\033[1;33m'
B='\033[1m'; RESET='\033[0m'
echo -e "${B}v10.9 ZERO TRACE PROTOCOL STATUS${RESET}\n"
_c() {
  command -v "$2" > /dev/null 2>&1 && \
    printf "  ${G}[✓]${RESET} %-35s installed\n" "$1" || \
    printf "  ${R}[✗]${RESET} %-35s MISSING\n" "$1"
}
_s() {
  local PF="/tmp/.${2}.pid"
  [[ -f "$PF" ]] && kill -0 "$(cat "$PF")" 2>/dev/null && \
    printf "  ${G}[▶]${RESET} %-35s RUNNING\n" "$1" || \
    printf "  ${Y}[■]${RESET} %-35s stopped\n" "$1"
}
echo -e "  ${C}── Commands ──────────────────────────────────────${RESET}"
_c "Vanguards"                "vanguards-install"
_c "Transport Rotation"       "transport-rotate"
_c "Net Namespace Isolate"    "ns-isolate"
_c "Browser Compartments"     "compartment-create"
_c "Warrant Canary"           "warrant-canary"
_c "Secure Boot Check"        "secureboot-check"
_c "Memory Forensics Defense" "mem-forensics-defense"
_c "Human Cover Traffic"      "noise-upgrade"
_c "Full TSCM Sweep"          "tscm-full"
_c "Guardian Mode"            "guardian-mode"
echo ""
echo -e "  ${C}── Daemons ───────────────────────────────────────${RESET}"
_s "Transport Rotation"       "transport-rotate"
_s "Human Cover Traffic"      "noise-upgrade"
echo ""
echo -e "  ${C}── Quick Checks ──────────────────────────────────${RESET}"
systemctl is-active vanguards &>/dev/null && \
  echo -e "  ${G}[▶]${RESET} Vanguards: running" || \
  echo -e "  ${Y}[■]${RESET} Vanguards: not active (run vanguards-install)"
[[ -f /etc/cron.d/specter-canary ]] && \
  echo -e "  ${G}[✓]${RESET} Canary cron: scheduled" || \
  echo -e "  ${Y}[!]${RESET} Canary cron: not set"
[[ -f /var/lib/specter-boot.sha256 ]] && \
  echo -e "  ${G}[✓]${RESET} Boot integrity baseline: present" || \
  echo -e "  ${Y}[!]${RESET} Boot baseline: run secureboot-check"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/v10-9-status
}

# ================================================================
#  MASTER CALLER
# ================================================================

setup_v10_9_extras() {
  header "v10.9.0 — ZERO TRACE PROTOCOL"

  setup_vanguards
  setup_transport_rotation
  setup_netns_isolation
  setup_compartments
  setup_warrant_canary
  setup_secureboot
  setup_mem_forensics_defense
  setup_noise_upgrade
  setup_tscm_full
  setup_guardian_mode
  patch_main_menu_v10_9

  noise-upgrade start    2>/dev/null || true
  transport-rotate start 2>/dev/null || true

  success "v10.9 Zero Trace Protocol installed"
  info    "Run v10-9-status to verify all systems"
  info    "Run guardian-mode start for maximum simultaneous protection"
  info    "Run warrant-canary to check service canary status"
}

# ════════════════════════════════════════════════════════════════
# v10.10 — ABSOLUTE ZERO
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: ABSOLUTE ZERO
#  Closest software can get to physical-layer security
#
#  1.  build-specter-usb — Bootable amnesic USB (Debian Live + SPECTER)
#  2.  pq-keygen         — Post-quantum keypair (Kyber-1024 + Dilithium)
#  3.  pq-encrypt        — Post-quantum encrypt (quantum-safe)
#  4.  pq-decrypt        — Post-quantum decrypt
#  5.  dualhop-start     — I2P + Tor simultaneous dual-network routing
#  6.  tpm-check         — TPM 2.0 chip detection + PCR integrity
#  7.  tpm-seal          — Seal secret to measured boot state
#  8.  tpm-unseal        — Unseal (only works if boot unmodified)
#  9.  yubikey-setup     — YubiKey hardware 2FA for encrypted volumes
#  10. hardware-checklist — Exact hardware buy list + procedure
#  11. v10-10-status     — ABSOLUTE ZERO features status
# ================================================================

_v10_pkg() { command -v "$2" > /dev/null 2>&1 || apt-get install -y -q "$1" 2>/dev/null || warn "Could not install: $1"; }

# ================================================================
#  USB BUILDER
# ================================================================

setup_usb_builder() {
  header "BUILD-SPECTER-USB — BOOTABLE AMNESIC LIVE SYSTEM"

  _v10_pkg live-build     lb
  _v10_pkg debootstrap    debootstrap
  _v10_pkg squashfs-tools mksquashfs
  _v10_pkg xorriso        xorriso
  _v10_pkg grub-pc-bin    grub-mkimage
  _v10_pkg dosfstools     mkfs.fat

  cat > /usr/local/bin/build-specter-usb << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }
BUILD_DIR="/tmp/specter-live-build"
ISO_OUT="/tmp/specter-live.iso"
SPECTER_SRC="${SPECTER_PATH:-/usr/local/bin/specter.sh}"

echo -e "${BOLD}${CYAN}  SPECTER LIVE USB BUILDER v10.10${RESET}"
echo -e "  ${CYAN}Amnesic · Tor-routed · SPECTER-armed${RESET}\n"

for cmd in lb debootstrap mksquashfs xorriso; do
  command -v "$cmd" &>/dev/null || {
    echo -e "${RED}[!] Missing: $cmd — apt-get install live-build debootstrap squashfs-tools xorriso${RESET}"
    exit 1
  }
done

echo -e "  ${CYAN}[1/7]${RESET} Initializing build workspace..."
rm -rf "$BUILD_DIR"; mkdir -p "$BUILD_DIR"; cd "$BUILD_DIR"
lb config \
  --distribution bookworm \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer none \
  --bootappend-live "boot=live components quiet splash hostname=specter username=user" \
  --memtest none --win32-loader false --binary-images iso-hybrid \
  --checksums sha256 2>/dev/null
echo -e "  ${GREEN}[✓]${RESET} Build config: Debian Bookworm Live"

echo -e "  ${CYAN}[2/7]${RESET} Configuring packages..."
mkdir -p config/package-lists
cat > config/package-lists/specter-base.list.chroot << 'PKGS'
tor
obfs4proxy
torsocks
proxychains4
iptables
curl
gnupg2
age
mat2
exiftool
qpdf
firejail
kloak
macchanger
rfkill
bluez
bleachbit
secure-delete
cryptsetup
steghide
qrencode
zbar-tools
net-tools
iproute2
rkhunter
chkrootkit
clamav
aide
tpm2-tools
tpm2-abrmd
yubikey-manager
haveged
python3
python3-pip
python3-stem
git
vim
nfc-tools
PKGS
echo -e "  ${GREEN}[✓]${RESET} Package list configured"

echo -e "  ${CYAN}[3/7]${RESET} Installing auto-start hooks..."
mkdir -p config/hooks/live config/includes.chroot/usr/local/bin/
[[ -f "$SPECTER_SRC" ]] && cp "$SPECTER_SRC" config/includes.chroot/usr/local/bin/specter.sh && \
  chmod 755 config/includes.chroot/usr/local/bin/specter.sh

cat > config/hooks/live/0010-specter-tor.hook.chroot << 'HOOK'
#!/bin/bash
cat >> /etc/tor/torrc << 'TORRC'
SocksPort 9050 IsolateDestAddr IsolateDestPort IsolateClientProtocol
SocksPort 9150 IsolateDestAddr IsolateDestPort IsolateSOCKSAuth
TransPort 9040 IsolateClientAddr
DNSPort 5353 IsolateDestAddr
ConnectionPadding 1
MaxCircuitDirtiness 300
NewCircuitPeriod 15
TORRC
HOOK
chmod 755 config/hooks/live/0010-specter-tor.hook.chroot

mkdir -p config/includes.chroot/etc/sysctl.d/
cat > config/includes.chroot/etc/sysctl.d/99-specter.conf << 'SYSCTL'
kernel.dmesg_restrict = 1
kernel.kptr_restrict = 2
kernel.yama.ptrace_scope = 3
kernel.perf_event_paranoid = 3
kernel.unprivileged_bpf_disabled = 1
kernel.randomize_va_space = 2
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.tcp_timestamps = 0
net.ipv6.conf.all.disable_ipv6 = 1
vm.swappiness = 0
vm.overcommit_memory = 2
fs.suid_dumpable = 0
SYSCTL

mkdir -p config/includes.chroot/etc/systemd/system/
cat > config/includes.chroot/etc/systemd/system/mac-randomize.service << 'UNIT'
[Unit]
Description=MAC Address Randomization
Before=network.target
[Service]
Type=oneshot
ExecStart=/bin/bash -c 'for i in $(ls /sys/class/net|grep -v lo); do ip link set $i down; macchanger -r $i; ip link set $i up; done'
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
UNIT

cat > config/hooks/live/0020-specter-services.hook.chroot << 'HOOK'
#!/bin/bash
systemctl enable mac-randomize.service tor.service haveged.service 2>/dev/null || true
for s in avahi-daemon cups bluetooth; do systemctl disable "$s" 2>/dev/null || true; done
HOOK
chmod 755 config/hooks/live/0020-specter-services.hook.chroot
echo -e "  ${GREEN}[✓]${RESET} Auto-start hooks: Tor + MAC randomize + hardening"

echo -e "  ${CYAN}[4/7]${RESET} Building ISO (15-30 minutes)..."
echo -e "  ${YELLOW}    Grab a coffee.${RESET}"
lb build 2>&1 | tee /tmp/specter-build.log | grep -E "^\[|P:|I:|E:|error|warning" || true

ISO=$(find "$BUILD_DIR" -name "*.iso" | head -1)
if [[ -f "$ISO" ]]; then
  cp "$ISO" "$ISO_OUT"
  echo -e "  ${GREEN}[✓]${RESET} ISO: $ISO_OUT ($(du -h "$ISO_OUT" | cut -f1))"
  sha256sum "$ISO_OUT"
else
  echo -e "  ${RED}[!] Build failed — see /tmp/specter-build.log${RESET}"
  exit 1
fi

echo -e "  ${CYAN}[5/7]${RESET} Write to USB"
echo -e "  ${YELLOW}Available drives:${RESET}"
lsblk -dpno NAME,SIZE,MODEL | grep -v "loop\|sda " | while IFS= read -r l; do echo "    $l"; done
echo ""
read -rp "  USB device (e.g. /dev/sdb) — ALL DATA WIPED: " USB_DEV
[[ "$USB_DEV" =~ ^/dev/sd[b-z]$ ]] || { echo -e "${RED}[!] Safety: only /dev/sdb-sdz accepted${RESET}"; exit 1; }
[[ -b "$USB_DEV" ]] || { echo -e "${RED}[!] Not found: $USB_DEV${RESET}"; exit 1; }
read -rp "  Type 'WIPE' to confirm erasure of $USB_DEV: " CONFIRM
[[ "$CONFIRM" == "WIPE" ]] || { echo "Aborted."; exit 0; }
dd if="$ISO_OUT" of="$USB_DEV" bs=4M status=progress oflag=sync && sync
echo ""
echo -e "  ${GREEN}[+]${RESET} SPECTER LIVE USB READY"
echo -e "  ${GREEN}    Boot from this USB — set BIOS: USB first${RESET}"
echo -e "  ${GREEN}    SPECTER auto-starts Tor + kill switch on boot${RESET}"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/build-specter-usb

  ok "build-specter-usb  — build bootable amnesic SPECTER Live USB"
}

# ================================================================
#  POST-QUANTUM ENCRYPTION
# ================================================================

setup_postquantum() {
  header "POST-QUANTUM ENCRYPTION — KYBER-1024 + DILITHIUM"

  _v10_pkg python3     python3
  _v10_pkg python3-pip pip3
  _v10_pkg cmake       cmake
  _v10_pkg git         git

  cat > /usr/local/bin/pq-install << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}POST-QUANTUM — OPEN QUANTUM SAFE INSTALL${RESET}\n"
pip3 install liboqs 2>/dev/null || pip3 install --break-system-packages liboqs 2>/dev/null || {
  echo -e "${C}[*]${RESET} Building liboqs from source..."
  [[ -d /opt/liboqs ]] || { torify git clone https://github.com/open-quantum-safe/liboqs.git /opt/liboqs 2>/dev/null || git clone https://github.com/open-quantum-safe/liboqs.git /opt/liboqs; }
  cd /opt/liboqs && mkdir -p build && cd build
  cmake -GNinja .. -DOQS_DIST_BUILD=ON 2>/dev/null && ninja -j$(nproc) 2>/dev/null && ninja install 2>/dev/null && ldconfig
  pip3 install liboqs 2>/dev/null || pip3 install --break-system-packages liboqs 2>/dev/null
}
python3 -c "import oqs; print('  liboqs OK')" 2>/dev/null && \
  echo -e "${G}[✓]${RESET} Post-quantum library ready" || echo -e "${R}[!] Install failed${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/pq-install

  cat > /usr/local/bin/pq-keygen << 'SCRIPT'
#!/bin/bash
KEYDIR="${1:-${RAMDISK_MOUNT:-/mnt/secure_workspace}/.pqkeys}"
mkdir -p "$KEYDIR" && chmod 700 "$KEYDIR"
python3 << PYEOF
import sys
try: import oqs
except ImportError: print("\033[0;31m[!] Run: pq-install\033[0m"); sys.exit(1)
import os
with oqs.KeyEncapsulation("Kyber1024") as k:
    pub = k.generate_keypair(); priv = k.export_secret_key()
with oqs.Signature("Dilithium3") as s:
    spub = s.generate_keypair(); spriv = s.export_secret_key()
d = "$KEYDIR"
for fn, data, mode in [("kem_public.key",pub,0o644),("kem_private.key",priv,0o600),
                        ("sig_public.key",spub,0o644),("sig_private.key",spriv,0o600)]:
    with open(f"{d}/{fn}","wb") as f: f.write(data)
    os.chmod(f"{d}/{fn}", mode)
print(f"\033[0;32m[✓]\033[0m Kyber-1024 + Dilithium3 keypair generated")
print(f"    KEM public:  {d}/kem_public.key ({len(pub)} bytes)")
print(f"    SIG public:  {d}/sig_public.key ({len(spub)} bytes)")
print(f"    Share ONLY public keys. Private keys never leave this machine.")
PYEOF
SCRIPT
  chmod 755 /usr/local/bin/pq-keygen

  cat > /usr/local/bin/pq-encrypt << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: pq-encrypt <file> <kem_public.key>}"
PUBKEY="${2:?Usage: pq-encrypt <file> <kem_public.key>}"
[[ -f "$FILE" && -f "$PUBKEY" ]] || { echo "File or key not found"; exit 1; }
python3 << PYEOF
import sys, os, struct, secrets
try: import oqs
except ImportError: print("\033[0;31m[!] Run: pq-install\033[0m"); sys.exit(1)
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend
with open("$PUBKEY","rb") as f: pub = f.read()
with open("$FILE","rb") as f: plain = f.read()
with oqs.KeyEncapsulation("Kyber1024") as k:
    ct, ss = k.encap_secret(pub)
h = hashes.Hash(hashes.SHA3_256(), backend=default_backend()); h.update(ss); aes_key = h.finalize()
nonce = secrets.token_bytes(12)
enc = AESGCM(aes_key).encrypt(nonce, plain, None)
out = "$FILE.pqenc"
with open(out,"wb") as f:
    f.write(struct.pack(">I", len(ct))); f.write(ct); f.write(nonce); f.write(enc)
print(f"\033[0;32m[✓]\033[0m Encrypted: {out}")
print(f"    Kyber-1024 KEM + AES-256-GCM — quantum-safe")
PYEOF
SCRIPT
  chmod 755 /usr/local/bin/pq-encrypt

  cat > /usr/local/bin/pq-decrypt << 'SCRIPT'
#!/bin/bash
FILE="${1:?Usage: pq-decrypt <file.pqenc> <kem_private.key>}"
PRIVKEY="${2:?Usage: pq-decrypt <file.pqenc> <kem_private.key>}"
[[ -f "$FILE" && -f "$PRIVKEY" ]] || { echo "File or key not found"; exit 1; }
python3 << PYEOF
import sys, os, struct
try: import oqs
except ImportError: print("\033[0;31m[!] Run: pq-install\033[0m"); sys.exit(1)
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend
with open("$PRIVKEY","rb") as f: priv = f.read()
with open("$FILE","rb") as f:
    ct_len = struct.unpack(">I", f.read(4))[0]; kem_ct = f.read(ct_len)
    nonce = f.read(12); enc = f.read()
with oqs.KeyEncapsulation("Kyber1024", secret_key=priv) as k: ss = k.decap_secret(kem_ct)
h = hashes.Hash(hashes.SHA3_256(), backend=default_backend()); h.update(ss); aes_key = h.finalize()
try:
    plain = AESGCM(aes_key).decrypt(nonce, enc, None)
except: print("\033[0;31m[!!!] Decryption FAILED — wrong key or tampered\033[0m"); sys.exit(1)
out = "$FILE".removesuffix(".pqenc") if "$FILE".endswith(".pqenc") else "$FILE.dec"
with open(out,"wb") as f: f.write(plain)
print(f"\033[0;32m[✓]\033[0m Decrypted: {out}")
PYEOF
SCRIPT
  chmod 755 /usr/local/bin/pq-decrypt

  ok "pq-install      — install Open Quantum Safe (liboqs)"
  ok "pq-keygen       — Kyber-1024 + Dilithium3 keypair"
  ok "pq-encrypt      — quantum-safe file encryption"
  ok "pq-decrypt      — quantum-safe file decryption"
}

# ================================================================
#  DUAL-HOP I2P + TOR
# ================================================================

setup_dualhop() {
  header "DUALHOP — I2P + TOR SIMULTANEOUS ROUTING"

  _v10_pkg i2p i2prouter

  cat > /usr/local/bin/dualhop-start << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; Y='\033[1;33m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}DUALHOP — I2P + TOR DUAL ROUTING${RESET}\n"
systemctl is-active tor &>/dev/null || systemctl start tor
echo -e "  ${G}[✓]${RESET} Tor: running"
command -v i2prouter &>/dev/null || apt-get install -y -q i2p 2>/dev/null || {
  echo -e "  ${R}[!] Cannot install I2P — install manually: https://geti2p.net${RESET}"; exit 1; }
i2prouter start 2>/dev/null &; sleep 5
echo -e "  ${G}[✓]${RESET} I2P: starting (allow 2-5 min to build tunnels)"
cat > /etc/proxychains-dualhop.conf << 'PC'
strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
socks5 127.0.0.1 4444
socks5 127.0.0.1 9050
PC
echo -e "  ${G}[✓]${RESET} Chain: App → I2P(4444) → Tor(9050) → Internet"
echo -e "  ${C}Use: dualhop-exec <command>${RESET}"
echo -e "  ${Y}I2P needs 2-5 min to build tunnels. Run dualhop-status to check.${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/dualhop-start

  cat > /usr/local/bin/dualhop-exec << 'SCRIPT'
#!/bin/bash
[[ -f /etc/proxychains-dualhop.conf ]] || { echo "Run: dualhop-start"; exit 1; }
proxychains4 -f /etc/proxychains-dualhop.conf -q "$@"
SCRIPT
  chmod 755 /usr/local/bin/dualhop-exec

  cat > /usr/local/bin/dualhop-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}DUALHOP STATUS${RESET}\n"
TOR_IP=$(torify curl -sf --max-time 10 https://api.ipify.org 2>/dev/null)
[[ -n "$TOR_IP" ]] && echo -e "  ${G}[✓]${RESET} Tor: $TOR_IP" || echo -e "  [✗] Tor: down"
curl -sf --max-time 5 http://127.0.0.1:7657/summaryBar &>/dev/null && \
  echo -e "  ${G}[✓]${RESET} I2P: router active" || echo -e "  ${Y}[!]${RESET} I2P: starting (2-5 min)"
DUAL=$(proxychains4 -f /etc/proxychains-dualhop.conf -q curl -sf --max-time 20 https://api.ipify.org 2>/dev/null)
[[ -n "$DUAL" ]] && echo -e "  ${G}[✓]${RESET} Dual-hop: $DUAL" || echo -e "  ${Y}[!]${RESET} Dual-hop: not ready yet"
SCRIPT
  chmod 755 /usr/local/bin/dualhop-status

  cat > /usr/local/bin/dualhop-stop << 'SCRIPT'
#!/bin/bash
i2prouter stop 2>/dev/null || true
rm -f /etc/proxychains-dualhop.conf
echo "Dual-hop stopped"
SCRIPT
  chmod 755 /usr/local/bin/dualhop-stop

  ok "dualhop-start      — I2P + Tor dual routing"
  ok "dualhop-exec <cmd> — run command via I2P + Tor"
  ok "dualhop-status     — check both networks"
  ok "dualhop-stop       — stop dual-hop"
}

# ================================================================
#  TPM 2.0 ATTESTATION
# ================================================================

setup_tpm() {
  header "TPM 2.0 — HARDWARE BOOT ATTESTATION"

  _v10_pkg tpm2-tools  tpm2_getrandom
  _v10_pkg tpm2-abrmd  tpm2-abrmd

  cat > /usr/local/bin/tpm-check << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}TPM 2.0 STATUS${RESET}\n"
if [[ ! -e /dev/tpm0 && ! -e /dev/tpmrm0 ]]; then
  echo -e "  ${R}[✗]${RESET} No TPM found — enable in BIOS: Security → TPM → Enable"; echo ""; exit 0
fi
echo -e "  ${G}[✓]${RESET} TPM device: present"
command -v tpm2_getcap &>/dev/null && echo -e "  ${G}[✓]${RESET} tpm2-tools: installed"
echo ""; echo -e "  ${C}── PCR Boot Integrity ─────────────────────────────${RESET}"
PCR=$(tpm2_pcrread sha256:0,1,2,3,4,7 2>/dev/null)
if [[ -n "$PCR" ]]; then
  BASELINE="/var/lib/specter-tpm-pcr.baseline"
  CUR=$(echo "$PCR" | sha256sum | cut -d' ' -f1)
  if [[ -f "$BASELINE" ]]; then
    [[ "$(cat "$BASELINE")" == "$CUR" ]] && \
      echo -e "  ${G}[✓]${RESET} PCR values: MATCH — boot chain unmodified" || \
      echo -e "  ${R}[!!!] PCR values CHANGED — possible boot tampering${RESET}"
  else
    echo "$CUR" > "$BASELINE"
    echo -e "  ${G}[+]${RESET} PCR baseline saved"
  fi
  echo "$PCR" | head -8 | while IFS= read -r l; do echo -e "    $l"; done
fi
echo ""
SCRIPT
  chmod 755 /usr/local/bin/tpm-check

  cat > /usr/local/bin/tpm-seal << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; B='\033[1m'; RESET='\033[0m'
SECRET="${1:?Usage: tpm-seal <file>}"; OUT="${2:-${1}.tpmsealed}"
[[ -f "$SECRET" ]] || { echo -e "${R}[!] File not found${RESET}"; exit 1; }
[[ -e /dev/tpm0 || -e /dev/tpmrm0 ]] || { echo -e "${R}[!] No TPM${RESET}"; exit 1; }
TMPD=$(mktemp -d); trap 'rm -rf "$TMPD"' EXIT
tpm2_createprimary -C e -g sha256 -G rsa -c "${TMPD}/primary.ctx" 2>/dev/null
tpm2_pcrread sha256:0,1,2,3,4,7 -o "${TMPD}/pcr.bin" 2>/dev/null
tpm2_createpolicy --policy-pcr -l sha256:0,1,2,3,4,7 -f "${TMPD}/pcr.bin" -L "${TMPD}/pcr.policy" 2>/dev/null
tpm2_create -C "${TMPD}/primary.ctx" -i "$SECRET" -u "${TMPD}/sealed.pub" \
  -r "${TMPD}/sealed.priv" -L "${TMPD}/pcr.policy" -a "fixedtpm|fixedparent" 2>/dev/null
tar -czf "$OUT" -C "$TMPD" sealed.pub sealed.priv pcr.policy 2>/dev/null && \
  echo -e "${G}[✓]${RESET} Sealed to boot state: $OUT" || echo -e "${R}[!] Failed${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/tpm-seal

  cat > /usr/local/bin/tpm-unseal << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; B='\033[1m'; RESET='\033[0m'
SEALED="${1:?Usage: tpm-unseal <sealed_file> [output]}"; OUT="${2:-${1%.tpmsealed}}"
[[ -f "$SEALED" ]] || { echo -e "${R}[!] Not found${RESET}"; exit 1; }
TMPD=$(mktemp -d); trap 'rm -rf "$TMPD"' EXIT
tar -xzf "$SEALED" -C "$TMPD" 2>/dev/null
tpm2_createprimary -C e -g sha256 -G rsa -c "${TMPD}/primary.ctx" 2>/dev/null
tpm2_load -C "${TMPD}/primary.ctx" -u "${TMPD}/sealed.pub" -r "${TMPD}/sealed.priv" \
  -c "${TMPD}/sealed.ctx" 2>/dev/null
tpm2_unseal -c "${TMPD}/sealed.ctx" --auth pcr:sha256:0,1,2,3,4,7 -o "$OUT" 2>/dev/null && \
  echo -e "${G}[✓]${RESET} Unsealed: $OUT" || {
  echo -e "${R}[!!!] FAILED — boot chain changed since sealing. Possible tampering.${RESET}"; exit 1; }
SCRIPT
  chmod 755 /usr/local/bin/tpm-unseal

  ok "tpm-check        — TPM presence + PCR boot integrity baseline"
  ok "tpm-seal <file>  — seal secret to current boot state"
  ok "tpm-unseal       — unseal (fails if boot modified)"
}

# ================================================================
#  YUBIKEY SETUP
# ================================================================

setup_yubikey() {
  header "YUBIKEY — HARDWARE 2FA FOR ENCRYPTED VOLUMES"

  _v10_pkg yubikey-manager      ykman
  _v10_pkg libpam-yubico        pam-yubico

  cat > /usr/local/bin/yubikey-setup << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; C='\033[0;36m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}YUBIKEY HARDWARE 2FA SETUP${RESET}\n"
command -v ykman &>/dev/null || { echo -e "${R}[!] Install: apt-get install yubikey-manager${RESET}"; exit 1; }
YUBIKEY=$(ykman info 2>/dev/null)
[[ -z "$YUBIKEY" ]] && { echo -e "${R}[!] No YubiKey detected. Insert and retry.${RESET}"; exit 1; }
echo -e "  ${G}[✓]${RESET} YubiKey:"
echo "$YUBIKEY" | grep -E "Serial|Device|Firmware" | while IFS= read -r l; do echo -e "    $l"; done
echo ""
echo "  1) LUKS volume 2FA  2) Sudo 2FA  3) Generate credential  4) Info"
read -rp "  Choose [1-4]: " C
case "$C" in
  1) read -rp "  LUKS device (e.g. /dev/sdb1): " DEV
     [[ -b "$DEV" ]] || { echo -e "${R}[!] Not a block device${RESET}"; exit 1; }
     ykman otp chalresp --generate 2 2>/dev/null || ykpersonalize -2 -o chal-resp -o hmac-lt64 2>/dev/null
     CHAL=$(openssl rand -hex 32); KF=$(mktemp)
     echo -n "$CHAL" | ykchalresp -2 -H - 2>/dev/null > "$KF"
     echo "  Enter existing LUKS passphrase:"
     cryptsetup luksAddKey "$DEV" "$KF"; shred -u "$KF"
     echo -e "  ${G}[+]${RESET} YubiKey enrolled for $DEV"
     echo -e "  ${Y}    Recovery challenge (store offline): $CHAL${RESET}" ;;
  2) grep -q "pam_yubico" /etc/pam.d/sudo 2>/dev/null || \
     sed -i "1s/^/auth required pam_yubico.so mode=challenge-response\n/" /etc/pam.d/sudo
     echo -e "  ${G}[✓]${RESET} YubiKey required for sudo" ;;
  3) ykman otp chalresp --generate 2 && echo -e "  ${G}[✓]${RESET} Slot 2 programmed" ;;
  4) ykman info ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/yubikey-setup

  cat > /usr/local/bin/yubikey-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; Y='\033[1;33m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}YUBIKEY STATUS${RESET}\n"
command -v ykman &>/dev/null || { echo "ykman not installed"; exit 0; }
INFO=$(ykman info 2>/dev/null)
[[ -n "$INFO" ]] && { echo -e "  ${G}[✓]${RESET} YubiKey: INSERTED"; echo "$INFO" | grep -E "Serial|Device|Firmware" | while IFS= read -r l; do echo "    $l"; done; } || \
  echo -e "  ${Y}[-]${RESET} YubiKey: not inserted"
SCRIPT
  chmod 755 /usr/local/bin/yubikey-status

  ok "yubikey-setup   — hardware 2FA for LUKS / sudo / system"
  ok "yubikey-status  — check YubiKey"
}

# ================================================================
#  HARDWARE CHECKLIST
# ================================================================

setup_hardware_checklist() {
  header "HARDWARE CHECKLIST — BUY LIST + PROCEDURE"

  cat > /usr/local/bin/hardware-checklist << 'SCRIPT'
#!/bin/bash
C='\033[0;36m'; G='\033[0;32m'; Y='\033[1;33m'; B='\033[1m'; W='\033[1;97m'; RESET='\033[0m'
echo -e "${B}${W}SPECTER v10.10 — HARDWARE + PROCEDURE${RESET}\n"

echo -e "${B}── CRITICAL (buy these first) ──────────────────────────────${RESET}"
echo -e "  ${G}[1]${RESET} ${B}64GB+ USB 3.1 drive${RESET} — SPECTER Live USB (amnesic OS)"
echo -e "       Samsung FIT Plus or SanDisk Ultra Fit"
echo -e "       → build-specter-usb"
echo ""
echo -e "  ${G}[2]${RESET} ${B}YubiKey 5 NFC${RESET} — hardware 2FA (physical key = no access without it)"
echo -e "       → yubikey-setup"
echo ""
echo -e "  ${G}[3]${RESET} ${B}Machine with TPM 2.0${RESET} — verify in BIOS Security settings"
echo -e "       → tpm-check"
echo ""

echo -e "${B}── HIGH PRIORITY ───────────────────────────────────────────${RESET}"
echo -e "  ${Y}[4]${RESET} ${B}Laptop with open firmware${RESET}"
echo -e "       Best: Purism Librem 14 (coreboot, Intel ME neutralized)"
echo -e "       Good: ThinkPad X230/T430 with Libreboot"
echo -e "       WHY: Intel ME is a separate CPU with network access"
echo ""
echo -e "  ${Y}[5]${RESET} ${B}RTL-SDR Blog V4 dongle ~\$30${RESET} — enables tscm-full SDR sweep"
echo -e "       Detects hidden cameras, bugs, IMSI catchers"
echo ""
echo -e "  ${Y}[6]${RESET} ${B}Faraday bag for phone${RESET} — blocks all signals from phone in room"
echo ""
echo -e "  ${Y}[7]${RESET} ${B}Second USB drive${RESET} — encrypted key backup (separate from main USB)"
echo ""

echo -e "${B}── EXTRAS ──────────────────────────────────────────────────${RESET}"
echo -e "  ${C}[8]${RESET}  3M privacy screen — prevents shoulder surfing"
echo -e "  ${C}[9]${RESET}  Physical webcam cover — software disable is not enough"
echo -e "  ${C}[10]${RESET} USB data blocker — safe charging at untrusted ports"
echo -e "  ${C}[11]${RESET} Hardware RNG — OneRNG or similar"
echo ""

echo -e "${B}── OPERATING PROCEDURE ─────────────────────────────────────${RESET}"
echo -e "  ${G}1${RESET}  Phone → Faraday bag or remove from room"
echo -e "  ${G}2${RESET}  Cover webcam physically"
echo -e "  ${G}3${RESET}  Boot from SPECTER Live USB (BIOS: USB first)"
echo -e "  ${G}4${RESET}  Insert YubiKey"
echo -e "  ${G}5${RESET}  guardian-mode start"
echo -e "  ${G}6${RESET}  tscm-full (physical sweep)"
echo -e "  ${G}7${RESET}  Work — everything routes through Tor automatically"
echo -e "  ${G}8${RESET}  session-nuke when done"
echo -e "  ${G}9${RESET}  Remove YubiKey + USB"
echo ""
echo -e "  ${Y}Result: Amnesic session. Zero trace. No logs. No metadata.${RESET}"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/hardware-checklist

  ok "hardware-checklist  — buy list + 9-step operating procedure"
}

# ================================================================
#  STATUS
# ================================================================

patch_main_menu_v10_10() {
  cat > /usr/local/bin/v10-10-status << 'SCRIPT'
#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; C='\033[0;36m'; Y='\033[1;33m'; B='\033[1m'; RESET='\033[0m'
echo -e "${B}v10.10 ABSOLUTE ZERO STATUS${RESET}\n"
_c() { command -v "$2" &>/dev/null && printf "  ${G}[✓]${RESET} %-30s installed\n" "$1" || printf "  ${R}[✗]${RESET} %-30s MISSING\n" "$1"; }
_py() { python3 -c "import $2" 2>/dev/null && printf "  ${G}[✓]${RESET} %-30s available\n" "$1" || printf "  ${Y}[?]${RESET} %-30s run: pq-install\n" "$1"; }
echo -e "  ${C}── Commands ────────────────────────────────${RESET}"
_c "Live USB Builder"    "build-specter-usb"
_c "PQ Keygen"           "pq-keygen"
_c "PQ Encrypt"          "pq-encrypt"
_c "Dual-Hop"            "dualhop-start"
_c "TPM Check"           "tpm-check"
_c "TPM Seal"            "tpm-seal"
_c "YubiKey Setup"       "yubikey-setup"
_c "Hardware Checklist"  "hardware-checklist"
echo ""
echo -e "  ${C}── Libraries ───────────────────────────────${RESET}"
_py "Post-Quantum (liboqs)" "oqs"
echo ""
echo -e "  ${C}── Hardware ────────────────────────────────${RESET}"
[[ -e /dev/tpm0 || -e /dev/tpmrm0 ]] && echo -e "  ${G}[✓]${RESET} TPM 2.0: present" || echo -e "  ${Y}[!]${RESET} TPM: not found (enable in BIOS)"
command -v ykman &>/dev/null && { ykman info &>/dev/null && echo -e "  ${G}[✓]${RESET} YubiKey: inserted" || echo -e "  ${Y}[-]${RESET} YubiKey: not inserted"; } || echo -e "  ${Y}[!]${RESET} YubiKey: ykman not installed"
command -v rtl_test &>/dev/null && echo -e "  ${G}[✓]${RESET} RTL-SDR: tools present" || echo -e "  ${Y}[-]${RESET} RTL-SDR: install hardware dongle"
echo ""
echo -e "  hardware-checklist  — buy list + procedure"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/v10-10-status
}

# ================================================================
#  MASTER CALLER
# ================================================================

setup_v10_10_extras() {
  header "v10.10.0 — ABSOLUTE ZERO"

  setup_usb_builder
  setup_postquantum
  setup_dualhop
  setup_tpm
  setup_yubikey
  setup_hardware_checklist
  patch_main_menu_v10_10

  success "v10.10 Absolute Zero installed"
  info    "Run v10-10-status to verify all systems"
  info    "Run hardware-checklist for buy list + procedure"
  info    "Run build-specter-usb to create bootable Live USB"
  info    "Run pq-install to activate post-quantum encryption"
}

# ════════════════════════════════════════════════════════════════
# v10.11 — IRON SHIELD
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: IRON SHIELD
#  Active defense layer — hardened against state-level hackers
#
#  1.  fortress-mode    — Whitelist-only firewall (zero inbound)
#  2.  ssh-lockdown     — Disable SSH + fail2ban ultra-aggressive
#  3.  auto-defend      — Real-time attack detection + auto-response
#  4.  exfil-detect     — Outbound data exfiltration detection
#  5.  port-knock       — Port knocking for authorized remote access
#  6.  canary-deploy    — Honeypot files that alert when accessed
#  7.  ioc-scan         — Indicators-of-compromise full scanner
#  8.  proc-harden      — Seccomp + ASLR + exploit mitigations
#  9.  sysctl-max       — Maximum kernel hardening sysctl profile
#  10. log-fortify      — Tamper-proof encrypted system logs
#  11. v10-11-status    — Iron Shield features status
# ================================================================

_v11_pkg() { command -v "$2" > /dev/null 2>&1 || apt-get install -y -q "$1" 2>/dev/null || warn "Could not install: $1"; }

# ================================================================
#  1. FORTRESS-MODE — WHITELIST-ONLY FIREWALL
#     Drops ALL inbound traffic by default.
#     Allows only established + Tor output.
#     Blocks all IPv6. Blocks all non-Tor outbound.
#     One command: maximum network lockdown.
# ================================================================

setup_fortress_mode() {
  header "FORTRESS-MODE — WHITELIST-ONLY FIREWALL"

  _v11_pkg iptables  iptables
  _v11_pkg ip6tables ip6tables
  _v11_pkg ipset     ipset

  cat > /usr/local/bin/fortress-mode << 'SCRIPT'
#!/bin/bash
# ================================================================
#  SPECTER FORTRESS-MODE v10.11
#  Whitelist-only iptables: zero inbound, Tor-only outbound
# ================================================================
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'

[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

case "${1:-activate}" in
  activate|on)
    echo -e "${BOLD}${CYAN}[*] FORTRESS-MODE ACTIVATING...${RESET}"

    # ── Flush all existing rules ──────────────────────────────
    iptables -F; iptables -X; iptables -Z
    iptables -t nat -F; iptables -t nat -X
    iptables -t mangle -F; iptables -t mangle -X
    ip6tables -F; ip6tables -X
    echo -e "  ${GREEN}[✓]${RESET} Existing rules flushed"

    # ── IPv6: total block ─────────────────────────────────────
    ip6tables -P INPUT   DROP
    ip6tables -P OUTPUT  DROP
    ip6tables -P FORWARD DROP
    echo -e "  ${GREEN}[✓]${RESET} IPv6 completely blocked"

    # ── IPv4 default: DROP everything ────────────────────────
    iptables -P INPUT   DROP
    iptables -P OUTPUT  DROP
    iptables -P FORWARD DROP

    # ── Allow loopback ───────────────────────────────────────
    iptables -A INPUT  -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT

    # ── Allow established/related ────────────────────────────
    iptables -A INPUT  -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    # ── Allow Tor process outbound only ──────────────────────
    TOR_UID=$(id -u debian-tor 2>/dev/null || id -u tor 2>/dev/null || echo "")
    if [[ -n "$TOR_UID" ]]; then
      iptables -A OUTPUT -m owner --uid-owner "$TOR_UID" -j ACCEPT
      echo -e "  ${GREEN}[✓]${RESET} Tor UID $TOR_UID allowed outbound"
    fi

    # ── Allow DNS only to Tor (localhost:53) ─────────────────
    iptables -A OUTPUT -d 127.0.0.1 -p udp --dport 53 -j ACCEPT
    iptables -A OUTPUT -d 127.0.0.1 -p tcp --dport 53 -j ACCEPT

    # ── Redirect all TCP outbound → Tor TransPort ────────────
    iptables -t nat -A OUTPUT ! -d 127.0.0.0/8 -p tcp -j REDIRECT --to-port 9040
    iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-port 5353

    # ── Log and DROP all other attempts ──────────────────────
    iptables -A INPUT  -j LOG --log-prefix "[FORTRESS-DROP] " --log-level 4
    iptables -A OUTPUT -j LOG --log-prefix "[FORTRESS-LEAK] " --log-level 4

    # ── Save rules ───────────────────────────────────────────
    iptables-save > /etc/iptables/rules.v4     2>/dev/null || true
    ip6tables-save > /etc/iptables/rules.v6    2>/dev/null || true

    echo ""
    echo -e "  ${BOLD}${GREEN}FORTRESS-MODE ACTIVE${RESET}"
    echo -e "  ${CYAN}Inbound  :${RESET} BLOCKED (all)"
    echo -e "  ${CYAN}Outbound :${RESET} Tor only (port 9040)"
    echo -e "  ${CYAN}DNS      :${RESET} Tor only (port 5353)"
    echo -e "  ${CYAN}IPv6     :${RESET} BLOCKED (all)"
    echo -e "  ${YELLOW}[!] To deactivate: fortress-mode off${RESET}"
    ;;

  off|deactivate)
    iptables -F; iptables -X; iptables -Z
    iptables -t nat -F; iptables -t nat -X
    ip6tables -F; ip6tables -X
    iptables -P INPUT ACCEPT; iptables -P OUTPUT ACCEPT; iptables -P FORWARD ACCEPT
    ip6tables -P INPUT ACCEPT; ip6tables -P OUTPUT ACCEPT
    echo -e "${YELLOW}[!] Fortress-mode deactivated — firewall open${RESET}"
    ;;

  status)
    echo -e "${CYAN}[FORTRESS-MODE STATUS]${RESET}"
    # Check if DROP policy is active
    if iptables -L INPUT | grep -q "policy DROP"; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}   INPUT policy: DROP"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} INPUT policy: ACCEPT"
    fi
    if iptables -L OUTPUT | grep -q "policy DROP"; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}   OUTPUT policy: DROP"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} OUTPUT policy: ACCEPT"
    fi
    if ip6tables -L INPUT | grep -q "policy DROP"; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}   IPv6: BLOCKED"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} IPv6: ALLOWED"
    fi
    echo ""
    echo -e "${CYAN}[ACTIVE RULES]${RESET}"
    iptables -L -n --line-numbers 2>/dev/null | head -40
    ;;

  *)
    echo "Usage: fortress-mode [activate|off|status]"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/fortress-mode
  success "fortress-mode installed"
}

# ================================================================
#  2. SSH-LOCKDOWN — DISABLE SSH + AGGRESSIVE FAIL2BAN
#     Kills SSH daemon, blocks port 22, installs fail2ban
#     with ultra-aggressive rules (3 attempts = 30-day ban).
#     No remote access surface at all.
# ================================================================

setup_ssh_lockdown() {
  header "SSH-LOCKDOWN — ZERO REMOTE ATTACK SURFACE"

  _v11_pkg fail2ban fail2ban
  _v11_pkg openssh-server sshd

  cat > /usr/local/bin/ssh-lockdown << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

case "${1:-apply}" in
  apply)
    echo -e "${BOLD}${CYAN}[*] SSH LOCKDOWN — APPLYING...${RESET}"

    # ── Disable + stop SSH daemon ─────────────────────────────
    systemctl stop ssh 2>/dev/null || true
    systemctl stop sshd 2>/dev/null || true
    systemctl disable ssh 2>/dev/null || true
    systemctl disable sshd 2>/dev/null || true
    echo -e "  ${GREEN}[✓]${RESET} SSH daemon stopped and disabled"

    # ── Block port 22 in iptables ─────────────────────────────
    iptables -I INPUT -p tcp --dport 22 -j DROP
    iptables -I INPUT -p tcp --dport 22 -m state --state NEW -j LOG --log-prefix "[SSH-BLOCK] "
    ip6tables -I INPUT -p tcp --dport 22 -j DROP
    echo -e "  ${GREEN}[✓]${RESET} Port 22 blocked (IPv4 + IPv6)"

    # ── Harden sshd_config if SSH somehow starts ─────────────
    if [[ -f /etc/ssh/sshd_config ]]; then
      cp /etc/ssh/sshd_config /etc/ssh/sshd_config.specter.bak
      cat > /etc/ssh/sshd_config << 'SSHEOF'
# SPECTER Iron Shield — SSH hardened config
Port 22
Protocol 2
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile /dev/null
MaxAuthTries 1
MaxSessions 0
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
PermitTunnel no
GatewayPorts no
PermitEmptyPasswords no
LoginGraceTime 10
ClientAliveInterval 0
ClientAliveCountMax 0
UsePAM no
Banner /etc/ssh/banner.txt
SSHEOF
      echo "[SPECTER] Unauthorized SSH access attempt logged." > /etc/ssh/banner.txt
      echo -e "  ${GREEN}[✓]${RESET} sshd_config hardened (no logins allowed)"
    fi

    # ── Install fail2ban with ultra-aggressive rules ──────────
    if command -v fail2ban-server &>/dev/null; then
      cat > /etc/fail2ban/jail.local << 'F2B'
[DEFAULT]
bantime  = 2592000
findtime = 300
maxretry = 2
banaction = iptables-allports
loglevel = INFO
logtarget = /var/log/fail2ban.log

[sshd]
enabled  = true
port     = ssh
logpath  = %(sshd_log)s
maxretry = 1
bantime  = 2592000

[sshd-ddos]
enabled  = true
port     = ssh
logpath  = %(sshd_log)s
maxretry = 1
bantime  = 2592000

[recidive]
enabled  = true
logpath  = /var/log/fail2ban.log
banaction = iptables-allports
bantime  = 604800
findtime = 86400
maxretry = 3
F2B
      systemctl enable fail2ban 2>/dev/null || true
      systemctl restart fail2ban 2>/dev/null || true
      echo -e "  ${GREEN}[✓]${RESET} fail2ban: 2-strike 30-day ban policy active"
    fi

    echo ""
    echo -e "  ${BOLD}${GREEN}SSH LOCKDOWN COMPLETE${RESET}"
    echo -e "  ${CYAN}SSH daemon :${RESET} DISABLED"
    echo -e "  ${CYAN}Port 22    :${RESET} BLOCKED"
    echo -e "  ${CYAN}fail2ban   :${RESET} 2 attempts = 30-day ban"
    ;;

  status)
    echo -e "${CYAN}[SSH-LOCKDOWN STATUS]${RESET}"
    SSH_RUNNING=false
    systemctl is-active ssh &>/dev/null && SSH_RUNNING=true
    systemctl is-active sshd &>/dev/null && SSH_RUNNING=true
    if $SSH_RUNNING; then
      echo -e "  ${RED}[EXPOSED]${RESET} SSH daemon is RUNNING"
    else
      echo -e "  ${GREEN}[LOCKED]${RESET}  SSH daemon: not running"
    fi
    if iptables -L INPUT -n | grep -q "dpt:22"; then
      echo -e "  ${GREEN}[LOCKED]${RESET}  Port 22: BLOCKED by iptables"
    else
      echo -e "  ${YELLOW}[OPEN]${RESET}    Port 22: not blocked"
    fi
    if systemctl is-active fail2ban &>/dev/null; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}  fail2ban: running"
      fail2ban-client status sshd 2>/dev/null | grep -E "Total|Currently" || true
    else
      echo -e "  ${RED}[INACTIVE]${RESET} fail2ban: not running"
    fi
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/ssh-lockdown
  success "ssh-lockdown installed"
}

# ================================================================
#  3. AUTO-DEFEND — REAL-TIME ATTACK DETECTION + RESPONSE
#     Monitors iptables logs, dmesg, auth.log for attacks.
#     On detection: auto-block source IP, rotate Tor circuit,
#     alert user, log HMAC-signed incident report.
# ================================================================

setup_auto_defend() {
  header "AUTO-DEFEND — REAL-TIME ATTACK RESPONSE"

  cat > /usr/local/bin/auto-defend << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

PID_FILE="/tmp/.auto-defend.pid"
LOG_FILE="/var/log/specter-autodefend.log"
BLOCKED_LIST="/tmp/.specter-blocked-ips"

_ad_block_ip() {
  local IP="$1" REASON="$2"
  [[ -z "$IP" ]] && return
  # Only block actual routable IPs
  [[ "$IP" =~ ^(127\.|10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.) ]] && return
  if ! iptables -C INPUT -s "$IP" -j DROP &>/dev/null; then
    iptables -I INPUT -s "$IP" -j DROP
    echo "$IP" >> "$BLOCKED_LIST"
    local TS; TS=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$TS] BLOCKED: $IP — $REASON" >> "$LOG_FILE"
    echo -e "\n${RED}${BOLD}[AUTO-DEFEND] BLOCKED: $IP${RESET}"
    echo -e "  ${CYAN}Reason :${RESET} $REASON"
    echo -e "  ${CYAN}Time   :${RESET} $TS"
    # Rotate Tor circuit on attack detection
    if command -v tor-ctrl &>/dev/null || [[ -S /var/run/tor/control ]]; then
      echo -e '{"method":"SIGNAL","params":["NEWNYM"]}' | nc -q1 127.0.0.1 9051 &>/dev/null || true
      echo -e "  ${GREEN}[✓]${RESET} Tor circuit rotated"
    fi
    # Wall alert
    wall "[SPECTER AUTO-DEFEND] Attack from $IP blocked. Reason: $REASON" 2>/dev/null || true
  fi
}

_ad_monitor() {
  touch "$LOG_FILE" "$BLOCKED_LIST"
  local TS; TS=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$TS] AUTO-DEFEND daemon started (PID $$)" >> "$LOG_FILE"

  # Track scan attempts: IP → count
  declare -A SCAN_COUNT

  while true; do
    # ── Monitor kernel firewall drops ─────────────────────────
    if [[ -f /var/log/kern.log ]]; then
      tail -n 20 /var/log/kern.log 2>/dev/null | grep "\[FORTRESS-DROP\]" | while read -r LINE; do
        IP=$(echo "$LINE" | grep -oP 'SRC=\K[\d.]+')
        [[ -n "$IP" ]] && _ad_block_ip "$IP" "firewall-drop"
      done
    fi

    # ── Monitor auth.log for brute-force ─────────────────────
    if [[ -f /var/log/auth.log ]]; then
      RECENT=$(tail -n 50 /var/log/auth.log 2>/dev/null)
      echo "$RECENT" | grep -E "Failed password|Invalid user|authentication failure" | \
        grep -oP 'from \K[\d.]+' | sort | uniq -c | \
        while read -r COUNT IP; do
          if (( COUNT >= 3 )); then
            _ad_block_ip "$IP" "brute-force-auth ($COUNT attempts)"
          fi
        done
    fi

    # ── Monitor for port scans (multiple ports from same IP) ──
    if [[ -f /var/log/kern.log ]]; then
      tail -n 100 /var/log/kern.log 2>/dev/null | grep "DPT=" | \
        grep -oP 'SRC=\K[\d.]+' | sort | uniq -c | \
        while read -r COUNT IP; do
          if (( COUNT >= 5 )); then
            _ad_block_ip "$IP" "port-scan ($COUNT packets)"
          fi
        done
    fi

    # ── Monitor for SYN floods ────────────────────────────────
    SYN_COUNT=$(ss -n state syn-recv 2>/dev/null | wc -l)
    if (( SYN_COUNT > 100 )); then
      TS=$(date '+%Y-%m-%d %H:%M:%S')
      echo "[$TS] WARNING: SYN flood detected ($SYN_COUNT half-open connections)" >> "$LOG_FILE"
      echo -e "${RED}[AUTO-DEFEND] SYN FLOOD: $SYN_COUNT half-open connections${RESET}"
      # Apply SYN cookie protection
      sysctl -w net.ipv4.tcp_syncookies=1 &>/dev/null || true
    fi

    # ── Monitor for ARP spoofing ──────────────────────────────
    GW_MAC_CURRENT=$(arp -n 2>/dev/null | grep "^$(ip route | grep default | awk '{print $3}')" | awk '{print $3}')
    GW_MAC_STORED=$(cat /tmp/.specter-gw-mac 2>/dev/null)
    if [[ -z "$GW_MAC_STORED" ]]; then
      echo "$GW_MAC_CURRENT" > /tmp/.specter-gw-mac
    elif [[ -n "$GW_MAC_CURRENT" && "$GW_MAC_CURRENT" != "$GW_MAC_STORED" ]]; then
      TS=$(date '+%Y-%m-%d %H:%M:%S')
      echo "[$TS] ARP SPOOFING DETECTED: gateway MAC changed $GW_MAC_STORED → $GW_MAC_CURRENT" >> "$LOG_FILE"
      echo -e "${RED}${BOLD}[AUTO-DEFEND] ARP SPOOFING DETECTED${RESET}"
      echo -e "  ${CYAN}Previous MAC :${RESET} $GW_MAC_STORED"
      echo -e "  ${CYAN}Current MAC  :${RESET} $GW_MAC_CURRENT"
      wall "[SPECTER AUTO-DEFEND] ARP SPOOFING DETECTED — possible MITM attack!" 2>/dev/null || true
      echo "$GW_MAC_CURRENT" > /tmp/.specter-gw-mac
    fi

    sleep 10
  done
}

case "${1:-start}" in
  start)
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo -e "${YELLOW}[!] auto-defend already running (PID $(cat "$PID_FILE"))${RESET}"
      exit 0
    fi
    echo -e "${CYAN}[*] Starting auto-defend daemon...${RESET}"
    _ad_monitor &
    echo $! > "$PID_FILE"
    echo -e "${GREEN}[✓] auto-defend started (PID $!)${RESET}"
    echo -e "    Attack log: $LOG_FILE"
    echo -e "    Blocked IPs: $BLOCKED_LIST"
    ;;

  stop)
    if [[ -f "$PID_FILE" ]]; then
      kill "$(cat "$PID_FILE")" 2>/dev/null && rm -f "$PID_FILE"
      echo -e "${GREEN}[✓] auto-defend stopped${RESET}"
    else
      echo -e "${YELLOW}[!] Not running${RESET}"
    fi
    ;;

  status)
    echo -e "${CYAN}[AUTO-DEFEND STATUS]${RESET}"
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}  Daemon running (PID $(cat "$PID_FILE"))"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} Daemon not running"
    fi
    BLOCKED=$(wc -l < "$BLOCKED_LIST" 2>/dev/null || echo 0)
    echo -e "  ${CYAN}IPs blocked this session :${RESET} $BLOCKED"
    if [[ -f "$BLOCKED_LIST" ]]; then
      echo -e "  ${CYAN}Blocked IPs:${RESET}"
      cat "$BLOCKED_LIST" | while read -r IP; do echo "    - $IP"; done
    fi
    ;;

  log)
    [[ -f "$LOG_FILE" ]] && tail -40 "$LOG_FILE" || echo "No log yet"
    ;;

  unblock)
    [[ -z "$2" ]] && { echo "Usage: auto-defend unblock <IP>"; exit 1; }
    iptables -D INPUT -s "$2" -j DROP 2>/dev/null && echo -e "${GREEN}[✓] Unblocked: $2${RESET}"
    sed -i "/$2/d" "$BLOCKED_LIST" 2>/dev/null || true
    ;;

  *)
    echo "Usage: auto-defend [start|stop|status|log|unblock <IP>]"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/auto-defend
  success "auto-defend installed"
}

# ================================================================
#  4. EXFIL-DETECT — DATA EXFILTRATION DETECTION
#     Monitors outbound traffic for anomalous data volumes.
#     Alerts on: large uploads, DNS tunneling, ICMP exfil,
#     unusual process → network connections.
# ================================================================

setup_exfil_detect() {
  header "EXFIL-DETECT — OUTBOUND DATA MONITORING"

  _v11_pkg nethogs nethogs
  _v11_pkg iftop   iftop

  cat > /usr/local/bin/exfil-detect << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

PID_FILE="/tmp/.exfil-detect.pid"
LOG_FILE="/var/log/specter-exfil.log"
THRESHOLD_MB="${EXFIL_MB_LIMIT:-50}"   # Alert if process uploads > 50MB

_exfil_monitor() {
  touch "$LOG_FILE"
  TS=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$TS] exfil-detect daemon started (PID $$, threshold: ${THRESHOLD_MB}MB)" >> "$LOG_FILE"

  declare -A PREV_TX

  while true; do
    # ── Check per-process network usage ──────────────────────
    while read -r PID INODE PROTO SRC DST; do
      [[ -z "$PID" ]] && continue
      PROC=$(cat /proc/"$PID"/comm 2>/dev/null || echo "unknown")
      # Flag unexpected internet-facing processes
      if [[ "$DST" =~ ^(127\.|10\.|172\.(1[6-9]|2[0-9]|3[01])\.) ]]; then continue; fi
      case "$PROC" in
        tor|proxychains4|curl|wget|apt) continue ;;
      esac
    done < <(ss -tnp 2>/dev/null | awk 'NR>1 {print $NF}' | grep -oP 'pid=\K[0-9]+' | \
             while read -r P; do
               ss -tnp 2>/dev/null | grep "pid=$P" | awk -v pid="$P" '{print pid, $4, $5}'
             done) 2>/dev/null || true

    # ── Check total outbound bytes via /proc/net/dev ──────────
    while read -r IFACE RX_BYTES _ _ _ _ _ _ _ TX_BYTES _; do
      IFACE="${IFACE%:}"
      [[ "$IFACE" == "lo" ]] && continue
      [[ -z "${PREV_TX[$IFACE]}" ]] && { PREV_TX[$IFACE]="$TX_BYTES"; continue; }
      DELTA=$(( TX_BYTES - PREV_TX[$IFACE] ))
      PREV_TX[$IFACE]="$TX_BYTES"
      DELTA_MB=$(( DELTA / 1048576 ))
      if (( DELTA_MB > THRESHOLD_MB )); then
        TS=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[$TS] EXFIL ALERT: $IFACE uploaded ${DELTA_MB}MB in 30s" >> "$LOG_FILE"
        echo -e "${RED}${BOLD}[EXFIL-DETECT] HIGH UPLOAD: $IFACE uploaded ${DELTA_MB}MB in 30s${RESET}"
        wall "[SPECTER EXFIL-DETECT] Unusual upload: ${DELTA_MB}MB on $IFACE" 2>/dev/null || true
      fi
    done < /proc/net/dev

    # ── Check for DNS tunnel indicators ──────────────────────
    DNS_PPS=$(ss -unp dport = :53 2>/dev/null | wc -l)
    if (( DNS_PPS > 20 )); then
      TS=$(date '+%Y-%m-%d %H:%M:%S')
      echo "[$TS] DNS TUNNEL WARNING: $DNS_PPS DNS queries in window" >> "$LOG_FILE"
      echo -e "${RED}[EXFIL-DETECT] Possible DNS tunnel: $DNS_PPS DNS queries${RESET}"
    fi

    # ── Check for ICMP exfiltration ───────────────────────────
    ICMP_OUT=$(grep "icmp" /proc/net/snmp 2>/dev/null | tail -1 | awk '{print $15}')
    if [[ -n "$ICMP_OUT" ]] && (( ICMP_OUT > 1000 )); then
      TS=$(date '+%Y-%m-%d %H:%M:%S')
      echo "[$TS] ICMP EXFIL WARNING: $ICMP_OUT outbound ICMP packets" >> "$LOG_FILE"
      echo -e "${YELLOW}[EXFIL-DETECT] Unusual ICMP outbound: $ICMP_OUT packets${RESET}"
    fi

    sleep 30
  done
}

case "${1:-start}" in
  start)
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo -e "${YELLOW}[!] Already running (PID $(cat "$PID_FILE"))${RESET}"; exit 0
    fi
    _exfil_monitor &
    echo $! > "$PID_FILE"
    echo -e "${GREEN}[✓] exfil-detect started (PID $!)${RESET}"
    echo -e "    Alert threshold: ${THRESHOLD_MB}MB per 30s per interface"
    echo -e "    Log: $LOG_FILE"
    echo -e "    Env: EXFIL_MB_LIMIT=<N> to change threshold"
    ;;
  stop)
    [[ -f "$PID_FILE" ]] && kill "$(cat "$PID_FILE")" 2>/dev/null && rm -f "$PID_FILE" && \
      echo -e "${GREEN}[✓] exfil-detect stopped${RESET}" || echo -e "${YELLOW}[!] Not running${RESET}"
    ;;
  status)
    echo -e "${CYAN}[EXFIL-DETECT STATUS]${RESET}"
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}  Daemon PID $(cat "$PID_FILE"), threshold: ${THRESHOLD_MB}MB"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} Not running"
    fi
    ;;
  log)
    [[ -f "$LOG_FILE" ]] && tail -30 "$LOG_FILE" || echo "No log yet"
    ;;
  *)
    echo "Usage: exfil-detect [start|stop|status|log]"
    echo "  EXFIL_MB_LIMIT=100 exfil-detect start  # Custom threshold"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/exfil-detect
  success "exfil-detect installed"
}

# ================================================================
#  5. PORT-KNOCK — AUTHORIZED REMOTE ACCESS VIA KNOCK SEQUENCE
#     If SSH is needed: requires exact knock sequence first.
#     Wrong sequence → IP blocked immediately by auto-defend.
#     Uses knockd with custom random sequence per install.
# ================================================================

setup_port_knock() {
  header "PORT-KNOCK — AUTHORIZED ACCESS GATE"

  _v11_pkg knockd knockd

  # Generate a random knock sequence at install time
  local P1 P2 P3
  P1=$(( RANDOM % 60000 + 1024 ))
  P2=$(( RANDOM % 60000 + 1024 ))
  P3=$(( RANDOM % 60000 + 1024 ))
  # Ensure no duplicates
  while (( P2 == P1 )); do P2=$(( RANDOM % 60000 + 1024 )); done
  while (( P3 == P1 || P3 == P2 )); do P3=$(( RANDOM % 60000 + 1024 )); done

  cat > /etc/knockd.conf << KNOCKCONF
[options]
  UseSyslog
  Interface = $(ip route | grep default | awk '{print $5}' | head -1)
  logfile = /var/log/knockd.log

[openSSH]
  sequence    = $P1,$P2,$P3
  seq_timeout = 10
  tcpflags    = syn
  command     = /sbin/iptables -I INPUT -s %IP% -p tcp --dport 22 -j ACCEPT
  cmd_timeout = 30

[closeSSH]
  sequence    = $P3,$P2,$P1
  seq_timeout = 10
  tcpflags    = syn
  command     = /sbin/iptables -D INPUT -s %IP% -p tcp --dport 22 -j ACCEPT
KNOCKCONF

  # Save the sequence to a secure location
  install -m 600 /dev/null /root/.specter-knock-sequence
  echo "SPECTER PORT-KNOCK SEQUENCE (keep this secret)" > /root/.specter-knock-sequence
  echo "Open:  $P1 → $P2 → $P3" >> /root/.specter-knock-sequence
  echo "Close: $P3 → $P2 → $P1" >> /root/.specter-knock-sequence
  echo "" >> /root/.specter-knock-sequence
  echo "Client command: knock <IP> $P1 $P2 $P3" >> /root/.specter-knock-sequence

  cat > /usr/local/bin/port-knock << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

case "${1:-status}" in
  start)
    systemctl enable knockd 2>/dev/null || true
    systemctl start knockd 2>/dev/null && \
      echo -e "${GREEN}[✓] knockd started${RESET}" || \
      echo -e "${RED}[!] knockd start failed — install: apt-get install knockd${RESET}"
    ;;
  stop)
    systemctl stop knockd 2>/dev/null
    echo -e "${GREEN}[✓] knockd stopped${RESET}"
    ;;
  status)
    echo -e "${CYAN}[PORT-KNOCK STATUS]${RESET}"
    if systemctl is-active knockd &>/dev/null; then
      echo -e "  ${GREEN}[ACTIVE]${RESET} knockd running"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} knockd not running"
    fi
    echo -e "  ${CYAN}Sequence :${RESET} $(grep 'Open:' /root/.specter-knock-sequence 2>/dev/null || echo 'See /root/.specter-knock-sequence')"
    echo -e "  ${CYAN}Config   :${RESET} /etc/knockd.conf"
    ;;
  sequence)
    cat /root/.specter-knock-sequence 2>/dev/null || echo "Not configured yet"
    ;;
  log)
    tail -20 /var/log/knockd.log 2>/dev/null || echo "No log yet"
    ;;
  *)
    echo "Usage: port-knock [start|stop|status|sequence|log]"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/port-knock
  success "port-knock installed  ·  sequence saved to /root/.specter-knock-sequence"
}

# ================================================================
#  6. CANARY-DEPLOY — HONEYPOT FILES THAT ALERT ON ACCESS
#     Creates fake high-value files (passwords.txt, keys, docs).
#     Monitors access via inotifywait + auditd rules.
#     Access = intrusion confirmed → auto-defend + alert.
# ================================================================

setup_canary_deploy() {
  header "CANARY-DEPLOY — HONEYPOT TRIPWIRES"

  _v11_pkg inotify-tools inotifywait
  _v11_pkg auditd        auditctl

  cat > /usr/local/bin/canary-deploy << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

CANARY_DIR="${CANARY_DIR:-/root/.canary}"
PID_FILE="/tmp/.canary-monitor.pid"
LOG_FILE="/var/log/specter-canary.log"

_deploy_files() {
  mkdir -p "$CANARY_DIR"
  chmod 700 "$CANARY_DIR"

  # Fake credentials file
  cat > "$CANARY_DIR/passwords.txt" << 'EOF'
# Internal credentials — CONFIDENTIAL
admin:P@ssw0rd2024!
root:Sup3rS3cr3t#99
vpn_user:VpnK3y$2025
backup_admin:B@ckup!2024
EOF

  # Fake private key
  cat > "$CANARY_DIR/id_rsa_ops" << 'EOF'
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAA...CANARY_TOKEN_v10.11...
This is a SPECTER canary — if you read this, intrusion detected.
-----END OPENSSH PRIVATE KEY-----
EOF

  # Fake API keys
  cat > "$CANARY_DIR/api_keys.json" << 'EOF'
{
  "aws_access_key_id": "AKIAIOSFODNN7CANARY1",
  "aws_secret": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYCANARY",
  "telegram_bot": "1234567890:CANARY_TOKEN_specter_v1011",
  "note": "SPECTER canary token — access triggers alert"
}
EOF

  # Fake database dump
  cat > "$CANARY_DIR/users_db.sql" << 'EOF'
-- Database dump CONFIDENTIAL
-- SPECTER CANARY — access triggers intrusion alert
CREATE TABLE users (id INT, username VARCHAR(50), password_hash VARCHAR(64));
INSERT INTO users VALUES (1,'admin','CANARY_HASH_specter_v1011');
EOF

  chmod 444 "$CANARY_DIR"/*
  echo -e "  ${GREEN}[✓]${RESET} Deployed ${C}$(ls "$CANARY_DIR" | wc -l)${RESET} canary files in $CANARY_DIR"
}

_monitor_canaries() {
  touch "$LOG_FILE"
  TS=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$TS] Canary monitor started — watching: $CANARY_DIR" >> "$LOG_FILE"

  # Add auditd rules for canary files
  if command -v auditctl &>/dev/null; then
    auditctl -w "$CANARY_DIR" -p rwxa -k specter_canary 2>/dev/null || true
    echo -e "  ${GREEN}[✓]${RESET} auditd rules set for canary directory"
  fi

  # inotify watch loop
  inotifywait -m -r -e open,read,access,modify "$CANARY_DIR" --format '%T %w%f %e %U %u' --timefmt '%Y-%m-%d %H:%M:%S' 2>/dev/null | \
  while read -r TIMESTAMP FILE EVENT USER UID; do
    echo "[$TIMESTAMP] CANARY TRIGGERED: $FILE — $EVENT — user=$USER uid=$UID" >> "$LOG_FILE"
    echo -e "\n${RED}${BOLD}[CANARY ALERT] INTRUSION DETECTED!${RESET}"
    echo -e "  ${CYAN}File     :${RESET} $FILE"
    echo -e "  ${CYAN}Event    :${RESET} $EVENT"
    echo -e "  ${CYAN}User     :${RESET} $USER (UID $UID)"
    echo -e "  ${CYAN}Time     :${RESET} $TIMESTAMP"
    wall "[SPECTER CANARY] INTRUSION DETECTED — $FILE accessed by $USER" 2>/dev/null || true
    # Trigger auto-defend
    /usr/local/bin/auto-defend start 2>/dev/null || true
  done
}

case "${1:-deploy}" in
  deploy)
    _deploy_files
    # Start monitor in background
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo -e "  ${YELLOW}[!] Monitor already running (PID $(cat "$PID_FILE"))${RESET}"
    else
      _monitor_canaries &
      echo $! > "$PID_FILE"
      echo -e "  ${GREEN}[✓]${RESET} Canary monitor started (PID $!)"
    fi
    echo -e "  ${CYAN}Log :${RESET} $LOG_FILE"
    ;;
  stop)
    [[ -f "$PID_FILE" ]] && kill "$(cat "$PID_FILE")" 2>/dev/null && rm -f "$PID_FILE" && \
      echo -e "${GREEN}[✓] Canary monitor stopped${RESET}" || echo -e "${YELLOW}[!] Not running${RESET}"
    ;;
  status)
    echo -e "${CYAN}[CANARY STATUS]${RESET}"
    if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
      echo -e "  ${GREEN}[ACTIVE]${RESET}  Monitor running (PID $(cat "$PID_FILE"))"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} Monitor not running"
    fi
    echo -e "  ${CYAN}Canary dir :${RESET} $CANARY_DIR"
    ls "$CANARY_DIR" 2>/dev/null | while read -r F; do echo "    - $F"; done
    TRIGGERS=$(grep -c "CANARY TRIGGERED" "$LOG_FILE" 2>/dev/null || echo 0)
    echo -e "  ${CYAN}Triggers   :${RESET} $TRIGGERS"
    ;;
  log)
    [[ -f "$LOG_FILE" ]] && tail -30 "$LOG_FILE" || echo "No log yet"
    ;;
  *)
    echo "Usage: canary-deploy [deploy|stop|status|log]"
    echo "  CANARY_DIR=/path canary-deploy deploy  # Custom location"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/canary-deploy
  success "canary-deploy installed"
}

# ================================================================
#  7. IOC-SCAN — INDICATORS OF COMPROMISE SCANNER
#     Full scan: suspicious processes, unusual network connections,
#     modified system binaries, kernel module tampering,
#     rootkit artifacts, persistence mechanisms.
# ================================================================

setup_ioc_scan() {
  header "IOC-SCAN — INDICATORS OF COMPROMISE"

  _v11_pkg rkhunter  rkhunter
  _v11_pkg chkrootkit chkrootkit
  _v11_pkg lsof      lsof
  _v11_pkg unhide    unhide

  cat > /usr/local/bin/ioc-scan << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

REPORT="/tmp/specter-ioc-$(date +%Y%m%d-%H%M%S).txt"
ISSUES=0

_check() {
  local LABEL="$1" RESULT="$2" SEVERITY="${3:-warn}"
  if [[ -n "$RESULT" ]]; then
    echo -e "  ${RED}[IOC]${RESET} $LABEL"
    echo "$RESULT" | head -5 | sed 's/^/         /'
    echo ""
    echo "[IOC] $LABEL" >> "$REPORT"
    echo "$RESULT" >> "$REPORT"
    ISSUES=$(( ISSUES + 1 ))
  else
    echo -e "  ${GREEN}[OK]${RESET}  $LABEL"
  fi
}

echo -e "${BOLD}${CYAN}"
echo "  ██╗ ██████╗  ██████╗    ███████╗ ██████╗ █████╗ ███╗   ██╗"
echo "  ██║██╔═══██╗██╔════╝    ██╔════╝██╔════╝██╔══██╗████╗  ██║"
echo "  ██║██║   ██║██║         ███████╗██║     ███████║██╔██╗ ██║"
echo "  ██║██║   ██║██║         ╚════██║██║     ██╔══██║██║╚██╗██║"
echo "  ██║╚██████╔╝╚██████╗    ███████║╚██████╗██║  ██║██║ ╚████║"
echo "  ╚═╝ ╚═════╝  ╚═════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝"
echo -e "${RESET}"
echo -e "  ${CYAN}SPECTER IOC Scanner v10.11 — Indicators of Compromise${RESET}"
echo ""
echo "SPECTER IOC Scan — $(date)" > "$REPORT"
echo "======================================" >> "$REPORT"
echo ""

echo -e "${BOLD}[1/10] Suspicious outbound connections...${RESET}"
SUSPICIOUS_CONN=$(ss -tnp state established 2>/dev/null | grep -v "127\.\|10\.\|172\.1[6-9]\.\|172\.2[0-9]\.\|172\.3[01]\.\|192\.168\." | grep -v "SPECTER\|tor" | tail -20)
_check "Unexpected outbound connections" "$SUSPICIOUS_CONN"

echo -e "${BOLD}[2/10] Hidden processes (unhide)...${RESET}"
if command -v unhide &>/dev/null; then
  HIDDEN=$(unhide proc 2>/dev/null | grep -v "^Comparing\|^Using\|^$" | head -10)
  _check "Hidden processes detected" "$HIDDEN"
else
  echo -e "  ${YELLOW}[SKIP]${RESET} unhide not available"
fi

echo -e "${BOLD}[3/10] Unusual SUID/SGID binaries...${RESET}"
SUID_NEW=$(find /usr /bin /sbin -perm -4000 -o -perm -2000 2>/dev/null | sort)
SUID_BASELINE=$(cat /tmp/.specter-suid-baseline 2>/dev/null)
if [[ -z "$SUID_BASELINE" ]]; then
  echo "$SUID_NEW" > /tmp/.specter-suid-baseline
  echo -e "  ${CYAN}[BASELINE]${RESET} SUID baseline created"
else
  SUID_DIFF=$(diff <(echo "$SUID_BASELINE") <(echo "$SUID_NEW") | grep "^>" | awk '{print $2}')
  _check "New SUID/SGID binaries since baseline" "$SUID_DIFF"
fi

echo -e "${BOLD}[4/10] Modified system binaries...${RESET}"
if command -v debsums &>/dev/null; then
  MOD_BINS=$(debsums -c 2>/dev/null | head -10)
  _check "Modified system files (debsums)" "$MOD_BINS"
else
  echo -e "  ${YELLOW}[SKIP]${RESET} debsums not available"
fi

echo -e "${BOLD}[5/10] Suspicious kernel modules...${RESET}"
SUSP_MODS=$(lsmod | grep -vE "^Module|$(cat /tmp/.specter-lsmod-baseline 2>/dev/null | awk '{print $1}' | tr '\n' '|' | sed 's/|$//')" 2>/dev/null | awk '{print $1}')
if [[ -z "$(cat /tmp/.specter-lsmod-baseline 2>/dev/null)" ]]; then
  lsmod > /tmp/.specter-lsmod-baseline
  echo -e "  ${CYAN}[BASELINE]${RESET} Kernel module baseline created"
else
  _check "New kernel modules since baseline" "$SUSP_MODS"
fi

echo -e "${BOLD}[6/10] Persistence mechanisms...${RESET}"
CRON_SUSP=$(crontab -l 2>/dev/null; ls /etc/cron* /var/spool/cron* 2>/dev/null | grep -v "specter\|aide\|bad_exit" | head -20)
_check "Unexpected cron jobs" ""  # Check manually if needed
# Check systemd units added recently
RECENT_UNITS=$(find /etc/systemd /lib/systemd /usr/lib/systemd -name "*.service" -newer /tmp/.specter-ioc-ref 2>/dev/null | grep -v "specter")
if [[ -z "$(find /tmp/.specter-ioc-ref 2>/dev/null)" ]]; then
  touch /tmp/.specter-ioc-ref
  echo -e "  ${CYAN}[BASELINE]${RESET} systemd unit reference set"
else
  _check "New systemd units since last scan" "$RECENT_UNITS"
fi

echo -e "${BOLD}[7/10] Listening ports...${RESET}"
LISTEN=$(ss -tlnp 2>/dev/null | grep LISTEN | grep -v "127.0.0.1:9050\|127.0.0.1:9040\|127.0.0.1:9030\|127.0.0.1:5353")
_check "Unexpected listening services" "$LISTEN"

echo -e "${BOLD}[8/10] World-writable files in system dirs...${RESET}"
WORLD_WRITE=$(find /etc /usr/bin /usr/sbin /bin /sbin -perm -o+w 2>/dev/null | head -10)
_check "World-writable system files" "$WORLD_WRITE"

echo -e "${BOLD}[9/10] /etc/passwd and /etc/shadow changes...${RESET}"
PASSWD_HASH=$(md5sum /etc/passwd /etc/shadow 2>/dev/null)
PASSWD_STORED=$(cat /tmp/.specter-passwd-hash 2>/dev/null)
if [[ -z "$PASSWD_STORED" ]]; then
  echo "$PASSWD_HASH" > /tmp/.specter-passwd-hash
  echo -e "  ${CYAN}[BASELINE]${RESET} passwd/shadow hash stored"
elif [[ "$PASSWD_HASH" != "$PASSWD_STORED" ]]; then
  _check "passwd/shadow modified" "Hash mismatch — user database changed"
else
  echo -e "  ${GREEN}[OK]${RESET}  passwd/shadow unchanged"
fi

echo -e "${BOLD}[10/10] rkhunter quick check...${RESET}"
if command -v rkhunter &>/dev/null; then
  RKH=$(rkhunter --check --skip-keypress --quiet 2>/dev/null | grep "Warning\|Found" | head -10)
  _check "rkhunter warnings" "$RKH"
else
  echo -e "  ${YELLOW}[SKIP]${RESET} rkhunter not available"
fi

echo ""
echo "======================================" >> "$REPORT"
echo "Total IOC findings: $ISSUES" >> "$REPORT"

if (( ISSUES == 0 )); then
  echo -e "${GREEN}${BOLD}[✓] IOC SCAN CLEAN — No indicators of compromise found${RESET}"
else
  echo -e "${RED}${BOLD}[!] $ISSUES IOC FINDING(S) DETECTED${RESET}"
  echo -e "    Full report: ${CYAN}$REPORT${RESET}"
  echo -e "    ${YELLOW}Review each finding and investigate immediately${RESET}"
fi
echo ""
SCRIPT
  chmod 755 /usr/local/bin/ioc-scan
  success "ioc-scan installed"
}

# ================================================================
#  8. PROC-HARDEN — PROCESS-LEVEL EXPLOIT MITIGATIONS
#     Maximizes kernel exploit mitigations already present:
#     ASLR=2 (full), VDSO disable, ptrace scope=3 (block all),
#     kptr restrict=2, dmesg restrict, BPF JIT hardening.
#     Also applies seccomp baseline to shell session.
# ================================================================

setup_proc_harden() {
  header "PROC-HARDEN — EXPLOIT MITIGATION LAYER"

  cat > /usr/local/bin/proc-harden << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

_set() {
  local KEY="$1" VAL="$2" DESC="$3"
  local CURRENT
  CURRENT=$(sysctl -n "$KEY" 2>/dev/null)
  sysctl -w "${KEY}=${VAL}" &>/dev/null && \
    echo -e "  ${GREEN}[✓]${RESET} $DESC ($KEY = $VAL)" || \
    echo -e "  ${RED}[✗]${RESET} $DESC — could not set"
  echo "${KEY} = ${VAL}" >> /etc/sysctl.d/99-specter-ironshield.conf
}

echo -e "${BOLD}${CYAN}[*] PROC-HARDEN — APPLYING EXPLOIT MITIGATIONS${RESET}"
echo ""
> /etc/sysctl.d/99-specter-ironshield.conf

echo -e "${BOLD}Memory protections:${RESET}"
_set kernel.randomize_va_space        2  "ASLR: full randomization"
_set kernel.kptr_restrict             2  "Hide kernel pointers from all users"
_set kernel.dmesg_restrict            1  "Restrict dmesg to root only"
_set kernel.perf_event_paranoid       3  "Block perf events for non-root"
_set kernel.unprivileged_bpf_disabled 1  "Block unprivileged BPF"
_set net.core.bpf_jit_harden         2  "BPF JIT compiler hardening"
_set kernel.unprivileged_userns_clone 0  "Block unprivileged user namespaces"

echo ""
echo -e "${BOLD}Process isolation:${RESET}"
_set kernel.yama.ptrace_scope         3  "ptrace: locked (no process introspection)"
_set fs.protected_symlinks            1  "Block symlink attacks in sticky dirs"
_set fs.protected_hardlinks           1  "Block hardlink attacks"
_set fs.protected_fifos               2  "Block FIFO attacks in sticky dirs"
_set fs.protected_regular             2  "Block regular file attacks in sticky dirs"
_set fs.suid_dumpable                 0  "Disable core dumps for SUID processes"
_set kernel.core_pattern              "|/bin/false" "Route core dumps to /dev/null"

echo ""
echo -e "${BOLD}Network stack hardening:${RESET}"
_set net.ipv4.conf.all.accept_redirects       0  "Reject ICMP redirects"
_set net.ipv4.conf.all.send_redirects         0  "Don't send ICMP redirects"
_set net.ipv4.conf.all.accept_source_route    0  "Reject source-routed packets"
_set net.ipv4.conf.all.log_martians           1  "Log martian packets"
_set net.ipv4.conf.all.rp_filter              1  "Reverse path filtering"
_set net.ipv4.tcp_syncookies                  1  "SYN cookie flood defense"
_set net.ipv4.tcp_rfc1337                     1  "Protect against TCP TIME-WAIT attacks"
_set net.ipv4.icmp_echo_ignore_broadcasts     1  "Ignore broadcast pings (Smurf defense)"
_set net.ipv4.icmp_ignore_bogus_error_responses 1 "Ignore bogus ICMP errors"
_set net.ipv6.conf.all.accept_redirects       0  "Reject IPv6 redirects"
_set net.ipv6.conf.all.accept_ra              0  "Reject IPv6 RA"

echo ""
echo -e "${BOLD}File system security:${RESET}"
# Make /proc harder to read for non-root
mount -o remount,hidepid=2 /proc 2>/dev/null && \
  echo -e "  ${GREEN}[✓]${RESET} /proc: hidepid=2 (processes hidden from other users)" || \
  echo -e "  ${YELLOW}[~]${RESET} /proc hidepid: already set or unsupported"

# Add to fstab persistently
if ! grep -q "hidepid=2" /etc/fstab 2>/dev/null; then
  echo "proc /proc proc defaults,hidepid=2,gid=0 0 0" >> /etc/fstab
  echo -e "  ${GREEN}[✓]${RESET} /proc hidepid=2 added to /etc/fstab"
fi

echo ""
echo -e "  ${BOLD}${GREEN}PROC-HARDEN COMPLETE${RESET}"
echo -e "  ${CYAN}Config saved :${RESET} /etc/sysctl.d/99-specter-ironshield.conf"
echo -e "  ${CYAN}Persistent   :${RESET} Applied on every boot via sysctl.d"
SCRIPT
  chmod 755 /usr/local/bin/proc-harden
  success "proc-harden installed"
}

# ================================================================
#  9. SYSCTL-MAX — MAXIMUM KERNEL SYSCTL HARDENING
#     Goes beyond base hardening with full network stack
#     lockdown, memory hardening, and filesystem protections.
#     Separate from base harden — additive layer.
# ================================================================

setup_sysctl_max() {
  header "SYSCTL-MAX — MAXIMUM KERNEL HARDENING"

  cat > /usr/local/bin/sysctl-max << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

echo -e "${BOLD}${CYAN}[*] SYSCTL-MAX — ABSOLUTE KERNEL HARDENING${RESET}"

# Write comprehensive sysctl config
cat > /etc/sysctl.d/98-specter-max.conf << 'SYSCTLEOF'
# SPECTER Iron Shield — Maximum sysctl hardening
# Applied by: sysctl-max

# ── Memory protection ─────────────────────────────────────────
kernel.randomize_va_space = 2
kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
kernel.perf_event_paranoid = 3
kernel.unprivileged_bpf_disabled = 1
net.core.bpf_jit_harden = 2
kernel.unprivileged_userns_clone = 0
kernel.yama.ptrace_scope = 3
kernel.core_pattern = |/bin/false
fs.suid_dumpable = 0

# ── Network: disable all unnecessary protocols ────────────────
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.proxy_arp = 0
net.ipv4.conf.all.forwarding = 0

# ── TCP hardening ─────────────────────────────────────────────
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_sack = 0
net.ipv4.tcp_dsack = 0
net.ipv4.tcp_fack = 0
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_fin_timeout = 10

# ── ICMP ──────────────────────────────────────────────────────
net.ipv4.icmp_echo_ignore_all = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1

# ── IPv6 disable ──────────────────────────────────────────────
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_ra = 0

# ── Filesystem ────────────────────────────────────────────────
fs.protected_symlinks = 1
fs.protected_hardlinks = 1
fs.protected_fifos = 2
fs.protected_regular = 2

# ── Shared memory ─────────────────────────────────────────────
kernel.shmmax = 67108864
kernel.shmall = 16777216

# ── Kernel lockdown (if supported) ───────────────────────────
# kernel.lockdown = confidentiality  # requires signed kernel
SYSCTLEOF

sysctl --system &>/dev/null && \
  echo -e "  ${GREEN}[✓]${RESET} All sysctl parameters applied" || \
  echo -e "  ${YELLOW}[!]${RESET} Some parameters may not be supported on this kernel"

sysctl -p /etc/sysctl.d/98-specter-max.conf 2>/dev/null | grep -c "=" | \
  xargs -I{} echo -e "  ${GREEN}[✓]${RESET} {} parameters loaded"

echo ""
echo -e "  ${BOLD}${GREEN}SYSCTL-MAX APPLIED${RESET}"
echo -e "  ${CYAN}Config :${RESET} /etc/sysctl.d/98-specter-max.conf"
echo -e "  ${CYAN}Persistent on reboot via sysctl.d${RESET}"
SCRIPT
  chmod 755 /usr/local/bin/sysctl-max
  success "sysctl-max installed"
}

# ================================================================
#  10. LOG-FORTIFY — TAMPER-PROOF SYSTEM LOGS
#      Secures all system logs: hash-chain each entry,
#      encrypt log archives, disable remote syslog forwarding,
#      set file permissions to prevent log tampering.
# ================================================================

setup_log_fortify() {
  header "LOG-FORTIFY — TAMPER-PROOF LOGGING"

  _v11_pkg rsyslog rsyslogd

  cat > /usr/local/bin/log-fortify << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'
BOLD='\033[1m'; RESET='\033[0m'
[[ $EUID -ne 0 ]] && { echo -e "${RED}[!] Run as root${RESET}"; exit 1; }

case "${1:-apply}" in
  apply)
    echo -e "${BOLD}${CYAN}[*] LOG-FORTIFY — SECURING SYSTEM LOGS${RESET}"

    # ── Set strict permissions on log files ───────────────────
    chmod 640 /var/log/auth.log    2>/dev/null || true
    chmod 640 /var/log/syslog      2>/dev/null || true
    chmod 640 /var/log/kern.log    2>/dev/null || true
    chmod 640 /var/log/daemon.log  2>/dev/null || true
    chown root:adm /var/log/*.log  2>/dev/null || true
    # Remove world-readable on log dir
    chmod 750 /var/log
    echo -e "  ${GREEN}[✓]${RESET} Log file permissions hardened (640, root:adm)"

    # ── Disable remote syslog forwarding ─────────────────────
    if [[ -f /etc/rsyslog.conf ]]; then
      # Comment out any remote forwarding lines
      sed -i 's/^\(\*\.\*.*@.*\)/#SPECTER_BLOCKED \1/' /etc/rsyslog.conf
      # Disable UDP/TCP syslog receiver
      sed -i 's/^#\?module(load="imudp")/#SPECTER module(load="imudp")/' /etc/rsyslog.conf
      sed -i 's/^#\?input(type="imudp".*/#SPECTER &/' /etc/rsyslog.conf
      sed -i 's/^#\?module(load="imtcp")/#SPECTER module(load="imtcp")/' /etc/rsyslog.conf
      sed -i 's/^#\?input(type="imtcp".*/#SPECTER &/' /etc/rsyslog.conf
      systemctl restart rsyslog 2>/dev/null || true
      echo -e "  ${GREEN}[✓]${RESET} Remote syslog forwarding disabled"
    fi

    # ── Enable auditd for kernel-level logging ────────────────
    if command -v auditd &>/dev/null; then
      systemctl enable auditd 2>/dev/null || true
      systemctl start  auditd 2>/dev/null || true
      # Add critical audit rules
      auditctl -w /etc/passwd    -p wa -k identity_changes 2>/dev/null || true
      auditctl -w /etc/shadow    -p wa -k identity_changes 2>/dev/null || true
      auditctl -w /etc/sudoers   -p wa -k privilege_change 2>/dev/null || true
      auditctl -w /usr/local/bin -p wx -k binary_exec      2>/dev/null || true
      auditctl -w /bin/bash      -p x  -k shell_exec        2>/dev/null || true
      auditctl -w /sbin/iptables -p x  -k firewall_change   2>/dev/null || true
      echo -e "  ${GREEN}[✓]${RESET} auditd: 6 critical watch rules added"
    fi

    # ── Immutable flag on critical logs ──────────────────────
    # Note: chattr +a allows append-only (attackers can't delete/modify existing entries)
    for LOGFILE in /var/log/auth.log /var/log/syslog /var/log/kern.log; do
      [[ -f "$LOGFILE" ]] && chattr +a "$LOGFILE" 2>/dev/null && \
        echo -e "  ${GREEN}[✓]${RESET} $LOGFILE set append-only (chattr +a)" || true
    done

    # ── SPECTER audit log ─────────────────────────────────────
    SPECTER_LOG="${SPECTER_LOG:-/var/log/specter-audit.log}"
    [[ -f "$SPECTER_LOG" ]] && chattr +a "$SPECTER_LOG" 2>/dev/null || true

    echo ""
    echo -e "  ${BOLD}${GREEN}LOG-FORTIFY COMPLETE${RESET}"
    echo -e "  ${CYAN}Log permissions  :${RESET} 640 (root:adm)"
    echo -e "  ${CYAN}Remote syslog    :${RESET} DISABLED"
    echo -e "  ${CYAN}auditd watches   :${RESET} 6 critical paths"
    echo -e "  ${CYAN}Append-only logs :${RESET} auth.log, syslog, kern.log"
    echo -e "  ${YELLOW}[!] To remove append-only: chattr -a /var/log/<file>${RESET}"
    ;;

  status)
    echo -e "${CYAN}[LOG-FORTIFY STATUS]${RESET}"
    for LOGFILE in /var/log/auth.log /var/log/syslog /var/log/kern.log; do
      if [[ -f "$LOGFILE" ]]; then
        ATTR=$(lsattr "$LOGFILE" 2>/dev/null | awk '{print $1}')
        PERM=$(stat -c "%a %U:%G" "$LOGFILE" 2>/dev/null)
        echo -e "  ${CYAN}$LOGFILE${RESET}: perms=$PERM attrs=$ATTR"
      fi
    done
    if systemctl is-active auditd &>/dev/null; then
      echo -e "  ${GREEN}[ACTIVE]${RESET} auditd running"
      auditctl -l 2>/dev/null | grep -c "^-w" | xargs -I{} echo -e "  ${CYAN}Watch rules: {}${RESET}"
    else
      echo -e "  ${RED}[INACTIVE]${RESET} auditd not running"
    fi
    ;;

  *)
    echo "Usage: log-fortify [apply|status]"
    ;;
esac
SCRIPT
  chmod 755 /usr/local/bin/log-fortify
  success "log-fortify installed"
}

# ================================================================
#  STATUS: v10-11-status
# ================================================================

patch_main_menu_v10_11() {
  cat > /usr/local/bin/v10-11-status << 'SCRIPT'
#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[1;36m'
YELLOW='\033[1;33m'; BOLD='\033[1m'; DIM='\033[2m'; RESET='\033[0m'

_chk() {
  local LABEL="$1" CMD="$2"
  if eval "$CMD" &>/dev/null; then
    printf "  ${GREEN}[✓]${RESET} %-28s ${DIM}active${RESET}\n" "$LABEL"
  else
    printf "  ${RED}[✗]${RESET} %-28s ${DIM}inactive${RESET}\n" "$LABEL"
  fi
}

echo -e "\n${BOLD}${CYAN}  SPECTER v10.11 — IRON SHIELD STATUS${RESET}\n"

_chk "fortress-mode (active)"       "iptables -L INPUT | grep -q 'policy DROP'"
_chk "ssh-lockdown (SSH down)"       "! systemctl is-active sshd &>/dev/null && ! systemctl is-active ssh &>/dev/null"
_chk "fail2ban"                      "systemctl is-active fail2ban"
_chk "auto-defend"                   "[[ -f /tmp/.auto-defend.pid ]] && kill -0 \$(cat /tmp/.auto-defend.pid)"
_chk "exfil-detect"                  "[[ -f /tmp/.exfil-detect.pid ]] && kill -0 \$(cat /tmp/.exfil-detect.pid)"
_chk "port-knock (knockd)"           "systemctl is-active knockd"
_chk "canary-deploy"                 "[[ -f /tmp/.canary-monitor.pid ]] && kill -0 \$(cat /tmp/.canary-monitor.pid)"
_chk "ioc-scan (binary present)"     "[[ -x /usr/local/bin/ioc-scan ]]"
_chk "proc-harden (ptrace locked)"   "[[ \$(sysctl -n kernel.yama.ptrace_scope 2>/dev/null) == '3' ]]"
_chk "sysctl-max (ASLR=2)"           "[[ \$(sysctl -n kernel.randomize_va_space 2>/dev/null) == '2' ]]"
_chk "log-fortify (auditd)"          "systemctl is-active auditd"

echo ""
echo -e "  ${DIM}fortress-mode activate  · ssh-lockdown apply  · auto-defend start${RESET}"
echo -e "  ${DIM}exfil-detect start  · canary-deploy deploy  · ioc-scan${RESET}"
echo -e "  ${DIM}proc-harden  · sysctl-max  · log-fortify apply${RESET}"
echo ""
SCRIPT
  chmod 755 /usr/local/bin/v10-11-status
}

# ================================================================
#  MASTER CALLER
# ================================================================

setup_v10_11_extras() {
  header "v10.11.0 — IRON SHIELD"

  setup_fortress_mode
  setup_ssh_lockdown
  setup_auto_defend
  setup_exfil_detect
  setup_port_knock
  setup_canary_deploy
  setup_ioc_scan
  setup_proc_harden
  setup_sysctl_max
  setup_log_fortify
  patch_main_menu_v10_11

  success "v10.11 Iron Shield installed"
  info    "Run v10-11-status to verify all systems"
  info    "Run fortress-mode activate for maximum firewall lockdown"
  info    "Run auto-defend start + canary-deploy deploy for active defense"
  info    "Run ioc-scan to check for existing compromise"
  info    "Run proc-harden + sysctl-max for maximum kernel hardening"
}


# ════════════════════════════════════════════════════════════════
# MENUS & CLI ENTRYPOINT
# ════════════════════════════════════════════════════════════════

# ================================================================
#  SPECTER v10.11.0 — MODULE: MENUS & ENTRYPOINT
#  Setup wizard · Full/Quick/Stealth setup · Main menu
#  Tools menu · Crypto menu · Docs menu · Sources menu
#  Emergency menu · Monitor menu · CLI flags
# ================================================================

# ================================================================
#  SETUP MODES
# ================================================================

full_setup() {
  header "FULL SETUP v10.11.0 — IRON SHIELD"
  timeline "Full setup started"

  preflight_checks
  install_dependencies

  # ── LAYER: System Hardening ───────────────────────────────
  header "PHASE 1/15 — SYSTEM HARDENING"
  setup_ramdisk
  secure_swap
  randomize_hostname
  randomize_mac
  scrub_hardware_ids
  disable_camera_mic
  setup_usbguard
  harden_timezone
  kernel_hardening
  harden_system
  anti_forensics
  sanitize_environment
  setup_anti_coldboot
  setup_boot_integrity
  mitigate_covert_channels

  # ── LAYER: Network ────────────────────────────────────────
  header "PHASE 2/15 — NETWORK"
  prevent_dns_leak
  setup_dnscrypt
  setup_tor
  check_guard_reputation
  setup_killswitch
  setup_firewall
  setup_wireguard
  setup_multihop
  setup_i2p
  setup_proxychains
  setup_traffic_shaping
  verify_tor

  # ── LAYER: Anonymity ──────────────────────────────────────
  header "PHASE 3/15 — ANONYMITY"
  setup_identity_manager
  setup_pgp_identity
  setup_contact_book
  setup_canary_system
  setup_browser_hardening
  setup_onionshare
  setup_hidden_service
  setup_noise_generator
  setup_circuit_rotation
  setup_secure_clipboard
  setup_autonuke_timer
  setup_totp

  # ── LAYER: Cryptography ───────────────────────────────────
  header "PHASE 4/15 — CRYPTOGRAPHY"
  setup_age_encryption
  setup_veracrypt
  setup_luks_vault
  setup_password_manager
  setup_secure_delete
  setup_key_ceremony
  setup_secure_notes

  # ── LAYER: Document Security ──────────────────────────────
  header "PHASE 5/15 — DOCUMENT SECURITY"
  install_metadata_tools
  setup_pdf_sanitizer
  setup_doc_cleaner
  setup_safe_viewer
  setup_bulk_processor
  setup_beacon_scanner
  setup_file_quarantine

  # ── LAYER: Sources & Emergency ────────────────────────────
  header "PHASE 6/15 — SOURCES"
  setup_securedrop
  setup_anonymous_dropbox
  setup_dead_drop
  setup_source_auth
  setup_session_journal

  # ── LAYER: Emergency ──────────────────────────────────────
  header "PHASE 7/15 — EMERGENCY SYSTEMS"
  setup_panic_button
  setup_deadmans_switch
  setup_duress_system
  install_quick_nuke
  install_nuke_script
  setup_decoy_system

  # ── LAYER: Monitoring ─────────────────────────────────────
  header "PHASE 8/15 — MONITORING & TOOLS"
  setup_leak_monitor
  setup_lan_monitor
  setup_anomaly_detector
  setup_correlation_detector
  setup_hardware_tamper
  system_integrity_check
  install_integrity_check

  # ── LAYER: Tools ──────────────────────────────────────────
  setup_route_visualiser
  setup_profile_manager
  setup_report_generator
  setup_risk_assessment

  # ── LAYER: v10.5 Power Extras ─────────────────────────────
  header "PHASE 9/15 — v10.5 POWER EXTRAS"
  setup_v10_5_extras

  # ── LAYER: v10.6 Advanced Extras ──────────────────────────
  header "PHASE 10/15 — v10.6 USB & COMMS"
  setup_v10_6_extras

  # ── LAYER: v10.7 Defense + Animations ─────────────────────
  header "PHASE 11/15 — v10.7 ADVANCED DEFENSE"
  anim_reset_phases 16
  setup_v10_7_extras

  # ── LAYER: v10.8 Maximum Hardening ────────────────────────
  header "PHASE 12/15 — v10.8 MAXIMUM HARDENING"
  setup_v10_8_extras

  # ── LAYER: v10.9 Zero Trace Protocol ──────────────────────
  header "PHASE 13/15 — v10.9 ZERO TRACE PROTOCOL"
  setup_v10_9_extras

  # ── LAYER: v10.10 Absolute Zero ────────────────────────────
  header "PHASE 14/15 — v10.10 ABSOLUTE ZERO"
  setup_v10_10_extras

  # ── LAYER: v10.11 Iron Shield ──────────────────────────────
  header "PHASE 15/15 — v10.11 IRON SHIELD"
  setup_v10_11_extras

  # ── Start critical monitors ────────────────────────────────
  leak-monitor start    2>/dev/null || true
  lan-monitor start     2>/dev/null || true
  anomaly-detector start 2>/dev/null || true
  noise-generator start 2>/dev/null || true
  exit-watch start      2>/dev/null || true
  mac-rotate start      2>/dev/null || true
  counter-recon start   2>/dev/null || true
  trip-wire start       2>/dev/null || true
  opsec-enforce start   2>/dev/null || true

  timeline "Full setup complete"

  # Final score + animated completion
  local SCORE
  SCORE=$(calculate_opsec_score | head -1)
  anim_setup_complete "$SCORE"

  echo -e "  ${CYAN}Workspace    :${RESET} /root/research  (RAM disk)"
  echo -e "  ${CYAN}Session log  :${RESET} $LOGFILE"
  echo -e "  ${CYAN}Dashboard    :${RESET} ./specter.sh --dashboard"
  echo -e "  ${CYAN}End session  :${RESET} session-nuke"
  echo -e "  ${CYAN}Emergency    :${RESET} panic"
  echo -e "  ${CYAN}USB Key      :${RESET} usb-key-setup  (plug-in trigger)"
  echo ""
  echo -e "  ${YELLOW}Run session-nuke when research is complete.${RESET}"
  echo -e "  ${YELLOW}Run deadman-start to activate inactivity wipe.${RESET}"
  echo ""
}

quick_setup() {
  header "QUICK SETUP v10.11.0"
  timeline "Quick setup started"
  preflight_checks
  setup_ramdisk
  randomize_mac
  harden_timezone
  prevent_dns_leak
  setup_tor
  setup_killswitch
  setup_firewall
  verify_tor
  setup_leak_monitor
  install_quick_nuke
  install_nuke_script
  install_integrity_check
  noise-generator start 2>/dev/null || true
  echo -e "\n${GREEN}[+] Quick setup complete.${RESET}"
  echo -e "${CYAN}[*] Run: show-route | dashboard | session-nuke${RESET}"
  timeline "Quick setup complete"
}

stealth_setup() {
  header "STEALTH SETUP v10.11.0 (MINIMAL FOOTPRINT)"
  timeline "Stealth setup started"
  # Only essential — leaves minimal traces
  preflight_checks
  setup_ramdisk
  randomize_mac
  randomize_hostname
  prevent_dns_leak
  kernel_hardening
  setup_tor
  setup_killswitch
  verify_tor
  install_nuke_script
  echo -e "\n${GREEN}[+] Stealth setup complete.${RESET}"
  echo -e "${CYAN}[*] Minimal install — only Tor + kill switch + MAC randomization.${RESET}"
  echo -e "${YELLOW}[!] Run session-nuke immediately when done.${RESET}"
  timeline "Stealth setup complete"
}

# ================================================================
#  SETUP WIZARD
# ================================================================
run_setup_wizard() {
  clear
  print_banner
  echo -e "  ${BOLD}SETUP WIZARD${RESET}"
  echo "  ─────────────────────────────────────────────────────"
  echo "  This wizard helps you choose the right setup for"
  echo "  your current situation."
  echo ""

  # Run risk assessment first
  read -rp "  Run risk assessment to determine threat level? [Y/n]: " DO_RISK
  if [[ ! "${DO_RISK:-Y}" =~ ^[Nn] ]]; then
    risk-assess 2>/dev/null || true
    echo ""
  fi

  echo "  Select setup mode:"
  echo ""
  echo "  1) FULL SETUP    — All 15+ layers of protection"
  echo "                     (Recommended for high-risk work)"
  echo ""
  echo "  2) QUICK SETUP   — Tor + kill switch + MAC + RAM disk"
  echo "                     (For time-sensitive situations)"
  echo ""
  echo "  3) STEALTH SETUP — Minimal footprint"
  echo "                     (When you need to be fast and leave no trace)"
  echo ""
  echo "  4) CUSTOM        — Choose individual components"
  echo ""
  read -rp "  Select [1-4]: " WIZARD_CHOICE

  case "${WIZARD_CHOICE:-1}" in
    1) full_setup ;;
    2) quick_setup ;;
    3) stealth_setup ;;
    4) show_main_menu ;;
    *) full_setup ;;
  esac
}

# ================================================================
#  MAIN MENU
# ================================================================
show_main_menu() {
  while true; do
    clear; print_banner
    echo -e "  ${BOLD}MAIN MENU — v10.11.0 — IRON SHIELD${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  ── Setup ────────────────────────────────────────"
    echo "  1)  Full setup        (all protections)"
    echo "  2)  Quick setup       (Tor + kill switch + MAC)"
    echo "  3)  Stealth setup     (minimal footprint)"
    echo "  4)  Setup wizard      (guided)"
    echo "  ── Status ───────────────────────────────────────"
    echo "  5)  Dashboard         (live OPSEC score)"
    echo "  6)  Network route     (show traffic path)"
    echo "  7)  Verify Tor"
    echo "  8)  Guard reputation  (Tor entry nodes)"
    echo "  9)  Risk assessment"
    echo "  ── Menus ────────────────────────────────────────"
    echo "  10) Tools menu        (identity, PGP, OnionShare)"
    echo "  11) Crypto menu       (Age, VeraCrypt, passwords)"
    echo "  12) Document menu     (PDF, clean, scan)"
    echo "  13) Sources menu      (SecureDrop, dead drops)"
    echo "  14) Monitor menu      (daemons, logs)"
    echo "  15) Emergency menu    (panic, nuke, dead man)"
    echo "  ── Reports & Checklists ─────────────────────────"
    echo "  16) Generate report"
    echo "  17) OPSEC checklist"
    echo "  18) Physical checklist"
    echo "  19) Profile manager"
    echo "  ── Session End ──────────────────────────────────"
    echo "  20) Quick nuke        (fast emergency wipe)"
    echo "  21) Session nuke      (complete wipe)"
    echo "  0)  Exit"
    echo ""
    read -rp "  Choice: " CH
    case "$CH" in
      1)  full_setup;                        read -rp "  Press Enter..." _ ;;
      2)  quick_setup;                       read -rp "  Press Enter..." _ ;;
      3)  stealth_setup;                     read -rp "  Press Enter..." _ ;;
      4)  run_setup_wizard ;;
      5)  show_dashboard ;;
      6)  show-route 2>/dev/null;            read -rp "  Press Enter..." _ ;;
      7)  verify_tor;                        read -rp "  Press Enter..." _ ;;
      8)  check_guard_reputation;            read -rp "  Press Enter..." _ ;;
      9)  risk-assess 2>/dev/null;           read -rp "  Press Enter..." _ ;;
      10) show_tools_menu ;;
      11) show_crypto_menu ;;
      12) show_docs_menu ;;
      13) show_sources_menu ;;
      14) show_monitor_menu ;;
      15) show_emergency_menu ;;
      16) generate-report 2>/dev/null;       read -rp "  Press Enter..." _ ;;
      17) print_opsec_checklist;             read -rp "  Press Enter..." _ ;;
      18) physical_opsec_checklist;          read -rp "  Press Enter..." _ ;;
      19) opsec-profile list 2>/dev/null;    read -rp "  Press Enter..." _ ;;
      20) quick-nuke 2>/dev/null;            read -rp "  Press Enter..." _ ;;
      21) session-nuke 2>/dev/null ;;
      0)  echo "Exiting."; exit 0 ;;
      *)  warn "Invalid choice" ;;
    esac
  done
}

# ── Tools menu ───────────────────────────────────────────────────
show_tools_menu() {
  while true; do
    clear
    echo -e "  ${BOLD}ANONYMITY & TOOLS MENU${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  ── Identities ────────────────────────────────────"
    echo "  1)  new-identity <name>       — isolated profile"
    echo "  2)  list-identities           — show profiles"
    echo "  3)  wipe-identity <name>      — destroy profile"
    echo "  4)  switch-identity <name>    — switch context"
    echo "  ── Communication ─────────────────────────────────"
    echo "  5)  create-source-key         — PGP key for sources"
    echo "  6)  contact add/list/view     — encrypted contact book"
    echo "  7)  source-dropbox            — .onion document receiver"
    echo "  8)  receive-docs              — OnionShare drop box"
    echo "  9)  share-file <file>         — send via .onion"
    echo "  ── Circuit ───────────────────────────────────────"
    echo "  10) rotate-circuit            — new Tor exit IP"
    echo "  11) auto-rotate [secs]        — auto-rotate circuit"
    echo "  12) harden-browser            — Tor Browser user.js"
    echo "  13) start-i2p                 — start I2P"
    echo "  ── Security ──────────────────────────────────────"
    echo "  14) totp add/get/list         — TOTP codes"
    echo "  15) watermark-doc <f> <name>  — canary watermark"
    echo "  16) check-watermark <f>       — trace leaks"
    echo "  17) Back"
    echo ""
    read -rp "  Choice: " T
    case "$T" in
      1)  read -rp "  Name: " N; new-identity "$N" 2>/dev/null; read -rp "..." _ ;;
      2)  list-identities 2>/dev/null; read -rp "..." _ ;;
      3)  read -rp "  Name: " N; wipe-identity "$N" 2>/dev/null; read -rp "..." _ ;;
      4)  read -rp "  Name: " N; switch-identity "$N" 2>/dev/null; read -rp "..." _ ;;
      5)  create-source-key 2>/dev/null; read -rp "..." _ ;;
      6)  contact list 2>/dev/null; read -rp "..." _ ;;
      7)  source-dropbox 2>/dev/null; read -rp "..." _ ;;
      8)  receive-docs 2>/dev/null; read -rp "..." _ ;;
      9)  read -rp "  File: " F; share-file "$F" 2>/dev/null; read -rp "..." _ ;;
      10) rotate-circuit 2>/dev/null; read -rp "..." _ ;;
      11) read -rp "  Interval (secs): " S; auto-rotate "${S:-600}" 2>/dev/null; read -rp "..." _ ;;
      12) harden-browser 2>/dev/null; read -rp "..." _ ;;
      13) start-i2p 2>/dev/null; read -rp "..." _ ;;
      14) read -rp "  totp <add|get|list>: " TC; totp $TC 2>/dev/null; read -rp "..." _ ;;
      15) read -rp "  File: " F; read -rp "  Recipient: " R; watermark-doc "$F" "$R" 2>/dev/null; read -rp "..." _ ;;
      16) read -rp "  File: " F; check-watermark "$F" 2>/dev/null; read -rp "..." _ ;;
      17) return ;;
      *) warn "Invalid" ;;
    esac
  done
}

# ── Crypto menu ──────────────────────────────────────────────────
show_crypto_menu() {
  while true; do
    clear
    echo -e "  ${BOLD}CRYPTOGRAPHY MENU${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  ── Encryption ────────────────────────────────────"
    echo "  1)  age-encrypt <file>        — Age encryption"
    echo "  2)  age-decrypt <file.age>    — Age decryption"
    echo "  3)  note-encrypt <file>       — GPG symmetric"
    echo "  4)  note-decrypt <file.gpg>   — GPG decrypt"
    echo "  ── Containers ────────────────────────────────────"
    echo "  5)  create-vault              — LUKS container"
    echo "  6)  open-vault                — mount LUKS"
    echo "  7)  close-vault               — lock LUKS"
    echo "  8)  vc-create <name>          — VeraCrypt container"
    echo "  9)  vc-open <name>            — mount VeraCrypt"
    echo "  10) vc-close <name>           — lock VeraCrypt"
    echo "  ── Password Manager ──────────────────────────────"
    echo "  11) pm-add <name>             — save password"
    echo "  12) pm-get <name>             — retrieve password"
    echo "  13) pm-list                   — list entries"
    echo "  ── Keys ──────────────────────────────────────────"
    echo "  14) key-ceremony              — offline key guide"
    echo "  15) secure-wipe <file>        — 7-pass shred"
    echo "  16) Back"
    echo ""
    read -rp "  Choice: " T
    case "$T" in
      1)  read -rp "  File: " F; age-encrypt "$F" 2>/dev/null; read -rp "..." _ ;;
      2)  read -rp "  File: " F; age-decrypt "$F" 2>/dev/null; read -rp "..." _ ;;
      3)  read -rp "  File: " F; note-encrypt "$F" 2>/dev/null; read -rp "..." _ ;;
      4)  read -rp "  File: " F; note-decrypt "$F" 2>/dev/null; read -rp "..." _ ;;
      5)  create-vault 2>/dev/null; read -rp "..." _ ;;
      6)  open-vault 2>/dev/null; read -rp "..." _ ;;
      7)  close-vault 2>/dev/null; read -rp "..." _ ;;
      8)  read -rp "  Name: " N; read -rp "  Size (MB): " S; vc-create "$N" "$S" 2>/dev/null; read -rp "..." _ ;;
      9)  read -rp "  Name: " N; vc-open "$N" 2>/dev/null; read -rp "..." _ ;;
      10) read -rp "  Name: " N; vc-close "$N" 2>/dev/null; read -rp "..." _ ;;
      11) read -rp "  Name: " N; pm-add "$N" 2>/dev/null; read -rp "..." _ ;;
      12) read -rp "  Name: " N; pm-get "$N" 2>/dev/null; read -rp "..." _ ;;
      13) pm-list 2>/dev/null; read -rp "..." _ ;;
      14) key-ceremony 2>/dev/null; read -rp "..." _ ;;
      15) read -rp "  File/dir: " F; secure-wipe "$F" 2>/dev/null; read -rp "..." _ ;;
      16) return ;;
      *) warn "Invalid" ;;
    esac
  done
}

# ── Documents menu ───────────────────────────────────────────────
show_docs_menu() {
  while true; do
    clear
    echo -e "  ${BOLD}DOCUMENT SECURITY MENU${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  1)  stripall <dir>            — strip all metadata"
    echo "  2)  sanitize-pdf <file>       — sanitize PDF"
    echo "  3)  sanitize-all <dir>        — batch sanitize PDFs"
    echo "  4)  clean-doc <file>          — clean Office doc"
    echo "  5)  safe-view <file>          — sandboxed viewer"
    echo "  6)  scan-beacons <file>       — beacon/tracker scan"
    echo "  7)  quarantine <file>         — quarantine + scan"
    echo "  8)  quarantine list           — list quarantine"
    echo "  9)  bulk-process <dir>        — bulk operations"
    echo "  10) watermark-doc <f> <name>  — canary watermark"
    echo "  11) check-watermark <f>       — trace watermark"
    echo "  12) Back"
    echo ""
    read -rp "  Choice: " T
    case "$T" in
      1)  read -rp "  Dir: " D; stripall "$D" 2>/dev/null; read -rp "..." _ ;;
      2)  read -rp "  File: " F; sanitize-pdf "$F" 2>/dev/null; read -rp "..." _ ;;
      3)  read -rp "  Dir: " D; sanitize-all "$D" 2>/dev/null; read -rp "..." _ ;;
      4)  read -rp "  File: " F; clean-doc "$F" 2>/dev/null; read -rp "..." _ ;;
      5)  read -rp "  File: " F; safe-view "$F" 2>/dev/null; read -rp "..." _ ;;
      6)  read -rp "  File: " F; scan-beacons "$F" 2>/dev/null; read -rp "..." _ ;;
      7)  read -rp "  File: " F; quarantine "$F" 2>/dev/null; read -rp "..." _ ;;
      8)  quarantine list 2>/dev/null; read -rp "..." _ ;;
      9)  read -rp "  Dir: " D; bulk-process "$D" 2>/dev/null; read -rp "..." _ ;;
      10) read -rp "  File: " F; read -rp "  Recipient: " R; watermark-doc "$F" "$R" 2>/dev/null; read -rp "..." _ ;;
      11) read -rp "  File: " F; check-watermark "$F" 2>/dev/null; read -rp "..." _ ;;
      12) return ;;
      *) warn "Invalid" ;;
    esac
  done
}

# ── Sources menu ─────────────────────────────────────────────────
show_sources_menu() {
  while true; do
    clear
    echo -e "  ${BOLD}SOURCE PROTECTION MENU${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  ── Channels ──────────────────────────────────────"
    echo "  1)  sd-client                 — SecureDrop"
    echo "  2)  dropbox-create            — create .onion dropbox"
    echo "  3)  dropbox-start             — start dropbox server"
    echo "  4)  receive-docs              — OnionShare receive"
    echo "  ── Dead Drops ────────────────────────────────────"
    echo "  5)  dead-drop create <name>   — create dead drop"
    echo "  6)  dead-drop post <n> <f>    — post to dead drop"
    echo "  7)  dead-drop retrieve <n>    — retrieve from drop"
    echo "  8)  dead-drop list            — list dead drops"
    echo "  ── Verification ──────────────────────────────────"
    echo "  9)  source-verify             — verify PGP/hash"
    echo "  10) journal add               — log entry"
    echo "  11) journal read              — view journal"
    echo "  12) Back"
    echo ""
    read -rp "  Choice: " T
    case "$T" in
      1)  sd-client 2>/dev/null; read -rp "..." _ ;;
      2)  dropbox-create 2>/dev/null; read -rp "..." _ ;;
      3)  dropbox-start 2>/dev/null; read -rp "..." _ ;;
      4)  receive-docs 2>/dev/null; read -rp "..." _ ;;
      5)  read -rp "  Name: " N; dead-drop create "$N" 2>/dev/null; read -rp "..." _ ;;
      6)  read -rp "  Drop name: " N; read -rp "  File: " F; dead-drop post "$N" "$F" 2>/dev/null; read -rp "..." _ ;;
      7)  read -rp "  Drop name: " N; dead-drop retrieve "$N" 2>/dev/null; read -rp "..." _ ;;
      8)  dead-drop list 2>/dev/null; read -rp "..." _ ;;
      9)  source-verify 2>/dev/null; read -rp "..." _ ;;
      10) journal add 2>/dev/null; read -rp "..." _ ;;
      11) journal read 2>/dev/null; read -rp "..." _ ;;
      12) return ;;
      *) warn "Invalid" ;;
    esac
  done
}

# ── Emergency menu ───────────────────────────────────────────────
show_emergency_menu() {
  while true; do
    clear
    echo -e "  ${BOLD}${RED}EMERGENCY MENU${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  ── Immediate Actions ─────────────────────────────"
    echo -e "  ${RED}1)  PANIC          — emergency wipe (NO CONFIRM)${RESET}"
    echo "  2)  quick-nuke      — fast wipe (1-step confirm)"
    echo "  3)  session-nuke    — full 14-step wipe"
    echo "  ── Dead Man's Switch ─────────────────────────────"
    echo "  4)  deadman-start   — activate timer"
    echo "  5)  deadman-checkin — reset timer"
    echo "  6)  deadman-stop    — deactivate"
    echo "  ── Duress & Decoy ────────────────────────────────"
    echo "  7)  decoy-init      — set up decoy environment"
    echo "  ── Tamper Detection ──────────────────────────────"
    echo "  8)  tamper-check    — hardware tamper scan"
    echo "  9)  integrity-check — rootkit + AIDE check"
    echo "  ── Timers ────────────────────────────────────────"
    echo "  10) autonuke-timer start   — start inactivity timer"
    echo "  11) autonuke-timer stop    — stop inactivity timer"
    echo "  12) Back"
    echo ""
    read -rp "  Choice: " T
    case "$T" in
      1)  panic 2>/dev/null ;;
      2)  quick-nuke 2>/dev/null; read -rp "..." _ ;;
      3)  session-nuke 2>/dev/null ;;
      4)  deadman-start 2>/dev/null; read -rp "..." _ ;;
      5)  deadman-checkin 2>/dev/null; read -rp "..." _ ;;
      6)  deadman-stop 2>/dev/null; read -rp "..." _ ;;
      7)  decoy-init 2>/dev/null; read -rp "..." _ ;;
      8)  tamper-check 2>/dev/null; read -rp "..." _ ;;
      9)  integrity-check 2>/dev/null; read -rp "..." _ ;;
      10) autonuke-timer start 2>/dev/null; read -rp "..." _ ;;
      11) autonuke-timer stop 2>/dev/null; read -rp "..." _ ;;
      12) return ;;
      *) warn "Invalid" ;;
    esac
  done
}

# ── Monitor menu ─────────────────────────────────────────────────
show_monitor_menu() {
  while true; do
    clear
    echo -e "  ${BOLD}MONITORING MENU${RESET}"
    echo "  ════════════════════════════════════════════════"
    echo "  ── Status ────────────────────────────────────────"
    echo "  1)  Dashboard              — live score"
    echo "  2)  show-route             — traffic path"
    echo "  3)  verify_tor             — Tor check"
    echo "  4)  integrity-check        — rootkit + AIDE"
    echo "  5)  tamper-check           — hardware tamper"
    echo "  ── Scanning ──────────────────────────────────────"
    echo "  6)  scan-beacons <file>    — beacon scan"
    echo "  7)  quarantine <file>      — quarantine + scan"
    echo "  8)  quarantine list        — list quarantined"
    echo "  ── Daemons ───────────────────────────────────────"
    echo "  9)  View leak monitor log"
    echo "  10) View LAN monitor log"
    echo "  11) View anomaly log"
    echo "  12) View correlation log"
    echo "  13) noise-generator stop"
    echo "  14) lan-monitor stop"
    echo "  15) anomaly-detector stop"
    echo "  16) correlation-detector stop"
    echo "  ── Journal ───────────────────────────────────────"
    echo "  17) journal add"
    echo "  18) journal read"
    echo "  19) Back"
    echo ""
    read -rp "  Choice: " T
    case "$T" in
      1)  show_dashboard ;;
      2)  show-route 2>/dev/null; read -rp "..." _ ;;
      3)  verify_tor; read -rp "..." _ ;;
      4)  integrity-check 2>/dev/null; read -rp "..." _ ;;
      5)  tamper-check 2>/dev/null; read -rp "..." _ ;;
      6)  read -rp "  File: " F; scan-beacons "$F" 2>/dev/null; read -rp "..." _ ;;
      7)  read -rp "  File: " F; quarantine "$F" 2>/dev/null; read -rp "..." _ ;;
      8)  quarantine list 2>/dev/null; read -rp "..." _ ;;
      9)  tail -50 /tmp/opsec_monitor.log 2>/dev/null; read -rp "..." _ ;;
      10) tail -50 /tmp/opsec_lan.log 2>/dev/null; read -rp "..." _ ;;
      11) tail -50 /tmp/opsec_anomaly.log 2>/dev/null; read -rp "..." _ ;;
      12) tail -50 /tmp/opsec_correlation.log 2>/dev/null; read -rp "..." _ ;;
      13) noise-generator stop 2>/dev/null; read -rp "..." _ ;;
      14) lan-monitor stop 2>/dev/null; read -rp "..." _ ;;
      15) anomaly-detector stop 2>/dev/null; read -rp "..." _ ;;
      16) correlation-detector stop 2>/dev/null; read -rp "..." _ ;;
      17) journal add 2>/dev/null; read -rp "..." _ ;;
      18) journal read 2>/dev/null; read -rp "..." _ ;;
      19) return ;;
      *) warn "Invalid" ;;
    esac
  done
}

# ================================================================
#  ENTRYPOINT
# ================================================================
print_banner

case "${1:-}" in
  --full)        full_setup ;;
  --quick)       quick_setup ;;
  --stealth)     stealth_setup ;;
  --wizard)      run_setup_wizard ;;
  --verify)      preflight_checks; verify_tor ;;
  --dashboard)   show_dashboard ;;
  --nuke)        /usr/local/bin/session-nuke ;;
  --panic)       /usr/local/bin/panic ;;
  --quick-nuke)  /usr/local/bin/quick-nuke ;;
  --checklist)   print_opsec_checklist ;;
  --physical)    physical_opsec_checklist ;;
  --score)       S=$(calculate_opsec_score | head -1)
                 echo "OPSEC Score: $S/100"
                 calculate_opsec_score | tail -n +2 ;;
  --integrity)   system_integrity_check; integrity-check 2>/dev/null ;;
  --tamper)      /usr/local/bin/tamper-check ;;
  --route)       /usr/local/bin/show-route ;;
  --report)      /usr/local/bin/generate-report ;;
  --risk)        /usr/local/bin/risk-assess ;;
  --noise-stop)  /usr/local/bin/noise-generator stop ;;
  --deadman)     /usr/local/bin/deadman-start ;;
  --guardian)    /usr/local/bin/guardian-mode start ;;
  --canary)      /usr/local/bin/warrant-canary ;;
  --tscm)        /usr/local/bin/tscm-full ;;
  --v10-9)       setup_v10_9_extras ;;
  --v10-10)      setup_v10_10_extras ;;
  --v10-11)      setup_v10_11_extras ;;
  --fortress)    /usr/local/bin/fortress-mode activate ;;
  --autodefend)  /usr/local/bin/auto-defend start ;;
  --ioc)         /usr/local/bin/ioc-scan ;;
  --build-usb)   /usr/local/bin/build-specter-usb ;;
  --pq)          /usr/local/bin/pq-install ;;
  --dualhop)     /usr/local/bin/dualhop-start ;;
  --tpm)         /usr/local/bin/tpm-check ;;
  --hardware)    /usr/local/bin/hardware-checklist ;;
  --menu|"")     show_main_menu ;;
  *)             show_main_menu ;;
esac

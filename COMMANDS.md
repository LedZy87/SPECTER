# Complete Command Reference — SPECTER v10.11.0

> Made by **LedZy**

All commands installed after running `sudo bash specter.sh --full`

---

## System Status & Health

| Command | Description |
|---|---|
| `opsec-status` | 12-point instant health indicator |
| `leak-test` | One-shot DNS / IP / IPv6 / WebRTC / swap leak check |
| `opsec-score` | Calculate OPSEC score (0–100) |
| `integrity-check` | rkhunter + chkrootkit + AIDE + port scan |
| `tamper-check` | Hardware tamper: PCI/USB baseline, dmesg, Secure Boot |
| `lockdown-status` | Show all kernel security parameters |
| `entropy-status` | Cryptographic RNG health check |
| `supply-check` | GPG + debsums + rootkit verification |
| `audit-verify` | Verify HMAC-chained tamper-evident audit log |
| `verify-tools` | SHA256 tamper-check on all critical binaries |
| `v10-6-status` | v10.6 features status |
| `v10-7-status` | v10.7 features status |
| `v10-8-status` | v10.8 features status |
| `v10-9-status` | v10.9 Zero Trace Protocol features status |
| `v10-10-status` | v10.10 Absolute Zero features status |
| `v10-11-status` | v10.11 Iron Shield features status |

---

## Network & Tor

| Command | Description |
|---|---|
| `circuit-status` | Active Tor circuits and stream isolation ports |
| `bridge-select` | Choose bridge: obfs4 / Snowflake / meek-azure / direct |
| `bridge-status` | Show current bridge configuration |
| `exit-watch start/stop` | Monitor Tor exit for circuit hijacking |
| `bad-exit-block` | Block known malicious Tor exit nodes |
| `exit-autoupdate now/log/status` | Manage bad-exit cron refresh |
| `leak-monitor start/stop/status` | DNS / IP / iptables leak daemon |
| `lan-monitor start/stop/status` | LAN anomaly detection daemon |
| `anomaly-detector start/stop` | Connection spike / process monitoring |
| `correlation-detector start/stop` | Guard node / timing correlation detection |
| `noise-generator start/stop` | Background Tor traffic noise |
| `traffic-pad start/stop/status` | 80ms±30ms jitter + MTU normalization |
| `mac-rotate start/stop/now/log` | Periodic MAC re-randomization daemon |
| `ntp-sync` | Sync system clock via Tor only |
| `honeypot-check` | DNS hijack + ARP spoof + MITM + timing detection |
| `counter-recon start/stop/log` | Live port scan + ARP probe detection |
| `net-wipe` | Flush ARP / DNS / conntrack / routing traces |
| `os-spoof windows/macos/restore` | TCP/IP fingerprint spoofing |
| `decoy-traffic start/stop/log` | Cover traffic via Tor (anti-analysis) |
| `transport-rotate now/start/stop/status/log` | Auto-cycle pluggable transports (obfs4/Snowflake/meek) |
| `ns-isolate start/exec/stop/list` | Per-app kernel network namespace — all traffic via Tor |

---

## v10.9 — Zero Trace Protocol

| Command | Description |
|---|---|
| `vanguards-install` | Install Vanguards addon (Tor guard rotation defense) |
| `vanguards-status` | Check Vanguards daemon status + log |
| `transport-rotate now` | Immediately rotate to next pluggable transport |
| `transport-rotate start/stop/status/log` | Auto-rotate transport daemon (30-90 min cycle) |
| `ns-isolate start [name]` | Create network namespace routing all traffic via Tor |
| `ns-isolate exec [name] <cmd>` | Run command in isolated namespace |
| `ns-isolate stop [name]` | Destroy network namespace |
| `ns-isolate list` | List all active SPECTER namespaces |
| `compartment-create <name>` | Create isolated browser session (own Tor SocksPort) |
| `compartment-start <name>` | Launch browser in compartment (Firejail + isolated circuit) |
| `compartment-list` | List all browser compartments |
| `compartment-wipe <name>` | Securely wipe compartment + release Tor port |
| `warrant-canary` | Check warrant canary pages via Tor (7 services) |
| `secureboot-check` | UEFI Secure Boot state + bootloader/kernel integrity |
| `secureboot-baseline-reset` | Reset boot integrity baseline after update |
| `mem-forensics-defense` | Apply kernel memory anti-forensics hardening |
| `noise-upgrade start/stop/status/log` | Human-pattern cover traffic (burst+quiet cycle) |
| `tscm-full` | Full TSCM: BLE scan + NFC + SDR wideband + physical checklist |
| `guardian-mode start` | Activate ALL protection layers simultaneously |
| `guardian-mode stop` | Deactivate all Guardian Mode daemons |
| `guardian-mode status` | Show status of all protection layers |

---

## v10.10 — Absolute Zero

| Command | Description |
|---|---|
| `build-specter-usb` | Build bootable Debian Live USB (amnesic, SPECTER pre-installed, zero host traces) |
| `pq-install` | Install Open Quantum Safe liboqs + Python bindings (post-quantum cryptography) |
| `pq-keygen` | Generate Kyber-1024 (encryption) + Dilithium3 (signing) NIST PQC keypair |
| `pq-encrypt <file>` | Post-quantum encrypt: Kyber-1024 KEM + AES-256-GCM hybrid encryption |
| `pq-decrypt <file.pqenc>` | Post-quantum decrypt using Kyber-1024 private key |
| `dualhop-start` | Start I2P daemon + configure proxychains4 for I2P → Tor dual chain |
| `dualhop-exec <cmd>` | Execute command through I2P → Tor (adversary must compromise both networks) |
| `dualhop-status` | Show I2P + Tor dual-hop routing status |
| `dualhop-stop` | Stop I2P daemon |
| `tpm-check` | Verify TPM 2.0 chip present + show current PCR state |
| `tpm-seal <secret>` | Seal secret to hardware boot state (PCRs 0,1,2,3,4,7) — survives only clean boots |
| `tpm-unseal` | Unseal secret (fails if BIOS/bootloader/kernel modified or booted from USB) |
| `yubikey-setup` | Configure YubiKey challenge-response for LUKS volume unlock + sudo authentication |
| `yubikey-status` | Show YubiKey authentication configuration status |
| `hardware-checklist` | Exact hardware buy list (Purism/ThinkPad/RTL-SDR/YubiKey) + 9-step hardened procedure |
| `v10-10-status` | v10.10 Absolute Zero features status |

---

## v10.11 — Iron Shield

| Command | Description |
|---|---|
| `fortress-mode activate` | Whitelist-only iptables: zero inbound, Tor-only outbound, full IPv6 block |
| `fortress-mode off` | Deactivate fortress firewall |
| `fortress-mode status` | Show current fortress firewall state |
| `ssh-lockdown apply` | Disable SSH daemon + block port 22 + fail2ban 2-strike 30-day ban |
| `ssh-lockdown status` | Show SSH lockdown state |
| `auto-defend start/stop/status/log` | Real-time attack daemon: auto-block IPs, rotate Tor circuit, ARP spoof detection |
| `auto-defend unblock <IP>` | Remove an IP from auto-defend block list |
| `exfil-detect start/stop/status/log` | Monitor outbound traffic for exfiltration (large uploads, DNS tunnel, ICMP exfil) |
| `port-knock start/stop/status/sequence` | Port knocking gate (random sequence) for any authorized remote access |
| `canary-deploy deploy/stop/status/log` | Deploy honeypot files (fake creds/keys/DBs) + inotify monitor that alerts on access |
| `ioc-scan` | Full indicators-of-compromise scan: hidden procs, SUID changes, new kernel modules, persistence |
| `proc-harden` | Apply ASLR=2, ptrace=3, kptr restrict, BPF JIT hardening, /proc hidepid=2 |
| `sysctl-max` | Maximum kernel sysctl: all TCP/network/ICMP/IPv6/memory hardening |
| `log-fortify apply` | Lock down log permissions, disable remote syslog, enable auditd, set append-only |
| `log-fortify status` | Show log fortification state |
| `v10-11-status` | Iron Shield features status |

---

## Browser & Communications

| Command | Description |
|---|---|
| `tb-install` | Download + GPG-verify Tor Browser (official) |
| `tb-start` | Launch Tor Browser (RAM profile, Safest level, JS off) |
| `browser-jail` | Firefox in Firejail + Tor SOCKS5 + RAM profile |
| `harden-browser` | Install hardened Firefox user.js |
| `comms-setup` | Configure Matrix client over Tor (WeeChat) |
| `comms-start` | Launch Matrix client |
| `voice-setup` | Configure Mumble for encrypted voice over Tor |
| `voice-start` | Launch Mumble over Tor |
| `airgap-send <file>` | Encrypt + split file into QR codes (zero network) |
| `airgap-receive` | Scan QR codes and reassemble file |
| `steg-hide <img> <file>` | Embed file inside innocent image (steghide) |
| `steg-reveal <img>` | Extract hidden file from image |

---

## Document Security

| Command | Description |
|---|---|
| `metadata-check <file/dir>` | Scan for identity / location / device metadata |
| `stripall <file>` | Strip all metadata (exiftool) |
| `sanitize-pdf <file>` | Full PDF sanitization (qpdf + exiftool + mat2) |
| `sanitize-all <dir>` | Batch sanitize all files in directory |
| `clean-doc <file>` | Strip metadata from .docx / .odt |
| `safe-view <file>` | Open file in Firejail (no network, no write) |
| `bulk-process` | Interactive batch document processor |
| `scan-beacons <dir>` | Scan for tracking URLs, pixels, UUIDs, JS, GPS |
| `dots-check <file>` | Detect printer tracking dots (deda) |
| `dots-strip <file>` | Attempt to mask printer tracking dots |
| `quarantine <file>` | Move file to isolated quarantine |
| `auto-quarantine start` | Watch downloads dir, auto-quarantine new files |
| `usb-safe <device>` | Mount USB isolated, ClamAV scan, copy to RAM disk |
| `watermark-doc <file>` | Add invisible canary watermark |
| `check-watermark <file>` | Check if file contains your watermark |

---

## Identity & Anonymity

| Command | Description |
|---|---|
| `new-identity <name>` | Create new anonymous identity |
| `list-identities` | List all identities |
| `switch-identity <name>` | Switch active identity |
| `wipe-identity <name>` | Wipe an identity |
| `rotate-circuit` | Force new Tor circuit |
| `auto-rotate start` | Auto-rotate circuits every N minutes |
| `contact` | Encrypted contact book |
| `totp` | TOTP 2FA authenticator |
| `kloak-start` | Keystroke timing anonymization |
| `kloak-stop` | Stop keystroke anonymizer |
| `screen-guard start/stop/status` | Block screenshot tools + framebuffer |

---

## Encryption & Crypto

| Command | Description |
|---|---|
| `age-encrypt <file>` | Encrypt with age (recipient or passphrase) |
| `age-decrypt <file>` | Decrypt age file |
| `create-vault` | Create LUKS2 encrypted container (argon2id) |
| `open-vault` | Unlock LUKS vault |
| `close-vault` | Lock LUKS vault |
| `vc-create` | Create VeraCrypt container |
| `vc-open` | Mount VeraCrypt container |
| `vc-close` | Unmount VeraCrypt container |
| `pm-init` | Initialize encrypted password manager |
| `pm-add <site> <pass>` | Add password (GPG AES256 encrypted) |
| `pm-get <site>` | Get password |
| `pm-list` | List stored sites |
| `secure-wipe <file>` | 7-pass shred deletion |
| `note-encrypt` | Encrypt a note to RAM disk |
| `note-decrypt` | Decrypt note |
| `key-ceremony` | Offline key generation guide |
| `audit-log <msg>` | Add HMAC-signed entry to audit log |

---

## Sources & SecureDrop

| Command | Description |
|---|---|
| `sd-client` | SecureDrop connection guide |
| `dropbox-create` | Create anonymous .onion file dropbox |
| `dropbox-start` | Start anonymous dropbox hidden service |
| `dead-drop create/post/retrieve` | Encrypted dead drop system |
| `source-verify <file/key>` | Verify source PGP key and file authenticity |
| `journal add/read/export/wipe` | Encrypted session journal |

---

## Emergency & Panic

| Command | Description |
|---|---|
| `panic` | Immediate full system wipe (no confirmation) |
| `quick-nuke` | Fast: kill apps + wipe RAM disk + flush iptables |
| `session-nuke` | Full 14-step clean session end |
| `physical-panic` | Webcam intruder photo + alarm + screen lock |
| `physical-panic --nuke` | Same + session nuke |
| `usb-key-setup` | Format USB drive as Dead Man's Key |
| `usb-key-status` | Show key status and last events |
| `opsec-key-insert` | Manually simulate USB plug-in (session start) |
| `opsec-key-remove` | Manually simulate USB pull (session nuke) |
| `deadman-start [minutes]` | Inactivity-based auto-nuke timer |
| `deadman-checkin` | Reset inactivity timer |
| `deadman-stop` | Stop dead man's switch |
| `duress-check` | Check if duress password entered |
| `decoy-init` | Create convincing decoy home directory |

---

## Reports & Assessment

| Command | Description |
|---|---|
| `generate-report` | Full HTML + text OPSEC report |
| `risk-assess` | 13-question threat model assessment |
| `show-route` | ASCII diagram of current traffic path |
| `opsec-profile save/load/list` | Save/load OPSEC configuration profiles |
| `physical-opsec` | Physical security checklist |

---

## Monitoring Daemons

All daemons support: `start` / `stop` / `status` / `log`

| Daemon | What it monitors |
|---|---|
| `leak-monitor` | DNS, Tor process, iptables DROP, IPv6 |
| `lan-monitor` | Gateway MAC, ARP duplicates, promiscuous mode |
| `anomaly-detector` | Connection spikes, networked processes, SUID |
| `correlation-detector` | Circuit count, RTT timing, guard node changes |
| `exit-watch` | Tor exit IP changes (circuit hijack) |
| `mac-rotate` | Scheduled MAC re-randomization |
| `noise-generator` | Background cover traffic |
| `counter-recon` | Port scans, ARP probes, unexpected inbound |
| `decoy-traffic` | Random URL browsing via Tor |
| `trip-wire` | Filesystem changes, new USB devices |
| `opsec-enforce` | Tor down, swap re-enable, DNS leak, non-Tor traffic |

---

## CLI Flags (direct invocation)

```bash
sudo bash specter.sh --full        # Full setup (all layers)
sudo bash specter.sh --quick       # Essential setup
sudo bash specter.sh --stealth     # Minimal footprint
sudo bash specter.sh --wizard      # Interactive guided setup
sudo bash specter.sh --dashboard   # Live refreshing dashboard
sudo bash specter.sh --score       # Calculate OPSEC score
sudo bash specter.sh --report      # Generate full report
sudo bash specter.sh --risk        # Threat model assessment
sudo bash specter.sh --verify      # Verify Tor + DNS
sudo bash specter.sh --nuke        # Session nuke
sudo bash specter.sh --panic       # Emergency panic wipe
sudo bash specter.sh --quick-nuke  # Fast nuke
sudo bash specter.sh --checklist   # OPSEC checklist
sudo bash specter.sh --physical    # Physical security checklist
sudo bash specter.sh --integrity   # Integrity check
sudo bash specter.sh --tamper      # Hardware tamper check
sudo bash specter.sh --route       # Show traffic route diagram
sudo bash specter.sh --noise-stop  # Stop noise generator
sudo bash specter.sh --deadman     # Start dead man's switch
sudo bash specter.sh --guardian    # Activate guardian mode (all layers)
sudo bash specter.sh --canary      # Check warrant canaries
sudo bash specter.sh --tscm        # Full TSCM sweep
sudo bash specter.sh --v10-9       # Install v10.9 Zero Trace Protocol only
sudo bash specter.sh --v10-10      # Install v10.10 Absolute Zero only
sudo bash specter.sh --build-usb   # Build bootable amnesic SPECTER Live USB
sudo bash specter.sh --pq          # Install post-quantum crypto (pq-install)
sudo bash specter.sh --dualhop     # Start I2P + Tor dual-hop routing
sudo bash specter.sh --tpm         # Check TPM 2.0 status
sudo bash specter.sh --hardware    # Show hardware buy list + setup checklist
sudo bash specter.sh --v10-11      # Install v10.11 Iron Shield only
sudo bash specter.sh --fortress    # Activate fortress-mode (whitelist firewall)
sudo bash specter.sh --autodefend  # Start auto-defend attack daemon
sudo bash specter.sh --ioc         # Run indicators-of-compromise scan
sudo bash specter.sh --menu        # Interactive main menu
```

# SPECTER v10.11.0 — Iron Shield

**The ultimate privacy and anonymity system — maximum hardening, zero trace, active defense.**

> Made by **LedZy**

A comprehensive, modular bash toolkit that sets up maximum operational security on Linux — covering network anonymity, identity protection, document security, encrypted communications, physical security, and government-level traffic analysis resistance.

---

## What it does

When you run `--full`, the script installs and configures over 160 commands covering every layer of privacy and security:

```
Network      →  Tor + kill switch + DNS lock + stream isolation + bridge obfuscation
Identity     →  MAC randomization + hostname randomization + hardware ID scrubbing
Documents    →  Metadata stripping + beacon scanning + printer dot detection
Encryption   →  Age + LUKS + VeraCrypt + GPG + steganographic comms
Emergency    →  USB dead man's key + panic button + dead man's switch + session nuke
Monitoring   →  Leak detection + anomaly detection + counter-recon + tripwire
Comms        →  Matrix over Tor + encrypted voice + air-gap QR transfer
Physical     →  RF scan + NFC + BLE + intruder camera + screen guard + USB isolation
Kernel       →  Lockdown mode + 50+ modules disabled + ptrace/kexec/BPF locked
Supply chain →  GPG verify + debsums + rootkit scan + HMAC audit logs
Zero Trace   →  Vanguards + transport rotation + net namespaces + compartments
Absolute Zero→  Post-quantum crypto + I2P+Tor dual-hop + TPM attestation + bootable USB
Iron Shield  →  Whitelist firewall + auto-defend + exfil-detect + canary + IOC scan
```

---

## Requirements

### Operating System
| OS | Support | Notes |
|---|---|---|
| **Tails OS** | ✅ Recommended | Amnesic, built for this purpose |
| **Whonix** | ✅ Recommended | Tor-routed by design |
| **Debian 11/12** | ✅ Full | All features available |
| **Ubuntu 22.04+** | ✅ Full | All features available |
| **Kali Linux** | ✅ Full | Most tools pre-installed |
| **Other Debian-based** | ⚠️ Partial | Some features may vary |
| **Fedora / Arch** | ⚠️ Partial | apt-based installs will fail |
| **macOS / Windows** | ❌ Not supported | Linux-only |

### Hardware
```
Minimum:    2GB RAM, 4GB storage, x86_64 CPU
Recommended: 4GB+ RAM, 8GB+ storage, modern multi-core CPU
Optional:    RTL-SDR USB dongle (for RF surveillance detection ~$20)
             USB drive (for Dead Man's Key feature)
```

### Kernel
```
Minimum:  Linux 4.19+
Recommended: Linux 5.4+ (for kernel lockdown mode)
Best:     Linux 5.15+ (full feature support)
```

---

## Installation

### Quick start (one command)
```bash
git clone https://github.com/YOUR_USERNAME/specter.git
cd specter
sudo bash specter.sh --full
```

### Step-by-step
```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/specter.git
cd specter

# 2. Review the script (always audit before running as root)
less specter.sh

# 3. Run full setup (requires root)
sudo bash specter.sh --full

# 4. Set up your USB Dead Man's Key (optional but highly recommended)
usb-key-setup

# 5. Install Tor Browser (official, GPG-verified)
tb-install
```

### Setup modes
```bash
sudo bash specter.sh --full     # Complete setup (all layers)
sudo bash specter.sh --wizard   # Guided interactive setup
sudo bash specter.sh --quick    # Essential only (Tor + kill switch + nuke)
sudo bash specter.sh --stealth  # Minimal footprint mode
```

---

## Usage

### Starting a session
```bash
# Option A: USB Dead Man's Key (recommended)
# Plug in your OPSEC_KEY USB → session activates automatically

# Option B: Manual
sudo bash specter.sh --full   # first time only
opsec-enforce start    # activate live monitoring
tb-start               # launch Tor Browser
kloak-start            # anonymize keystroke timing
```

### During a session
```bash
opsec-status           # 12-point health check
leak-test              # comprehensive leak check
honeypot-check         # detect MITM / DNS hijack
rf-scan                # scan for surveillance devices
metadata-check <file>  # check file before sharing
dots-check <file>      # check for printer tracking dots
usb-safe /dev/sdb1     # safely open untrusted USB
```

### Ending a session
```bash
session-nuke           # clean end (wipe RAM disk, restore network, clear logs)
panic                  # emergency wipe (immediate, no confirmation)
# Or: pull your USB Dead Man's Key for instant nuke
```

---

## Core Commands Reference

### Network & Anonymity
| Command | Description |
|---|---|
| `opsec-status` | 12-point instant health indicator |
| `leak-test` | One-shot DNS/IP/IPv6/WebRTC leak check |
| `circuit-status` | Show active Tor circuits (stream isolation) |
| `bridge-select` | Choose obfs4 / Snowflake / meek-azure bridge |
| `traffic-pad start` | Add 80ms±30ms timing jitter to traffic |
| `exit-watch start` | Monitor Tor exit for circuit hijacking |
| `bad-exit-block` | Block known malicious Tor exit nodes |
| `honeypot-check` | Detect DNS hijack, ARP spoof, MITM |
| `ntp-sync` | Sync system clock via Tor only |

### Browser & Comms
| Command | Description |
|---|---|
| `tb-install` | Download + GPG-verify Tor Browser |
| `tb-start` | Tor Browser (RAM profile, JS off, Safest) |
| `browser-jail` | Firefox in Firejail + Tor + RAM profile |
| `comms-start` | Matrix client over Tor (WeeChat) |
| `voice-start` | Mumble encrypted voice over Tor |
| `airgap-send <file>` | Split file into QR codes (zero network) |
| `airgap-receive` | Reassemble file from QR codes |
| `steg-hide <img> <file>` | Hide file inside innocent image |
| `steg-reveal <img>` | Extract hidden file from image |

### Document Security
| Command | Description |
|---|---|
| `metadata-check <file>` | Scan for identity/location metadata |
| `stripall <file>` | Strip all metadata |
| `sanitize-pdf <file>` | Full PDF sanitization pipeline |
| `dots-check <file>` | Detect printer tracking dots |
| `scan-beacons <dir>` | Scan for tracking pixels, URLs, GPS |
| `usb-safe <device>` | Mount USB isolated, scan, copy to RAM |

### Encryption
| Command | Description |
|---|---|
| `age-encrypt <file>` | Encrypt with age (modern, simple) |
| `age-decrypt <file>` | Decrypt age-encrypted file |
| `create-vault` | Create LUKS2 encrypted container |
| `vc-create` | Create VeraCrypt container |
| `pm-add <site> <pass>` | Add to encrypted password manager |
| `note-encrypt` | Encrypt a note to RAM disk |

### Emergency
| Command | Description |
|---|---|
| `panic` | Immediate full system wipe |
| `quick-nuke` | Fast RAM disk wipe + kill switch |
| `session-nuke` | Full 14-step clean session end |
| `physical-panic` | Webcam photo + alarm + lock + nuke |
| `deadman-start` | Inactivity-based auto-nuke timer |
| `usb-key-setup` | Format USB as Dead Man's Key |

### Monitoring & Integrity
| Command | Description |
|---|---|
| `opsec-enforce start` | Live: block DNS leaks, swap, non-Tor |
| `counter-recon start` | Detect port scans and ARP probes |
| `trip-wire start` | Filesystem + USB tamper detection |
| `verify-tools` | SHA256 tamper-check critical binaries |
| `supply-check` | GPG verify packages + rootkit scan |
| `lockdown-status` | Kernel security parameters |
| `audit-verify` | Verify HMAC-chained audit log |
| `entropy-status` | Check cryptographic RNG health |

### System Hardening
| Command | Description |
|---|---|
| `kloak-start` | Keystroke timing anonymization |
| `screen-guard start` | Block screenshot tools + framebuffer |
| `os-spoof windows` | TCP/IP fingerprint → Windows 10 |
| `net-wipe` | Flush ARP/DNS/conntrack/routing |
| `rf-scan` | Scan for surveillance transmitters |
| `ram-shred` | Fill free RAM (cold-boot defense) |
| `mac-rotate start` | Periodic MAC re-randomization |
| `exit-autoupdate` | Auto-refresh bad exit list (6h cron) |

### v10.9 — Zero Trace Protocol
| Command | Description |
|---|---|
| `vanguards-install` | Install Vanguards guard rotation defense (Tor HS deanon protection) |
| `vanguards-status` | Check Vanguards daemon status |
| `transport-rotate now/start/stop` | Auto-cycle obfs4/Snowflake/meek bridges |
| `ns-isolate start/exec/stop/list` | Per-app kernel network namespace isolation |
| `compartment-create <name>` | Isolated browser session with own Tor circuit |
| `compartment-start <name>` | Launch compartmented browser |
| `compartment-list` | List all compartments |
| `compartment-wipe <name>` | Securely destroy compartment |
| `warrant-canary` | Check warrant canaries for key services via Tor |
| `secureboot-check` | UEFI Secure Boot + bootloader integrity baseline |
| `secureboot-baseline-reset` | Reset boot baseline after kernel/grub update |
| `mem-forensics-defense` | Kernel memory anti-forensics hardening |
| `noise-upgrade start/stop` | Human-pattern cover traffic (burst+quiet cycle) |
| `tscm-full` | Full TSCM sweep: NFC + BLE + SDR wideband + physical |
| `guardian-mode start/stop/status` | Single command: ALL protection layers active |
| `v10-9-status` | v10.9 features status |

### v10.10 — Absolute Zero
| Command | Description |
|---|---|
| `build-specter-usb` | Build bootable Debian Live USB with SPECTER pre-installed (amnesic) |
| `pq-install` | Install Open Quantum Safe liboqs + Python bindings |
| `pq-keygen` | Generate Kyber-1024 + Dilithium3 post-quantum keypair |
| `pq-encrypt <file>` | Post-quantum encrypt: Kyber-1024 KEM + AES-256-GCM |
| `pq-decrypt <file>` | Post-quantum decrypt |
| `dualhop-start` | Start I2P + Tor dual-hop daemon (two independent anonymity networks) |
| `dualhop-exec <cmd>` | Run command through I2P → Tor dual chain |
| `dualhop-status` | Show dual-hop routing status |
| `dualhop-stop` | Stop dual-hop daemon |
| `tpm-check` | Verify TPM 2.0 availability and PCR state |
| `tpm-seal <secret>` | Seal secret to current hardware boot state (TPM PCRs 0,1,2,3,4,7) |
| `tpm-unseal` | Unseal secret (only succeeds if boot state unchanged) |
| `yubikey-setup` | Configure YubiKey for LUKS + sudo hardware 2FA |
| `yubikey-status` | Show YubiKey authentication status |
| `hardware-checklist` | Exact hardware buy list + 9-step hardened setup procedure |
| `v10-10-status` | v10.10 Absolute Zero features status |

---

## Threat Model

### What this tool protects against

| Threat | Level | How |
|---|---|---|
| ISP traffic monitoring | ✅ Strong | Tor + kill switch + DNS lock |
| Network-level surveillance | ✅ Strong | Stream isolation + bridge obfuscation |
| Corporate tracking | ✅ Strong | MAC randomization + metadata stripping |
| Traffic analysis (size) | ✅ Strong | Packet padding + MTU normalization |
| Traffic analysis (timing) | ✅ Strong | 80ms±30ms jitter + Tor padding |
| Document watermarking | ✅ Strong | Beacon scan + metadata strip + dots-check |
| File metadata leaks | ✅ Strong | mat2 + exiftool + qpdf pipeline |
| Physical seizure | ✅ Strong | RAM disk + instant nuke + dead man's key |
| Cold-boot attacks | ✅ Strong | RAM shred + swap off + encrypted RAM disk |
| Keyloggers (software) | ✅ Good | kloak (timing randomization) |
| DNS leaks | ✅ Strong | resolv.conf locked + Tor DNS only |
| WebRTC leaks | ✅ Strong | Browser hardening + media.peerconnection off |
| Printer tracking | ✅ Good | deda detection + strip |
| MITM / SSL intercept | ✅ Good | honeypot-check + cert verification |
| Correlation attacks | ✅ Strong | Stream isolation + Vanguards + human-pattern cover traffic |
| Targeted endpoint exploit | ✅ Strong | Kernel lockdown + supply chain + mem forensics defense |
| State-level backbone intercept | ✅ Strong | Tor + bridges + transport rotation + net namespaces |
| Subpoena / legal compulsion | ⚠️ Moderate | Encrypted containers + deniable storage + warrant canary |
| Guard node discovery | ✅ Strong | Vanguards guard rotation defense |
| Transport fingerprinting | ✅ Strong | Auto-rotate obfs4 / Snowflake / meek bridges |
| Cross-session identity correlation | ✅ Strong | Browser compartments (isolated circuits) |
| Boot-level tampering | ✅ Good | Secure Boot check + bootloader integrity baseline |
| Memory forensics | ✅ Strong | Core dump disable + ptrace lock + anti-forensics kernel |
| Post-quantum decryption (future) | ✅ Strong | Kyber-1024 NIST PQC KEM (quantum-resistant) |
| Single-network deanonymization | ✅ Strong | I2P + Tor dual-hop (must compromise both networks) |
| Boot-state secret theft | ✅ Strong | TPM 2.0 PCR sealing + hardware attestation |
| Password/key theft without hardware | ✅ Strong | YubiKey challenge-response hardware 2FA |
| Forensics on confiscated live system | ✅ Strong | Amnesic bootable USB (leaves zero traces on host) |

### What software cannot fully protect against

| Threat | Why | Mitigation |
|---|---|---|
| Hardware implants | Physical — no software fix | Clean hardware, RF scan |
| Mobile phone in the room | Separate device | Faraday bag or remove phone |
| State backbone correlation (at scale) | Infrastructure access | Multiple hops + Tor bridges |
| Human OPSEC mistakes | Social/behavioral | Training + opsec-enforce |
| Physical coercion | Legal/physical | Deniable encryption + dead man's switch |
| Zero-day kernel exploits | Unknown vulnerabilities | Kernel lockdown reduces surface |

---

## Building from Source

The final script is assembled from 19 modules:

```bash
# Build latest version
bash specter_build.sh

# Module structure
modules/
├── v10_core.sh          # Globals, logging, config, OS detection
├── v10_7_anim.sh        # Animation system (matrix rain, spinners, etc.)
├── v10_harden.sh        # 15-layer system hardening
├── v10_network.sh       # Tor, VPN, DNS, kill switch, I2P
├── v10_anonymity.sh     # Identity, PGP, watermarks, OnionShare
├── v10_crypto.sh        # Age, VeraCrypt, LUKS, password manager
├── v10_documents.sh     # PDF/doc sanitize, beacon scan, quarantine
├── v10_sources.sh       # SecureDrop, dead drops, source auth
├── v10_emergency.sh     # Panic, dead man, duress, nuke
├── v10_monitor.sh       # Leak/LAN/anomaly/correlation monitoring
├── v10_tools.sh         # OPSEC score, dashboard, reports
├── v10_5_extras.sh      # v10.5: exit-watch, mac-rotate, opsec-status...
├── v10_6_extras.sh      # v10.6: USB key, air-gap, printer dots, kloak...
├── v10_7_extras.sh      # v10.7: honeypot, steg, counter-recon, browser-jail...
├── v10_8_extras.sh      # v10.8: stream isolation, Tor Browser, kernel lockdown...
├── v10_9_extras.sh      # v10.9: Vanguards, transport rotation, namespaces, compartments...
├── v10_10_extras.sh     # v10.10: post-quantum, dual-hop, TPM, YubiKey, bootable USB...
├── v10_11_extras.sh     # v10.11: fortress firewall, auto-defend, exfil-detect, canary, IOC scan...
└── v10_menus.sh         # All menus + CLI entrypoint
```

---

## Environment Variables

```bash
ANIM_ENABLED=0        # Disable all animations (useful for CI/servers)
ANIM_SPEED=fast       # Animation speed: fast | normal | slow
RAMDISK_MOUNT=/custom # Custom RAM disk mount point
```

---

## Authorship

**SPECTER** is created and maintained by **LedZy**.

Authorship proof token: `TGVkWnk6U1BFQ1RFUjoyMDI1`

Verify: `echo 'TGVkWnk6U1BFQ1RFUjoyMDI1' | base64 -d`

---

## Legal & Ethical Use

This tool is designed for **security researchers, privacy advocates, human rights workers, and anyone who needs to protect their communications and data from surveillance**.

**Legitimate uses:**
- Protecting private communications
- Investigating organized crime, corruption, or human rights abuses
- Security research and education
- Privacy protection in high-risk environments

**This tool does not:**
- Bypass any specific organization's systems
- Provide any offensive capabilities
- Enable anything not already possible with standard Linux tools

Users are responsible for compliance with applicable laws in their jurisdiction.

---

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-module`
3. Write your module following the existing pattern
4. Add it to the build script
5. Ensure `bash -n specter.sh` passes
6. Submit a pull request

---

## Changelog

| Version | Lines | Key additions |
|---|---|---|
| v10.11.0 | 14,500+ | Iron Shield: fortress-mode whitelist firewall, auto-defend attack daemon, exfil detection, port knocking, canary honeypots, IOC scanner, proc-harden, sysctl-max, log-fortify |
| v10.10.0 | 13,500+ | Absolute Zero: bootable amnesic Live USB, post-quantum Kyber-1024+Dilithium3 encryption, I2P+Tor dual-hop routing, TPM 2.0 attestation + PCR sealing, YubiKey hardware 2FA, hardware buy checklist |
| v10.9.0 | 12,000+ | Zero Trace Protocol: Vanguards guard rotation, transport auto-rotation, net namespace isolation, browser compartments, warrant canary monitor, Secure Boot check, memory forensics defense, human-pattern cover traffic, full TSCM sweep (NFC+BLE+SDR), guardian mode |
| v10.8.0 | 10,194 | Stream isolation, Tor Browser verified, kernel lockdown, supply chain, OPSEC enforcer, entropy boost, HMAC audit log, RF detection, bridge obfuscation |
| v10.7.0 | 8,989 | Animations (matrix rain, typewriter, glitch), honeypot check, steganography, counter-recon, decoy traffic, browser jail, OS spoof, tripwire |
| v10.6.0 | 7,653 | USB Dead Man's Key, air-gap QR transfer, printer dot detection, keystroke anonymizer, USB isolation |
| v10.5.0 | 6,603 | Exit watch, mac-rotate, leak test, RAM shred, metadata check, TCP hardening |
| v10.0.0 | 5,787 | Full rewrite: 11 modules, 120+ commands |

---

## License

MIT License — see [LICENSE](LICENSE)

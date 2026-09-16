# Sweet Potato Compute Module — Manpack Build

Provides a **Compute Module** for the [AnyTone AT-779UV manpack frame](https://github.com/brulejr/manpack-at779uv-claude-mark3)
project, built around a Libre Computer Sweet Potato. This covers the SBC
itself — hardware selection, OS bring-up, networking, and the application
stack it runs — as a companion to the frame's own README.

## Overview

This compute module turns the manpack from a radio-only rig into a field
computing platform with WiFi access and add-on applications.

WiFi can serve either as

- a client (joining an existing network)
- as its own access point (for a phone/tablet to connect to directly in the field)

It hangs beneath the frame's battery box in the `compute_box_inline_sweetpotato` tray.

Reliability, power efficiency, and robustness under field conditions —
unattended reboots, no monitor/keyboard available, intermittent power — drive
most of the design decisions documented here, more than raw performance.

## Hardware

|                   |                                                                                                                                                                                  |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Board             | Libre Computer Sweet Potato, AML-S905X-CC-V2                                                                                                                                     |
| OS                | Debian 12 (bookworm), arm64                                                                                                                                                      |
| WiFi adapter      | Realtek RTL8188CUS, USB ID `0bda:8176`                                                                                                                                           |
| WiFi driver       | `rtl8192cu` — **in-tree**, ships with the kernel package, no DKMS/out-of-tree module to maintain                                                                                 |
| Interface name    | `wlan0`, pinned via a systemd `.link` file so the name survives across dongle replug/enumeration order                                                                           |
| Physical mounting | Sits in the `compute_box_inline_sweetpotato` tray, hanging under the frame's battery box; a separate 3D-printed eMMC retention bracket secures the eMMC module against vibration |

**Why the Sweet Potato over other boards considered:** its USB-C power, a
vibration-mounted eMMC module with a standoff, and a PoE header made it the
strongest Libre Computer option evaluated for this use case.

Other contenders include:

- The Libre Computer La Frite (used on an earlier/parallel manpack build) was a solid choice; however, its opposite-end connector layout led to less efficicient space utilitzation than the Sweet Potato, which is more like a Raspberry Pi layout.
- The Orange Pi was ruled out as the weakest candidate here due to microSD-only storage, split GPIO headers, and inconsistent documentation.
- The Radxa Cubie A5E (T527, industrial-rated) looked promising but was judged too immature in software support for current field deployment — worth revisiting as that ecosystem matures.
- The BeagleBone Black remains a candidate specifically if precise signal timing via PRU real-time
  microcontrollers ever becomes a requirement, though it needs custom wiring due to non-RPi-compatible headers.

## Operating System Setup (including Docker)

### Base image

Libre Computer's EDK2-based UEFI abstraction layer means a single generic
arm64 Debian image works across all their supported boards — there's no
board-specific image to track down. Images are sourced from
`distro.libre.computer`. The eMMC was flashed from a bootable USB stick using
`dd`.

> **`USBBOOT` switch note:** the Sweet Potato's `USBBOOT` switch is a
> low-level Amlogic recovery mechanism, not a boot-media priority selector —
> don't expect it to behave like a simple "boot from USB instead of eMMC"
> toggle. This is also the relevant recovery path if the board ever becomes
> unbootable and the eMMC needs to be accessed from another machine.

### Bring-up issues resolved

These came up during initial commissioning and are documented here so they
don't get re-diagnosed from scratch on a rebuild:

- HDMI EDID artifacts during early boot
- A read-only USB filesystem boot failure
- Hostname configuration
- An SSH service failure traced to a config file typo
- Harmless `update-initramfs` firmware warnings (cosmetic, no action needed)
- Ethernet was temporarily lost to a MAC address mismatch in a `.link` file
  causing `udev` rename conflicts — resolved; see the networking section
  below for why `.link` files are used deliberately despite this history

### Networking

WiFi is configured via `systemd-networkd` + `wpa_supplicant`, with
`wpa_supplicant@wlan0.service` enabled for persistence across reboots. See
[WiFi Mode Switching](#wifi-mode-switching) below for the full client/AP
switching mechanism built on top of this baseline.

Field-reliability posture: key-based SSH auth, serial console treated as the
primary recovery interface (not just HDMI/keyboard — this has mattered in
practice when a boot hangs before a getty spawns), and consistent network
manager selection across interfaces so `systemd-networkd` isn't fighting
another tool for control of a link.

### Docker

Docker Engine is the base layer for future containerized services (see
[Applications](#applications-overview-and-sections) below). Standard install
for Debian arm64:

```bash
# Remove any conflicting older packages first
sudo apt-get remove docker docker-engine docker.io containerd runc

# Set up Docker's apt repository
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Let the non-root operator run docker without sudo
sudo usermod -aG docker $USER
```

`docker compose` (the plugin, not the standalone `docker-compose` binary) is
installed above and is the intended way to run the application stack in
[Applications](#applications-overview-and-sections) once those are defined —
one compose file per service, or one combined stack file, TBD as that section
fills in.

## WiFi Mode Switching

`wifi-mode.sh` switches the board between WiFi **client** mode (joins an
existing network) and **AP** mode (broadcasts its own network for a
phone/tablet to join in the field), either immediately or staged for the
next reboot.

### Files

| File                                          | Purpose                                                           |
| --------------------------------------------- | ----------------------------------------------------------------- |
| `/usr/local/sbin/wifi-mode.sh`                | The script itself                                                 |
| `/etc/systemd/system/wifi-mode-apply.service` | Applies a _staged_ mode change at boot                            |
| `/etc/wifi-mode/client.conf`                  | Default SSID/password for client mode                             |
| `/etc/wifi-mode/ap.conf`                      | Default SSID/password (and AP-only settings) for AP mode          |
| `/etc/wifi-mode/pending.conf`                 | Written by `stage`, consumed by `apply-pending`; not user-edited  |
| `/etc/wifi-mode/current.conf`                 | Written after any successful apply, for `status`; not user-edited |

### Setup (one-time)

```
sudo cp wifi-mode.sh /usr/local/sbin/wifi-mode.sh
sudo chmod +x /usr/local/sbin/wifi-mode.sh
sudo cp wifi-mode-apply.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable wifi-mode-apply.service
```

```
# /etc/wifi-mode/client.conf
SSID="HomeNetwork"
PASSWORD="supersecret"

# /etc/wifi-mode/ap.conf
SSID="ManpackRadio"
PASSWORD="fieldpassword"
AP_IP="192.168.50.1/24"          # optional, this is the default
DHCP_RANGE_START="192.168.50.10" # optional, this is the default
DHCP_RANGE_END="192.168.50.100"  # optional, this is the default
```

`AP_IP`/`DHCP_RANGE_START`/`DHCP_RANGE_END` are **only** read from
`ap.conf` — no command-line override, by design (see Design below).
`SSID`/`PASSWORD` in either file can still be overridden on the command
line.

### Usage

| Command                                                 | What it does                                                                       |
| ------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `wifi-mode.sh client [iface] [ssid] [pass]`             | Switch to client mode **right now**                                                |
| `wifi-mode.sh ap [iface] [ssid] [pass]`                 | Switch to AP mode **right now**                                                    |
| `wifi-mode.sh stage <client\|ap> [iface] [ssid] [pass]` | Stage a mode change for the **next reboot only** — current networking is untouched |
| `wifi-mode.sh apply-pending`                            | Applies whatever is staged; called automatically by the systemd unit at boot       |
| `wifi-mode.sh cancel-pending`                           | Drops a staged change before it takes effect                                       |
| `wifi-mode.sh status`                                   | Shows current vs. staged mode                                                      |

`[iface]` defaults to `wlan0`. `[ssid]`/`[pass]` fall back to the matching
config file if omitted.

**Recommended practice:** use immediate `client`/`ap` when you have console
access — reliable throughout this project's history. Use `stage` when
changing mode without disturbing your current session (e.g. over SSH on the
link you're about to switch away from), and confirm with `status` after the
reboot.

### Design

**Why staging exists:** switching directly to AP mode over an SSH session
connected via WiFi client mode kills your own connection mid-command.
`stage` writes the desired mode to `pending.conf` and does nothing else — no
interface changes, no service changes — so it's safe to run over the link
you're about to lose. `wifi-mode-apply.service` picks it up on the next
boot.

**Why `AP_IP` and the DHCP range are config-file-only:** an early version
naively `source`d `ap.conf` into the script's global scope, where `AP_IP`
collided with an internal constant of the same name and corrupted an `ip
addr add` argument. The fix was to read these values deliberately in
`resolve_params()`, with defaults, and pass them as explicit function
arguments from there on — nothing downstream relies on an ambient global a
config file could silently mutate.

### Known issues and design history

**USB enumeration race:** at least one boot failed with `Device "wlan0" does
not exist` partway through `apply-pending` — the WiFi dongle hadn't finished
USB enumeration yet. This is why `wifi-mode-apply.service` is ordered
`After=local-fs.target network.target` rather than earlier in boot.

**Two systemd ordering deadlocks (the root cause of the worst symptoms):**
full boot hangs requiring a power cycle initially looked like a driver
reliability problem, but were actually two separate ordering deadlocks
introduced while trying to make `wifi-mode-apply.service` "win the race"
against other units via `Before=`:

1. `Before=hostapd.service wpa_supplicant@wlan0.service dnsmasq.service` —
   `setup_ap` calls `systemctl enable --now hostapd`/`dnsmasq`, which blocks
   until the target job completes; but that job can't start until our unit
   finishes, which can't happen until that call returns. Circular wait.
2. `Before=network.target`, tried as a "safer" replacement — also wrong,
   because Debian's `dnsmasq.service`/`hostapd.service` ship with
   `After=network.target`. Same deadlock, one level removed.

**Fix:** no `Before=` ordering against anything — only
`After=local-fs.target network.target`. The script's own
`systemctl enable`/`disable`/`start` calls coordinate state; no static
ordering constraint is safe here given the unit both waits on and is waited
on by the same services depending on which target is chosen.

Diagnosed by comparing `journalctl -u wifi-mode-apply.service -b -1` across
failed boots — the log consistently stopped at `Enabling dnsmasq and hostapd
for persistence across reboots...`, with a timeout gap right at the first
`systemctl start` call. If a similar hang recurs, get that log before
changing anything.

A defensive `TimeoutStartSec=20` remains on the unit — turns a hang into a
failed-but-recoverable boot for userspace hangs, though it can't help with a
true kernel-level driver deadlock.

**Confirmed reliable:** immediate `wifi-mode.sh ap`/`client`, including
surviving an ordinary subsequent reboot. **Wants more test cycles before
fully trusting in the field:** `stage ap` + reboot — failed repeatedly before
the ordering fix above; has passed at least one clean test since.

## Applications Overview and Sections

> **This section is a placeholder.** The applications below are planned or
> in early stages; details need to be filled in as each is actually built
> out and confirmed running on this board. Candidate list, carried over from
> the broader manpack project's software stack planning:

### WebSDR

_TBD._

### Logging

_TBD._ Candidates under consideration for this compute module include:

- **Direwolf** — APRS iGate/digipeater, KISS TNC
- **Pat** — Winlink email over ARDOP/VARA FM
- **fldigi** / **flrig** — digital modes and rig control
- GPS track logging
- Squelch-triggered voice recording
- Contact logging

### Other

_TBD — reserve this space for anything that doesn't fit WebSDR/Logging
(e.g. a tablet-facing web UI, a status dashboard, etc.)._

# Seoulos 22.04 LTS (Live) (Ubuntu), Desktop (GNOME)

This folder contains reproducible inputs (branding + scripts) to build a Seoulos live ISO based on Ubuntu 22.04 Desktop.

## Recommended path (fastest): Cubic

Cubic is the quickest way to produce a working live ISO and iterate on branding.

### 1) Install Cubic (host)

Install Cubic on your Ubuntu host using the method you trust (PPA or .deb).

### 2) Start a new project

In Cubic:

- Choose an Ubuntu 22.04 Desktop ISO as the base input.
- Project name: `Seoulos`
- Output ISO label/menu text: `Seoulos 22.04 LTS (Live) (Ubuntu)`

### 3) Apply branding inside the Cubic chroot

Inside Cubic chroot terminal, copy this repository folder into the chroot (or mount it), then run:

```sh
bash /path/to/seoulos-live/scripts/apply-branding.sh
```

### 4) Optional GNOME desktop tweaks

You can apply GNOME defaults in Cubic (dconf, backgrounds, favorites). Keep those changes minimal at first.

### 5) Build ISO

Build from Cubic and test in QEMU.

## Test the ISO in QEMU (UEFI)

### 1) Install UEFI firmware (OVMF)

On Ubuntu hosts:

```sh
sudo apt-get update
sudo apt-get install -y qemu-system-x86 ovmf
```

### 2) Locate OVMF firmware files

Common locations (pick the ones that exist on your system):

- `/usr/share/OVMF/OVMF_CODE.fd`
- `/usr/share/OVMF/OVMF_VARS.fd`
- `/usr/share/OVMF/OVMF_CODE_4M.fd`
- `/usr/share/OVMF/OVMF_VARS_4M.fd`

### 3) Boot the ISO (UEFI)

From the directory containing your Cubic output ISO (example name shown):

```sh
cp /usr/share/OVMF/OVMF_VARS.fd OVMF_VARS.seoulos.fd

qemu-system-x86_64 \
  -machine q35,accel=kvm:tcg \
  -m 4096 \
  -cpu host \
  -smp 2 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=OVMF_VARS.seoulos.fd \
  -cdrom Seoulos-22.04-live.iso \
  -boot d \
  -display gtk
```

If your system only provides the `*_4M.fd` files, substitute those in the command.

## What this folder provides

- `branding/`:
  - `os-release`
  - `lsb-release`
  - `issue`
- `scripts/apply-branding.sh`: applies branding files into the target filesystem.

## Notes

- This repo also contains a historical `linux-0.01` tree; it is not used for the Ubuntu-based live ISO.

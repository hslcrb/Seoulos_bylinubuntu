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

## What this folder provides

- `branding/`:
  - `os-release`
  - `lsb-release`
  - `issue`
- `scripts/apply-branding.sh`: applies branding files into the target filesystem.

## Notes

- This repo also contains a historical `linux-0.01` tree; it is not used for the Ubuntu-based live ISO.

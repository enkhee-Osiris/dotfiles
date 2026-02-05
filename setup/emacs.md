# Emacs Install

Emacs installation guide by **enkhee-Osiris**.

---

## System

```

16-inch MacBook Pro (2023)
Apple M2 Pro (12 cores)
macOS Tahoe 26.2 (25C56)
Xcode 26.2 (17C52)

````

---

## Guide

### Clone the Emacs builder project

```bash
git clone git@github.com:enkhee-Osiris/build-emacs-for-macos.git
cd build-emacs-for-macos
````

### Install prerequisites

```bash
brew install ruby
make bootstrap
```

### Build Emacs

```bash
./build-emacs-for-macos emacs-30.2 \
  --parallel 12 \
  --no-use-nix \
  --tree-sitter \
  --native-comp \
  --rsvg \
  --dbus \
  --fd-setsize 100000
```

### Extract the build

Built files will be located in the `builds` directory.

```bash
cd builds
tar -xjvf Emacs.2025-08-14.636f166.emacs-30-2.macOS-26.arm64.tbz
```

### Install Emacs.app

Copy `Emacs.app` to `/Applications`:

```bash
sudo cp -R Emacs.2025-08-14.636f166.emacs-30-2.macOS-26.arm64/Emacs.app /Applications/
```

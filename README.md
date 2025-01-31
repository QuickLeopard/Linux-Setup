# Linux-Setup

## Initial Setup and Programming languages development environment setup

### Rocky Linux initial setup from minimal distro

- Install dnf: ```sudo microdnf install dnf```

### Rocky Linux Haskell Stack Install

- Install prerequisities: ```sudo dnf install gmp gmp-devel mpfr mpfr-devel libmpc libmpc-devel```
- Install tar and xz: ```sudo dnf install tar xz```
- Install haskell stack: ```curl -sSL https://get.haskellstack.org/ | sh```

### Ubuntu add GDI support

- Install prerequisities for Windows GDI support in Linux: ```sudo apt-get update && sudo apt-get install -y apt-utils libgdiplus libc6-dev```

## Security Setup

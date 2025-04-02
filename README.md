# Linux-Setup

## Initial Setup and Programming languages development environment setup

### Rocky Linux initial setup from minimal distro

- Install dnf: ```sudo microdnf install dnf```

### Rocky Linux Haskell Stack Install

- Install prerequisities: ```sudo dnf install gmp gmp-devel mpfr mpfr-devel libmpc libmpc-devel```
- Install tar and xz: ```sudo dnf install tar xz```
- Install haskell stack: ```curl -sSL https://get.haskellstack.org/ | sh```

### Rocky Linux .Net Install

- Install .NET 8 Runtime: ```sudo yum install dotnet-runtime-8.0 -y```
- Install .NET 8 SDK: ```sudo yum install dotnet-sdk-8.0 -y```

### Rocky Linux Real-Time kernel Install
- Enable RT repositiory: ```dnf config-manager --set-enabled rt```
- Real-Time kernel install: ```dnf install kernel-rt```

### Rocky Linux _btop_ Install

- Install _btop_ utility:
  ```dnf -y install epel-release && dnf makecache && dnf -y install btop```

### Rocky Linux _tmux_ Install

- Install _tmux_ utility:
  ```dnf -y install tmux```

### Ubuntu add GDI support(```System.Drawing.Common```)

- Install prerequisities for Windows GDI support in Linux: ```sudo apt-get update && sudo apt-get install -y apt-utils libgdiplus libc6-dev```

### SkiaSharp add Linux No Dependencies

- Add NuGet package: ```SkiaSharp.NativeAssets.Linux.NoDependencies```

## Security Setup

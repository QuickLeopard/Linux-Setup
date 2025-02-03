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

### Ubuntu add GDI support(```System.Drawing.Common```)

- Install prerequisities for Windows GDI support in Linux: ```sudo apt-get update && sudo apt-get install -y apt-utils libgdiplus libc6-dev```

### SkiaSharp add Linux No Dependencies

- Add NuGet package: ```SkiaSharp.NativeAssets.Linux.NoDependencies```

## Security Setup

# Linux-Setup

## Initial Setup and Programming languages development environment setup

### Rocky Linux 9/10 initial setup from minimal distro

- Install dnf: ```sudo microdnf install dnf```

### Rocky Linux 9/10 Network Speed Test

- Enable Pyhton Pip package manager: ```sudo dnf install python3-pip```
- Install SpeedTest CLI: ```pip3 install speedtest-cli```
- Test Network Speed: ```speedtest```

### Rocky Linux 9/10 Haskell Stack Install

- Install prerequisities: ```sudo dnf install gmp gmp-devel mpfr mpfr-devel libmpc libmpc-devel```
- Install tar and xz: ```sudo dnf install tar xz```
- Install haskell stack: ```curl -sSL https://get.haskellstack.org/ | sh```

### Rocky Linux 9/10 .Net Install

- Install .NET 8 Runtime: ```sudo yum install dotnet-runtime-8.0 -y```
- Install .NET 8 SDK: ```sudo yum install dotnet-sdk-8.0 -y```

### Rocky Linux 9/10 Real-Time kernel Install

- Enable RT repositiory: ```sudo dnf config-manager --set-enabled rt```
- Real-Time kernel install: ```sudo dnf -y install kernel-rt```

### Rocky Linux 9/10 Docker Install

- Update the package database: ```sudo dnf check-update```
- Add the official Docker repository: ```sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo```
- Install Docker: ```sudo dnf install docker-ce docker-ce-cli containerd.io```
- Start the Docker daemon: ```sudo systemctl start docker```
- Verify Docker running: ```sudo systemctl status docker```
- Make sure Docker starts at every server reboot: ```sudo systemctl enable docker```

### Rocky Linux 9/10 NTP Client Install

- Chrony install: ```sudo dnf install chrony```
- Check Chrony time sync: ```chronyc tracking```
- Check Chrony service status: ```sudo systemctl status chronyd```
- Restart Chrony service: ```sudo systemctl restart chronyd```
- Config file Path: _/etc/chrony.conf_

### Rocky Linux 9/10 _btop_ Install

- Install _btop_ utility:
  ```sudo dnf -y install epel-release && dnf makecache && dnf -y install btop```

### Rocky Linux 9/10 _tmux_ Install

- Install _tmux_ utility:
  ```sudo dnf -y install tmux```

### Ubuntu add GDI support(```System.Drawing.Common```)

- Install prerequisities for Windows GDI support in Linux: ```sudo apt-get update && sudo apt-get install -y apt-utils libgdiplus libc6-dev```

### SkiaSharp add Linux No Dependencies

- Add NuGet package: ```SkiaSharp.NativeAssets.Linux.NoDependencies```

## Security Setup

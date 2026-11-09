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
- List all available kernels: ```ls -1 /boot/vmlinuz*```
- Set RT kernel with grubby utility: ```sudo grubby --set-default=/boot/vmlinuz-6.12.0-55.34.1.el10_0.x86_64+rt```

### Rocky Linux 9/10 rt-tests install
  
- Clone rt-tests repository: ```git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git```
- Install build-tools: ```sudo dnf groupinstall "Development Tools" -y```
- Install numa-devel: ```sudo dnf install -y numactl-devel```
- Install tuna utility: ```sudo dnf install tuna```
- Setup scheduler algo and priority: ```tuna priority -t rngd FIFO:1```
- Install kdump utility: ```sudo dnf install kexec-tools```

### Optimizing RT kernel
- https://docs.redhat.com/en/documentation/red_hat_enterprise_linux_for_real_time/8/html-single/optimizing_rhel_8_for_real_time_for_low_latency_operation/index

### Rocky Linux 9/10 failban Install

- Add the official EPEL repository: ```sudo dnf install -y epel-release```
- Install failban: ```sudo dnf install -y fail2ban fail2ban-firewalld```
- Enable failban service: ```sudo systemctl enable --now fail2ban```
- Copy the configuration: ```sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local```
- Edit the configuration: ```sudo nano /etc/fail2ban/jail.d/sshd.local```
- Copy/Paste the configuration:
```
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
maxretry = 3
bantime = 1d
```
- Restart failban service: ```sudo systemctl restart fail2ban```

### Rocky Linux 9/10 Docker Install

- Update the package database: ```sudo dnf check-update```
- Add the official Docker repository: ```sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo```
- Install Docker: ```sudo dnf install docker-ce docker-ce-cli containerd.io```
- Start the Docker daemon: ```sudo systemctl start docker```
- Verify Docker running: ```sudo systemctl status docker```
- Make sure Docker starts at every server reboot: ```sudo systemctl enable docker```

### Rocky Linux 9/10 Docker Compose Install

#### 1. Update all packages
```bash
sudo dnf update -y
```

#### 2. Add the Docker Repository
Rocky Linux 10 is binary-compatible with RHEL 10. Use the official Docker repository for RHEL:
```bash
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
```

#### 3. Install Docker Engine and Compose Plugin
Install the core Docker engine along with the **Docker Compose plugin**. This enables the modern `docker compose` (without the hyphen) command:
```bash
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
*Note: If you encounter a `containerd.io` conflict, use the `--allowerasing` flag.*

#### 4. Start and Enable Docker
Start the Docker service and set it to launch automatically on boot:
```bash
sudo systemctl enable --now docker
```

#### 5. Verify the Installation
Check that Docker Compose is installed correctly by viewing the version:
```bash
docker compose version
```

#### 6. (Optional) Run Docker as a Non-Root User
To run `docker compose` commands without prefixing them with `sudo`, add your current user to the `docker` group:
```bash
sudo usermod -aG docker $USER
newgrp docker
```


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

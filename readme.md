# K3SUP Tutorial

# A) INSTALLING TO THE FIRST SERVER
## 1. Setup passwordless ssh loggin for root user

```
sh nickm@10.154.2.93
sudo su -
```


### 1.1 Allow root user to loggin
nano /etc/ssh/sshd_config

change FROM:

PermitRootLogin prohibit-password

TO:

**PermitRootLogin yes**

#### Restart SSH service:
```
sudo systemctl restart ssh
sudo systemctl restart sshd
passwd root
exit

su - root
exit
exit

ssh root@10.154.2.93
exit

sudo su -
ssh-keygen -t rsa -b 4096
ssh root@10.154.2.93
exit
```
#### COPY THE PUBLIC KEY TO THE FIRST SERVER

```
scp ~/.ssh/id_rsa.pub root@10.154.2.98:~

ssh root@10.154.2.93
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
exit

ssh root@10.154.2.93
exit
```
## 2. create 1_InstallFirstServer.sh shell script
```
sudo su -
mkdir scripts
cd ~/scripts
nano 1_InstallFirstServer.sh
chmod 775 1_InstallFirstServer.sh
```

## 3. run 1_InstallFirstServer.sh shell script

./1_InstallFirstServer.sh

## 4. Output from 1_InstallFirstServer.sh shell script

Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.

Saving file to: /root/scripts/kubeconfig

## 5. Test your cluster with:
```
export KUBECONFIG=/root/scripts/kubeconfig
kubectl config set-context nico-clust
kubectl get node -o wide
```

## 6. scp the kubeconfig file to first server
scp /root/scripts/kubeconfig root@10.154.2.93:~/scripts

## 7. setup the kubeconfig file on the first server
```
ssh root@10.154.2.93
export KUBECONFIG=/root/scripts/kubeconfig
kubectl config set-context nico-clust
kubectl get node -o wide
kubectl get namespaces
kubectl get pods --all-namespaces
kubectl config set-context --current --namespace=nico-clust
kubectl config view --minify | grep namespace:
journalctl -u k3s.service
```
============================================================================================================

# B) ADDING THE SECOND SERVER
## 1. Setup passwordless ssh loggin for root user
```
ssh nickm@10.154.2.98
sudo su -
sh nickm@10.154.2.98
sudo su -
```



### 1.1 Allow root user to loggin
```
nano /etc/ssh/sshd_config
change FROM:
PermitRootLogin prohibit-password
TO:
```
**PermitRootLogin yes**

#### Restart SSH service:
```
sudo systemctl restart ssh
sudo systemctl restart sshd
passwd root
exit

su - root
exit
exit

ssh root@10.154.2.98
exit

sudo su -
ssh-keygen -t rsa -b 4096
ssh root@10.154.2.98
exit
```
#### COPY THE PUBLIC KEY TO THE SECOND SERVER
```
scp ~/.ssh/id_rsa.pub root@10.154.2.98:~
ssh root@10.154.2.98
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
exit

ssh root@10.154.2.98
exit
```

## 2. create 2_InstallSecondServer shell script
```
sudo su -
mkdir scripts
cd ~/scripts
nano ~/scripts/2_InstallSecondServer.sh
chmod 775 ~/scripts/2_InstallSecondServer.sh
```

## 3. run 2_InstallSecondServer shell script

./2_InstallSecondServer.sh

## 4. Output from 2_InstallSecondServer shell script
```
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-agent-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s-agent.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s-agent.service
[INFO]  systemd: Enabling k3s-agent unit
[INFO]  systemd: Starting k3s-agent
```

============================================================================================================



# B) ADDING THE THIRD SERVER
## 1. Setup passwordless ssh loggin for root user
```
ssh nickm@10.154.2.88
sudo su -
 
ssh nickm@10.154.2.88
sudo su -
```

### 1.1 Allow root user to loggin
```
nano /etc/ssh/sshd_config
change FROM:
PermitRootLogin prohibit-password
TO:
```
**PermitRootLogin yes**

#### Restart SSH service:
```
sudo systemctl restart ssh
sudo systemctl restart sshd
passwd root
exit

su - root
exit
exit

ssh root@10.154.2.88
exit

sudo su -
ssh-keygen -t rsa -b 4096
ssh root@10.154.2.88
exit
```
#### COPY THE PUBLIC KEY TO THE THIRD SERVER
```
scp ~/.ssh/id_rsa.pub root@10.154.2.88:~
ssh root@10.154.2.88
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
exit
ssh root@10.154.2.88
exit
```
## 2. create 3_InstallThirdServer.sh shell script
```
sudo su -
mkdir scripts
cd ~/scripts
nano ~/scripts/3_InstallThirdServer.sh
chmod 775 ~/scripts/3_InstallThirdServer.sh
```
## 3. run 3_InstallThirdServer.sh shell script
```
./3_InstallThirdServer.sh
```

## 4. Output from 3_InstallThirdServer.shshell script
```
`+ export NODE_1=10.154.2.93
+ NODE_1=10.154.2.93
+ export NODE_2=10.154.2.98
+ NODE_2=10.154.2.98
+ export NODE_3=10.154.2.88
+ NODE_3=10.154.2.88
+ export USER=root
+ USER=root
+ /usr/local/bin/k3sup join --k3s-version v1.17.5+k3s1 --ip 10.154.2.88 --user root --server-user root --server-ip 10.154.2.93
Running: k3sup join
Server IP: 10.154.2.93
K10ae51fd448b71eadce424d1f9542799c48646a6c970423fa8c4c9a04b1120d19a::server:b673881a808d578ea82596df8011480d
[INFO]  Using v1.17.5+k3s1 as release
[INFO]  Downloading hash https://github.com/k3s-io/k3s/releases/download/v1.17.5+k3s1/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/k3s-io/k3s/releases/download/v1.17.5+k3s1/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Skipping installation of SELinux RPM
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-agent-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s-agent.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s-agent.service
[INFO]  systemd: Enabling k3s-agent unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s-agent.service → /etc/systemd/system/k3s-agent.service.
[INFO]  systemd: Starting k3s-agent
Logs: Created symlink /etc/systemd/system/multi-user.target.wants/k3s-agent.service → /etc/systemd/system/k3s-agent.service.
Output: [INFO]  Using v1.17.5+k3s1 as release
[INFO]  Downloading hash https://github.com/k3s-io/k3s/releases/download/v1.17.5+k3s1/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/k3s-io/k3s/releases/download/v1.17.5+k3s1/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Skipping installation of SELinux RPM
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-agent-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s-agent.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s-agent.service
[INFO]  systemd: Enabling k3s-agent unit
[INFO]  systemd: Starting k3s-agent`
```
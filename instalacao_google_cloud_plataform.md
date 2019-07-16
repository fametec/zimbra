Instanciar um zimbra o Google Cloud Plataform

# Servidor 2vCPU + 8GB ram + 20GB / + 100GB /opt/zimbra
# Linux CentOS 7

# Preparar o Sistema: 

# Desativar postfix
systemctl disable --now postfix



# Desativar SELinux
setenforce 0
sed -i s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config



# Criar swap

dd if=/dev/zero of=/swap.file bs=1M count=1024 status=progress
chmod 600 /swap.file
mkswap /swap.file
swapon /swap.file
echo '/swap.file none swap swap 0 0' >> /etc/fstab


# Atualizar o sistema
yum -y update


# Instalar o EPEL Repo
yum -y install epel-release


# Instalar pacotes de dependencias
yum -y install lvm2 screen git vim 
# java



# particionar o disco 100GB com lvm


[root@zimbra-01 ~]# pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.


[root@zimbra-01 ~]# vgcreate vg_zimbra /dev/sdb1
  Volume group "vg_zimbra" successfully created

[root@zimbra-01 ~]# lvcreate -l 100%VG --name lv_zimbra vg_zimbra
  Logical volume "lv_zimbra" created.



[root@zimbra-01 ~]# mkfs.xfs /dev/mapper/vg_zimbra-lv_zimbra
meta-data=/dev/mapper/vg_zimbra-lv_zimbra isize=512    agcount=4, agsize=6553344 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=26213376, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=12799, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0


# FSTAB

# /dev/mapper/vg_zimbra-lv_zimbra:
echo '/dev/mapper/vg_zimbra-lv_zimbra /opt      xfs     defaults    0 0' >> /etc/fstab



# MOUNT /opt

mount /opt



# DNS Unbound

yum -y install unbound bind-utils


## BAIXAR o ZIMBRA 

cd ~

curl -sSL https://files.zimbra.com/downloads/8.8.12_GA/zcs-8.8.12_GA_3794.RHEL7_64.20190329045002.tgz -o zcs-8.8.12_GA_3794.RHEL7_64.20190329045002.tgz 


10.128.0.5 zimbra-01.us-central1-a.c.refined-legend-246812.internal zimbra-01  # Added by Google




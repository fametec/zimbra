# Instanciar um zimbra o Google Cloud Plataform

## Requirements: 
- Servidor 2vCPU + 8GB ram + 20GB / + 100GB /opt/zimbra
- Linux CentOS 7

## Preparar o Sistema: 

### Desativar postfix

    systemctl disable --now postfix



### Desativar SELinux

    setenforce 0

    sed -i s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config



### Criar swap

    dd if=/dev/zero of=/swap.file bs=1M count=1024 status=progress

    chmod 600 /swap.file

    mkswap /swap.file

    swapon /swap.file

    echo '/swap.file none swap swap 0 0' >> /etc/fstab


### Atualizar o sistema

    yum -y update


### Instalar o EPEL Repo

    yum -y install epel-release


### Instalar pacotes de dependencias

    yum -y install lvm2 screen git vim 



### Particionar o disco 100GB com lvm


    pvcreate /dev/sdb1

    vgcreate vg_zimbra /dev/sdb1

    lvcreate -l 100%VG --name lv_zimbra vg_zimbra


### Formatar

     mkfs.xfs /dev/mapper/vg_zimbra-lv_zimbra


### Ponto de Montagem em /opt 

    echo '/dev/mapper/vg_zimbra-lv_zimbra /opt      xfs     defaults    0 0' >> /etc/fstab

    mount /opt



## DNS Unbound

    yum -y install unbound bind-utils


## Download do ZIMBRA 

    cd ~

    curl -L https://files.zimbra.com/downloads/8.8.12_GA/zcs-8.8.12_GA_3794.RHEL7_64.20190329045002.tgz -o zcs-8.8.12_GA_3794.RHEL7_64.20190329045002.tgz 


## Instalação 

    tar -zxvf zcs-8.8.12_GA_3794.RHEL7_64.20190329045002.tgz

    cd zcs-8.8.12_GA_3794.RHEL7_64.20190329045002

    ./install.sh
  

export LC_ALL="en_US.UTF-8" && \
export LC_CTYPE="en_US.UTF-8" && \
\
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release && yum update && \

# adding ose repo : /etc/yum.repos.d/ose.repo
#[rhel-7-server-rpms]
#name=rhel-7-server-rpms
#baseurl=http://<server_IP>/repos/rhel-7-server-rpms 
#enabled=1
#gpgcheck=0
#[rhel-7-server-extras-rpms]
#name=rhel-7-server-extras-rpms
#baseurl=http://<server_IP>/repos/rhel-7-server-extras-rpms 
#enabled=1
#gpgcheck=0
#[rhel-7-server-ansible-2.6-rpms]
#name=rhel-7-server-ansible-2.6-rpms
#baseurl=http://<server_IP>/repos/rhel-7-server-ansible-2.6-rpms 
#enabled=1
#gpgcheck=0
#[rhel-7-server-ose-3.11-rpms]
#name=rhel-7-server-ose-3.11-rpms
#baseurl=http://<server_IP>/repos/rhel-7-server-ose-3.11-rpms 
#enabled=1
#gpgcheck=0
\
yum update -y && yum install bind-utils -y && yum install git -y && \
mkfs.xfs -f -n ftype=1 -i size=512 -n size=8192 /dev/xvdc && \
# hostnamectl set-hostname server8.cto-org-india.dns-cloud.net
\
mkdir /foldermounts && \
mount /dev/xvdc /foldermounts && \
echo "/dev/xvdc /foldermounts xfs defaults,noatime 1 2" >> /etc/fstab && \
\
mkdir -p /var/lib/docker /foldermounts/lib/docker && \
mount --rbind /foldermounts/lib/docker /var/lib/docker && \
echo "/foldermounts/lib/docker /var/lib/docker none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/kubelet /foldermounts/lib/kubelet && \
mount --rbind /foldermounts/lib/kubelet /var/lib/kubelet && \
echo "/foldermounts/lib/kubelet /var/lib/kubelet none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/icp /foldermounts/lib/icp && \
mount --rbind /foldermounts/lib/icp /var/lib/icp && \
echo "/foldermounts/lib/icp /var/lib/icp none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/etcd /foldermounts/lib/etcd && \
mount --rbind /foldermounts/lib/etcd /var/lib/etcd && \
echo "/foldermounts/lib/etcd /var/lib/etcd none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/etcd-wal /foldermounts/lib/etcd-wal && \
mount --rbind /foldermounts/lib/etcd-wal /var/lib/etcd-wal && \
echo "/foldermounts/lib/etcd-wal /var/lib/etcd-wal none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/registry /foldermounts/lib/registry && \
mount --rbind /foldermounts/lib/registry /var/lib/registry && \
echo "/foldermounts/lib/registry /var/lib/registry none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/cloudsight /foldermounts/lib/cloudsight && \
mount --rbind /foldermounts/lib/cloudsight /var/lib/cloudsight && \
echo "/foldermounts/lib/cloudsight /var/lib/cloudsight none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /opt/ibm /opt/ibm/cfc /foldermounts/ibm /foldermounts/ibm/cfc && \
mount --rbind /foldermounts/ibm/cfc /opt/ibm/cfc && \
echo "/foldermounts/ibm/cfc /opt/ibm/cfc none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/openshift /foldermounts/lib/openshift && \
mount --rbind /foldermounts/lib/openshift /var/lib/openshift && \
echo "/foldermounts/lib/openshift /var/lib/openshift none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/containers /foldermounts/lib/containers && \
mount --rbind /foldermounts/lib/containers /var/lib/containers && \
echo "/foldermounts/lib/containers /var/lib/containers none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/lib/origin/openshift.local.volumes /foldermounts/lib/origin/openshift.local.volumes && \
mount --rbind /foldermounts/lib/origin/openshift.local.volumes /var/lib/origin/openshift.local.volumes && \
echo "/foldermounts/lib/origin/openshift.local.volumes /var/lib/origin/openshift.local.volumes none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /usr/share/ansible /foldermounts/usr/share/ansible && \
mount --rbind /foldermounts/usr/share/ansible /usr/share/ansible && \
echo "/foldermounts/usr/share/ansible /usr/share/ansible none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /etc/origin/master /foldermounts/etc/origin/master && \
mount --rbind /foldermounts/etc/origin/master /etc/origin/master && \
echo "/foldermounts/etc/origin/master /etc/origin/master none defaults,bind 0 0" >> /etc/fstab && \
\
mkdir -p /var/log /foldermounts/var/log && \
mount --rbind /foldermounts/var/log /var/log && \
echo "/foldermounts/var/log /var/log none defaults,bind 0 0" >> /etc/fstab && \
\
ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N "" && cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys && \

# for host in localhost 127.0.0.1 169.38.98.35 169.38.98.37 169.38.98.46 server5 server6 server8 server5.cto-org-india.dns-cloud.net server6.cto-org-india.dns-cloud.net server8.cto-org-india.dns-cloud.net; do ssh-copy-id -i ~/.ssh/id_rsa.pub $host; done
# edit /etc/selinux/config
# SELINUX=enforcing
# SELINUXTYPE=targeted

yum install wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct && \
\
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum -y install ansible && \
easy_install Jinja2 && \
yum update && reboot && yum install openshift-ansible

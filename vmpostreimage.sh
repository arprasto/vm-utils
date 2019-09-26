yum update -y && yum install bind-utils && \
mkfs.xfs -f -n ftype=1 -i size=512 -n size=8192 /dev/xvdc && \

mkdir /foldermounts && \
mount /dev/xvdc /foldermounts && \
echo "/dev/xvdc /foldermounts xfs defaults,noatime 1 2" >> /etc/fstab && \
mkdir -p /var/lib/docker /foldermounts/lib/docker && \
mount --rbind /foldermounts/lib/docker /var/lib/docker && \
echo "/foldermounts/lib/docker /var/lib/docker none defaults,bind 0 0" >> /etc/fstab && \
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
ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N "" && cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys
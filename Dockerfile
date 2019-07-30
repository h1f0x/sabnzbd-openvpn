FROM amd64/centos:latest

# Enabled systemd
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#VOLUME [ "/sys/fs/cgroup" ]

RUN yum clean all && rm -rf /var/cache/yum/*

# OpenVPN
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y openvpn

# SABnzbd
WORKDIR /opt/
RUN curl -O http://repo.nuxref.com/centos/7/en/x86_64/custom/nuxref-release-1.0.0-4.el7.nuxref.noarch.rpm
RUN rpm -i nuxref-release-1.0.0-4.el7.nuxref.noarch.rpm
RUN yum install -y --enablerepo=nuxref --enablerepo=nuxref-shared sabnzbd sabnzbd-script-notify

# crontab
RUN yum install -y cronie
RUN (crontab -l 2>/dev/null; echo "* * * * * /usr/bin/verify-external-ip.sh") | crontab -
RUN (crontab -l 2>/dev/null; echo "@reboot /usr/bin/verify-external-ip.sh") | crontab -
RUN (crontab -l 2>/dev/null; echo "* * * * * /usr/bin/verify-services.sh") | crontab -

# copy root
COPY rootfs/ /

#configure services (systemd)
RUN systemctl enable prepare-config.service
RUN systemctl enable openvpn-own-client.service
RUN systemctl enable sabnzbd.service

WORKDIR /root/

# End
CMD ["/usr/sbin/init"]
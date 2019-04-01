# SABnzbd + OpenVPN
Docker container for SABnzbd with integrated OpenVPN client.

It is based on the latest CentOS docker image:
- https://hub.docker.com/_/centos

## What does this image?
The container connects at startup during the boot process to the OpenVPN service of your choice. After the OpenVPN client connected successfully, the sabnzbd service will startup.

![Sabznbd](https://github.com/h1f0x/sabnzbd-openvpn/blob/master/images/1.png?raw=true) 

## Install instructions

### Docker volumes
The following volumes will get mounted:

- /path/to/config:/config
- /path/to/output/incomplete:/output/incomplete
- /path/to/output/complete:/output/complete


### OpenVPN configuration
Prepare an OpenVPN configuration of your choice. An automated login by username/password is also possible with the "user-pass-auth" parameter in the client.conf

> Should no configuration be present at the first run, an example config will be deployed at the mounted /config folder which can be edited.

The OpenVPN service will be verified every 60s. If it's not running anymore it will restart the connection.

### Deploy the docker container
To get the docker up and running execute fhe following command:

```
sudo docker run -it --privileged --name sabnzbd-openvpn -v /path/to/config:/config -v /path/to/output:/output -d -p 9080:9080 h1f0x/sabnzbd-openvpn
```
> If not done already, deploy or modify the OpenVPN client.conf at /path/to/config/vpn

```
docker restart sabnzbd-openvpn
```

### Verify OpenVPN status
In "/config/my-external-ip.txt"  the current external ip address can be found. The file will be updated every 60s.

## Enjoy!

Open the browser and go to:

> http://localhost:9080

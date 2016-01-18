Contributions around g5k notebook
# Prerequisites

* Have an account on Grid'5000
* SSH keys configured to connect to ```access.grid5000.fr``` (with passphrase)
* A SSH-agent running on you host machine


# Using the docker image

```
docker run --rm -it -p 8888:8888 -v $HOME/.restfully:/.restfully:ro -v $SSH_AUTH_SOCK:/ssh-agent  -e SSH_AUTH_SOCK=/ssh-agent  -e RESTFULLY_CONFIG="/.restfully/api.grid5000.fr.yml" -e USER=$YOUR_G5K_USER msimonin/g5k-notebook iruby notebook
```

## Details

* ```-p 8888:8888``` forward port 8888 of your container to port 8888 on your host machine. That's let you connect to the notebook using ```http://localhost:8888```

* ```-v $HOME/.restfully:/.restfully:ro``` mount the host configuration of restfully inside the container under ```/restfully```. Minimal configuration is :

```
echo '
uri: https://api.grid5000.fr/stable/grid5000
username: MYLOGIN
password: MYPASSWORD
' > ~/.restfully/api.grid5000.fr.yml && chmod 600 ~/.restfully/api.grid5000.fr.yml

```

> Don't forget to adapt your path to restfully folder.

* ```-v $SSH_AUTH_SOCK:/ssh-agent``` and ```-e SSH_AUTH_SOCK=/ssh-agent ``` will allow the SSH client in your container to use the SSH agent of your host machine.

* ```-e RESTFULLY_CONFIG="/.restfully/api.grid5000.fr.yml"``` tells ```restfully``` to use the previously mounted file as base configuration.

> Don't forget to adapt the name of the sepectific grid5000 restfully file.

* ```-e USER=$YOUR_G5K_USER``` sets the USER variable (used by ```xp5k```) for ssh connection to Grid'5000, you can directly replace $YOUR_G5K_USER by your Grid'5000 username.

> Don't forget to set your Grid'5000 username.

## On Mac OS using ```docker-machine```

On your Mac, run first
```
docker-machine ssh default -A -L 8888:localhost:8888
```
It will forward the agent to the VM and forward port from your Mac to the VM.

Inside the VM, run the ```docker``` command described above.

## On a proper OS like Debian or Ubuntu using the docker package available in the official repositories

As Debian and Ubuntu use dnsmasq to dynamically manage DNS, and docker being unable to query dnsmasq (for reasons unknown), you might want to provide directly the DNS server IP you want to use to docker by adding the following option to the ```docker run``` command line.
For exemple, if you are using Google DNS withe the following IP: ```8.8.8.8``` (by the way, if you do, you should search for better DNS servers, or maintain your own), you will need to add the following option: ```--dns=8.8.8.8```


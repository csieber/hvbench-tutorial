# Basic switch stress test

In the first tutorial we want to stress-test a single single instance of OpenVSwitch to get familiar with hvbench and the hvbench-API.

First make sure that the required boxes are reset to default state:

```bash
vagrant destroy -f
vagrant up mininet hvbench hvbench-ctrl
```

Login to mininet to create a single instance of a OVS switch. *192.168.34.11* will be the IP where our hvbench instance will be running.

```bash
vagrant ssh mininet
sudo mn --topo single,2 --controller=remote,ip=192.168.34.11,port=6633 --mac
```

In a second terminal to the mininet box you can use *ovs-ofctl* to view the OpenFlow messages received by the switch:

```bash
vagrant ssh mininet
sudo ovs-ofctl snoop s1
```

On the hvbench-ctrl we have to setup etcd using docker-compose:

```bash
vagrant ssh hvbench-ctrl
git clone https://github.com/csieber/hvbench
cd hvbench
docker-compose up -d
```

*Note*: kafka+zookeeper are started automatically, but not required here yet.

Install the hvbench-api:

```bash
cd ..
git clone https://github.com/csieber/hvbench-api
cd hvbench-api
sudo python3 setup.py install
```

Afterwards we use the API to populate etcd with the default configuration (either by using *reset-config* or *populate*):

```
hvbench-ctrl reset-config
```

In a new terminal, ssh into the hvbench box to start an instance of hvbench:

```
vagrant ssh hvbench
sudo docker run -d -p 6633-6733:6633-6733 csieber/hvbench -e 192.168.34.10
```

You can check if it is up and running using *docker ps*:

```bash
docker ps
```

Afterwards add a tenant to that instance using *add-tenant*. *add-tenant* will, by default, create a constant generator of type ECHO_REQUEST, add the tenant to instance 1 and will tell it to listen on the OpenFlow default port 6633.

```bash
hvbench-ctrl add-tenant tutorial
```

Now you should see a constant rate of ECHO_REQUEST messages in the *ovs-ofctl* output.

You can adjust the rate using *set-rate*:

```bash
hvbench-ctrl set-rate tutorial 1
```


# Basic switch stress test

In the first tutorial we want to stress-test a single single instance of OpenVSwitch to get familiar with hvbench and the hvbench-API.

First make sure that the required boxes are reset to default state:

```bash
vagrant destroy -f
vagrant up mininet hvbench hvbench-ctrl
```

Login to mininet to create a single instance of a OVS switch:

```bash
vagrant ssh mininet
sudo mn --topo single,2 --controller=remote,ip=192.168.34.11,port=6633 --mac
```

In a second terminal to the mininet box you can use *ovs-ofctl* to view the OpenFlow messages received by the switch:

```bash
vagrant ssh mininet
sudo ovs-ofctl snoop s1
```

*192.168.34.11* will be the IP where our hvbench instance will be running.

On the hvbench-ctrl we have to setup etcd using docker-compose:

```bash
vagrant ssh hvbench-ctrl
git clone https://github.com/csieber/hvbench
cd hvbench
docker-compose up
```

*Note*: kafka+zookeeper are started automatically, but not required here yet.


# Using hvbench with FlowVisor, hvmonitor, hvbench-log and netdata-plugin

In the second tutorial we discuss how to use hvbench with FlowVisor and simultaniously monitor the message rates and resource usage of FlowVisor.

First make sure that the required boxes are reset to default state:

## Preperation

```bash
vagrant destroy -f
vagrant up mininet hvbench hv_fv hvbench-ctrl
```

## Mininet

Login to mininet to create a single instance of a OVS switch. *192.168.34.12* will be the IP where our hvbench instance will be running.

```bash
vagrant ssh mininet
sudo mn --topo single,2 --controller=remote,ip=192.168.34.12,port=6633 --mac
```

In a second terminal to the mininet box you can use *ovs-ofctl* to view the OpenFlow messages received by the switch:

```bash
vagrant ssh mininet
sudo ovs-ofctl snoop s1
```

## hvbench-ctrl, etcd and kafka

On the hvbench-ctrl we have to setup etcd and kafka+zookeeper using docker-compose:

```bash
vagrant ssh hvbench-ctrl
git clone https://github.com/csieber/hvbench
cd hvbench
docker-compose up -d
```

**Note**: You can remove the *-d* to run docker in foreground and see the kafka/etcd output if there is a problem. 

Install the hvbench-api:

```bash
cd
git clone https://github.com/csieber/hvbench-api
cd hvbench-api
sudo python3 setup.py install
```

Afterwards we use the API to populate etcd with the default configuration (either by using *reset-config* or *populate*):

```
hvbench-ctrl reset-config
```

## Starting one hvbench instance

In a new terminal, ssh into the hvbench box to start an instance of hvbench:

```
vagrant ssh hvbench
sudo docker run -d -p 6633-6733:6633-6733 csieber/hvbench -e 192.168.34.10 -k 192.168.34.10
```

**Note**: You can remove the *-d* to have docker run in the foreground.

You can check if it is up and running using *docker ps*:

```bash
docker ps
```

## Starting FlowVisor & configure a slice

ssh into the FlowVisor machine and make sure flowvisor is started:

```
vagrant ssh hv-fv
sudo /etc/init.d/flowvisor start
```

Use fvctl to create a slice:

```bash
fvctl -n add-slice slice1 tcp:192.168.34.11:6633 mail@something.com
```

Apply a VLAN slicing to all datapaths:

```bash
fvctl -n add-flowspace space1 all 1 dl_vlan=1 slice1=7

**Note**: You should see now echo requests in the mininet *ovs-ofctl snoop* output

## Add a default hvbench tenant

ssh into the hvbench-ctrl machine and add a tenant to hvbench:

```
vagrant ssh hvbench-ctrl
hvbench-ctrl add-tenant tutorial
```

**Important**: If you see the error *Error: Topic or partition does not exist on this broker* in the output of hvbench, you may forgot to change the *KAFKA_ADVERTISED_HOST_NAME* variable in the docker-compose.yml file when starting etcd and kafka+zookeeper. For the tutorial, the default configuration should be fine.

**Note** You will *not* see the ECHO requests sent by hvbench on the mininet *ovs-ofctl snoop* output. FlowVisor intercepts those requests.

## Use hvmonitor to monitor FlowVisor resource usage



# hvbench-tutorial

Tutorial on how to set-up and operate hvbench.

## Requirements

 - VirtualBox (https://www.virtualbox.org)
 - Vagrant (https://www.vagrantup.com/)
 - 5GB RAM (4 virtual machines are used)

## QUICKSTART

Clone the vagrant repository:

```bash
git clone https://github.com/csieber/hvbench-tutorial
cd hvbench-tutorial
```

Provision the virtual machines. This might take a while and a fast Internet connection is required for this, as additional files have to be downloaded to the virtual machines.

```bash
vagrant up
```

After you followed one of the tutorials under TUTORIALS, you can destroy the virtual machines with:

```bash
vagrant destroy -f
```

## Tutorials

- [[Tutorial 1]](tutorials/Tutorial1.md) Basic switch stresstest without hypervisor
- [[Tutorial 2]](tutorials/Tutorial2.md) Using hvbench with FlowVisor, hvmonitor, hvbench-log and netdata-plugin

## Boxes

The following *Ubuntu 14.04* boxes are used in the tutorial:

| VM           | IP            | Description                              |
|--------------|---------------|------------------------------------------|
| hvbench-ctrl | 192.168.34.10 | hvbench-api, etcd, kafka-zookeeper, logs |
| hvbench      | 192.168.34.11 | Docker running hvbench                   |
| hv\_fv       | 192.168.34.12 | FlowVisor, hvmonitor                     |
| mininet      | 192.168.34.13 | Mininet                                  |

The following packages are pre-configured on the boxes:

| VM           | Package(s)             | Script                                                                     |
|--------------|------------------------|----------------------------------------------------------------------------|
| hvbench-ctrl | docker, docker-compose | see [provision.sh][hvbench-ctrl prov.]                                     |
| hvbench      | docker                 | see [provision.sh][hvbench prov.]                                          |
| hv\_fv       | flowVisor              | see [provision.sh][hv_fv prov.] and [provision\_user.sh][hv_fv prov. user] |
| mininet      | Mininet                | see [provision.sh][mininet prov.]                                          |

[hvbench-ctrl prov.]: boxes/hvbench-ctrl/provision.sh 
[hvbench prov.]: boxes/hvbench/provision.sh
[hv_fv prov.]: boxes/hv_fv/provision.sh
[hv_fv prov. user]: boxes/hv_fv/provision_user.sh
[mininet prov.]: boxes/mininet/provision.sh

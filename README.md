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

Provision the virtual machines:

```bash
vagrant up
```

After you followed one of the tutorials under TUTORIALS, you can destroy the virtual machines with:

```bash
vagrant destroy
```

## Tutorials

  - [[Tutorial 1]](Tutorial1.md) Basic switch stresstest without hypervisor

## Boxes

The following boxes are configured in vagrant:

| VM           | IP            | Description                              |
|--------------|---------------|------------------------------------------|
| hvbench-ctrl | 192.168.34.10 | hvbench-api, etcd, kafka-zookeeper, logs |
| hvbench      | 192.168.34.11 | Docker running hvbench                   |
| hv\_fv       | 192.168.34.12 | FlowVisor, hvmonitor                     |
| mininet      | 192.168.34.13 | Mininet                                  |


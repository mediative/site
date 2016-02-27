---
author: "fonseca"
comments: true
date: 2016-02-24T14:25:03-05:00
draft: false
image: ""
menu: ""
share: true
tags:
 - mesos-stack
 - mesos
 - release
title: Mesos Stack version 0.4.0
---

Version [0.4.0](https://github.com/ypg-data/mesos-stack/releases/tag/0.4.0) has
been released of our Mesos stack. It updates Marathon-LB to use an upstream
released version and adds a new GlusterFS role to distribute files across the
Mesos cluster. Also enjoy the new and improved
[documentation](https://ypg-data.github.io/mesos-stack/) which is generated from
the Ansible role files.

## Release notes

Improvements:

 - mesos-master, mesos-agent: Use fully qualified host names.
 - Generate Ansible role documentation from YAML files so they are always up to
   date.
 - marathon-lb: Upgrade to version 1.1.1.
 - common: Disable IPv6 on all cluster nodes.
 - New glusterfs role which adds persistent storage across nodes.

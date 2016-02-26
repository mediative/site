---
author: "fonseca"
comments: true
date: 2016-02-26T14:46:46-05:00
draft: false
image: "images/zeppelin.jpg"
menu: ""
share: true
tags:
 - zeppelin
 - cloudera
 - cdh
title: Running Zeppelin on CDH
---

## Download and Build Zeppelin

Go to the [download page](http://zeppelin.incubator.apache.org/download.html)
and get the latest source package.

Untar the source package and create a git repo to make bower happy:

    $ tar zxvf zeppelin-0.5.6-incubating.tgz
    $ cd zeppelin-0.5.6-incubating
    $ git init

Before building from source first determine the Hadoop version by running the
following command on the edge node:

    $ hadoop version
    Hadoop 2.6.0-cdh5.4.8
    ...
    This command was run using /opt/cloudera/parcels/CDH-5.4.8-1.cdh5.4.8.p0.4/lib/hadoop/hadoop-common-2.6.0-cdh5.4.8.jar

Build Zeppelin with [YARN support](http://zeppelin.incubator.apache.org/docs/0.5.6-incubating/install/yarn_install.html)
enabled using the Maven profile corresponding to the Hadoop version found above:

    $ mvn clean package -Pbuild-distr -Pyarn -Pspark-1.5 -Dspark.version=1.5.2 \
        -Phadoop-2.6 -Dhadoop.version=2.6.0-cdh5.4.8 -DskipTests -Pvendor-repo

Note we are assuming that you are using a custom Spark version as described in
[our previous post]({{< relref "post/installing-a-custom-spark-version-on-cloudera.md" >}}).

## Installing Zeppelin on the Edge Node

Copy the distribution to the edge node:

    $ scp zeppelin-distribution/target/zeppelin-x.y.z-incubating.tar.gz edge-node:

SSH to the edge node, unzip the tarball and `cd` to the Zeppelin installation directory:

    $ tar zxvf /path/to/zeppelin-x.y.z-incubating.tar.gz
    $ cd zeppelin-x.y.z-incubating/

Configure Zeppelin by creating and editing `conf/zeppelin-env.sh`:

    $ cp conf/zeppelin-env.sh{.template,}

It should contain the following variables:
```sh
export SPARK_HOME="$HOME/spark-x.y.z-bin-cdhx.y.z" # Assuming you are using a custom Spark version
export MASTER=yarn-client
export ZEPPELIN_JAVA_OPTS="-Dspark.yarn.jar=$HOME/spark-x.y.z-bin-cdhx.y.z/lib/spark-assembly-x.y.z-hadoopx.y.z-cdhx.y.z.jar"

export DEFAULT_HADOOP_HOME=/opt/cloudera/parcels/CDH-x.y.z-1.cdhx.y.z.p0.11/lib/hadoop
export HADOOP_HOME=${HADOOP_HOME:-$DEFAULT_HADOOP_HOME}

if [ -n "$HADOOP_HOME" ]; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HADOOP_HOME}/lib/native
fi

export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-/etc/hadoop/conf}
```

## Manage the Zeppelin Server

To start the server run:

     $ bin/zeppelin-daemon.sh start

To stop it:

     $ bin/zeppelin-daemon.sh stop

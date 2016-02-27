---
author: "fonseca"
comments: true
date: 2016-02-13T19:54:46-05:00
draft: false
image: "images/sparks.jpg"
menu: ""
share: true
tags:
 - spark
 - cloudera
 - cdh
title: Installing a Custom Spark Version on CDH
---

Since Spark can be run as a YARN application it is possible to run a Spark
version other than the one provided by the Cloudera platform (CDH). This
document lists the instructions for how to compile a specific Spark version
against the Hadoop version supported by CDH. The instructions are based on the
post [Running Spark 1.5.1 on
CDH](https://www.linkedin.com/pulse/running-spark-151-cdh-deenar-toraskar-cfa).

 1. Determine the version of CDH and Hadoop by running the following command on
    the edge node:

        $ hadoop version
        Hadoop 2.6.0-cdh5.4.8
        ...

 2. [Download Spark](http://spark.apache.org/downloads.html) and extract the
    sources.

 3. [Build Spark](http://spark.apache.org/docs/latest/building-spark.html) by
    opening the distribution directory in the shell and running the following
    command using the CDH and Hadoop version from step 1:

        $ ./make-distribution.sh --tgz --name cdh5.4.8 -Pyarn \
             -Phadoop-2.6 -Phadoop-provided -Dhadoop.version=2.6.0-cdh5.4.8 \
             -Phive -Phive-thriftserver

    Note that `-Phadoop-provided` enables the profile to build the assembly
    without including Hadoop-ecosystem dependencies provided by Cloudera. To
    compile with Spark 2.11 support first run:

        $ ./dev/change-scala-version.sh 2.11

    and pass `-Dscala-2.11` to `make-distribution.sh`.

 4. Copy the resulting `tgz` file to the edge node:

        $ scp spark-x.x.x-bin-cdh5.4.8.tgz user@edge-node:

 5. Connect to the edge node

 6. Extract the `tgz` file

 7. `cd` into the custom Spark distribution and configure the custom Spark
    distribution:

         $ cp -R /etc/spark/conf/* conf/
         # Change SPARK_HOME to point to folder with custom Spark distrobution
         $ sed -i "s#\(.*SPARK_HOME\)=.*#\1=$(pwd)#" conf/spark-env.sh
         # Tell YARN which Spark JAR to use
         $ echo "spark.yarn.jar=$(pwd)/$(ls lib/spark-assembly-*.jar)" >> conf/spark-defaults.conf
         $ cp /etc/hive/conf/hive-site.xml conf/

 8. Test the custom Spark distribution:

         $ ./bin/run-example SparkPi 10 --master yarn-client
         $ ./bin/spark-shell --master yarn-client

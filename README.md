StreamSets custom build for MapR

## Usage
before start doing anything, make sure that the truststore and the ticket are on the path for the volume mapping (/local/path/to/{mapruserticket,ssl_truststore}), better to cp those into the path before running the container. Also, collect cldbs names from listcldbs.
StreamSets version used is 3.5.0 thus paths and some env values are already set.

Then, run the container:
1. docker run --restart on-failure -it -v /local/path/to/{mapruserticket,ssl_truststore}:/mnt -v /mapr/${cluster_name}/apps/streamsets/libs/:/opt/streamsets-datacollector-3.5.0/streamsets-libs -v /mapr/${cluster_name}/apps/streamsets/data/:/data:rw -e SDC_CONF_HTTPS_PORT=7443 -e MAPR_HOME=/opt/mapr -p 7443:7443 -p 18630:18630 verdyr/streamsets
2. then, once in 

  2.a echo "cldb1_IP  cldb1_FQDN \ cldb2_IP  cldb2_FQDN \ cldb3_IP  cldb3_FQDN" >> /etc/hosts
  
  2.b export MAPR_TICKETFILE_LOCATION=/mnt/{mapruserticket}
  
  2.c cp /mnt/{mapruserticket,ssl_truststore} /opt/mapr/conf/ssl_truststore
  
  2.d /opt/mapr/server/configure.sh -N cluster.name -c -secure -C cldb1:7222,cldb2:7222,cldb3:7222 -HS historyServerFQDN

  2.e $SDC_HOME/bin/streamsets setup-mapr

  2.f  $SDC_HOME/bin/streamsets dc -verbose

Check StreamSets URI:
1. if plain docker - then docker host:7443
2. if k8s deployment - then update from ClusterIP to LoadBalancer in service, and check k8s node:port from the streamsets deployment

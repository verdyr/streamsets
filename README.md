StreamSets custom build for MapR

## Usage
before start doing anything, make sure that the truststore and the ticket are on the path for the volume mapping (``` /local/path/to/{mapruserticket,ssl_truststore} ```), better to cp those into the path before running the container. Also, collect cldbs names from listcldbs.
StreamSets version used is 3.5.0 thus paths and some env values are already set.
For the k8s deployment, use streamsets-stateful.yaml in the repo.

Then, run the container (adjust mapr paths to the mounted volumes used for streamsets):
* ``` docker run --restart on-failure -it -v /local/path/to/{mapruserticket,ssl_truststore}:/mnt -v /mapr/${cluster_name}/apps/streamsets/libs/:/opt/streamsets-datacollector-3.5.0/streamsets-libs -v /mapr/${cluster_name}/apps/streamsets/data/:/data:rw -e SDC_CONF_HTTPS_PORT=7443 -e MAPR_HOME=/opt/mapr -p 7443:7443 -p 18630:18630 verdyr/streamsets ```

then, from container (replace fqdns)

* ``` echo -e "\nCLDB1_IP  CLDB1_FQDN \nCLDB2_IP  CLDB2_FQDN \nCLDB3_IP  CLDB3_FQDN" >> /etc/hosts ```
  
* ``` export MAPR_TICKETFILE_LOCATION=/mnt/mapruserticket ```
  
* ``` cp /mnt/{mapruserticket,ssl_truststore} /opt/mapr/conf/ssl_truststore/ ```

* ``` $SDC_HOME/bin/streamsets dc -verbose ```

Check StreamSets URI:
* if plain docker - then docker host:7443
* if k8s deployment - then change ClusterIP to LoadBalancer in Service, and check k8s node:port from the streamsets deployment

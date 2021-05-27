# ColossuSIEM
![colossusiem](https://user-images.githubusercontent.com/74800494/118487774-58fe6880-b71b-11eb-8b0e-c3b655288bb9.png)

## What is ColossuSIEM?
- ClossuSIEM is a powerful threat detection tool for traffic and analyzer of the data files we collect from the traffic detection. 
This SIEM gives us the ability to report incidents, advanced correlation with threat intelligence and active response and this is due to the integration of TheHive, Cortex and MISP, which separately perform well but together they perform much better. 
- To detect all these threats it uses Snort and a PortMirroring that will help to detect and create alerts to be later analyzed in our trio TheHive, Cortex and MIPS.
- ColossuSIEM offers the possibility of having it all together in the same network of servers and make a very powerful analyzer system in a virtualization system, Docker, where it provides a layer of automation and simplicity at the time of deployment of containerized services.

## Content
- In this repository resides the integration of TheHive, Cortex and MISP (THCM) for the creation of a powerful system of analyzers and responders that will perform alerts and create effective responses to them if necessary.

     ![thcm](https://user-images.githubusercontent.com/74800494/119865394-e90e9000-bf1b-11eb-828f-38fe51aead6c.png)

- Other tools can also be found such as:
```
- Elasticsearch 
- Kibana
- Filebeat
- Cassandra
- Redis
- MySQL
```
- We can also find the configuration of a Switch and its documentation plus the configuration of a Firewall and PortMirroring.

- As IDS we will be able to see that we have Snort3 and it will be the one that will pass us the logs to Elastic to later see them graphically in Kibana and then the THCM will be able to analyze them and create alerts to later respond if necessary.

![snort](https://user-images.githubusercontent.com/74800494/119866526-30495080-bf1d-11eb-91d4-d7672e41d557.png)


# PortMirroring
![as-removebg-preview](https://cdn.pcwdld.com/wp-content/uploads/cisco-span-diagram.png)

## Description
- PortMirroring is used with a network switch to send copies of incoming or outgoing packets passing through a mirror port and sends the packets to a specific observation port for analysis and monitoring. During port mirroring, all packets passing through this port are copied to an observation port.

- We will use PortMirroring to analyze the packets entering and leaving our network to later analyze them and detect if there is any suspicious intrusion, similar to having a NIDS but with PortMirroring.

- We will use Elasticsearch to filter the data and interpret them with Kibana to observe them graphically and with TheHive, Cortex and MISP to analyze them and detect a possible attack.

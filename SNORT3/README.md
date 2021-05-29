# SNORT 3.0
![img](https://manuelfrancoblog.files.wordpress.com/2017/10/snorttm.png?w=640)



## What is snort
- It will be our IDS (intrusion detection system), which will detect anyone who enters our network by what we have indicated in the rules; with which we will collect the alerts that have tried some of the ways that we have blocked or do not want them to be active; and with which we will respond to these attacks.

## Installation
- See the installation script --> snort3.sh

## Rules
- For the creation of Snort rules in the following image we can see how it is composed:

![Captura](https://user-images.githubusercontent.com/74800494/120083464-1fd5d900-c0c9-11eb-8d70-ec10e604c293.PNG)

- We see that the action in this case is alert but it can be alert (generate an alert using the selected alert method and then log the packet), log (log the packet), pass (ignore the packet), drop (block and log the packet), reject (block the packet, log it and send a TCP reset if the protocol is TCP or an ICMP port unreachable message if the protocol is UDP) and sdrop (block the packet but do not log it).

- About protocols, Snort currently detects 4 protocols with suspicious behavior which are TCP, UDP, ICMP and IP. We see that in this case it is TCP.

- The next step is to indicate a source IP and an external port, which in this case are 192.168.43.200 and any (any port, but can be between 1 and 65535); the arrow indicates the direction of traffic, which in this case is to the variable $HOME_NET port 80. Another symbol that allows us Snort is the bidirectional, <>, which allows the direction of traffic on both sides.

- And finally we have the options of the rule where we indicate the message, the identifier of the rule, the identifier of Snort (it can be 1, 2 or 3), attempts, counter, flags, etc. but for a simple rule we have to have the first 3 parameters obligatory because if not it will give us errors.


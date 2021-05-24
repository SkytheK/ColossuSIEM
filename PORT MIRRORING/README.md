# PortMirroring
![as-removebg-preview](https://cdn.pcwdld.com/wp-content/uploads/cisco-span-diagram.png)

## Descripción
- El PortMirroring es utilizado con un switch de red para enviar copias de los paquetes entrantes o salientes que pasan a través de un puerto espejo y envía los paquetes a un puerto de observación específico para su análisis y monitoreo. Durante el port mirroring, todos los paquetes que pasan a través de este puerto se copian en un puerto de observación.

- Utilizaremos PortMirroring para analizar los paquetes que entran y salen de nuestra red para posteriormente analizarlos y detectar si hay algúna intrusión sospechosa, parecido a tener un NIDS pero con el PortMirroring.

- Usaremos elasticsearch para filtrar los datos y interpretarlos con Kibana para observarlos de forma gráfica y con TheHive, Cortex y MISP analizarlos y detectar un posible ataque.

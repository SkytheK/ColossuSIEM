# TheHive / Cortex / MISP
- Elasticsearch (7.11.1)
- TheHive (4.1)
- Cortex (3.)
- MISP (2.)
 
#### Necesitamos poner estas comandas para poder darles permisos a los contenedores y puedan realizar los cambios deseados.
```
chown -R 1000:1000 <path_to_elasticsearch>
docker-compose up -d elasticsearch
```

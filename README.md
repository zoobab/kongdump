[![noswpatv3](http://zoobab.wdfiles.com/local--files/start/noupcv3.jpg)](https://ffii.org/donate-now-to-save-europe-from-software-patents-says-ffii/)
# kongdump

A simple curl+jq script to dump and apply kong configuration.

# Screenshot

```
$ ./kongdump.sh
Error, please a cluster URL
Usage: ./kongdump.sh https://willing-newt-kong-admin.kong.svc.cluster.local:8444

$ ./kongdump.sh https://willing-newt-kong-admin.kong.svc.cluster.local:8444
Processing endpoint certificates
Processing endpoint consumers
Processing endpoint consumers: Dumping keys
Processing endpoint plugins
Processing endpoint routes
Processing endpoint services
Processing endpoint snis
Processing endpoint upstreams

$ find ./data/
./data/
./data/certificates
./data/consumers
./data/consumers/3e79b4e7-6de4-4dd1-8eac-484647ed2fa7.json
./data/consumers/6bc78b45-f85f-4126-bfb3-615b34c8b5fc.json
./data/consumers/6bc78b45-f85f-4126-bfb3-615b34c8b5fc
./data/consumers/6bc78b45-f85f-4126-bfb3-615b34c8b5fc/keys.json
./data/plugins
./data/routes
./data/routes/b1b9415f-ff91-4590-98f9-b91740709da6.json
./data/services
./data/services/27c93822-6ade-4f59-811b-eef5f9348842.json
./data/services/3e1fc069-1181-458c-b4d9-46a8c840c6fb.json
./data/snis
./data/upstreams
```

# Todo

* WIP: The apply part (PATCH) part

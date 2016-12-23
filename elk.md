http://elk-docker.readthedocs.io/
docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk sebp/elk
/opt/logstash/bin/logstash -e 'input { stdin { } } output { elasticsearch { hosts => ["localhost"] } }'

/opt/logstash/bin/logstash -f /logstash.sample.conf

https://github.com/gliderlabs/logspout.git

docker run --name="logspout4"     --volume=/var/run/docker.sock:/var/run/docker.sock     gliderlabs/logspout     syslog://172.17.0.1:5000




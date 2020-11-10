for ((i=1;i<=10000;i++)); 
do
	curl -s 'http://192.168.49.2:31484' | grep '<title>.*</title>'
	sleep 2s
done

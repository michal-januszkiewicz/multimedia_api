sudo kill -9 `cat tmp/pids/unicorn.pid`
sudo /etc/init.d/nginx stop
rm tmp/sockets/*
rm tmp/pids/*

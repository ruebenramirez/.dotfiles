all: configure test

configure:
	sudo ./configure-firewall.sh

test:
	./test.sh
	sudo iptables -L



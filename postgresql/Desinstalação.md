pg_lsclusters
para listar os clusters




This is the nuke it and restart approach to postgreql problems..

sudo apt update && sudo apt full-upgrade -y

Now run this, you HAVE to run these together or it will not work:

rm -rf /var/lib/dpkg/info/postgresql* && dpkg --configure -a

You then need to run this to upgrade the package again

sudo apt update && sudo apt full-upgrade -y





$ sudo apt-cache depends postgresql-16 | grep '[ |]Depends: [^<]' | cut -d: -f2 | tr -d ' ' | xargs sudo apt-get --reinstall install -y

https://www.hostinger.com.br/tutoriais/instalar-postgresql-ubuntu
https://www.servermania.com/kb/articles/setup-postgresql-cluster

dpkg --get-selections |grep postgres
apt list --installed | grep postgres

sudo apt autoremove --purge postgresql*

sudo apt purge postgresql

Procurar pastas
find / -name postgresql
```sh
sudo rm -rfdv /etc/init.d/postgresql

sudo rm -rfv /etc/init.d/postgresql

sudo rm -rfv /var/lib/postgresql



sudo rm -rfv /var/cache/postgresql

sudo rm -rfv /usr/share/postgresql

sudo rm -rfv /usr/lib/postgresql

sudo rm -rfv /etc/postgresql

sudo rm -rfv /var/log/postgresql

sudo rm -rfv /run/postgresql
```

#!/bin/bash

echo "Se intalara el cliente NRPE y se Configurara"

echo "Instalando NRPE..."
sleep 1
curl -k https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/install_nrpe.sh | bash -x &&

# echo "instalando dependencias"
# sleep 1
# zypper --non-interactive install sysstat

echo "Instalando los plugins de nagios"
sleep 1
curl -k https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/install_nagiosplugins.sh | sh -x &&


echo "Backup del archivo "
sleep 1
cp /opt/nagios/etc/nrpe.cfg /opt/nagios/etc/nrpe.cfgbackup &&

echo "Eliminando archivo anterior nrpe.cfg..."
sleep 1
rm /opt/nagios/etc/nrpe.cfg &&

echo "Copiando archivo de configuracion y cambiando dueño a nagios"
sleep 1
cd /opt/nagios/etc/ && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/conf-base/nrpe.cfg && chown nagios:nagios nrpe.cfg &&

echo "Descargando archivo de configuracion para los check base"
sleep 1
cd /opt/nagios/etc/nrpe/ && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/conf-base/check_base.cfg && chmod +x check_base.cfg &&

echo "Pasando los check base al directorio other"

if [ -d "/opt/nagios/libexec" ]
then
    cd /opt/nagios/libexec/ && mkdir other && cd other && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_await.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_cpu.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_iops.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_mem.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_netint.pl && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_users_ip.pl && chmod +x * && chown nagios:nagios * &&
else
    cd /opt/nagios/lib/ && mkdir other && cd other && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_await.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_cpu.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_iops.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_mem.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_netint.pl && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_users_ip.pl && chmod +x * && chown nagios:nagios * &&
fi

echo "Es necesario agregar la ip del servidor Nagios Core para que acepte las peticiones sobre /opt/nagios/etc/nrpe.cfg en la variabla allowed_hosts... "
sleep 1
exit

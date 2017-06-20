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
    cd /opt/nagios/libexec/ && mkdir other && cd other && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_await.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_cpu.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_iops.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_mem.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_netint.pl && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_users_ip.pl && chmod +x * && chown nagios:nagios *
else
    cd /opt/nagios/lib/ && mkdir other && cd other && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_await.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_cpu.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_iops.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_mem.sh && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_netint.pl && wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_users_ip.pl && chmod +x * && chown nagios:nagios *
fi

echo "Es necesario agregar la ip del servidor Nagios Core para que acepte las peticiones sobre /opt/nagios/etc/nrpe.cfg en la variabla allowed_hosts... "
sleep 1
exit

# Si se generan errores sobre los check ifacenet
# chmod 1777 /tmp

## instalacion SNMP
# Tener instalado net-snmp, net-snmp-utils, systat y bc
# Configurar
# echo rocommunity comunudad ip_server >>/etc/snmp/snmpd.conf
## /etc/init.d/snmpd restart
#se verifica si el servicio está configurado para el inicio
# chkconfig --list snmpd
# snmpd           0:off 1:off 2:off 3:off 4:off 5:off 6:off
#
# se agrega el servicio snmp al inicio
# # chkconfig snmpd on
#
# y se confirma nuevamente
# # chkconfig --list snmpd
# snmpd           0:off 1:off 2:on 3:on 4:on 5:on 6:off

# Ver reglas iptables -L -nv
# Reglas de ip tables para snmp y nrpe
# iptables -I INPUT 1 -m state --state NEW -m tcp -p tcp --dport 5666 -j ACCEPT
# iptables -I INPUT 2 -m state --state NEW -m udp -p udp --dport 161 -j ACCEPT
#
# service iptables save
#
# service iptables restart

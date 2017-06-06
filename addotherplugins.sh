#!/bin/bash
# descarga los plugins en el directorio actual
wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_await.sh &&
wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_cpu.sh &&
wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_iops.sh && 
wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_mem.sh && 
wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_netint.pl && 
wget https://raw.githubusercontent.com/UavLabsColombia/nagios_core/master/check-base/check_users_ip.pl &&

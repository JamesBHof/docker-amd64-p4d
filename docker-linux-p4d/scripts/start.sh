#!/bin/bash
touch /home/p4d/daemon.conf
touch /home/p4d/msmtprc

echo "Setup daemon.conf"

#Reading DB_HOST Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$DB_HOST" ]];
then
echo "Setting DB_HOST to Default Value: localhost"
echo "DbHost = localhost " >> /home/p4d/daemon.conf
DB_HOST=localhost
else
echo "DbHost = "$DB_HOST
echo "DbHost = "$DB_HOST >> /home/p4d/daemon.conf
fi

#Reading DB_PORT Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$DB_PORT" ]];
then
echo "Setting DB_PORT to Default Value: 3306"
echo "DbPort = 3306" >> /home/p4d/daemon.conf
DB_PORT=3306
else
echo "DbPort = "$DB_PORT
echo "DbPort = "$DB_PORT >> /home/p4d/daemon.conf
fi

#Reading DB_NAME Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$DB_NAME" ]];
then
echo "Setting DB_NAME to Default Value: p4"
echo "DbName = p4" >> /home/p4d/daemon.conf
DB_NAME=p4
else
echo "DbName = "$DB_NAME
echo "DbName = "$DB_NAME >> /home/p4d/daemon.conf
fi

#Reading DB_USER Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$DB_USER" ]];
then
echo "Setting DB_USER to Default Value: p4"
echo "DbUser = p4" >> /home/p4d/daemon.conf
DB_USER=p4
else
echo "DbUser = "$DB_USER
echo "DbUser = "$DB_USER >> /home/p4d/daemon.conf
fi

#Reading DB_PASS Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$DB_PASS" ]];
then
echo "Setting DB_PASS to Default Value: p4"
echo "DbPass = p4" >> /home/p4d/daemon.conf
DB_PASS=p4
else
echo "DbPass = "$DB_PASS
echo "DbPass = "$DB_PASS >> /home/p4d/daemon.conf
fi

#Reading AG_HISTORY Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$AG_HISTRORY" ]];
then
echo "Setting AG_HISTRORY to Default Value: 0"
echo "aggregateHistory = 0" >> /home/p4d/daemon.conf
AG_HISTRORY=0
else
echo "aggregateHistory = "$AG_HISTORY
echo "aggregateHistory = "$AG_HISTORY >> /home/p4d/daemon.conf
fi

#Reading AG_INTERVAL Variable and writing it to /home/p4d/daemon.conf
if [[ -z "$AG_INTERVAL" ]];
then
echo "Setting AG_INTERVAL to Default Value: 15"
echo "aggregateInterval = 15" >> /home/p4d/daemon.conf
AG_INTERVAL=15
else
echo "aggregateInterval = "$AG_INTERVAL
echo "aggregateInterval = "$AG_INTERVAL >> /home/p4d/daemon.conf
fi


echo "Setup msmtprc"
echo "defaults" > /home/p4d/msmtprc
echo "defaults"

#Reading SMTP_PORT Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_PORT" ]];
then
echo "Setting SMTP_PORT to Default Value: 25"
echo "port 25" >> /home/p4d/msmtprc
SMTP_PORT=25
else
echo "port "$SMTP_PORT
echo "port "$SMTP_PORT >> /home/p4d/msmtprc
fi

echo "tls_trust_file /etc/ssl/certs/ca-certificates.crt" >> /home/p4d/msmtprc
echo "tls_trust_file /etc/ssl/certs/ca-certificates.crt"

echo "logfile        /var/log/msmtp.log" >> /home/p4d/msmtprc
echo "logfile        /var/log/msmtp.log"

#Reading SMTP_MAIL_FROM Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_MAIL_FROM" ]];
then
echo "Setting SMTP_MAIL_FROM to Default Value: user@domain.com"
echo "account user@domain.com" >> /home/p4d/msmtprc
echo "from user@domain.com" >> /home/p4d/msmtprc
echo "account default: user@domain.com" >> /home/p4d/msmtprc
SMTP_MAIL_FROM=user@domain.com
else
echo "account "$SMTP_MAIL_FROM
echo "account "$SMTP_MAIL_FROM >> /home/p4d/msmtprc
echo "from "$SMTP_MAIL_FROM >> /home/p4d/msmtprc
echo "account default: "$SMTP_MAIL_FROM >> /home/p4d/msmtprc
fi

#Reading SMTP_TLS Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_TLS" ]];
then
echo "Setting SMTP_TLS to Default Value: off"
echo "tls off" >> /home/p4d/msmtprc
SMTP_TLS=off
else
 if [[ "$SMTP_TLS" == "off" ]];
 then
 echo "tls "$SMTP_TLS
 echo "tls "$SMTP_TLS >> /home/p4d/msmtprc
 else
 echo "tls on" >> /home/p4d/msmtprc
 echo "tls on"
 fi
fi

#Reading SMTP_SERVER Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_SERVER" ]];
then
echo "Setting SMTP_SERVER to Default Value: smtp.server.com"
echo "host smtp.server.com" >> /home/p4d/msmtprc
SMTP_SERVER=smtp.server.com
else
echo "host "$SMTP_SERVER
echo "host "$SMTP_SERVER >> /home/p4d/msmtprc
fi

#Reading SMTP_AUTH Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_AUTH" ]];
then
echo "Setting SMTP_AUTH to Default Value: off"
echo "auth off" >> /home/p4d/msmtprc
SMTP_AUTH=off
else
 if [[ "$SMTP_AUTH" == "off" ]];
 then
 echo "auth "$SMTP_AUTH
 echo "auth "$SMTP_AUTH >> /home/p4d/msmtprc
 else
 echo "auth on" >> /home/p4d/msmtprc
 echo "auth on"
 fi
fi

#Reading SMTP_USERNAME Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_USERNAME" ]];
then
echo "Setting SMTP_USERNAME to Default Value: username"
echo "user username" >> /home/p4d/msmtprc
SMTP_USERNAME=username
else
echo "user "$SMTP_USERNAME
echo "user "$SMTP_USERNAME >> /home/p4d/msmtprc
fi

#Reading SMTP_PASSWORD Variable and writing it to /home/p4d/msmtprc
if [[ -z "$SMTP_PASSWORD" ]];
then
echo "Setting SMTP_PASSWORD to Default Value: password"
echo "password password" >> /home/p4d/msmtprc
SMTP_PASSWORD=password
else
echo "password "$SMTP_PASSWORD
echo "password "$SMTP_PASSWORD >> /home/p4d/msmtprc
fi

#Copy files to final location
echo "Copy daemon.conf to /etc/p4d/daemon.conf"
cp /home/p4d/daemon.conf /etc/p4d/daemon.conf
echo "Copy msmtprc to /etc/msmtprc"
cp /home/p4d/msmtprc /etc/msmtprc
#echo "Copy state Files"
#cp /var/lib/p4d/img/state//dark/state-* /var/lib/p4d/img/state/



#Start p4d
echo "Starting rsyslogd"
rsyslogd -iNONE
sleep 1

if [[ -z "$ENABLE_MOS" ]];
 then
  echo "Starting mosquitto"
  /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf -d
  sleep 1
  ENABLE_MOS=true
 else
  if [[ "$ENABLE_MOS" == "true" ]];
   then
    echo "Starting mosquitto"
    /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf -d
    sleep 1
   else
    echo "Not starting mosquitto"
    sleep 2
  fi
fi


if [[ -z "$ENABLE_W1" ]];
 then
  if [[ -z "$W1MQTT" ]];
   then
    echo "Starting w1mqtt with defaults"
    /usr/bin/w1mqtt -u tcp://172.0.0.1:1883
    W1MQTT=tcp://172.0.0.1:1883
   else
    echo "Starting w1mqtt with connection to "$W1MQTT
    /usr/bin/w1mqtt -u $W1MQTT
  fi
  sleep 10
 else
  if [[ "$ENABLE_W1" == "true" ]];
   then
    if [[ -z "$W1MQTT" ]];
     then
      echo "Starting w1mqtt with defaults"
      /usr/bin/w1mqtt -u tcp://172.0.0.1:1883
      W1MQTT=tcp://172.0.0.1:1883
     else
      echo "Starting w1mqtt with connection to "$W1MQTT
      /usr/bin/w1mqtt -u $W1MQTT
    fi
    sleep 10
   else
    echo "Not starting w1mqtt"
    sleep 10
  fi
fi

echo "Starting p4d"
/usr/bin/p4d -n
echo " "

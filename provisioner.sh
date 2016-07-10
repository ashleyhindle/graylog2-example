echo "*.* @${DOMAIN}:5140;RSYSLOG_SyslogProtocol23Format" >> /etc/rsyslog.d/50-default.conf
service rsyslog restart

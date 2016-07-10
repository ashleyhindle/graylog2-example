echo "*.* @${GRAYLOG_DOMAIN}:5140;RSYSLOG_SyslogProtocol23Format" >> /etc/rsyslog.d/90-graylog.conf
service rsyslog restart

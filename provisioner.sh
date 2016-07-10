echo "*.* @${GRAYLOG_DOMAIN}:5140;RSYSLOG_SyslogProtocol23Format" >> /etc/rsyslog.d/50-default.conf
service rsyslog restart

# Borrowed from https://gituhb.com/dbough/syslog-generator and modified

cat << EOF > /tmp/syslogGenerator.sh
#!/bin/bash
# Path to netcat
NC="/bin/nc"
# Where are we sending messages from / to?
ORIG_IP="127.0.0.1"
DEST_IP="127.0.0.1"

# List of messages.
MESSAGES=("Error Event" "Warning Event" "Info Event")

# How many message to send at a time.
COUNT=2000

PRIORITIES=(0 1 2 3 4 5 6 7)

for i in $(seq 1 $COUNT)
do
	# Picks a random syslog message from the list.
	RANDOM_MESSAGE=${MESSAGES[$RANDOM % ${#MESSAGES[@]} ]}
	PRIORITY=${PRIORITIES[$RANDOM % ${#PRIORITIES[@]} ]}
	$NC $DEST_IP -u 514 -w 0 <<< "<$PRIORITY>`env LANG=us_US.UTF-8 date "+%b %d %H:%M:%S"` $ORIG_IP service: $RANDOM_MESSAGE"
done
EOF

bash /tmp/syslogGenerator.sh

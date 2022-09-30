!/bin/bash
DROP_LIST=$(curl -s http://www.spamhaus.org/drop/drop.txt | grep -v "^;" | awk {'print $1'})
ipset create spamhaus hash:net -exist
ipset create spamhaus_new hash:net -exist
ipset flush spamhaus_new
for net in $DROP_LIST
do
ipset add spamhaus_new $net
done
ipset swap spamhaus spamhaus_new

#!/bin/bash
for (( i=1; i<=50; i++ ))
do
	while read -r line
	do
	    part1=$(echo "$line" | cut -d'/' -f1)
	    part2=$(echo "$line" | cut -d'/' -f2-) 
	    ./quic_perf -t -4 -s $part1:443 -p /$part2 -V Q043 2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -4 -s $part1:443 -p /$part2 -V Q046 2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -4 -s $part1:443 -p /$part2 -V Q050 2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -4 -s $part1:443 -p /$part2 version=h3-24  2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -6 -s $part1:443 -p /$part2 -V Q043 2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -6 -s $part1:443 -p /$part2 -V Q046 2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -6 -s $part1:443 -p /$part2 -V Q050 2>/dev/null >> output_quic_gdrive.csv
	    ./quic_perf -t -6 -s $part1:443 -p /$part2 version=h3-24 2>/dev/null >> output_quic_gdrive.csv
	    ./tls_perf -4 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -4 -3 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -4 -2 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -4 -3 -2 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -6 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -6 -3 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -6 -2 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	    ./tls_perf -6 -3 -2 -u $line -p 443 2>/dev/null >> output_curl_gdrive.csv
	done< "$1"
	sleep 10s
done

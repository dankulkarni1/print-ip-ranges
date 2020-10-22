#!/bin/bash

helpFunction() {
   echo ""
   echo "Usage: $0 -r REGION"
   exit 1 # Exit script after printing help
}

while getopts "r:" aws_region; do
   case "$aws_region" in
   r) region=${OPTARG} ;;
   ?) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$region" ]; then
   echo "You must put in a region as a command line input e.g. us-east-1"
   helpFunction
   exit 1
fi

# Update the IP-Range File
echo "Updating ip-ranges.json... Downloading now!"
rm -rf ip-ranges.json
wget -nv "https://ip-ranges.amazonaws.com/ip-ranges.json"
echo "Download Complete! "

# Begin script in case all parameters are correct
file='ip-ranges.json'
lines=$(cat $file | grep region | wc -l | sed 's/^ *//g')
false_region='true'
sum="0"

# For the regions matching jquery of $region, print the corresponding IP range
for ((i = 0; i<=$lines; i++)); do
   if [[ $(cat $file | jq '.prefixes['$i'] .region' | sed 's/.//;s/.$//') = $region ]]; then
      false_region='false'
      ip_prefix=$(cat $file | jq '.prefixes['$i'] .ip_prefix')
      ipv6_prefix=$(cat $file | jq '.prefixes['$i'] .ipv6_prefix')
      if [[ "$ip_prefix" = null ]]; then
         echo "$ipv6_prefix"
         ((sum++)) # Add to the number of unique IP ranges
      else
         echo "$ip_prefix"
         ((sum++)) # Add to the number of unique IP ranges
      fi
   fi
done

# Print error if region doesn't exist
if [[ $false_region == 'true' ]]; then
   echo "ERROR: Region \"$region\" doesn't seem to exist within $file"
   helpFunction
   exit 1
else # Print SUM of unique number of IP ranges in a particular region
   echo "Total SUM of IP ranges available in Region \"$region\" is \"$sum\" !"
   exit 0
fi

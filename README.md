## Introduction

This script will print all the IP ranges for a region name within all available AWS public ranges

The AWS IP Ranges JSON File ` https://ip-ranges.amazonaws.com/ip-
ranges.json ` will be downloaded if not present or updated everytime the script is run.

## Usage

To run the script there is a help function built in that will prompt you.

`You must put in a region as a command line input e.g. us-east-1`

`Usage: ./print_aws_ip_ranges.sh -r REGION`

## Error Handling

The script will error if there is no `-r` flag present followed by a valid region passed as a command line argument.

If an invalid region is used, it will take some time to check the json file before it comes back with an error message `ERROR: Region "YOUR INPUT" doesn't seem to exist within ip-ranges.json`.

Example : `ERROR: Region "test" doesn't seem to exist within ip-ranges.json`

## Bonus

At the end of running a valid query, the total sum of the unique IP ranges availavle within that region will be outputted `Total SUM of IP ranges available in Region "YOUR REGION" is "SUM" !`

Example : `Total SUM of IP ranges available in Region "ap-northeast-2" is "1" !`


Author - Dan Kulkarni
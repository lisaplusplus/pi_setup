#!/bin/bash

usage()
{
    echo "Usage: ./pi_setup.sh [Hostname to set] [Wifi SSID] [Wifi key]";
}

HOSTNAME=$1
SSID=$2
NETKEY=$3

if [ ! "$(whoami)" = "root" ]
then
    echo "You must run this script with sudo or as root"
    exit 1
fi 

if [ -z $HOSTNAME ]
then
    echo "No hostname argument provided"
    usage
    exit 1
fi

if [ -z $SSID ]
then
    echo "No Wifi SSID argument provided"
    usage
    exit 1
fi

if [ -z $NETKEY ]
then
    echo "No Wifi key argument provided"
    usage
    exit 1
fi

echo "Setting Raspberry Pi hostname to $HOSTNAME ..."
sed -i "s/raspberrypi/${HOSTNAME}/" /etc/hosts
sed -i "s/raspberrypi/${HOSTNAME}/" /etc/hostname

echo "Setting up Wifi to use $SSID ..."

echo "
network={
    ssid=\"$SSID\"
    psk=\"$NETKEY\"
}" >> /etc/wpa_supplicant/wpa_supplicant.conf

reboot

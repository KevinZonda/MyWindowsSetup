#!/bin/bash

FRPS_VERSION="0.71.0"

wget https://github.com/fatedier/frp/releases/download/v${FRPS_VERSION}/frp_${FRPS_VERSION}_linux_amd64.tar.gz
tar -zxvf frp_${FRPS_VERSION}_linux_amd64.tar.gz
cp frp_${FRPS_VERSION}_linux_amd64/frps /usr/bin

rm -fr frp_${FRPS_VERSION}_linux_amd64
rm -fr frp_${FRPS_VERSION}_linux_amd64.tar.gz

cp frps.service /etc/systemd/system/
mkdir /etc/frps
cp frps.ini /etc/frps/

systemctl daemon-reload
systemctl enable frps
systemctl start frps
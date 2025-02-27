#! /bin/sh

#ad-list
wget https://github.com/privacy-protection-tools/anti-AD/raw/master/anti-ad-smartdns.conf
wget https://github.com/neodevpro/neodevhost/raw/master/lite_smartdns.conf

#dnsmasq-china-list
wget -O china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
#删除不符合规则的域名
sed -i "s/^server=\/\(.*\)\/[^\/]*$/nameserver \/\1\/china/g;/^nameserver/!d" china.conf

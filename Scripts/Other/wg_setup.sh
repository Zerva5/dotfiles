#/bin/sh

IP=10.10.0.$1

cd /etc/wireguard
wg genkey | tee privatekey | wg pubkey > publickey

PK=cat ./publickey

ip link add dev wg0 type wireguard

ip addr add $IP/24 dev wg0

echo "[Interface]
Address = ${IP}/32
Address = fd86:ea04:1111::2/128
SaveConfig = true
PrivateKey = <your client private key here>
DNS = 1.1.1.1

[Peer]
PublicKey = knruIr6PAX/KMeOZov8CW8ZT+5ybJ/R2Y+kJyiqCWl8=
Endpoint = 144.202.22.113:51820
AllowedIPs = 0.0.0.0/0, ::/0" > wg0.conf

chmod 600 privatekey
chmod 600 publickey
chmod 600 wg0.conf

ssh lmayall@144.202.22.113 -p 3309 "wg set wg0 peer  allowed-ips ${IP}/32"


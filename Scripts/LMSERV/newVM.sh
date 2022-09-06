NEW_HOSTNAME=$1
NEW_USER=$2
BASE_IMG=$3
SIZE=$4


qemu-img create -f qcow2 -o backing_file=$BASE_IMG /var/lib/libvirt/images/$NEW_HOSTNAME/$NEW_HOSTNAME.qcow2


qemu-img resize /var/lib/libvirt/images/$NEW_HOSTNAME/$NEW_HOSTNAME.qcow2 ${SIZE}G

cp /var/lib/libvirt/images/base/cloud-init/meta-data  /var/lib/libvirt/images/$NEW_HOSTNAME/meta-data && cp /var/lib/libvirt/images/base/cloud-init/user-data /var/lib/libvirt/images/$NEW_HOSTNAME/user-data

sed -i 's/%NAME%/$NEW_USER' /var/lib/libvirt/images/$NEW_HOSTNAME/user-data

sed -i 's/%HOSTNAME%/$NEW_HOSTNAME' /var/lib/libvirt/images/$NEW_HOSTNAME/user-data



sudo virt-install \
            --name TorDown\
            --memory 1024 \
            --vcpus 1 \
            --disk /var/lib/libvirt/images/TorDown.qcow2,device=disk,bus=virtio \
            --disk /var/lib/libvirt/images/TorDown-cloud.iso,device=cdrom \
            --os-type linux \
            --os-variant ubuntu20.04 \
            --virt-type kvm \
            --graphics none \
            --network bridge=br0\
            --boot hd 
            

$6$zsTtcg/mynmvRSt$u5wOeaILXl73J57JJrmrldTl2uu8WTH2MX0kLdb9O4SuDjMly9bbiq12f/7UiuiaJtnDyH066X8nbqNrKmgs60

# Successful NUMA node read from SysFS had negative value (-1) 
# more info: https://stackoverflow.com/questions/44232898/memoryerror-in-tensorflow-and-successful-numa-node-read-from-sysfs-had-negativ
for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done

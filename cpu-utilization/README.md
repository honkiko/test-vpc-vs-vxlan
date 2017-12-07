# test CPU utilazation druing qperf

## testbed setup
1) get an CCS cluster with 2 CVM nodes on qcloud

2) start 2 POD using VPC container network, one per each node

3) start 2 container using vxlan network, one per each node

4) start qperf server in VPC POD on node1

5) start qperf server in vxlan container on node1

## on node2, modify run-mpstat-test.sh
Modyfy below values. 

```
VPC_LOCAL_NS=6512
VPC_REMOTE_IP='10.0.1.11'
VXLAN_LOCAL_NS=18172
VXLAN_REMOTE_IP='192.168.24.2'
```

VPC_LOCAL_NS is the pid of VPC POD on node2. 

VPC_REMOTE_IP is the IP of VPC POD on node1.

## run test

Run run-mpstat-test.sh on node2.
```
# run 5 rounds of tests, with 10 seconds of interval
./run-mpstat-test.sh 5 10
```

After the script returns, some files recording mpstat reports will be generated:
```
./vpc-mpstat-2.raw
./vpc-mpstat-1.raw
./vpc-mpstat-3.raw
./vpc-mpstat-4.raw
./vpc-mpstat-0.raw
./vxlan-mpstat-1.raw
./vxlan-mpstat-2.raw
./vxlan-mpstat-4.raw
./vxlan-mpstat-3.raw
./vxlan-mpstat-0.raw
```

## parse mpstat reports and calculate average
```
ls vxlan-mpstat-[0-9].raw |xargs ./parse-average-mpstat.py > vxlan-mpstat
ls vpc-mpstat-[0-9].raw |xargs ./parse-average-mpstat.py > vpc-mpstat
```

## plot diagrams
```
gnuplot -c mpstat-plot.plt vpc-mpstat vxlan-mpstat
```

4 png files will be generated.
```
./idle-[vpc-mpstat]-vs-[vxlan-mpstat].png
./si-[vpc-mpstat]-vs-[vxlan-mpstat].png
./usr-[vpc-mpstat]-vs-[vxlan-mpstat].png
./sys-[vpc-mpstat]-vs-[vxlan-mpstat].png
```

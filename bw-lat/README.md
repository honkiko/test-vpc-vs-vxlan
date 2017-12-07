# test CPU utilazation druing qperf

## testbed setup
1) get an CCS cluster with 2 CVM nodes on qcloud

2) start 2 POD using VPC container network, one per each node

3) start 2 container using vxlan network, one per each node

4) start qperf server in VPC POD on node1

5) start qperf server in vxlan container on node1

6) start qperf server directly on node1

## on node2, modify run-bw-lat-test.sh
Modyfy below values. 

```
VPC_LOCAL_NS=6512
VPC_REMOTE_IP='10.0.1.11'
VXLAN_LOCAL_NS=18172
VXLAN_REMOTE_IP='192.168.24.2'
REMOTE_NODE_IP='172.31.0.5'
```

VPC_LOCAL_NS is the pid of VPC POD on node2. 

VPC_REMOTE_IP is the IP of VPC POD on node1.

REMOTE_NODE_IP is the IP of node1.

## run test

Run run-bw-lat-test.sh on node2.
```
# run 5 rounds of tests, with 10 seconds of interval
./run-bw-lat-test.sh 5 10
```

After the script returns, some files recording mpstat reports will be generated:
```
./n2n-0.raw
./n2n-1.raw
./n2n-2.raw
./n2n-3.raw
./n2n-4.raw
./vpc-c2c-0.raw
./vpc-c2c-1.raw
./vpc-c2c-2.raw
./vpc-c2c-3.raw
./vpc-c2c-4.raw
./vpc-c2n-0.raw
./vpc-c2n-1.raw
./vpc-c2n-2.raw
./vpc-c2n-3.raw
./vpc-c2n-4.raw
./vxlan-c2c-0.raw
./vxlan-c2c-1.raw
./vxlan-c2c-2.raw
./vxlan-c2c-3.raw
./vxlan-c2c-4.raw
./vxlan-c2n-0.raw
./vxlan-c2n-1.raw
./vxlan-c2n-2.raw
./vxlan-c2n-3.raw
./vxlan-c2n-4.raw
```

## parse qperf reports to data files
```
./batch-parse-qperf-raw.sh
```

## calculate average from data files
```
ls vpc-c2c-[0-9] | xargs ./average.py >vpc-c2c
ls vxlan-c2c-[0-9] | xargs ./average.py >vxlan-c2c
ls vpc-c2n-[0-9] | xargs ./average.py >vpc-c2n
ls vxlan-c2n-[0-9] | xargs ./average.py >vxlan-c2n
ls n2n-[0-9] | xargs ./average.py >n2n
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

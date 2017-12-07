
rounds=$1
internal=$2

VPC_LOCAL_NS=6512
VPC_REMOTE_IP='10.0.1.11'
VXLAN_LOCAL_NS=18172
VXLAN_REMOTE_IP='192.168.24.2'

n=0; while [[ $n -lt $rounds ]]; do
	mpstat 1 60 > vpc-mpstat-$n.raw  &
	nsenter -t $VPC_LOCAL_NS -n qperf $VPC_REMOTE_IP -t 60 -oo msg_size:1440 -vu -vvc tcp_bw > vpc-c2c-$n.raw
	sleep 5

	mpstat 1 60 > vxlan-mpstat-$n.raw  &
	nsenter -t $VXLAN_LOCAL_NS -n qperf $VXLAN_REMOTE_IP -t 60 -oo msg_size:1440 -vu -vvc tcp_bw  > vxlan-c2c-$n.raw
done

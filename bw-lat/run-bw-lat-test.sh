
rounds=$1
internal=$2

VPC_LOCAL_NS=6512
VPC_REMOTE_IP='10.0.1.11'
VXLAN_LOCAL_NS=18172
VXLAN_REMOTE_IP='192.168.24.2'
REMOTE_NODE_IP='172.31.0.5'

n=0; while [[ $n -lt $rounds ]]; do
	nsenter -t $VPC_LOCAL_NS -n qperf $VPC_REMOTE_IP -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > vpc-c2c-$n.raw
	sleep 1
	nsenter -t $VXLAN_LOCAL_NS -n qperf $VXLAN_REMOTE_IP -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > vxlan-c2c-$n.raw
	sleep 1
	nsenter -t $VPC_LOCAL_NS -n qperf $VPC_REMOTE_IP -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > vpc-c2n-$n.raw
	sleep 1
	nsenter -t $VXLAN_LOCAL_NS -n qperf $VXLAN_REMOTE_IP -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > vxlan-c2n-$n.raw
	sleep 1
	qperf $REMOTE_NODE_IP -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > n2n-$n.raw
	sleep 1
	n=$((n+1)); 
	sleep $internal
done

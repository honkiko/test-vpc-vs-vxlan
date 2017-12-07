# plot vpc-c2c vs vxlan-c2c
gnuplot -c qperf-plot.plt vpc-c2c vxlan-c2c

# plus n2n as baseline
gnuplot -c qperf-plot.plt n2n vpc-c2c vxlan-c2c

# plot vpc-c2n vs vxlan-c2n
gnuplot -c qperf-plot.plt vpc-c2n vxlan-c2n

# plus n2n as baseline
gnuplot -c qperf-plot.plt n2n vpc-c2n vxlan-c2n

# parse mpstat raw output and calculate the average, write to *-mpstat
ls vxlan-mpstat-[0-9].raw |xargs ./parse-average-mpstat.py > vxlan-mpstat
ls vpc-mpstat-[0-9].raw |xargs ./parse-average-mpstat.py > vpc-mpstat

# plot from average CPU usage data file vpc-mpstat and vxlan-mpstat
gnuplot -c mpstat-plot.plt vpc-mpstat vxlan-mpstat

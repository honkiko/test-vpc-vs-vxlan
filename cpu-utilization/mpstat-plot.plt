#!/usr/bin/env gnuplot

if (!exists("ARGC")) {
	print "This copy of gnuplot does not support the ARG call method"
	exit
}

if (ARGC != 2) {
	print "usage: ", ARG0, " DATAFILE1 DATAFILE2 "
	exit
}


file1=ARG1
file2=ARG2


set xlabel "time (sec)"
set ylabel "CPU usage (%)"
set style data linespoints 
set pointsize 2
set term png 

set title "mpstat-usr"
usrfile=sprintf("usr-[%s]-vs-[%s].png",file1, file2)
set output usrfile
plot file1 using 1:2 title file1 pointtype 5 ,\
	file2 using 1:2 title file2 pointtype 5

set title "mpstat-sys"
sysfile=sprintf("sys-[%s]-vs-[%s].png",file1, file2)
set output sysfile
plot file1 using 1:3 title file1 pointtype 5 ,\
	file2 using 1:3 title file2 pointtype 5


set title "mpstat-softirq"
sifile=sprintf("si-[%s]-vs-[%s].png",file1, file2)
set output sifile
plot file1 using 1:4 title file1 pointtype 5 ,\
	file2 using 1:4 title file2 pointtype 5


set title "mpstat-idle"
idlefile=sprintf("idle-[%s]-vs-[%s].png",file1, file2)
set output idlefile
plot file1 using 1:5 title file1 pointtype 5 ,\
	file2 using 1:5 title file2 pointtype 5

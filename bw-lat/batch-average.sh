ls vpc-c2c-[0-9] | xargs ./average.py >vpc-c2c
ls vxlan-c2c-[0-9] | xargs ./average.py >vxlan-c2c
ls vpc-c2n-[0-9] | xargs ./average.py >vpc-c2n
ls vxlan-c2n-[0-9] | xargs ./average.py >vxlan-c2n
ls n2n-[0-9] | xargs ./average.py >n2n

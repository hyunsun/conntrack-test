FROM kolla/ubuntu-source-neutron-linuxbridge-agent:4.0.0
ADD conntrack_test.py /
ADD conntrack_test.sh /
CMD [ "/bin/bash" ]

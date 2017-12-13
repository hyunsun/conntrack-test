#!/usr/bin/python

import time
from oslo_config import cfg
from neutron.agent.linux import utils as linux_utils

CONF = cfg.CONF

ROOT_HELPER_OPTS = [
    cfg.StrOpt('root_helper', default='sudo'),
    cfg.StrOpt('root_helper_daemon')
]
CONF.register_opts(ROOT_HELPER_OPTS, 'AGENT')

cmd = ['conntrack', '-D', '-f', 'ipv4', '-s', '192.168.100.1', '-w', '1', '-d', '192.168.100.2']
start = time.time()
linux_utils.execute(list(cmd), run_as_root=True,
                    check_exit_code=True,
                    extra_ok_codes=[1])
elapsed = (time.time() - start)
print "Elapsed %s seconds" % elapsed

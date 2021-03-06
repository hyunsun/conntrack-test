# conntrack-test
This repo provides a script and Dockerfile for comparing `conntrack -D` command operation time in native and container environment. I also added python script trying to do the same but in a way that Neutron Linux bridge agent does. The test shows that there's a serious performance degradation when the command is run inside a container with python subprocess, which can cause Neutron Linux bridge agent blocked for trying to remove all possible conntrack entries when large numbers of VMs are removed at once.

# How to run the test
Just run "run.sh" from Docker installed and Internet accessible machine.

Here is the result of my test.
```
======= native + command =======
conntrack v1.4.3 (conntrack-tools): 0 flow entries have been deleted.

real    0m0.003s
user    0m0.000s
sys     0m0.000s

======= container + command =======
conntrack v1.4.3 (conntrack-tools): 0 flow entries have been deleted.

real    0m0.004s
user    0m0.000s
sys     0m0.000s

======= native + python =======
Elapsed 0.0128059387207 seconds

======= container + python =======
Elapsed 0.104089975357 seconds
```

# How to resolve
It can be resolved by decreasing filehandle limit per process to smaller value than default. Root cause of poor performance with Python subprocess in Docker is described well here, https://github.com/moby/moby/issues/9876.

Here's the test result with ulimit change.
```
======= container + python + default ulimit =======
Elapsed 0.0829100608826 seconds

======= container + python + ulimit 1024 =======
Elapsed 0.0137021541595 seconds
```

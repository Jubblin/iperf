# kubernetes-iperf
Simple wrapper around iperf to measure network bandwidth from all nodes of a Kubernetes cluster.

## How to use
*Make sure you are using the correct cluster context before running this script: `kubectl config current-context`*
```
$ ./iperf.sh
```

Any options supported by iperf can be added, e.g.:

```
$ ./iperf.sh -t 2
```

### NetworkPolicies
If you need NetworkPolicies you can install it:

```
$ kubectl apply -f network-policy.yaml
```

And cleanup afterwards:
```
$ kubectl delete -f network-policy.yaml
```

### Output:
```
deployment.apps "iperf-server-deployment" created
service "iperf-server" created
daemonset.apps "iperf-clients" created
Waiting for iperf server to start...
Waiting for iperf server to start...
Waiting for iperf server to start...
Server is running

Client on 172.20.47.197:  Connecting to host iperf-server, port 5201
Client on 172.20.47.197:  [  4] local 100.96.0.28 port 37580 connected to 100.65.13.40 port 5201
Client on 172.20.47.197:  [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
Client on 172.20.47.197:  [  4]   0.00-1.00   sec  3.59 GBytes  30.8 Gbits/sec    0   4.00 MBytes
Client on 172.20.47.197:  [  4]   1.00-2.00   sec  3.66 GBytes  31.5 Gbits/sec    0   4.00 MBytes
Client on 172.20.47.197:  - - - - - - - - - - - - - - - - - - - - - - - - -
Client on 172.20.47.197:  [ ID] Interval           Transfer     Bandwidth       Retr
Client on 172.20.47.197:  [  4]   0.00-2.00   sec  7.25 GBytes  31.1 Gbits/sec    0             sender
Client on 172.20.47.197:  [  4]   0.00-2.00   sec  7.25 GBytes  31.1 Gbits/sec                  receiver
Client on 172.20.47.197:
Client on 172.20.47.197:  iperf Done.

Client on 172.20.57.129:  Connecting to host iperf-server, port 5201
Client on 172.20.57.129:  [  4] local 100.96.1.31 port 55166 connected to 100.65.13.40 port 5201
Client on 172.20.57.129:  [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
Client on 172.20.57.129:  [  4]   0.00-1.00   sec   954 MBytes  8.00 Gbits/sec    5   3.10 MBytes
Client on 172.20.57.129:  [  4]   1.00-2.00   sec   948 MBytes  7.95 Gbits/sec    1   4.22 MBytes
Client on 172.20.57.129:  - - - - - - - - - - - - - - - - - - - - - - - - -
Client on 172.20.57.129:  [ ID] Interval           Transfer     Bandwidth       Retr
Client on 172.20.57.129:  [  4]   0.00-2.00   sec  1.86 GBytes  7.97 Gbits/sec    6             sender
Client on 172.20.57.129:  [  4]   0.00-2.00   sec  1.85 GBytes  7.93 Gbits/sec                  receiver
Client on 172.20.57.129:
Client on 172.20.57.129:  iperf Done.

deployment.apps "iperf-server-deployment" deleted
service "iperf-server" deleted
daemonset.apps "iperf-clients" deleted
```

## Caution
This script could potentially disrupt normal cluster operations by causing high CPU and network load.
Use with care.

## How it works
The script will run an iperf client inside a pod on every cluster node including the Kubernetes master.
Each iperf client will then sequentially run the same benchmark against the iperf server running on the Kubernetes master.

All required Kubernetes resources will be created and removed after the benchmark finished successfully.

This has been tested with v1.9.6, v1.10.3 and v1.11.6 of Kubernetes.

The latest version of this Docker image is used to run iperf:
https://hub.docker.com/r/networkstatic/iperf/

Details on how to use iperf can be found here:
https://github.com/esnet/iperf

## Thanks
Thanks to the iperf maintainers for providing such a great tool.

## License
[MIT](LICENSE)

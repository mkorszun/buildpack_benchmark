buildpack_benchmark
===================

# Usage

Change directory to the app you want to test and run:

~~~bash
$ sh /PATH/TO/buildpack_benchmark/benchmark.sh BUILDPACK_URL
~~~

# Info

* You need to have test application you want to benchmark
* Script uses non-interactive cctrlapp mode, so ensure that you have proper environment with existing auth token
* Script creates temporary app using provided buildpack URL (and removes it after test)
* You need to execute script from test application directory


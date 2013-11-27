buildpack_benchmark
===================

## Info

* You need to have test application you want to benchmark
* Script uses non-interactive cctrlapp mode, so ensure that you have proper environment with existing auth token
* Script creates temporary app using provided buildpack URL (and removes it after test)

## Usage

Change to test application directory and run:

~~~bash
$ sh /PATH/TO/buildpack_benchmark/benchmark.sh BUILDPACK_URL
~~~


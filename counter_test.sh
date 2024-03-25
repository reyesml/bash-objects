#!/usr/bin/env bash

set -e

source ./counter.sh

test_increment() {
  build_counter
  local test_counter=$(get_counter)

  wants_count=7
  got_count=''

  for i in $(seq 1 $wants_count); do
    $test_counter.increment
  done

  got_count=$($test_counter.get_count)
  if [ $wants_count -ne $got_count ]; then
    echo "$FUNCNAME: fail."
    echo "Expected $wants_count, got $got_count"
    return 1
  fi

  echo "$FUNCNAME: pass."
}

test_multiple_instances() {
  build_counter
  local test_counter_1=$(get_counter)

  build_counter
  local test_counter_2=$(get_counter)

  wants_count_1=5
  for i in $(seq 1 $wants_count_1); do
    $test_counter_1.increment
  done

  wants_count_2=3
  for i in $(seq 1 $wants_count_2); do
    $test_counter_2.increment
  done

  got_count_1=$($test_counter_1.get_count)
  got_count_2=$($test_counter_2.get_count)

  if [ $wants_count_1 -ne $got_count_1 ]; then
    echo "$FUNCNAME: fail."
    echo "Expected count_1 $wants_count_1, got $got_count_1"
    return 1
  fi

  if [ $wants_count_2 -ne $got_count_2 ]; then
    echo "$FUNCNAME: fail."
    echo "Expected count_2 $wants_count_2, got $got_count_2"
    return 1
  fi

  echo "$FUNCNAME: pass."
}



test_increment
test_multiple_instances
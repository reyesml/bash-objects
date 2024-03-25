#!/usr/bin/env bash

set -e

source ./counter.sh

echo 'My first counter:'
build_counter
my_counter=$(get_counter)
$my_counter.increment
$my_counter.increment
$my_counter.increment
$my_counter.increment

echo ''
echo "My second counter:"
build_counter
different_counter=$(get_counter)
$different_counter.increment

echo ''
echo "Back to my first."
$my_counter.get_count
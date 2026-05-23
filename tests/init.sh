#!/usr/bin/env bash
# -*- coding: utf-8 -*-

root=${home}/../..
tree=${root}/tree
test_name=$(basename ${home})
target_directory=/tmp/tree/${test_name}

# $1: test name
# $2: test result (0->success, 1->failure)
print_result () {
  if [ -z $2 ] || [ $2 -eq 0 ]; then
    echo "SUCCESS:" $1
  else
    echo "FAILURE:" $1
  fi
}

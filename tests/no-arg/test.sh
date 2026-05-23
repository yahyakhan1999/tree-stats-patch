#!/usr/bin/env bash
# -*- coding: utf-8 -*-

home=$(cd $(dirname $0) && pwd)
. ${home}/../init.sh

mkdir -p $target_directory
cd $target_directory

mkdir -p a b/c d/e/f
$tree > ${home}/out

cmp ${home}/{exp,out} || result=1
print_result ${test_name} ${result}

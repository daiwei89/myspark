#!/usr/bin/env bash
num_iterations=10
step_size=4
reg_type=L2
lambda=1e-1
data_format=LibSVM
minibatch_fraction=1
num_legs=1
num_dups=1

master_ip=10.53.1.7
#data_path='/tank/projects/biglearning/wdai/datasets/lr/giant/subset'
data_path="/tank/projects/biglearning/jinlianw_marmot/data/kddb"

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
spark_dir=`dirname $script_dir`

cmd="time $spark_dir/bin/spark-submit \
    --class LogisticRegression \
    --master spark://${master_ip}:7077 \
    --driver-memory 100G \
    $script_dir/lr/target/lr-1.0.jar \
    --numIterations ${num_iterations} \
    --stepSize ${step_size} \
    --regType ${reg_type} \
    --regParam ${lambda} \
    --minibatchFraction ${minibatch_fraction} \
    --dataFormat ${data_format} \
    --numLegs ${num_legs} \
    --numDups ${num_dups} \
    ${data_path}"
echo $cmd
eval $cmd

#!/usr/bin/env bash
num_iterations=30
step_size=8
reg_type=L1
lambda=1e-4
data_format=LibSVM
minibatch_fraction=1

master_ip=10.52.1.35
data_path='/tank/projects/biglearning/wdai/datasets/lr/jin_synth/s5k_dim10M.libsvm'

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
spark_dir=`dirname $script_dir`

cmd="time $spark_dir/bin/spark-submit \
    --class LogisticRegression \
    --master spark://${master_ip}:7077 \
    --driver-memory 60G \
    $script_dir/lr/target/lr-1.0.jar \
    --numIterations ${num_iterations} \
    --stepSize ${step_size} \
    --regType ${reg_type} \
    --regParam ${lambda} \
    --minibatchFraction ${minibatch_fraction} \
    --dataFormat ${data_format} \
    ${data_path}"
echo $cmd
eval $cmd

#! /bin/bash

/opt/spark/bin/spark-submit wordcount.py hdfs://master/data/ hdfs://master/results/results-basic-$1 --driver-memory 3000m --master spark://master:7077 > output_stream_basic.txt
hdfs dfs -getmerge hdfs://master/results/results-basic-$1  /tmp/results-basic-merged.txt
hdfs dfs -copyFromLocal /tmp/results-basic-merged.txt hdfs://master/results/results-basic-$1/
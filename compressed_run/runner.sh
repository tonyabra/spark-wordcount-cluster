#! /bin/bash
hdfs dfs -mkdir /data;
hdfs dfs -mkdir /back-data;
hdfs dfs -mkdir /results;
apt-get install unzip -y;

./downloader.sh 0 300;

echo "Sending text message"
curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/AC20da93c6b90d3dde8b06692b74d7998f/Messages.json' \
    --data-urlencode 'To=4432800850'  \
    --data-urlencode 'From=+12566073154'  \
    --data-urlencode 'Body=Finished Downloading!' \
    -u AC20da93c6b90d3dde8b06692b74d7998f:d259e77336fb0e19fb34c0645745158b;

hdfs dfs -mv /data/* /back-data;

echo "1 file test."
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-00000-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -ls /data > ./results/pre_test_1.txt
{ time ./basic.sh 1; } 2> ./results/basic_time_1.txt;
hdfs dfs -ls /results/results-basic-1 > ./results/basic_check_1.txt;

echo "3 file test."
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-00001-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-00002-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -ls /data > ./results/pre_test_3.txt
{ time ./basic.sh 3; } 2> ./results/basic_time_3.txt;
hdfs dfs -ls /results/results-basic-3 > ./results/basic_check_3.txt;

echo "10 files test."
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-0000*-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -ls /data > ./results/pre_test_10.txt
{ time ./basic.sh 10; } 2> ./results/basic_time_10.txt;
hdfs dfs -ls /results/results-basic-10 > ./results/basic_check_10.txt;

echo "30 files test."
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-000[1-2]*-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -ls /data > ./results/pre_test_30.txt
{ time ./basic.sh 30; } 2> ./results/basic_time_30.txt;
hdfs dfs -ls /results/results-basic-30 > ./results/basic_check_30.txt;

echo "90 files test."
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-000[3-8]*-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -ls /data > ./results/pre_test_90.txt
{ time ./basic.sh 90; } 2> ./results/basic_time_90.txt;
hdfs dfs -ls /results/results-basic-90 > ./results/basic_check_90.txt;

echo "300 files test."
hdfs dfs -mv /back-data/CC-MAIN-20150124161055-00*-ip-10-180-212-252.ec2.internal.warc.wet.gz /data
hdfs dfs -ls /data > ./results/pre_test_300.txt
{ time ./basic.sh 300; } 2> ./results/basic_time_300.txt;
hdfs dfs -ls /results/results-basic-300 > ./results/basic_check_300.txt;

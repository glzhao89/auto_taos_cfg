#!/bin/bash

HOSTNAME=`uname -n`
CUR_DIR=`pwd`
PARENT_DIR=`pwd | awk -F "/" '{print $(NF-1)}'`
CFG_FILE=taos.cfg

TAOS_DATA_DIR=TDinternal/taos/data
TAOS_LOG_DIR=TDinternal/taos/log
TAOS_CFG_DIR=TDinternal/taos/cfg


if [ "$PARENT_DIR" != "TDinternal" ]; then
  echo "Must execute under TDinternal directory."
  exit
fi


echo "=== Making taos dir ==="
mkdir -p ../../$TAOS_DATA_DIR && \
mkdir -p ../../$TAOS_LOG_DIR && \
mkdir -p ../../$TAOS_CFG_DIR

if [ ! -f $CFG_FILE ]; then
  echo "No taos.cfg file in current dir."
  exit
fi

cp $CFG_FILE ../../$TAOS_CFG_DIR
cd ../..
tmp_dir=`pwd`
echo "=== Setting config file to $tmp_dir/$TAOS_CFG_DIR/$CFG_FILE ==="
sed -i "s/hostname/$HOSTNAME/g" $TAOS_CFG_DIR/$CFG_FILE
sed -i "s!$TAOS_DATA_DIR!${tmp_dir}/${TAOS_DATA_DIR}!g" $TAOS_CFG_DIR/$CFG_FILE
sed -i "s!$TAOS_LOG_DIR!$tmp_dir/$TAOS_LOG_DIR!g" $TAOS_CFG_DIR/$CFG_FILE

echo "Done."

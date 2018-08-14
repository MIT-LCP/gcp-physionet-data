#!/bin/bash

# This script is to be run after creating the data hosting project "physionet-data"
# This script does, for each dataset (mimiciii_demo, mimiciii_clinical, mimiciii_notes, eICU):
# - create a bucket
# - upload zipped csvs to bucket
# - create bigquery dataset
# - create tables and importing data in the bigquery dataset
# Not written by Google.


# High level

# The local root location of the dataset files
DATA_DIR=<INSERT>
BILLING_ACCOUNT=<INSERT>
DOMAIN=googlegroups.com
PROJECT_NAME=physionet-data


# Group permissions

# Admin owners
OWNERS_GROUP=physionet-owners@googlegroups.com
# Project auditors who has the permission to view audit logs. Same group as above.
AUDITORS_GROUP=physionet-owners@googlegroups.com
# Members who have read-write access to the data hosted in the projects.
EDITORS_GROUP=physionet-editors@googlegroups.com
# Internal and collaborative users who have read-only access to the data.
READERS_GROUP=physionet-internal-viewers@googlegroups.com


# Creating and populating the datasets
for DATASET_NAME in mimiciii_demo mimiciii_clinical mimiciii_notes eICU
do
    INPUT_DIR=$DATA_DIR/$DATASET_NAME

    if [[ DATASET_NAME = mimiciii_* ]]; then
      # table schemas are here for all 3 mimic datasets.
      SCHEMA_DIR=bqschemas/mimic3
    else
      SCHEMA_DIR=bqschemas/$DATASET_NAME
    fi

    echo Processing dataset: $DATASET_NAME

    scripts/upload_data.sh \
      --owners_group ${OWNERS_GROUP} \
      --editors_group ${EDITORS_GROUP} \
      --readers_group ${READERS_GROUP} \
      --project_id ${PROJECT_NAME} \
      --dataset_name ${DATASET_NAME} \
      --input_dir ${INPUT_DIR} \
      --schema_dir ${SCHEMA_DIR}
done

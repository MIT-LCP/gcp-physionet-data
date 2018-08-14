# Simplified Readme

This is a simplified readme that describes the overall process and the scripts
involved.

The [original readme file](https://github.com/GoogleCloudPlatform/healthcare/blob/master/datathon/organizer/README.md) contains more details.

# Overall Description

There are 2 projects to be created once: `physionet-auditing`, for storing
audit logs, and the more prominent `physionet-data` for storing data.


## Available Data

The idea is to upload the four datasets to the `physionet-data` project:
1. mimiciii_demo
2. mimiciii_clinical
3. mimiciii_notes
4. eICU

There will be a storage bucket containing the compressed csv files, and a
bigquery database for each of these datasets. The data is separated in this
manner due to the access system we have decided for them.


## Groups and Access

Access to projects and datasets is controlled through [google groups](https://groups.google.com/).

There are 3 relevant baseline google groups. We will use these groups as follows:
1. `physionet-owners@googlegroups.com` - Administrative owners of PhysioNet
   data on Google Cloud Platform. Alistair, Chen, Felipe, and Tom only.
2. `physionet-editors@googlegroups.com` - PhysioNet data managers, able to edit
   PhysioNet data on Google Cloud Platform. Suitable group for datathon
   facilitators and those who need to edit the data. IF YOU BELONG TO THIS GROUP,
   DO NOT CLOG THE PHYSIONET PROJECTS WITH UNNECESSARY BUCKETS AND TABLES,
   INCLUDING TESTS AND BACKUPS.
3. `physionet-internal-viewers@googlegroups.com` - Internal members of the
   PhysioNet team, and collaborators, who are authorized to view, but not edit,
   the PhysioNet data.

### Data user groups

The


### Limited Duration Events

For datathons and the HST class,





# Uploading Data

After creating the data hosting project (`physionet-data`) and the auditing
project (`physionet-auditing`), we must upload the data to the data hosting
project.

Call the `upload_all_data.sh` script to upload all four datasets. This script
does, for each dataset (mimiciii_demo, mimiciii_clinical, mimiciii_notes, eICU):
- create a bucket
- upload zipped csvs to bucket
- create bigquery dataset
- create tables and importing data in the bigquery dataset

Before calling this script, set the two variables near the top of the script:
`DATA_DIR` and `BILLING_ACCOUNT`. This script calls the `upload_data.sh` script
for each dataset using the appropriate variables.

# Rules

- DO NOT clog the `physionet-data` project with unnecessary buckets and tables,
  including tests and backups. If you want to figure out how gcp works, create
  your own projects using your own account.

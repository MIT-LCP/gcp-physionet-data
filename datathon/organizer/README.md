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
bigquery database for each of these datasets. The system is set up so that
authorized data readers are able to set up their own projects, and under
that project, query the data in `physionet-data` at their own expense
(requester pays).

The data is separated in this manner due to the access system we have decided
for them:
- Access to mimiciii_demo only requires a click agreement.
- Access to mimiciii_clinical requires a certified training course, and
  authorization by Ken Pierce. But we have limited duration events that give
  temporary access to it in a less cumbersome manner. We do not provide notes
  in this way however, so the notes are separated from the rest of the data.
- Access to eICU requires a certified training course, and authorization by
  Ken Pierce. This dataset has no notes.


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

### Data User groups

Ideally for the long term, we would have all mimic certified users added
to the `mimic-users@googlegroups.com` group, and eICU users to the
`eICU-users@googlegroups.com` group, so that they may make their own projects
and query the data whenever they want at their own expense.


### Limited Duration Events

For datathons and the HST class, a google group, and project will be made for
all participants to share. The project will be able to make queries via bigquery
or download the flat files, and will be charged. Google has agreed to give
credit for the first N events for these projects.

ie. For the fall HST-953 class, there is the google group: `hst-953-2018@googlegroups.com`
who all the class members should be added to, and a project that will be
created for them.


# Uploading Data

After creating the data hosting project (`physionet-data`) and the auditing
project (`physionet-auditing`), we must upload the data to the data hosting
project.

Call the `upload_all_data.sh` script to upload all four datasets. The script
should be called from this directory due to the relative paths of the bqschemas
and such. Call as follows: `./scripts/upload_all_data.sh`

This script does, for each dataset (mimiciii_demo, mimiciii_clinical,
mimiciii_notes, eICU):
- create a bucket
- upload zipped csvs to bucket
- create bigquery dataset
- create tables and importing data in the bigquery dataset

Before calling this script, set the two variables near the top of the script:
`DATA_DIR` and `BILLING_ACCOUNT`. This script calls the `upload_data.sh` script
for each dataset using the appropriate variables.
- Within the `DATA_DIR` directory on your local computer, there should be
  subdirectories: `eICU`, `mimiciii_clinical`, `mimiciii_demo`, and
  `mimiciii_notes`. `mimiciii_clinical` should contain all the zipped csvs
  except the NOTEEVENTS one, which should be moved to `mimiciii_notes`. Also,
  `mimiciii_demo` should not have the NOTEEVENTS file (which is empty anyway).
- The billing account ID is for the `physionet-build` project.


# Rules

- DO NOT clog the `physionet-data` project with unnecessary buckets and tables,
  including tests and backups. Or if you create test projects or datasets,
  DELETE THEM immediately after you are done. Otherwise, create your own
  projects using your own account.

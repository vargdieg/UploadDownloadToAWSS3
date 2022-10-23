# Upload and download files using Amazon S3 buckets

The main purpose of this project was to make a linux shell in order to upload files from your localstorage to a bucket in S3 and to download files from your bucket on S3 to your localstorage.
S3([Simple Storage Service][1]) is a AWS service that let an user store objects in the cloud offering high avaliability, scalability and also security of the data. 

The shell uses the AWS command line interface in order to make the petitions to AWS to upload/download files.

![Overview][2]

# Prerequisites
- Download the [AWS CLI][3]
- Create an S3 [bucket][4]
- Create [access keys][5] to access the bucket - the access keys must have permission to get put and list files on the bucket
- [Create a profile][6] usign a pair of access keys

# How the shell's works

## GetFiles.sh (Download files from S3 to localstorage)
The GetFiles.sh file downloads or copy the file from the target bucket to a folder in the localstorage.

First it list all the objects inside the bucket, then it downloads all the files that matches with an specific filter

### **Syntaxis**
sh GetFiles.sh ***ProfileName*** ***BucketName*** ***FolderName*** ***StoredFolder*** ***Filter*** ***DeleteFlag*** ***TransitFile***

### **Parameters**

| Name        | Description | Required    |
| :----------- | ----------- | :-----------: |
| ProfileName | is the profile associated with the credentials eg: personalprofile       | Yes       |
| Bucketname   | name of the bucket in wich the file is going to be extracted eg: testbucket        | Yes        |
| Foldername   | path in the bucket wich the file is going to be extracted s3 eg: /folder1/folder2/ (must start and end with /)        | Yes        |
| StoredFolder   | Folder in wich the file is stored locally (ends with /)        | Yes        |
| Filter   | Character(s) that must be in the file for it to be extracted        | Yes        |
| DeleteFlag   | Flag wich determinates if the file is deleted or not in the bucket        | Yes        |
| TransitFile   | Name of the file in wich saves the file list        | Yes        |

**Filter character**: 

The file must contain this character(s) in its name in order to be downloaded.
the text ThisIsSpecificFilter function as a wildcard, so using this text as a filter result on downloading all files on the bucket

**Delete Flag**: 

if it sets to true the file is deleted of the bucket

if it sets to false the file is copied of the bucket

**TransitFile Name**: 

this filename is used to storage the list of the items on the bucket (is it deleted before the shell stops)

## PutFiles.sh (Upload files from localstorage to S3)
The GetFiles.sh file puts or copy the file from a folder in your localstorage to a folder in an s3 bucket.


### **Syntaxis**
sh GetFiles.sh ***ProfileName*** ***BucketName*** ***FolderName*** ***FileName*** ***StoredFolder*** ***StoredFilename*** ***PutOrCopy***

### **Parameters**

| Name        | Description | Required    |
| :----------- | ----------- | :-----------: |
| ProfileName | is the profile associated with the credentials eg: personalprofile       | Yes       |
| Bucketname   | name of the bucket to store the file eg: testbucket        | Yes        |
| Foldername   | path in which the file is gonna be stored in bucket s3 eg: /folder1/folder2/ (must start and end with /)        | Yes        |
| FileName   | File name of the file in the bucket (can differ to StoredFilename so it is possible to rename the file) can have or not extension        | Yes        |
| StoredFolder   | Folder in wich the file is stored locally (ends with /)        | Yes        |
| StoredFilename   | FileName of the file locally        | Yes        |
| PutOrCopy   | Binary flag - True Put - False Copy        | Yes        |

**PutOrCopy**: 

TRUE : Removes the file from origin and put it on destination

FALSE: Keeps the file in origin and in destination

# Logs

Additionally both shells write logs on an text file called **PutLogsToAWS.txt**


![ImageLogs][7]


[1]:https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html
[2]:Images/Overview.drawio.png
[3]:https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
[4]:https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html
[5]:https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
[6]:https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html
[7]:Images/LogFile.png
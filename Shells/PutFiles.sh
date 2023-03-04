#Parameters ProfileName BucketName FolderName FileName StoredFolder StoredFilename PutOrCopy

# 1 ProfileName is the profile associated with the credentials eg: personalprofile
# 2 Bucketname name of the bucket to store the file eg: testbucket
# 3 Foldername path in which the file is gonna be stored in bucket s3 eg: /folder1/folder2/ (must start and end with /)
# 4 FileName File name of the file in the bucket (can differ to StoredFilename so it is possible to rename the file) can have or not extension
# 5 StoredFolder Folder in wich the file is stored locally (ends with /)
# 6 StoredFilename FileName of the file locally
# 7 PutOrCopy Binary flag - True Put - False Copy
    # Put: Removes the file from origin and put it on destination
    # Copy: Keeps the file in origin and in destination

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt >> PutLogsToAws.txt  # 12-30-2017 13:12:12
echo "Put Operation" >> PutLogsToAws.txt
echo Profile $1 BucketName $2 FolderName $3 FileName $4 StoredFolder $5 StoredFilename $6  PutCopyFlag $7 >> PutLogsToAws.txt
    if($7=="True" 2> /dev/null)
    then
        echo aws s3 mv $5$6 s3://$2$3$4 --profile $1 >> PutLogsToAws.txt
        aws s3 mv $5$6 s3://$2$3$4 --profile $1 >> PutLogsToAws.txt 2>&1
    else
        echo aws s3 cp $5$6 s3://$2$3$4 --profile $1 >> PutLogsToAws.txt
        aws s3 cp $5$6 s3://$2$3$4 --profile $1 >> PutLogsToAws.txt 2>&1
    fi
echo >> PutLogsToAws.txt
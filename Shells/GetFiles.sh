#Parameters ProfileName BucketName FolderName StoredFolder Filter DeleteFlag TransitFile

# 1 ProfileName is the profile associated with the credentials eg: personalprofile
# 2 Bucketname name of the bucket in wich the file is going to be extracted eg: testbucket
# 3 Foldername path in the bucket wich the file is going to be extracted s3 eg: /folder1/folder2/ (must start and end with /)
# 4 StoredFolder Folder in wich the file is stored locally (ends with /) 
# 5 Filter Character(s) that must be in the file for it to be extracted
# 6 DeleteFlag Flag wich determinates if the file is deleted or not in the bucket
        # True: file is deleted of the bucket
        # False: file is kept in the bucket
# 7 TransitFile Name of the file in wich saves the file list

varx="ThisIsSpecificFilter";
vartrue="True";
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt >> PutLogsToAws.txt  # 12-30-2017 13:12:12
echo "Get Operation" >> PutLogsToAws.txt
echo Profile $1 BucketName $2 FolderName $3 StoredFolder $4 Filter $5 PutCopyFlag $6 >> PutLogsToAws.txt
echo aws s3 ls s3://$2$3 --profile $1 >> PutLogsToAws.txt
aws s3 ls s3://$2$3 --profile $1 >> $7.txt 2>&1
echo >> PutLogsToAws.txt

input="$7.txt"
#Expected output like:
#                            PRE Carpeta1/
#                            PRE CarpetaPrueba2/
#                            PRE testfolder/
# 2021-11-09 18:00:07      87853 beach.jpg
# 2021-11-09 18:00:08     110985 coffee.jpg

echo "ListingFiles" >> PutLogsToAws.txt
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt >> PutLogsToAws.txt  # 12-30-2017 13:12:12
echo >> PutLogsToAws.txt

while read date hour size name #Read parameters of date hour size and name
                               #For folders the folder name is saved in hour variable and PRE is saved in date variable
do
echo "$date $hour $size $name" >> PutLogsToAws.txt
done < "$input"
echo >> PutLogsToAws.txt

echo "Processing Files" >> PutLogsToAws.txt
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt >> PutLogsToAws.txt  # 12-30-2017 13:12:12
echo >> PutLogsToAws.txt

while read date hour size name #Read parameters of date hour size and name
                               #For folders the folder name is saved in hour variable and PRE is saved in date variable
do
echo "$date $hour $size $name" >> PutLogsToAws.txt
    if [ -n "$name" 2> /dev/null ] #if there is no name is a folder so it does not have to be processed
    then
        if [ "$5" = "$varx" ] #If the filter equals the text ThisIsSpecificFilter it means this shell will grab every file in the bucket
        then
            if [ "$6" = "$vartrue" ] #If delete flag is set to true it moves the file from bucket to pc, else, it copies it
            then
                echo aws s3 mv s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt
                aws s3 mv s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt 2>&1
            else
                echo aws s3 cp s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt
                aws s3 cp s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt 2>&1
            fi
        else
            # Filter is not *
            if echo "$name" | grep -q "$5"; then # If the filter text is in the filename it will be processed otherwise is not processed
                if [ "$6" = "$vartrue" ] #If delete flag is set to true it moves the file from bucket to pc, else it copies it
                    then
                        echo aws s3 mv s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt
                        aws s3 mv s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt 2>&1
                    else
                        echo aws s3 cp s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt
                        aws s3 cp s3://$2$3$name $4$name --profile $1 >> PutLogsToAws.txt 2>&1
                fi
            fi
        fi
    fi
done < "$input"
echo >> PutLogsToAws.txt
rm $7.txt
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
#del_version=$(cat delete_version.txt)

#addr="ftp://oplab9.parqtec.unicamp.br"
echo $github_version
echo $ftp_version

if [ "$github_version" != "$ftp_version" ]
then
    wget https://github.com/rclone/rclone/releases/download/$github_version/rclone-$github_version.tar.gz
    tar -xzf rclone-$github_version.tar.gz
    mv rclone-$github_version rclone
    #cd rclone-$github_version
    cd rclone
    make 
    ./rclone --version
    #go get github.com/rclone/rclone/backend/all github.com/rclone/rclone/cmd github.com/rclone/rclone/cmd/all github.com/rclone/rclone/lib/plugin
    #go build
    pwd
    mv rclone rclone-$github_version
    if [[ $github_version != $ftp_version ]]
    then
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/rclone/latest rclone-$github_version"
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/rclone/latest/rclone-$ftp_version" 
    fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/rclone rclone-$github_version"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minio/minio-$del_version" 
fi

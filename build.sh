github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)

addr="ftp://oplab9.parqtec.unicamp.br"
echo $github_version
echo $ftp_version

if [ $github_version != $ftp_version ]
then
    wget https://github.com/rclone/rclone/releases/download/$github_version/rclone-$github_version.tar.gz
    tar -xzf rclone-$github_version.tar.gz
    #mv rclone-$github_version rclone
    cd rclone-$github_version
    go get github.com/rclone/rclone/backend/all github.com/rclone/rclone/cmd github.com/rclone/rclone/cmd/all github.com/rclone/rclone/lib/plugin
    go build
    mv rclone rclone-$github_version
    ls -a
    ./rclone-$github_version --help
    

    #if [[ $github_version > $ftp_version ]]
    #then
        #lftp -c "open -u $FTP_USER,$FTP_PASSWORD ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/rclone rclone-$github_version"
        #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /test/marcelo/rclone/latest/rclone-$ftp_version"
    #fi
    # lftp -c "open -u $FTP_USER,$FTP_PASSWORD ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/rclone rclone-$github_version"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/rclone-$del_version"

    # lftp -c "open -u $USER,$PASS $addr; cd $path; mv rclone-$ftp_version ../"

    # mv rclone rclone-$github_version
    # lftp -c "open -u $USER,$PASS $addr; cd $path; put rclone-$github_version"
fi

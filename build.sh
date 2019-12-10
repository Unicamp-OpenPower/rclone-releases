github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)
status=$(curl -s --head -w %{http_code} https://oplab9.parqtec.unicamp.br/pub/ppc64el/rclone-$github_version -o /dev/null)

addr="ftp://oplab9.parqtec.unicamp.br"
path="/test/marcelo/rclone/latest/"

   
if [ [$status==404] ]
then
    echo "CLONING"
    wget https://github.com/rclone/rclone/releases/download/$github_version/rclone-$github_version.tar.gz
    tar -xzf rclone-$github_version.tar.gz
    mv rclone-$github_version rclone
    cd rclone
    go get github.com/rclone/rclone/backend/all github.com/rclone/rclone/cmd github.com/rclone/rclone/cmd/all github.com/rclone/rclone/lib/plugin

    echo "BUILDING"
    go build
    mkdir output
    mv rclone output/rclone-$github_version
    ls -la output
    
    echo "MOVING BINARY"
    # if [[ $github_version > $ftp_version ]]
    # then
    #     #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /test/marcelo/rclone/latest rclone-$github_version"
    #     #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /test/marcelo/rclone/latest/rclone-$ftp_version"
    # fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O ppc64el/rclone rclone-$github_version"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm ppc64el/rclone-$del_version"

    # lftp -c "open -u $USER,$PASS $addr; cd $path; mv rclone-$ftp_version ../"

    # mv rclone rclone-$github_version
    # lftp -c "open -u $USER,$PASS $addr; cd $path; put rclone-$github_version"
fi
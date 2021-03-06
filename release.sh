#!/usr/bin/env bash
github_version=$(cat github_version.txt)
github_version2=$(cat github_version2.txt)
ftp_version=$(cat ftp_version.txt)
ROOTPATH="~/rpmbuild/RPMS/ppc64le"
LOCALPATH="/home/travis/gopath/src/github.com/Unicamp-OpenPower/rclone-releases/rclone"
REPO1="/repository/debian/ppc64el/rclone"
REPO2="/repository/rpm/ppc64le/rclone"


if [ "$github_version" != "$ftp_version" ]
  then
    git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
    cd repository-scrips/
    chmod +x empacotar-deb.sh
    chmod +x empacotar-rpm.sh
    sudo mv empacotar-deb.sh  $LOCALPATH
    sudo mv empacotar-rpm.sh  $LOCALPATH
    cd  $LOCALPATH
    sudo ./empacotar-deb.sh rclone rclone-$github_version $github_version2 " "
    sudo ./empacotar-rpm.sh rclone rclone-$github_version $github_version2 " " "rsync for cloud storage” - Google Drive, Amazon Drive, and more."
fi

if [[ $github_version != $ftp_version ]]
   then
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO1 $LOCALPATH/rclone-$github_version2-ppc64le.deb"
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO2 $ROOTPATH/rclone-$github_version2-1.ppc64le.rpm"
fi

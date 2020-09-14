import requests
# find and save the current Github release
html = str(
           requests.get('https://github.com/rclone/rclone/releases/latest')
           .content)
index = html.find('rclone:v')
github_version = html[index + 7 :index + 14]
github_version2 = html[index + 8 :index + 14] # remove the caracter 'v'

# version string: v1.xx.x
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()
#create the version file without v caracter in the string version: 1.xx.x
file =open('github_version2.txt','w')
file.writelines(github_version2)
file.close()

# find and save the current Docker version on FTP server
html = str(
             requests.get(
                        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/rclone/'
                        ).content)
index = html.rfind('rclone-')
ftp_version = html[index + 7:index + 14]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

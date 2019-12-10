import requests
# find and save the current Github release
html = str(
           requests.get('https://github.com/rclone/rclone/releases/latest')
           .content)
index = html.find('rclone:v')
github_version = html[index + 7 :index + 14]
print(index)
#print(html)
print("Latest:", github_version)
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Docker version on FTP server
html = str(
             requests.get(
                        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/rclone/'
                        ).content)
index = html.rfind('rclone-')
ftp_version = html[index + 7:index + 12]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()
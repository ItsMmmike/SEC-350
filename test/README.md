## Install info for Updating CentOS 7 Repost (Post EOL)
To Use:
* Nav to CentOS Box + Log into Root
* Run the following commands:

```bash
# Nav to package repo directory
cd /etc/yum.repos.d

# Make new direcotry for old files, then empty repo
mkdir /etc/yum.repos.d/old
mv /etc/yum.repos.d/CentOS*.repo /etc/yum.repos.d/old/
mv /etc/yum.repos.d/epel*.repo /etc/yum.repos.d/old/ # Note: There may not be any epel repos installed --> Continue to next step if this is the case

# Copy configs
wget "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/test/CentOS.repo"
wget "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/test/epel.repo"

# Update New Repo Configs
yum clean all
yum check-update
```

From here, you should now should be able to run `yum update`,  then `yum install <package-here>`

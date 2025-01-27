## Install info for Updating CentOS 7 (Post EOL)
To Use:
* Nav to CentOS Box + Log into User w/ sudo
* Run the following commands:

```bash
# Nav to package repo directory
cd /etc/yum.repos.d

# Copy configs to system
sudo wget "https://raw.githubusercontent.com/ItsMmmike/SEC-350/refs/heads/main/test/CentOS.repo"

### ^^^ Strongly reccomend making a backup of "/etc/yum.repos.d/CentOS-Base.Repo" before overwriting file

# Update New Repo Configs
yum clean all
yum makecache
```

From here, you should now should be able to run `yum update`,  then `yum install <package-here>`

# Linux Server Automation Toolkit

## 1. Project Overview

The Linux Server Automation Toolkit is a Bash-based project designed to automate common Linux server administration and monitoring tasks.

This project helps monitor system resources, manage Linux users, create backups, compress log files, clean temporary files, and automate recurring tasks using Cron.

## 2. Project Objectives

- Monitor CPU utilization and identify high CPU usage.
- Monitor memory utilization.
- Check root filesystem disk usage.
- Identify processes consuming high CPU and memory.
- Monitor important Linux services such as SSH, Cron, and Jenkins.
- Create timestamped compressed backups.
- Compress log files using Gzip.
- Remove temporary files safely.
- Automate Linux user creation.
- Monitor system uptime and load average.
- Execute monitoring scripts automatically using Cron.
- Maintain monitoring logs for troubleshooting.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Ubuntu 24.04 | Operating system |
| Bash | Shell scripting |
| Git | Version control |
| GitHub | Source code hosting |
| Cron | Task scheduling |
| Gzip | Log compression |
| Tar | Backup archiving |
| Systemd | Service management |
| Linux utilities | System monitoring |

## 4. Project Directory Structure

```text
linux-automation-toolkit/
│
├── backups/
├── cleanup-test/
├── config/
│   └── config.conf
├── log/
│   ├── monitoring.log
│   └── cron.log
├── scripts/
│   ├── backup.sh
│   ├── cleanup.sh
│   ├── compress_logs.sh
│   ├── cpu_check.sh
│   ├── create_user.sh
│   ├── disk_check.sh
│   ├── master.sh
│   ├── memory_check.sh
│   ├── process_check.sh
│   ├── service_check.sh
│   └── uptime.sh
├── .gitignore
├── readme.md
└── setup.sh
```

## 5. Prerequisites

Before running this project, make sure the following tools are installed:

- Ubuntu 24.04
- Bash
- Git
- Cron
- Gzip
- Tar
- Systemd
- Linux utilities such as `top`, `free`, `df`, `ps`, and `awk`

### Required Permissions

- Execute permission is required for Bash scripts.
- Sudo privileges are required for Linux user creation.
- Appropriate permissions are required to manage system services.

## 6. Installation and Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/Abis2001/linux-automation-toolkit.git
```

### Step 2: Navigate to the Project Directory

```bash
cd linux-automation-toolkit
```

### Step 3: Give Execute Permissions

```bash
chmod +x scripts/*.sh
```

### Step 4: Run the Master Monitoring Script

```bash
./scripts/master.sh
```

## 7. Individual Script Documentation

### 7.1 CPU Monitoring

**Filename:** `cpu_check.sh`

**Explanation:**

This script monitors CPU utilization using the `top` command. It extracts the CPU idle percentage using `grep` and `awk`, calculates CPU usage, and displays a warning if utilization exceeds 80%.

**Commands used:**

- `top`
- `grep`
- `awk`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

echo "***************************************"

echo "                CPU MONITORING USAGE"

echo "***************************************"

CPU_IDLE=$(top -bn1 | grep "%Cpu" | awk -F',' '{print $4}' | awk '{print $1}')

CPU_USAGE=$(awk -v idle="$CPU_IDLE" 'BEGIN {printf "%.0f", 100-idle}')

echo Cpu_Usage="$CPU_USAGE%"

if [ "$CPU_USAGE" -gt 80 ]
then
    echo "WARNING : CPU USAGE IS HIGH"
else
    echo "CPU USAGE IS NORMAL"
fi
```

**Execution:**

```bash
./scripts/cpu_check.sh
```

### 7.2 Memory Monitoring

**Filename:** `memory_check.sh`

**Explanation:**

This script monitors memory utilization using the `free` command. It calculates memory usage based on total memory and available memory. If memory utilization exceeds 80%, it displays a warning.

**Commands used:**

- `free`
- `awk`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

echo "***********************************"

echo " MEMORY USAGE CHECK "

echo "**********************************"

MEMORY_USAGE=$(free | awk '/^Mem:/ {printf "%.0f" ,($2-$7)/$2*100}')

echo "MEMORY USAGE: $MEMORY_USAGE%"

if [ "$MEMORY_USAGE" -gt 80 ]
then
    echo "WARNING MEMORY IS HIGH"
else
    echo "MEMORY IS NORMAL"
fi

echo "********************************"
```

**Execution:**

```bash
./scripts/memory_check.sh
```

### 7.3 Disk Monitoring

**Filename:** `disk_check.sh`

**Explanation:**

This script checks root filesystem disk utilization using `df`. It extracts the percentage of used disk space and displays a warning if usage exceeds 80%.

**Commands used:**

- `df`
- `awk`
- `gsub`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

echo "************************************"
echo "       DISK USAGE CHECK"
echo "************************************"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')

echo "DISK USAGE = $DISK_USAGE%"

if [ "$DISK_USAGE" -gt 80 ]
then
    echo "WARNING: DISK USAGE IS HIGH"
else
    echo "DISK USAGE IS NORMAL"
fi
```

**Execution:**

```bash
./scripts/disk_check.sh
```

### 7.4 Process Monitoring

**Filename:** `process_check.sh`

**Explanation:**

This script identifies the top 10 processes consuming CPU and memory. It also checks whether the Jenkins process is running by searching for `jenkins.war`.

**Commands used:**

- `ps`
- `head`
- `pgrep`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

echo "***********************"

echo "          PROCESS CHECKING"

echo "***********************"

echo "TOP 10 CONSUMING CPU PROCESS"

ps aux --sort=-%cpu | head -n 10

echo "TOP 10 CONSUMING MEMORY PROCESS"

ps aux --sort=-%mem | head -n 10

echo "JENKINS PROCESS STATUS"

if pgrep -f 'jenkins.war' > /dev/null
then
    echo "Jenkins process is running"
else
    echo "WARNING: Jenkins process is not running"
fi
```

**Execution:**

```bash
./scripts/process_check.sh
```

### 7.5 Service Monitoring

**Filename:** `service_check.sh`

**Explanation:**

This script checks the status of important Linux services such as SSH, Cron, and Jenkins using `systemctl`.

It uses a Bash array and a `for` loop to check each service.

**Commands used:**

- `systemctl`
- `for`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

echo "SERVICE IS RUNNING OR NOT"

SERVICES=("ssh" "cron" "jenkins")

for SERVICE in "${SERVICES[@]}"
do
   STATUS=$(systemctl is-active "$SERVICE")

   if [ "$STATUS" = "active" ]
   then
       echo "$SERVICE SERVICE IS RUNNING"
   else
       echo "WARNING: $SERVICE SERVICE IS NOT RUNNING"
   fi
done
```

**Execution:**

```bash
./scripts/service_check.sh
```

### 7.6 Automated Backup

**Filename:** `backup.sh`

**Explanation:**

This script creates a timestamped compressed backup of the `backup-test` directory. It uses `tar` and Gzip to create a `.tar.gz` archive.

**Commands used:**

- `date`
- `mkdir`
- `tar`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

SOURCE="$HOME/backup-test"
DEST="$HOME/linux-automation-toolkit/backups"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$DEST/backup_$TIMESTAMP.tar.gz"

if [ -d "$SOURCE" ]
then
    mkdir -p "$DEST"

    tar -czf "$BACKUP_FILE" -C "$HOME" backup-test

    if [ $? -eq 0 ]
    then
        echo "BACKUP SUCCESSFUL"
        echo "Backup file: $BACKUP_FILE"
    else
        echo "ERROR: BACKUP FAILED"
        exit 1
    fi
else
    echo "ERROR: SOURCE DIRECTORY NOT FOUND"
    exit 1
fi
```

**Execution:**

```bash
./scripts/backup.sh
```

**Note:** Create the source directory before running the script:

```bash
mkdir -p ~/backup-test
```

### 7.7 Log Compression

**Filename:** `compress_logs.sh`

**Explanation:**

This script compresses `.log` files in the project's `log` directory using Gzip. It uses `gzip -k` to retain the original log file after compression and checks whether a compressed file already exists.

**Commands used:**

- `gzip`
- `if`
- `for`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

SOURCE="$HOME/linux-automation-toolkit/log"

for FILE in "$SOURCE"/*.log
do
    if [ -f "$FILE" ]
    then
        if [ -f "$FILE".gz ]
        then
            echo "Already compressed file is $FILE"
        else
            gzip -k "$FILE"

            if [ $? -eq 0 ]
            then
                echo "SUCCESS $FILE COMPRESSED"
            else
                echo "ERROR: Compression failed for $FILE"
            fi
        fi
    fi
done
```

**Execution:**

```bash
./scripts/compress_logs.sh
```

### 7.8 Temporary File Cleanup

**Filename:** `cleanup.sh`

**Explanation:**

This script searches for temporary files with the `.tmp` extension inside the project's `cleanup-test` directory. It displays matching files and deletes them using the `find` command.

The `-maxdepth 1` option ensures that it only operates on files directly inside the target directory.

**Commands used:**

- `find`
- `-type`
- `-name`
- `-print`
- `-delete`

**Complete Code:**

```bash
#!/bin/bash

TARGET="$HOME/linux-automation-toolkit/cleanup-test"

echo "***********************************"
echo "         CLEANUP TOOL"
echo "***********************************"

if [ -d "$TARGET" ]
then
    echo "Checking temporary files..."

    find "$TARGET" -maxdepth 1 -type f -name "*.tmp" -print

    find "$TARGET" -maxdepth 1 -type f -name "*.tmp" -delete

    echo "Temporary files cleaned successfully."
else
    echo "ERROR: TARGET DIRECTORY NOT FOUND"
    exit 1
fi

echo "***********************************"
```

**Execution:**

```bash
./scripts/cleanup.sh
```

### 7.9 Linux User Management

**Filename:** `create_user.sh`

**Explanation:**

This script accepts a username from the user, validates the input, checks whether the user already exists, and creates a new Linux user with a home directory using `useradd -m`.

**Commands used:**

- `read`
- `id`
- `useradd`
- `sudo`
- `if`
- `exit`

**Complete Code:**

```bash
#!/bin/bash

read -p "Enter the username to create " USERNAME

if [[ ! "$USERNAME" =~ ^[a-z_][a-z0-9_-]*[@]?$ ]]
then
    echo "ERROR: Invalid username"
    exit 1
fi

if id "$USERNAME" &> /dev/null
then
    echo "User $USERNAME already exists"
else
    sudo useradd -m "$USERNAME"

    if [ $? -eq 0 ]
    then
        echo "User $USERNAME created successfully"
    else
        echo "ERROR: User creation failed"
        exit 1
    fi
fi
```

**Execution:**

```bash
./scripts/create_user.sh
```

**Note:** This script requires sudo privileges. A newly created account may need a password configured separately before interactive login.

### 7.10 System Uptime Monitoring

**Filename:** `uptime.sh`

**Explanation:**

This script displays the current date, system uptime, human-readable uptime, and system load average. It uses the Linux `/proc/loadavg` file to read load-average information.

**Commands used:**

- `date`
- `uptime`
- `cat`
- `/proc/loadavg`

**Complete Code:**

```bash
#!/bin/bash

echo "================================"

echo " server uptime Monitor"

echo "================================"

echo "Current Date"
date

echo "Server Uptime"
uptime

echo "SERVER UPTOME HUMAN READABLE"
uptime -p

echo "SYSTEM LOAD AVERAGE"
cat /proc/loadavg

echo "================================"
```

**Execution:**

```bash
./scripts/uptime.sh
```

### 7.11 Master Monitoring Script

**Filename:** `master.sh`

**Explanation:**

The master script executes six monitoring scripts in sequence. It uses a `for` loop to run CPU, memory, disk, process, service, and uptime monitoring automatically.

It also checks each script's exit status and displays a warning if a script returns a non-zero exit code.

**Commands used:**

- `for`
- `bash`
- `$?`
- `if`
- `echo`

**Complete Code:**

```bash
#!/bin/bash

PROJECT="$HOME/linux-automation-toolkit"
SCRIPTS="$PROJECT/scripts"

echo "======================================"
echo "       LINUX SERVER MONITORING"
echo "======================================"

for SCRIPT in cpu_check memory_check disk_check process_check service_check uptime
do
    echo ""
    echo "Running $SCRIPT.sh"
    echo "--------------------------------------"

    bash "$SCRIPTS/$SCRIPT.sh"

    if [ $? -ne 0 ]
    then
        echo "WARNING: $SCRIPT.sh failed"
    fi
done

echo ""
echo "======================================"
echo "       MONITORING COMPLETED"
echo "======================================"
```

**Execution:**

```bash
./scripts/master.sh
```

## 8. Logging

The project uses the `tee` command to display monitoring output on the terminal and save it to a log file.

### Save Monitoring Output

```bash
./scripts/master.sh 2>&1 | tee -a log/monitoring.log
```

### View Monitoring Logs

```bash
cat log/monitoring.log
```

### Display the Last 20 Lines

```bash
tail -n 20 log/monitoring.log
```

### Logging Explanation

- `2>&1` redirects standard error to standard output.
- `tee` displays output and writes it to a file.
- `-a` appends output instead of overwriting the file.
- `tail` displays the end of a log file.

## 9. Cron Automation

Cron is used to schedule recurring Linux tasks automatically.

### Check Cron Service

```bash
systemctl status cron
```

### Open Crontab

```bash
crontab -e
```

### Example: Run Monitoring Every Hour

```cron
0 * * * * /home/abishek/linux-automation-toolkit/scripts/master.sh >> /home/abishek/linux-automation-toolkit/log/cron.log 2>&1
```

### Verify Cron Jobs

```bash
crontab -l
```

### View Cron Logs

```bash
tail -n 30 ~/linux-automation-toolkit/log/cron.log
```

**Note:** Cron executes the monitoring script automatically at the configured schedule. In WSL, Ubuntu and its Cron service must be running for scheduled jobs to execute.

## 10. Sample Project Output

Example output from the master monitoring script:

```text
======================================
       LINUX SERVER MONITORING
======================================

Running cpu_check.sh
CPU USAGE IS NORMAL

Running memory_check.sh
MEMORY IS NORMAL

Running disk_check.sh
DISK USAGE IS NORMAL

Running process_check.sh
Jenkins process is running

Running service_check.sh
ssh SERVICE IS RUNNING
cron SERVICE IS RUNNING
jenkins SERVICE IS RUNNING

Running uptime.sh
up 57 minutes

======================================
       MONITORING COMPLETED
======================================
```

*Actual CPU, memory, disk, process and uptime values depend on the system.*

## 11. Git Ignore

Generated backup archives, log files, temporary test directories, and editor files are excluded from Git tracking.

```gitignore
# Generated backup files
backups/*.tar.gz

# Monitoring logs
log/*.log

# Temporary test files
cleanup-test/

# Temporary files
*.tmp
*.swp
*~
```

## 12. Key Learnings

Through this project, I gained practical experience in:

- Linux system administration.
- Bash scripting and automation.
- Variables, conditions, loops, and command substitution.
- CPU, memory, disk, and process monitoring.
- Linux service management using systemctl.
- Linux user management.
- Backup creation and file compression.
- Log management and troubleshooting.
- Cron-based task scheduling.
- Git version control and GitHub repository management.

## 13. Author

**Abishek Baskaran**

GitHub: https://github.com/Abis2001

**Project:** Linux Server Automation Toolkit

#!/bin/bash
#=======================================================================================
#  Name:  dynamix.system.autofan.cpu
#=======================================================================================
#  Description:
#
#  dynamix.system.autofan 改为 cpu温度获取
PATH="/tmp/dynamix.system.autofan.cpu"
ShName="autofan"
CrontabsRoot="/var/spool/cron/crontabs/root"
BINPATH="/usr/local/emhttp/plugins/dynamix.system.autofan/scripts"

if [[ -f ${BINPATH}/${ShName} && -f ${PATH}/${ShName} ]];then
  BinMD5=$(/usr/bin/md5sum ${BINPATH}/${ShName}|/usr/bin/awk '{print $1}')
  TmpMD5=$(/usr/bin/md5sum ${PATH}/${ShName}|/usr/bin/awk '{print $1}')
  if [[ ${BinMD5} == ${TmpMD5} ]];then
    exit 0
  fi
fi

if [[ -d ${BINPATH} ]]; then 
  echo ""
else
  echo "dynamix.system.autofan dose no exist!"
  exit 1
fi

if [[ -d ${PATH} ]]; then 
  cd ${PATH} && /usr/bin/git pull
else
  cd /tmp && /usr/bin/git clone https://github.com/chaosk731/dynamix.system.autofan.cpu.git
fi

if [[ -d ${PATH} ]]; then
  BinMD5=1
  TmpMD5=1
  [[ -f ${BINPATH}/${ShName} ]] && BinMD5=$(/usr/bin/md5sum ${BINPATH}/${ShName}|/usr/bin/awk '{print $1}')
  [[ -f ${PATH}/${ShName} ]] && TmpMD5=$(/usr/bin/md5sum ${PATH}/${ShName}|/usr/bin/awk '{print $1}')
  if [[ ${BinMD5} != ${TmpMD5} ]];then
    /usr/bin/cp -af ${PATH}/${ShName} ${BINPATH}/${ShName}
    /usr/local/emhttp/plugins/dynamix.system.autofan/scripts/rc.autofan restart
  fi
  [[ -f ${PATH}/dynamix.system.autofan.cpu.sh ]] && /usr/bin/cp -af ${PATH}/dynamix.system.autofan.cpu.sh /root/
  /usr/bin/grep "dynamix.system.autofan.cpu" /etc/cron.d/root || echo -e "\n#CRON for autofan.cpu\n*/1 * * * * /bin/bash /root/dynamix.system.autofan.cpu.sh" >> /etc/cron.d/root
  echo "dynamix.system.autofan.cpu done!"
fi
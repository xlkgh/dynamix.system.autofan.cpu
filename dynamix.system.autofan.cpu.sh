#!/bin/bash
#=======================================================================================
#  Name:  dynamix.system.autofan.cpu
#=======================================================================================
#  Description:
#
#  app:dynamix.system.autofan(Version 1.6) chang to get cpu temp
PATH="/tmp/dynamix.system.autofan.cpu"
ShName="autofan"
BINPATH="/usr/local/emhttp/plugins/dynamix.system.autofan/scripts"

if [[ -d ${BINPATH} ]]; then 
  echo ""
else
  echo "dynamix.system.autofan dose no exist!"
  exit 1
fi

if [[ -d ${PATH} ]]; then 
  echo ""
else
  /usr/bin/mkdir -p ${PATH}
  cd ${PATH} && /usr/bin/wget -q https://gitee.com/xlkgh/dynamix.system.autofan.cpu/raw/master/autofan
fi

if [[ -d ${PATH} ]]; then
  BinMD5=1
  TmpMD5=1
  [[ -f ${BINPATH}/${ShName} ]] && BinMD5=$(/usr/bin/md5sum ${BINPATH}/${ShName}|/usr/bin/awk '{print $1}')
  [[ -f ${PATH}/${ShName} ]] && TmpMD5=$(/usr/bin/md5sum ${PATH}/${ShName}|/usr/bin/awk '{print $1}')
  if [[ ${BinMD5} != ${TmpMD5} ]];then
    /usr/bin/cp -af ${PATH}/${ShName} ${PATH}/backup_${ShName} 
    /usr/bin/cp -af ${PATH}/${ShName} ${BINPATH}/${ShName}
    /usr/bin/chmod +x ${BINPATH}/${ShName}
    /usr/local/emhttp/plugins/dynamix.system.autofan/scripts/rc.autofan restart
  fi
  echo -e "dynamix.system.autofan.cpu done!\n"
  echo -e "backup file path : ${PATH}/backup_${ShName}\n"
fi

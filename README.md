来源于 https://github.com/chaosk731/dynamix.system.autofan.cpu.git

在此基础上修改为了gitee源，并对获取温度的代码作出调整

适合于 tank 机箱, 该机箱只有一个风扇，需要根据CPU或者硬盘中温度较高者进行调整,并且要考虑直通硬盘的温度获取

以下是原修改
> 
> # dynamix.system.autofan.cpu
> 基于unraid app dynamix.system.autofan，进行修改，将温度获取种类由磁盘改为cpu温度。便于nas diy玩家使用。cpu被动散热勿使用
> # exec
> curl "https://raw.githubusercontent.com/chaosk731/dynamix.system.autofan.cpu/master/dynamix.system.autofan.cpu.sh" | /bin/bash
> 

这里是新添加的修改

# exec

```
curl "https://gitee.com/xlkgh/dynamix.system.autofan.cpu/raw/master/dynamix.system.autofan.cpu.sh" | /bin/bash

```

#!/bin/bash

# rofi -show 自定义 -modi "自定义:~/rofi.sh"
#   1: 上述命令可调用rofi.sh作为自定义脚本
#   2: 将打印的内容作为rofi的选项
#   3: 每次选中后 会用选中项作为入参再次调用脚本
#   4: 当没有输出时 整个过程结束

server_menu_item[1]="picom"
server_cmd[1]='autorun picom'
server_menu_item[2]="easyeffects"
server_cmd[2]='autorun easyeffects'
server_menu_item[3]="aria2"
server_cmd[3]='autorun aria2'
server_menu_item[4]="megasync"
server_cmd[4]='autorun megasync'
server_menu_item[5]="sxhkd"
server_cmd[5]='autorun sxhkd'
server_menu_item[6]="textsearch"
server_cmd[6]='autorun textsearch'
server_menu_item[7]="translator"
server_cmd[7]='autorun translator'
server_menu_item[8]="conky"
server_cmd[8]='autorun conky'
server_menu_item[9]="vmware"
server_cmd[9]='autorun vmware'

server_menu() {
    echo -e "\0prompt\x1fserver"
    for item in "${server_menu_item[@]}"; do
        echo "$item"
    done
}

[ ! "$*" ] && server_menu
for i in "${!server_menu_item[@]}"; do
    [ "$*" = "${server_menu_item[$i]}" ] && eval "${server_cmd[$i]}"
done

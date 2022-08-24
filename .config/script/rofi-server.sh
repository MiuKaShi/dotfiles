# rofi -show 自定义 -modi "自定义:~/rofi.sh"
#   1: 上述命令可调用rofi.sh作为自定义脚本
#   2: 将打印的内容作为rofi的选项
#   3: 每次选中后 会用选中项作为入参再次调用脚本
#   4: 当没有输出时 整个过程结束

server_menu_item[1]="picom"
server_cmd[1]='killall picom || autorun picom'
server_menu_item[2]="easyeffects"
server_cmd[2]='killall easyeffects || autorun easyeffects'
server_menu_item[3]="aria2c"
server_cmd[3]='killall aria2c || autorun aria2c'
server_menu_item[4]="nutstore"
server_cmd[4]='killall nutstore || autorun nutstore'
server_menu_item[5]="sxhkd"
server_cmd[5]='killall sxhkd || autorun sxhkd'
server_menu_item[6]="remaps"
server_cmd[6]='killall remaps || autorun remaps'
server_menu_item[7]="virsual arch"
server_cmd[7]='[ "$(docker ps | grep minearch)" ] && docker stop minearch >> /dev/null || docker restart minearch >> /dev/null && docker exec -u root -itd arch bash -c "/usr/sbin/vncserver :1" ;'

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

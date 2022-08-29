--- Gismeteo api manual https://www.gismeteo.ru/api/ ---
dofile (scripts .. "token.lua")

local img_path = scripts .. "/gismeteo/new_png/"
local min_img_path = scripts .. "/gismeteo/min_icons/min_"

local weather_data = { '','','' }
local need_count = 4
local xs = { 30, 180, 330, 480 } -- положение каждого элемента по горизонтали

--------------
--- Погода ---
--------------
function weather()
    local date = os.date ("*t")
    weather_now()
    weather_by_hours(date)
    weather_by_days(date)
end

---------------------
--- Запрос на API ---
---------------------
function get_weather(key, type, params)
    local url = "curl -H 'X-Gismeteo-Token: "..token.."' 'https://api.gismeteo.net/v2/weather/"..type.."/"..cityid.."/"..params.."'"
    local f = io.popen(url)
    weather_data[key] = f:read("*a")
    f:close()
end

-------------------------
--- Актуальная погода ---
-------------------------
function weather_now()
    if weather_data[1] == '' or os.date("%M:%S") == '00:01' then
        get_weather(1, 'current', '')
    end
    local response = json.decode(weather_data[1]).response
    local temp = string.gsub(response.temperature.air.C, ",", ".")
    local comf = string.gsub(response.temperature.comfort.C, ",", ".")
    text_by_left ({x=20,  y=920}, temp, { color='0x02c3fa', font='LED', size='88' })
    text_by_left ({x=10,   y=960}, comf, { font='LED', size='68'})
    text_by_right({x=383, y=905}, format_wind(response.wind.direction.scale_8), { font='Arrows', size=60 })
    text_by_right({x=423, y=900}, response.wind.speed.m_s, { font='LED', size='38' })
    text_by_right({x=483, y=900}, 'm/s', { font='LED', size='22' })
    text_by_right({x=383, y=940}, response.pressure.mm_hg_atm, { font='LED', size='38' })
    text_by_right({x=483, y=940}, 'мм.рт.ст.', { size='22' })
    text_by_right({x=463, y=965}, response.description.full, { size='20' })
    display_image( { img = img_path..response.icon..'.png', coord = { x = 213, y = 880 } } )
end

----------------------------
--- Погода каждые 3 часа ---
----------------------------
function weather_by_hours(now_date)
    if weather_data[2] == '' or os.date("%M:%S") == '00:06' then
        get_weather(2,'forecast', '?days=2')
    end
    local response = json.decode(weather_data[2]).response
    local counter = 1
    local ys = { 985, 1005, 1065 } -- положение каждого жлемента по вертикали
    for i in pairs(response) do
        local date = os.date("*t", response[i]['date']['unix'])
        if counter <= need_count and (date.hour > now_date.hour or date.day > now_date.day or date.month > now_date.month or date.year > now_date.year) then
            local temp = response[i]['temperature']['air']['C']
            text_by_center({x=xs[counter], y=ys[1]}, date.hour..':00', {size='24'})
            text_by_center({x=xs[counter], y=ys[3]}, temp..'°', {size='22'}, { color=temp_color(temp) })
            display_image ({ img = min_img_path..response[i]['icon']..'.png', coord = { x = xs[counter]-35/2, y = ys[2] }} )
            display_wind(response[i].wind.direction.scale_8, {x=xs[counter], y=ys[3]})
            counter = counter+1
        end
        if counter > need_count then break end
    end
end

-------------------------------
--- Погода на следующие дни ---
-------------------------------
function weather_by_days(now_date)
    if weather_data[3] == '' or os.date("%M:%S") == '00:11' then
        get_weather(3,'forecast/aggregate', '?days=5')
    end
    local response = json.decode(weather_data[3]).response
    local counter  = 1
    local ys = { 1130, 1150, 1210, 1230 } -- положение каждого жлемента по вертикали
    for i in pairs(response) do
        local date = os.date("*t", response[i]['date']['unix'])
        if counter <= need_count and (date.day > now_date.day or date.month > now_date.month or date.year > now_date.year) then
            local temp_max = response[i]['temperature']['air']['max']['C']
            local temp_min = response[i]['temperature']['air']['min']['C']
            text_by_center({x=xs[counter],   y=ys[1]}, date.day..'.'..get_weekday(date.wday), {size='24'})
            text_by_center({x=xs[counter]-5, y=ys[3]}, temp_max..'°', {size='20'}, { color=temp_color(temp_max) })
            text_by_center({x=xs[counter]+5, y=ys[4]}, temp_min..'°', {size='20'}, { color=temp_color(temp_min) })
            display_image ( { img = min_img_path..response[i]['icon']..'.png', coord = { x = xs[counter]-35/2, y = ys[2] }} )
            display_wind(response[i].wind.direction.max.scale_8, {x=xs[counter], y=ys[3]})
            counter = counter+1
        end
        if counter > need_count then break end
    end
end

------------------------------------
--- Направление ветра стрелочкой ---
------------------------------------
function display_wind(wind, coord)
    local arrow = format_wind(wind)
    text_by_center({x=coord.x-10, y=coord.y-25}, arrow, { color='0x000000', font='Arrows', size=42 })
    text_by_center({x=coord.x-10, y=coord.y-25}, arrow, { font='Arrows', size=36 })
end

------------------------------------------------------------
--- Конвертация направления ветра в символ для стрелочки ---
------------------------------------------------------------
function format_wind(wind)
    local arrows = {
        '',  -- Штиль
        'd', -- Северный
        'f', -- Северо-восточный
        'b', -- Восточный
        'e', -- Юго-восточный
        'c', -- Южный
        'g', -- Юго-западный
        'a', -- Западный
        'h', -- Северо-западный
    }

    return arrows[wind+1]
end

---------------------------------------
--- Градация цветов для температуры ---
---------------------------------------
function temp_color(temp)
    if temp > 30  then return "0xcc0000" end
    if temp > 20  then return "0xffb4bb" end
    if temp > 10  then return "0xffe0ba" end
    if temp > 0   then return "0xfce3c4" end
    if temp == 0  then return  def.color end
    if temp > -10 then return "0xbae1ff" end
    if temp > -20 then return "0x0ad1f3" end
    if temp > -30 then return "0x3c82e2" end
    if -30 > temp then return "0x0000cc" end
end

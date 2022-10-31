require 'lib.moonloader'

script_name("/giftmap-halloween22")
script_version("31.10.2022-115")
script_author("Serhiy_Rubin", "qrlk")
script_properties("work-in-pause")
script_url("https://github.com/qrlk/giftmap-halloween22")

-- https://github.com/qrlk/qrlk.lua.moonloader
local enable_sentry = true -- false to disable error reports to sentry.io
if enable_sentry then
  local sentry_loaded, Sentry = pcall(loadstring, [=[return {init=function(a)local b,c,d=string.match(a.dsn,"https://(.+)@(.+)/(%d+)")local e=string.format("https://%s/api/%d/store/?sentry_key=%s&sentry_version=7&sentry_data=",c,d,b)local f=string.format("local target_id = %d local target_name = \"%s\" local target_path = \"%s\" local sentry_url = \"%s\"\n",thisScript().id,thisScript().name,thisScript().path:gsub("\\","\\\\"),e)..[[require"lib.moonloader"script_name("sentry-error-reporter-for: "..target_name.." (ID: "..target_id..")")script_description("Этот скрипт перехватывает вылеты скрипта '"..target_name.." (ID: "..target_id..")".."' и отправляет их в систему мониторинга ошибок Sentry.")local a=require"encoding"a.default="CP1251"local b=a.UTF8;local c="moonloader"function getVolumeSerial()local d=require"ffi"d.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local e=d.new("unsigned long[1]",0)d.C.GetVolumeInformationA(nil,nil,0,e,nil,nil,nil,0)e=e[0]return e end;function getNick()local f,g=pcall(function()local f,h=sampGetPlayerIdByCharHandle(PLAYER_PED)return sampGetPlayerNickname(h)end)if f then return g else return"unknown"end end;function getRealPath(i)if doesFileExist(i)then return i end;local j=-1;local k=getWorkingDirectory()while j*-1~=string.len(i)+1 do local l=string.sub(i,0,j)local m,n=string.find(string.sub(k,-string.len(l),-1),l)if m and n then return k:sub(0,-1*(m+string.len(l)))..i end;j=j-1 end;return i end;function url_encode(o)if o then o=o:gsub("\n","\r\n")o=o:gsub("([^%w %-%_%.%~])",function(p)return("%%%02X"):format(string.byte(p))end)o=o:gsub(" ","+")end;return o end;function parseType(q)local r=q:match("([^\n]*)\n?")local s=r:match("^.+:%d+: (.+)")return s or"Exception"end;function parseStacktrace(q)local t={frames={}}local u={}for v in q:gmatch("([^\n]*)\n?")do local w,x=v:match("^	*(.:.-):(%d+):")if not w then w,x=v:match("^	*%.%.%.(.-):(%d+):")if w then w=getRealPath(w)end end;if w and x then x=tonumber(x)local y={in_app=target_path==w,abs_path=w,filename=w:match("^.+\\(.+)$"),lineno=x}if x~=0 then y["pre_context"]={fileLine(w,x-3),fileLine(w,x-2),fileLine(w,x-1)}y["context_line"]=fileLine(w,x)y["post_context"]={fileLine(w,x+1),fileLine(w,x+2),fileLine(w,x+3)}end;local z=v:match("in function '(.-)'")if z then y["function"]=z else local A,B=v:match("in function <%.* *(.-):(%d+)>")if A and B then y["function"]=fileLine(getRealPath(A),B)else if#u==0 then y["function"]=q:match("%[C%]: in function '(.-)'\n")end end end;table.insert(u,y)end end;for j=#u,1,-1 do table.insert(t.frames,u[j])end;if#t.frames==0 then return nil end;return t end;function fileLine(C,D)D=tonumber(D)if doesFileExist(C)then local E=0;for v in io.lines(C)do E=E+1;if E==D then return v end end;return nil else return C..D end end;function onSystemMessage(q,type,i)if i and type==3 and i.id==target_id and i.name==target_name and i.path==target_path and not q:find("Script died due to an error.")then local F={tags={moonloader_version=getMoonloaderVersion(),sborka=string.match(getGameDirectory(),".+\\(.-)$")},level="error",exception={values={{type=parseType(q),value=q,mechanism={type="generic",handled=false},stacktrace=parseStacktrace(q)}}},environment="production",logger=c.." (no sampfuncs)",release=i.name.."@"..i.version,extra={uptime=os.clock()},user={id=getVolumeSerial()},sdk={name="qrlk.lua.moonloader",version="0.0.0"}}if isSampAvailable()and isSampfuncsLoaded()then F.logger=c;F.user.username=getNick().."@"..sampGetCurrentServerAddress()F.tags.game_state=sampGetGamestate()F.tags.server=sampGetCurrentServerAddress()F.tags.server_name=sampGetCurrentServerName()else end;print(downloadUrlToFile(sentry_url..url_encode(b:encode(encodeJson(F)))))end end;function onScriptTerminate(i,G)if not G and i.id==target_id then lua_thread.create(function()print("скрипт "..target_name.." (ID: "..target_id..")".."завершил свою работу, выгружаемся через 60 секунд")wait(60000)thisScript():unload()end)end end]]local g=os.tmpname()local h=io.open(g,"w+")h:write(f)h:close()script.load(g)os.remove(g)end}]=])
  if sentry_loaded and Sentry then
    pcall(Sentry().init, { dsn = "https://c5baba2e847149cbae46a3c832f4843f@o1272228.ingest.sentry.io/4504078576648192" })
  end
end

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
  local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
  if updater_loaded then
    autoupdate_loaded, Update = pcall(Updater)
    if autoupdate_loaded then
      Update.json_url = "https://raw.githubusercontent.com/qrlk/giftmap-halloween22/main/version.json?" .. tostring(os.clock())
      Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
      Update.url = "https://github.com/qrlk/giftmap-halloween22"
    end
  end
end

local sampev = require "lib.samp.events"
local inicfg = require "inicfg"
local map, checkpoints = {}, {}
local gift, wh = {}, false

local chatTag = "{FF5F5F}" .. thisScript().name .. "{ffffff}"

function main()
  if not isSampLoaded() or not isSampfuncsLoaded() then
    return
  end
  while not isSampAvailable() do
    wait(0)
  end

  -- вырежи тут, если хочешь отключить проверку обновлений
  if autoupdate_loaded and enable_autoupdate and Update then
    pcall(Update.check, Update.json_url, Update.prefix, Update.url)
  end
  -- вырежи тут, если хочешь отключить проверку обновлений

  serverAddress = sampGetCurrentServerAddress()

  function switch()
    wh = not wh

    local count = 0
    for k, v in pairs(map_ico) do
      count = count + 1
    end

    if not wh then
      if map_ico ~= nil then
        for id, data in pairs(map_ico) do
          removeBlip(map[id])
          deleteCheckpoint(checkpoints[id])
        end
        map, checkpoints = {}, {}
      end
    else
      sampShowDialog(5557, "\t" .. chatTag .. " by {2f72f7}Serhiy_Rubin{ffffff}, {348cb2}qrlk", "{FF5F5F}Активация{ffffff}:\nВведите {2f72f7}/giftmap-halloween22{ffffff}, чтобы включить/выключить скрипт.\n\n{FF5F5F}Event{ffffff}:\nНа карте есть точки, где спавнятся тыквы.\nТыквы дают какие-то монетки, их можно менять на призы: аксессуары и мелочь всякую.\nСейчас скрипт знает о " .. count .. " точках спавна.\nКогда вы заметите тыкву, она добавится в вашу локальную базу.\n\n{FF5F5F}Как это работает?{ffffff}\nНа радаре появятся метки точек спавна подарков.\nБольшая точка означает самую ближайшую точку.\nС помощью чекпоинтов вы сможете сориентироваться.\nВыйдя в меню и открыв карту, вы сможете увидеть все тыквы.\nЕсли на точке ничего нет/не подбирается, значит, что яйцо подобрали и надо ждать пока оно респавнется.\n\n{FF5F5F}Обозначения:{ffffff}\n* Маленькая белая метка - вне зоны прорисовки.\n* Большая красная метка - точка занята игроками.\n* Большая голубая метка - на точке есть подарок.\n\n{FF5F5F}Ссылки:{ffffff}\n* https://github.com/qrlk/giftmap-halloween22\n* https://vk.com/rubin.mods", "OK")
    end

    printStringNow((wh and "ON, DB: " .. count .. "/125" or "OFF, DB: " .. count .. "/125"), 1000)
  end

  sampRegisterChatCommand(
      "giftmap-halloween22",
      switch
  )

  map_ico = inicfg.load({
    x10323984375 = {
      x = 1032.3984375,
      y = 1313.3725585938,
      z = 10.827500343323
    },
    x10653502197266 = {
      x = 1065.3502197266,
      y = 1918.76953125,
      z = 10.820300102234
    },
    x10825444335938 = {
      x = 1082.5444335938,
      y = 1603.2469482422,
      z = 12.546799659729
    },
    x10825831298828 = {
      x = 1082.5831298828,
      y = -1614.8579101563,
      z = 13.664600372314
    },
    x11034753417969 = {
      x = 1103.4753417969,
      y = -1885.3728027344,
      z = 13.546799659729
    },
    x11209620361328 = {
      x = 1120.9620361328,
      y = -864.06011962891,
      z = 43.261100769043
    },
    x12052135009766 = {
      x = 1205.2135009766,
      y = -1071.1046142578,
      z = 29.245800018311
    },
    x12439250488281 = {
      x = 1243.9250488281,
      y = -1466.8083496094,
      z = 13.546799659729
    },
    x12495278320313 = {
      x = 1249.5278320313,
      y = 2585.0290527344,
      z = 10.820300102234
    },
    x13053647460938 = {
      x = 1305.3647460938,
      y = 1968.7945556641,
      z = 10.820300102234
    },
    x13345633544922 = {
      x = 1334.5633544922,
      y = -862.77020263672,
      z = 39.53630065918
    },
    x13416302490234 = {
      x = 1341.6302490234,
      y = -1810.2855224609,
      z = 13.536399841309
    },
    x13533858642578 = {
      x = 1353.3858642578,
      y = 941.35162353516,
      z = 10.820300102234
    },
    x13869305419922 = {
      x = 1386.9305419922,
      y = 2262.5275878906,
      z = 10.820300102234
    },
    x14032508544922 = {
      x = 1403.2508544922,
      y = -1503.0390625,
      z = 13.565899848938
    },
    x14266490478516 = {
      x = -1426.6490478516,
      y = 886.48651123047,
      z = 7.1875
    },
    x14305357666016 = {
      x = 1430.5357666016,
      y = 2698.7248535156,
      z = 11.1875
    },
    x14352040100098 = {
      x = 143.52040100098,
      y = -1660.0837402344,
      z = 13.373999595642
    },
    x14704748535156 = {
      x = 1470.4748535156,
      y = 1865.2794189453,
      z = 10.820300102234
    },
    x14938857421875 = {
      x = 1493.8857421875,
      y = -1111.1313476563,
      z = 24.033100128174
    },
    x15486380004883 = {
      x = 154.86380004883,
      y = -1960.3525390625,
      z = 3.7734000682831
    },
    x15510073242188 = {
      x = -1551.0073242188,
      y = 1170.1546630859,
      z = 7.1875
    },
    x15605167236328 = {
      x = 1560.5167236328,
      y = 1708.1092529297,
      z = 10.820300102234
    },
    x15613582763672 = {
      x = 1561.3582763672,
      y = -1495.5642089844,
      z = 13.558500289917
    },
    x15675291748047 = {
      x = 1567.5291748047,
      y = -1890.9041748047,
      z = 13.559200286865
    },
    x15783172607422 = {
      x = -1578.3172607422,
      y = 949.40472412109,
      z = 7.1875
    },
    x15809143066406 = {
      x = 1580.9143066406,
      y = 2371.3942871094,
      z = 10.820300102234
    },
    x16052993164063 = {
      x = -1605.2993164063,
      y = 789.55822753906,
      z = 6.8203001022339
    },
    x16264847412109 = {
      x = 1626.4847412109,
      y = 633.8779296875,
      z = 10.820300102234
    },
    x16499256591797 = {
      x = 1649.9256591797,
      y = 2219.4245605469,
      z = 10.820300102234
    },
    x16538707275391 = {
      x = -1653.8707275391,
      y = 373.37539672852,
      z = 7.1875
    },
    x16611507568359 = {
      x = 1661.1507568359,
      y = 2685.4113769531,
      z = 10.820300102234
    },
    x16880786132813 = {
      x = 1688.0786132813,
      y = -1342.9168701172,
      z = 17.425100326538
    },
    x16935921630859 = {
      x = 1693.5921630859,
      y = -1980.0406494141,
      z = 14.117099761963
    },
    x17059024658203 = {
      x = -1705.9024658203,
      y = 1221.3260498047,
      z = 30.078100204468
    },
    x17150776367188 = {
      x = -1715.0776367188,
      y = -603.64727783203,
      z = 14.303700447083
    },
    x17428128662109 = {
      x = 1742.8128662109,
      y = 1374.1765136719,
      z = 10.707599639893
    },
    x17449300537109 = {
      x = 1744.9300537109,
      y = -1033.3690185547,
      z = 23.960800170898
    },
    x17606716308594 = {
      x = -1760.6716308594,
      y = 755.18591308594,
      z = 24.890600204468
    },
    x17754420166016 = {
      x = 1775.4420166016,
      y = 1709.8923339844,
      z = 7.4738001823425
    },
    x17755389404297 = {
      x = -1775.5389404297,
      y = 1400.8531494141,
      z = 7.1875
    },
    x18376032714844 = {
      x = 1837.6032714844,
      y = -2131.4565429688,
      z = 15.173899650574
    },
    x1846248046875 = {
      x = -1846.248046875,
      y = 135.47470092773,
      z = 15.117099761963
    },
    x18587420654297 = {
      x = 1858.7420654297,
      y = 2727.5651855469,
      z = 10.835900306702
    },
    x18799223632813 = {
      x = -1879.9223632813,
      y = 465.349609375,
      z = 35.171901702881
    },
    x19027497558594 = {
      x = 1902.7497558594,
      y = 2392.1525878906,
      z = 10.820300102234
    },
    x1903005859375 = {
      x = -1903.005859375,
      y = 305.92309570313,
      z = 41.046901702881
    },
    x19030716552734 = {
      x = -1903.0716552734,
      y = -473.98611450195,
      z = 25.171800613403
    },
    x19058839111328 = {
      x = 1905.8839111328,
      y = -1908.3249511719,
      z = 15.027500152588
    },
    x19193005371094 = {
      x = -1919.3005371094,
      y = 685.65991210938,
      z = 46.5625
    },
    x19601676025391 = {
      x = -1960.1676025391,
      y = -721.00567626953,
      z = 32.2047996521
    },
    x19766772460938 = {
      x = -1976.6772460938,
      y = 1389.3431396484,
      z = 7.1819000244141
    },
    x19789140319824 = {
      x = 197.89140319824,
      y = -1439.8724365234,
      z = 13.071299552917
    },
    x19923441162109 = {
      x = 1992.3441162109,
      y = 2073.509765625,
      z = 10.820300102234
    },
    x20061375732422 = {
      x = 2006.1375732422,
      y = -2135.3464355469,
      z = 13.546799659729
    },
    x20127768554688 = {
      x = 2012.7768554688,
      y = -1043.443359375,
      z = 24.723100662231
    },
    x20195958251953 = {
      x = 2019.5958251953,
      y = 630.10241699219,
      z = 10.820300102234
    },
    x20416070556641 = {
      x = 2041.6070556641,
      y = 1738.4919433594,
      z = 10.820300102234
    },
    x20682646484375 = {
      x = 2068.2646484375,
      y = 2764.2604980469,
      z = 10.820300102234
    },
    x21285473632813 = {
      x = -2128.5473632813,
      y = 179.21020507813,
      z = 35.201801300049
    },
    x21601083984375 = {
      x = 2160.1083984375,
      y = 1053.9327392578,
      z = 10.820300102234
    },
    x21821479492188 = {
      x = 2182.1479492188,
      y = 1787.2312011719,
      z = 10.820300102234
    },
    x22215129394531 = {
      x = 2221.5129394531,
      y = 2819.0729980469,
      z = 10.820300102234
    },
    x22247331542969 = {
      x = -2224.7331542969,
      y = -381.78540039063,
      z = 35.419300079346
    },
    x22496977539063 = {
      x = 2249.6977539063,
      y = -2153.0810546875,
      z = 13.546799659729
    },
    x22664760742188 = {
      x = 2266.4760742188,
      y = 934.92321777344,
      z = 10.826899528503
    },
    x22738894042969 = {
      x = -2273.8894042969,
      y = 527.57012939453,
      z = 35.01549911499
    },
    x23057026367188 = {
      x = 2305.7026367188,
      y = 1914.9178466797,
      z = 10.976499557495
    },
    x23180554199219 = {
      x = -2318.0554199219,
      y = -116.70259857178,
      z = 35.320301055908
    },
    x23203029785156 = {
      x = 2320.3029785156,
      y = 2574.0354003906,
      z = 10.818400382996
    },
    x23803784179688 = {
      x = 2380.3784179688,
      y = 641.78851318359,
      z = 10.820300102234
    },
    x23816206054688 = {
      x = 2381.6206054688,
      y = 1033.7451171875,
      z = 10.820300102234
    },
    x24007465820313 = {
      x = 2400.7465820313,
      y = 1181.0947265625,
      z = 10.820300102234
    },
    x2423484375 = {
      x = -2423.484375,
      y = 663.63952636719,
      z = 35.001800537109
    },
    x246730859375 = {
      x = 2467.30859375,
      y = -1813.5948486328,
      z = 16.205600738525
    },
    x24745678710938 = {
      x = 2474.5678710938,
      y = 1428.1511230469,
      z = 10.820300102234
    },
    x24988862304688 = {
      x = 2498.8862304688,
      y = 762.76391601563,
      z = 10.820300102234
    },
    x25156447753906 = {
      x = -2515.6447753906,
      y = 393.02780151367,
      z = 27.769800186157
    },
    x25233044433594 = {
      x = 2523.3044433594,
      y = -1968.9558105469,
      z = 13.546799659729
    },
    x25245112304688 = {
      x = 2524.5112304688,
      y = 1915.0354003906,
      z = 10.822099685669
    },
    x25267565917969 = {
      x = -2526.7565917969,
      y = 1163.7744140625,
      z = 55.4375
    },
    x25309125976563 = {
      x = 2530.9125976563,
      y = -1133.8935546875,
      z = 42.830299377441
    },
    x25363737792969 = {
      x = 2536.3737792969,
      y = 2640.8935546875,
      z = 10.820300102234
    },
    x25511323242188 = {
      x = 2551.1323242188,
      y = 2185.5646972656,
      z = 10.820300102234
    },
    x25589877929688 = {
      x = -2558.9877929688,
      y = 1396.5128173828,
      z = 7.1875
    },
    x25715061035156 = {
      x = 2571.5061035156,
      y = 1302.0135498047,
      z = 10.820300102234
    },
    x25903312988281 = {
      x = 2590.3312988281,
      y = 1559.4073486328,
      z = 10.820300102234
    },
    x26180712890625 = {
      x = 2618.0712890625,
      y = -2142.0192871094,
      z = 13.546799659729
    },
    x26274230957031 = {
      x = -2627.4230957031,
      y = 232.80690002441,
      z = 4.484799861908
    },
    x26373884277344 = {
      x = 2637.3884277344,
      y = 2349.9533691406,
      z = 10.671799659729
    },
    x26769123535156 = {
      x = -2676.9123535156,
      y = -5.4903998374939,
      z = 6.1328001022339
    },
    x26947429199219 = {
      x = 2694.7429199219,
      y = -1109.1596679688,
      z = 69.52140045166
    },
    x27060695800781 = {
      x = -2706.0695800781,
      y = 376.67050170898,
      z = 4.9682002067566
    },
    x2734447265625 = {
      x = -2734.447265625,
      y = 969.60772705078,
      z = 54.367500305176
    },
    x27795874023438 = {
      x = 2779.5874023438,
      y = -2089.2495117188,
      z = 11.76159954071
    },
    x27952358398438 = {
      x = 2795.2358398438,
      y = -1944.4797363281,
      z = 17.320199966431
    },
    x28040346679688 = {
      x = 2804.0346679688,
      y = -1740.1214599609,
      z = 11.843700408936
    },
    x28232260742188 = {
      x = -2823.2260742188,
      y = 1078.0257568359,
      z = 27.749000549316
    },
    x2842251953125 = {
      x = -2842.251953125,
      y = -402.40530395508,
      z = 10.680500030518
    },
    x28438249511719 = {
      x = 2843.8249511719,
      y = 2403.5913085938,
      z = 10.820300102234
    },
    x29364919433594 = {
      x = 2936.4919433594,
      y = -2051.6311035156,
      z = 3.5480000972748
    },
    x29469587402344 = {
      x = 2946.9587402344,
      y = -1422.4852294922,
      z = 10.66759967804
    },
    x29873190307617 = {
      x = 298.73190307617,
      y = -1561.3842773438,
      z = 36.039100646973
    },
    x2990283203125 = {
      x = -2990.283203125,
      y = 462.92520141602,
      z = 4.9141001701355
    },
    x36757281494141 = {
      x = 367.57281494141,
      y = -2041.4493408203,
      z = 7.6718001365662
    },
    x53484271240234 = {
      x = 534.84271240234,
      y = -1873.5079345703,
      z = 3.9356000423431
    },
    x68650372314453 = {
      x = 686.50372314453,
      y = -1727.0053710938,
      z = 8.7031002044678
    },
    x68725177001953 = {
      x = 687.25177001953,
      y = -1245.5959472656,
      z = 14.428000450134
    },
    x82873480224609 = {
      x = 828.73480224609,
      y = -1855.0788574219,
      z = 8.329400062561
    },
    x83621832275391 = {
      x = 836.21832275391,
      y = -2061.2143554688,
      z = 12.867099761963
    },
    x90672302246094 = {
      x = 906.72302246094,
      y = -936.83221435547,
      z = 42.65650177002
    },
    x97764202880859 = {
      x = 977.64202880859,
      y = 2171.1052246094,
      z = 10.820300102234
    },
    x97985272216797 = {
      x = 979.85272216797,
      y = -1266.6434326172,
      z = 15.41489982605
    },
    x98925360107422 = {
      x = 989.25360107422,
      y = -1446.6364746094,
      z = 13.546799659729
    },
    x99848791503906 = {
      x = 998.48791503906,
      y = 1079.7037353516,
      z = 10.820300102234
    }
  }, "giftmap-halloween22")

  inicfg.save(map_ico, "giftmap-halloween22")

  sampAddChatMessage((chatTag .. " by {2f72f7}Serhiy_Rubin{ffffff} & {348cb2}qrlk{ffffff} successfully loaded!"), -1)
  while true do
    wait(500)
    if wh then
      local dist = 99999
      for key, coord in pairs(map_ico) do
        local x, y, z = getCharCoordinates(PLAYER_PED)
        local distance = getDistanceBetweenCoords2d(coord.x, coord.y, x, y)
        if not isPauseMenuActive() then
          if distance < 1200 then
            if map[key] == nil then
              map[key] = addBlipForCoord(coord.x, coord.y, coord.z)
              checkpoints[key] = createCheckpoint(1, coord.x, coord.y, coord.z, coord.x, coord.y, coord.z, 5)
            end
            if distance < 200 then
              changeBlipScale(map[key], 5)
              if findAllRandomCharsInSphere(coord.x, coord.y, coord.z, 5, false, true) then
                if isAnyPickupAtCoords(coord.x, coord.y, coord.z) then
                  changeBlipColour(map[key], 0x00FFFFFF)
                else
                  changeBlipColour(map[key], 0xFF0000FF)
                end
              else
                if isAnyPickupAtCoords(coord.x, coord.y, coord.z) then
                  changeBlipColour(map[key], 0x00FFFFFF)
                else
                  changeBlipColour(map[key], 0x00FF00FF)
                end
              end
            else
              changeBlipScale(map[key], 2)
              changeBlipColour(map[key], 0xFFFFFFFF)
            end
          else
            if map[key] ~= nil then
              removeBlip(map[key])
              map[key] = nil

              deleteCheckpoint(checkpoints[key])
              checkpoints[key] = nil
            end
          end
          if distance < dist then
            bliz = key
            dist = distance
          end
        else
          if map[key] == nil then
            map[key] = addBlipForCoord(coord.x, coord.y, coord.z)
            checkpoints[key] = createCheckpoint(1, coord.x, coord.y, coord.z, coord.x, coord.y, coord.z, 5)
            changeBlipScale(map[key], 2)
            changeBlipColour(map[key], 0xFF2138eb)
          end
        end
      end

      changeBlipScale(map[bliz], 8)
    end
  end
end

function sampev.onCreatePickup(id, model, pickupType, pos)
  if serverAddress == '92.63.199.6' or serverAddress == '92.63.199.5' or serverAddress == '92.63.199.8' or serverAddress == '92.63.199.7' then
    local x, y, z = getCharCoordinates(playerPed)
    if model == 19320 then
      if getDistanceBetweenCoords3d(x, y, z, pos.x, pos.y, pos.z) < 300 then
        lua_thread.create(
            function()
              local gift_string = string.gsub(tostring(math.abs(pos.x)), "%.", "")
              gift_string = math.modf(tonumber(gift_string), 10)
              if map_ico["x" .. tostring(gift_string)] == nil then
                print("Обнаружена тыква", model, pos.x, pos.y, pos.z)
                local message = {
                  gift_string = gift_string,
                  typ = "pumkpin",
                  x = pos.x,
                  y = pos.y,
                  z = pos.z,
                  rand = os.time()
                }
                downloadUrlToFile("http://qrlk.me:13625/" .. encodeJson(message))

                if wh then
                  addOneOffSound(0.0, 0.0, 0.0, 1139)
                  --downloadUrlToFile("http://qrlk.me:13625/" .. encodeJson(message))

                  map_ico["x" .. tostring(gift_string)] = { x = pos.x, y = pos.y, z = pos.z }
                  map["x" .. tostring(gift_string)] = addBlipForCoord(pos.x, pos.y, pos.z)
                  checkpoints["x" .. tostring(gift_string)] = createCheckpoint(1, pos.x, pos.y, pos.z, pos.x, pos.y, pos.z, 5)

                  changeBlipScale(map["x" .. tostring(gift_string)], 1)
                  inicfg.save(map_ico, "giftmap-halloween22")
                end
              end
            end
        )
      end
    end
  end
end

function onScriptTerminate()
  if map_ico ~= nil then
    for id, data in pairs(map_ico) do
      removeBlip(map[id])
      deleteCheckpoint(checkpoints[id])
    end
  end
end
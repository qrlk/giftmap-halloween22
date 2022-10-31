require 'lib.moonloader'

script_name("/giftmap-easter22")
script_version("25.06.2022")
script_author("Serhiy_Rubin", "qrlk")
script_properties("work-in-pause")
script_url("https://github.com/qrlk/giftmap-easter22")

-- https://github.com/qrlk/qrlk.lua.moonloader
local enable_sentry = true -- false to disable error reports to sentry.io
if enable_sentry then
  local sentry_loaded, Sentry = pcall(loadstring, [=[return {init=function(a)local b,c,d=string.match(a.dsn,"https://(.+)@(.+)/(%d+)")local e=string.format("https://%s/api/%d/store/?sentry_key=%s&sentry_version=7&sentry_data=",c,d,b)local f=string.format("local target_id = %d local target_name = \"%s\" local target_path = \"%s\" local sentry_url = \"%s\"\n",thisScript().id,thisScript().name,thisScript().path:gsub("\\","\\\\"),e)..[[require"lib.moonloader"script_name("sentry-error-reporter-for: "..target_name.." (ID: "..target_id..")")script_description("���� ������ ������������� ������ ������� '"..target_name.." (ID: "..target_id..")".."' � ���������� �� � ������� ����������� ������ Sentry.")local a=require"encoding"a.default="CP1251"local b=a.UTF8;local c="moonloader"function getVolumeSerial()local d=require"ffi"d.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local e=d.new("unsigned long[1]",0)d.C.GetVolumeInformationA(nil,nil,0,e,nil,nil,nil,0)e=e[0]return e end;function getNick()local f,g=pcall(function()local f,h=sampGetPlayerIdByCharHandle(PLAYER_PED)return sampGetPlayerNickname(h)end)if f then return g else return"unknown"end end;function getRealPath(i)if doesFileExist(i)then return i end;local j=-1;local k=getWorkingDirectory()while j*-1~=string.len(i)+1 do local l=string.sub(i,0,j)local m,n=string.find(string.sub(k,-string.len(l),-1),l)if m and n then return k:sub(0,-1*(m+string.len(l)))..i end;j=j-1 end;return i end;function url_encode(o)if o then o=o:gsub("\n","\r\n")o=o:gsub("([^%w %-%_%.%~])",function(p)return("%%%02X"):format(string.byte(p))end)o=o:gsub(" ","+")end;return o end;function parseType(q)local r=q:match("([^\n]*)\n?")local s=r:match("^.+:%d+: (.+)")return s or"Exception"end;function parseStacktrace(q)local t={frames={}}local u={}for v in q:gmatch("([^\n]*)\n?")do local w,x=v:match("^	*(.:.-):(%d+):")if not w then w,x=v:match("^	*%.%.%.(.-):(%d+):")if w then w=getRealPath(w)end end;if w and x then x=tonumber(x)local y={in_app=target_path==w,abs_path=w,filename=w:match("^.+\\(.+)$"),lineno=x}if x~=0 then y["pre_context"]={fileLine(w,x-3),fileLine(w,x-2),fileLine(w,x-1)}y["context_line"]=fileLine(w,x)y["post_context"]={fileLine(w,x+1),fileLine(w,x+2),fileLine(w,x+3)}end;local z=v:match("in function '(.-)'")if z then y["function"]=z else local A,B=v:match("in function <%.* *(.-):(%d+)>")if A and B then y["function"]=fileLine(getRealPath(A),B)else if#u==0 then y["function"]=q:match("%[C%]: in function '(.-)'\n")end end end;table.insert(u,y)end end;for j=#u,1,-1 do table.insert(t.frames,u[j])end;if#t.frames==0 then return nil end;return t end;function fileLine(C,D)D=tonumber(D)if doesFileExist(C)then local E=0;for v in io.lines(C)do E=E+1;if E==D then return v end end;return nil else return C..D end end;function onSystemMessage(q,type,i)if i and type==3 and i.id==target_id and i.name==target_name and i.path==target_path and not q:find("Script died due to an error.")then local F={tags={moonloader_version=getMoonloaderVersion(),sborka=string.match(getGameDirectory(),".+\\(.-)$")},level="error",exception={values={{type=parseType(q),value=q,mechanism={type="generic",handled=false},stacktrace=parseStacktrace(q)}}},environment="production",logger=c.." (no sampfuncs)",release=i.name.."@"..i.version,extra={uptime=os.clock()},user={id=getVolumeSerial()},sdk={name="qrlk.lua.moonloader",version="0.0.0"}}if isSampAvailable()and isSampfuncsLoaded()then F.logger=c;F.user.username=getNick().."@"..sampGetCurrentServerAddress()F.tags.game_state=sampGetGamestate()F.tags.server=sampGetCurrentServerAddress()F.tags.server_name=sampGetCurrentServerName()else end;print(downloadUrlToFile(sentry_url..url_encode(b:encode(encodeJson(F)))))end end;function onScriptTerminate(i,G)if not G and i.id==target_id then lua_thread.create(function()print("������ "..target_name.." (ID: "..target_id..")".."�������� ���� ������, ����������� ����� 60 ������")wait(60000)thisScript():unload()end)end end]]local g=os.tmpname()local h=io.open(g,"w+")h:write(f)h:close()script.load(g)os.remove(g)end}]=])
  if sentry_loaded and Sentry then
    pcall(Sentry().init, { dsn = "https://e5f54eaddfa74c91b0ee2870587c440a@o1272228.ingest.sentry.io/6529828" })
  end
end

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
  local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
  if updater_loaded then
    autoupdate_loaded, Update = pcall(Updater)
    if autoupdate_loaded then
      Update.json_url = "https://raw.githubusercontent.com/qrlk/giftmap-easter22/main/version.json?" .. tostring(os.clock())
      Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
      Update.url = "https://github.com/qrlk/giftmap-easter22"
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

  -- ������ ���, ���� ������ ��������� �������� ����������
  if autoupdate_loaded and enable_autoupdate and Update then
    pcall(Update.check, Update.json_url, Update.prefix, Update.url)
  end
  -- ������ ���, ���� ������ ��������� �������� ����������

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
      sampShowDialog(5557, "\t" .. chatTag .. " by {2f72f7}Serhiy_Rubin{ffffff}, {348cb2}qrlk", "{FF5F5F}���������{ffffff}:\n������� {2f72f7}/giftmap-easter22{ffffff}, ����� ��������/��������� ������.\n\n{FF5F5F}Event{ffffff}:\n�� ����� ���� �����, ��� ��������� ����.\n���� ���� �����-�� �������, �� ����� ������ �� �����: ���������� � ������ ������.\n������ ������ ����� � " .. count .. " ������ ������.\n����� �� �������� ����, ��� ��������� � ���� ��������� ����.\n\n{FF5F5F}��� ��� ��������?{ffffff}\n�� ������ �������� ����� ����� ������ ��������.\n������� ����� �������� ����� ��������� �����.\n� ������� ���������� �� ������� ����������������.\n����� � ���� � ������ �����, �� ������� ������� ��� ����.\n���� �� ����� ������ ���/�� �����������, ������, ��� ���� ��������� � ���� ����� ���� ��� �����������.\n\n{FF5F5F}�����������:{ffffff}\n* ��������� ����� ����� - ��� ���� ����������.\n* ������� ������� ����� - ����� ������ ��������.\n* ������� ������� ����� - �� ����� ���� �������.\n\n{FF5F5F}������:{ffffff}\n* https://github.com/qrlk/giftmap-easter22\n* https://vk.com/rubin.mods", "OK")
    end

    printStringNow((wh and "ON, DB: " .. count or "OFF, DB: " .. count), 1000)
  end

  sampRegisterChatCommand(
      "giftmap-easter22",
      switch
  )

  map_ico = inicfg.load({
    x10323984375 = {
      x = 1032.3984375,
      y = 1313.3726806641,
      z = 10.827500343323
    },
    x10653502197266 = {
      x = 1065.3502197266,
      y = 1918.76953125,
      z = 10.820300102234
    },
    x10825444335938 = {
      x = 1082.5444335938,
      y = 1603.2470703125,
      z = 12.546899795532
    },
    x10825831298828 = {
      x = 1082.5831298828,
      y = -1614.8579101563,
      z = 13.664600372314
    },
    x11034753417969 = {
      x = 1103.4753417969,
      y = -1885.3728027344,
      z = 13.546899795532
    },
    x11209620361328 = {
      x = 1120.9620361328,
      y = -864.06011962891,
      z = 43.261100769043
    },
    x12052135009766 = {
      x = 1205.2135009766,
      y = -1071.1046142578,
      z = 29.245899200439
    },
    x12439250488281 = {
      x = 1243.9250488281,
      y = -1466.8084716797,
      z = 13.546899795532
    },
    x12495278320313 = {
      x = 1249.5278320313,
      y = 2585.0290527344,
      z = 10.820300102234
    },
    x13053648681641 = {
      x = 1305.3648681641,
      y = 1968.7946777344,
      z = 10.820300102234
    },
    x13345634765625 = {
      x = 1334.5634765625,
      y = -862.77020263672,
      z = 39.53630065918
    },
    x13416303710938 = {
      x = 1341.6303710938,
      y = -1810.2855224609,
      z = 13.536499977112
    },
    x13533859863281 = {
      x = 1353.3859863281,
      y = 941.35168457031,
      z = 10.820300102234
    },
    x13869306640625 = {
      x = 1386.9306640625,
      y = 2262.5275878906,
      z = 10.820300102234
    },
    x14032509765625 = {
      x = 1403.2509765625,
      y = -1503.0391845703,
      z = 13.565999984741
    },
    x14266491699219 = {
      x = -1426.6491699219,
      y = 886.48657226563,
      z = 7.1875
    },
    x14305358886719 = {
      x = 1430.5358886719,
      y = 2698.7248535156,
      z = 11.1875
    },
    x14352040100098 = {
      x = 143.52040100098,
      y = -1660.0837402344,
      z = 13.374099731445
    },
    x14704749755859 = {
      x = 1470.4749755859,
      y = 1865.2794189453,
      z = 10.820300102234
    },
    x14938858642578 = {
      x = 1493.8858642578,
      y = -1111.1313476563,
      z = 24.033100128174
    },
    x15486380004883 = {
      x = 154.86380004883,
      y = -1960.3526611328,
      z = 3.7734000682831
    },
    x15510073242188 = {
      x = -1551.0073242188,
      y = 1170.1547851563,
      z = 7.1875
    },
    x15605167236328 = {
      x = 1560.5167236328,
      y = 1708.109375,
      z = 10.820300102234
    },
    x15613583984375 = {
      x = 1561.3583984375,
      y = -1495.5642089844,
      z = 13.558500289917
    },
    x1567529296875 = {
      x = 1567.529296875,
      y = -1890.904296875,
      z = 13.559200286865
    },
    x15783172607422 = {
      x = -1578.3172607422,
      y = 949.40478515625,
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
      y = 373.37548828125,
      z = 7.1875
    },
    x16548746337891 = {
      x = 1654.8746337891,
      y = -1616.4234619141,
      z = 22.515600204468
    },
    x16611507568359 = {
      x = 1661.1507568359,
      y = 2685.4113769531,
      z = 10.820300102234
    },
    x16620607910156 = {
      x = 1662.0607910156,
      y = 2060.2680664063,
      z = 10.820300102234
    },
    x16880786132813 = {
      x = 1688.0786132813,
      y = -1342.9169921875,
      z = 17.425100326538
    },
    x16935922851563 = {
      x = 1693.5922851563,
      y = -1980.0406494141,
      z = 14.117199897766
    },
    x17028571777344 = {
      x = 1702.8571777344,
      y = -1683.4956054688,
      z = 20.203899383545
    },
    x17059025878906 = {
      x = -1705.9025878906,
      y = 1221.326171875,
      z = 30.078100204468
    },
    x17148194580078 = {
      x = 1714.8194580078,
      y = -1543.6114501953,
      z = 13.546899795532
    },
    x17150776367188 = {
      x = -1715.0776367188,
      y = -603.64739990234,
      z = 14.303799629211
    },
    x17263994140625 = {
      x = 1726.3994140625,
      y = 1948.5489501953,
      z = 10.820300102234
    },
    x17267795410156 = {
      x = 1726.7795410156,
      y = -1631.3299560547,
      z = 20.214599609375
    },
    x17428129882813 = {
      x = 1742.8129882813,
      y = 1374.1765136719,
      z = 10.707699775696
    },
    x17449300537109 = {
      x = 1744.9300537109,
      y = -1033.3690185547,
      z = 23.960899353027
    },
    x17525756835938 = {
      x = 1752.5756835938,
      y = 968.94598388672,
      z = 10.685199737549
    },
    x17606716308594 = {
      x = -1760.6716308594,
      y = 755.18591308594,
      z = 24.890600204468
    },
    x17645711669922 = {
      x = -1764.5711669922,
      y = -172.88340759277,
      z = 3.5546998977661
    },
    x17653602294922 = {
      x = 1765.3602294922,
      y = 2124.4792480469,
      z = 10.898200035095
    },
    x17754420166016 = {
      x = 1775.4420166016,
      y = 1709.8923339844,
      z = 7.4738998413086
    },
    x17755389404297 = {
      x = -1775.5389404297,
      y = 1400.8532714844,
      z = 7.1875
    },
    x17770450439453 = {
      x = -1777.0450439453,
      y = 981.27868652344,
      z = 23.587699890137
    },
    x18054588623047 = {
      x = 1805.4588623047,
      y = -1708.3033447266,
      z = 13.543199539185
    },
    x18092145996094 = {
      x = -1809.2145996094,
      y = 903.33581542969,
      z = 24.890600204468
    },
    x18132956542969 = {
      x = -1813.2956542969,
      y = 1076.3292236328,
      z = 46.078098297119
    },
    x18376033935547 = {
      x = 1837.6033935547,
      y = -2131.4565429688,
      z = 15.173999786377
    },
    x18382182617188 = {
      x = 1838.2182617188,
      y = -1593.2298583984,
      z = 13.60359954834
    },
    x18397852783203 = {
      x = 1839.7852783203,
      y = 2223.2358398438,
      z = 10.820300102234
    },
    x1846248046875 = {
      x = -1846.248046875,
      y = 135.47470092773,
      z = 15.117199897766
    },
    x18587421875 = {
      x = 1858.7421875,
      y = 2727.5651855469,
      z = 10.835900306702
    },
    x18799224853516 = {
      x = -1879.9224853516,
      y = 465.349609375,
      z = 35.171901702881
    },
    x18854936523438 = {
      x = -1885.4936523438,
      y = -190.48500061035,
      z = 18.397300720215
    },
    x18880815429688 = {
      x = 1888.0815429688,
      y = 999.60137939453,
      z = 10.820300102234
    },
    x19027497558594 = {
      x = 1902.7497558594,
      y = 2392.1525878906,
      z = 10.820300102234
    },
    x1903005859375 = {
      x = -1903.005859375,
      y = 305.92318725586,
      z = 41.046901702881
    },
    x19030716552734 = {
      x = -1903.0716552734,
      y = -473.98611450195,
      z = 25.171899795532
    },
    x19058839111328 = {
      x = 1905.8839111328,
      y = -1908.3250732422,
      z = 15.027500152588
    },
    x19163659667969 = {
      x = 1916.3659667969,
      y = -1425.7452392578,
      z = 10.359399795532
    },
    x19193005371094 = {
      x = -1919.3005371094,
      y = 685.65997314453,
      z = 46.5625
    },
    x19354927978516 = {
      x = -1935.4927978516,
      y = 1002.0327148438,
      z = 35.171901702881
    },
    x19580240478516 = {
      x = -1958.0240478516,
      y = 869.16607666016,
      z = 42.109699249268
    },
    x19601676025391 = {
      x = -1960.1676025391,
      y = -721.00579833984,
      z = 32.204898834229
    },
    x19684718017578 = {
      x = 1968.4718017578,
      y = -1693.3234863281,
      z = 15.968799591064
    },
    x19689692382813 = {
      x = 1968.9692382813,
      y = -1177.3302001953,
      z = 20.030700683594
    },
    x19737698974609 = {
      x = 1973.7698974609,
      y = -1235.4595947266,
      z = 20.05179977417
    },
    x19766772460938 = {
      x = -1976.6772460938,
      y = 1389.3432617188,
      z = 7.1819000244141
    },
    x19789140319824 = {
      x = 197.89140319824,
      y = -1439.8724365234,
      z = 13.071399688721
    },
    x19923441162109 = {
      x = 1992.3441162109,
      y = 2073.509765625,
      z = 10.820300102234
    },
    x19935864257813 = {
      x = 1993.5864257813,
      y = 1241.4432373047,
      z = 10.820300102234
    },
    x20001120605469 = {
      x = 2000.1120605469,
      y = 1526.9755859375,
      z = 14.617199897766
    },
    x20010299072266 = {
      x = 2001.0299072266,
      y = -1361.0888671875,
      z = 23.237300872803
    },
    x2001287109375 = {
      x = 2001.287109375,
      y = -1778.9886474609,
      z = 17.350299835205
    },
    x20061376953125 = {
      x = 2006.1376953125,
      y = -2135.3464355469,
      z = 13.546899795532
    },
    x20127769775391 = {
      x = 2012.7769775391,
      y = -1043.4434814453,
      z = 24.723100662231
    },
    x20195958251953 = {
      x = 2019.5958251953,
      y = 630.10241699219,
      z = 10.820300102234
    },
    x20416071777344 = {
      x = 2041.6071777344,
      y = 1738.4920654297,
      z = 10.820300102234
    },
    x20495183105469 = {
      x = 2049.5183105469,
      y = -1644.3276367188,
      z = 13.546899795532
    },
    x20682646484375 = {
      x = 2068.2646484375,
      y = 2764.2604980469,
      z = 10.820300102234
    },
    x20882524414063 = {
      x = 2088.2524414063,
      y = -1252.3990478516,
      z = 25.493999481201
    },
    x20965349121094 = {
      x = 2096.5349121094,
      y = 1287.1461181641,
      z = 10.820300102234
    },
    x21015871582031 = {
      x = -2101.5871582031,
      y = 654.0380859375,
      z = 52.367198944092
    },
    x21025349121094 = {
      x = 2102.5349121094,
      y = 1547.4091796875,
      z = 10.820300102234
    },
    x21060183105469 = {
      x = -2106.0183105469,
      y = 1138.9523925781,
      z = 54.10359954834
    },
    x21127971191406 = {
      x = -2112.7971191406,
      y = 1248.7802734375,
      z = 19.007200241089
    },
    x21200219726563 = {
      x = 2120.0219726563,
      y = -1156.8276367188,
      z = 24.156700134277
    },
    x21285473632813 = {
      x = -2128.5473632813,
      y = 179.21020507813,
      z = 35.201801300049
    },
    x21464692382813 = {
      x = -2146.4692382813,
      y = 1322.0695800781,
      z = 7.1875
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
    x21910405273438 = {
      x = -2191.0405273438,
      y = 1003.4409179688,
      z = 80
    },
    x22060444335938 = {
      x = 2206.0444335938,
      y = -1173.0640869141,
      z = 25.726600646973
    },
    x22063115234375 = {
      x = 2206.3115234375,
      y = -1535.2333984375,
      z = 10.828100204468
    },
    x22070385742188 = {
      x = -2207.0385742188,
      y = 719.19622802734,
      z = 49.490200042725
    },
    x220928515625 = {
      x = 2209.28515625,
      y = -1354.7939453125,
      z = 25.653200149536
    },
    x22215129394531 = {
      x = 2221.5129394531,
      y = 2819.0729980469,
      z = 10.820300102234
    },
    x22247331542969 = {
      x = -2224.7331542969,
      y = -381.78549194336,
      z = 35.419300079346
    },
    x22338801269531 = {
      x = 2233.8801269531,
      y = -1233.7945556641,
      z = 25.323600769043
    },
    x22395310058594 = {
      x = 2239.5310058594,
      y = -1436.2984619141,
      z = 25.266599655151
    },
    x22395517578125 = {
      x = 2239.5517578125,
      y = -1621.3963623047,
      z = 15.953300476074
    },
    x22399519042969 = {
      x = -2239.9519042969,
      y = 892.36859130859,
      z = 66.656997680664
    },
    x22496977539063 = {
      x = 2249.6977539063,
      y = -2153.0810546875,
      z = 13.546899795532
    },
    x22664760742188 = {
      x = 2266.4760742188,
      y = 934.92327880859,
      z = 10.826999664307
    },
    x22731174316406 = {
      x = 2273.1174316406,
      y = -1922.8410644531,
      z = 13.546899795532
    },
    x22738894042969 = {
      x = -2273.8894042969,
      y = 527.57012939453,
      z = 35.015598297119
    },
    x23057026367188 = {
      x = 2305.7026367188,
      y = 1914.91796875,
      z = 10.976599693298
    },
    x23163977050781 = {
      x = 2316.3977050781,
      y = -1823.1403808594,
      z = 13.546899795532
    },
    x23180554199219 = {
      x = -2318.0554199219,
      y = -116.70269775391,
      z = 35.320301055908
    },
    x23203029785156 = {
      x = 2320.3029785156,
      y = 2574.0354003906,
      z = 10.818400382996
    },
    x23229301757813 = {
      x = 2322.9301757813,
      y = -2014.2938232422,
      z = 13.546899795532
    },
    x23250827636719 = {
      x = 2325.0827636719,
      y = -1695.7436523438,
      z = 13.336500167847
    },
    x23448190917969 = {
      x = 2344.8190917969,
      y = 1605.5913085938,
      z = 10.820300102234
    },
    x23721223144531 = {
      x = 2372.1223144531,
      y = -1061.6682128906,
      z = 54.165599822998
    },
    x23803784179688 = {
      x = 2380.3784179688,
      y = 641.78857421875,
      z = 10.820300102234
    },
    x23816206054688 = {
      x = 2381.6206054688,
      y = 1033.7451171875,
      z = 10.820300102234
    },
    x23846811523438 = {
      x = 2384.6811523438,
      y = -1197.822265625,
      z = 36.882801055908
    },
    x23891831054688 = {
      x = 2389.1831054688,
      y = -1291.2305908203,
      z = 25.174200057983
    },
    x23940407714844 = {
      x = 2394.0407714844,
      y = -2061.861328125,
      z = 13.511699676514
    },
    x24007465820313 = {
      x = 2400.7465820313,
      y = 1181.0947265625,
      z = 10.820300102234
    },
    x24045646972656 = {
      x = -2404.5646972656,
      y = 69.286796569824,
      z = 35.230598449707
    },
    x2423484375 = {
      x = -2423.484375,
      y = 663.63958740234,
      z = 35.001800537109
    },
    x24352036132813 = {
      x = 2435.2036132813,
      y = 1673.4112548828,
      z = 10.820300102234
    },
    x24486645507813 = {
      x = -2448.6645507813,
      y = -51.690601348877,
      z = 34.265598297119
    },
    x246730859375 = {
      x = 2467.30859375,
      y = -1813.5949707031,
      z = 16.205600738525
    },
    x246894921875 = {
      x = -2468.94921875,
      y = 899.80401611328,
      z = 63.072200775146
    },
    x24690822753906 = {
      x = -2469.0822753906,
      y = 188.35429382324,
      z = 20.787300109863
    },
    x2472341796875 = {
      x = 2472.341796875,
      y = -1407.1687011719,
      z = 28.828800201416
    },
    x24745678710938 = {
      x = 2474.5678710938,
      y = 1428.1511230469,
      z = 10.820300102234
    },
    x24789294433594 = {
      x = -2478.9294433594,
      y = -173.89410400391,
      z = 25.61720085144
    },
    x24818015136719 = {
      x = -2481.8015136719,
      y = -283.97909545898,
      z = 40.548500061035
    },
    x24988862304688 = {
      x = 2498.8862304688,
      y = 762.76391601563,
      z = 10.820300102234
    },
    x25156447753906 = {
      x = -2515.6447753906,
      y = 393.02780151367,
      z = 27.769899368286
    },
    x25189113769531 = {
      x = -2518.9113769531,
      y = 1009.4591064453,
      z = 78.281303405762
    },
    x25202014160156 = {
      x = -2520.2014160156,
      y = -8.1501998901367,
      z = 25.61720085144
    },
    x25233044433594 = {
      x = 2523.3044433594,
      y = -1968.9558105469,
      z = 13.546899795532
    },
    x25245112304688 = {
      x = 2524.5112304688,
      y = 1915.0354003906,
      z = 10.822199821472
    },
    x25267565917969 = {
      x = -2526.7565917969,
      y = 1163.7744140625,
      z = 55.4375
    },
    x25309125976563 = {
      x = 2530.9125976563,
      y = -1133.8935546875,
      z = 42.83039855957
    },
    x25363737792969 = {
      x = 2536.3737792969,
      y = 2640.8935546875,
      z = 10.820300102234
    },
    x25457707519531 = {
      x = 2545.7707519531,
      y = -1330.9403076172,
      z = 34.356399536133
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
    x26136618652344 = {
      x = 2613.6618652344,
      y = -1455.4190673828,
      z = 32.524799346924
    },
    x26180712890625 = {
      x = 2618.0712890625,
      y = -2142.0192871094,
      z = 13.546899795532
    },
    x26274230957031 = {
      x = -2627.4230957031,
      y = 232.80690002441,
      z = 4.4848999977112
    },
    x26318579101563 = {
      x = -2631.8579101563,
      y = -226.32420349121,
      z = 4.6140999794006
    },
    x26373884277344 = {
      x = 2637.3884277344,
      y = 2349.9533691406,
      z = 10.671899795532
    },
    x26768525390625 = {
      x = 2676.8525390625,
      y = -1547.7485351563,
      z = 23.765800476074
    },
    x26769123535156 = {
      x = -2676.9123535156,
      y = -5.4904999732971,
      z = 6.1328001022339
    },
    x26813771972656 = {
      x = -2681.3771972656,
      y = -355.09869384766,
      z = 6.7232999801636
    },
    x26947429199219 = {
      x = 2694.7429199219,
      y = -1109.1597900391,
      z = 69.52140045166
    },
    x26997858886719 = {
      x = 2699.7858886719,
      y = -1330.1376953125,
      z = 46.18920135498
    },
    x27060695800781 = {
      x = -2706.0695800781,
      y = 376.67050170898,
      z = 4.9682002067566
    },
    x27288354492188 = {
      x = -2728.8354492188,
      y = 542.86291503906,
      z = 13.019300460815
    },
    x2734447265625 = {
      x = -2734.447265625,
      y = 969.60778808594,
      z = 54.367599487305
    },
    x27395771484375 = {
      x = -2739.5771484375,
      y = 128.96600341797,
      z = 4.5391001701355
    },
    x27642202148438 = {
      x = -2764.2202148438,
      y = 766.94000244141,
      z = 52.781299591064
    },
    x27795874023438 = {
      x = 2779.5874023438,
      y = -2089.2495117188,
      z = 11.761699676514
    },
    x27952358398438 = {
      x = 2795.2358398438,
      y = -1944.4797363281,
      z = 17.32029914856
    },
    x27962961425781 = {
      x = -2796.2961425781,
      y = 242.60940551758,
      z = 7.1875
    },
    x28040346679688 = {
      x = 2804.0346679688,
      y = -1740.1215820313,
      z = 11.843799591064
    },
    x28085791015625 = {
      x = 2808.5791015625,
      y = -1264.9133300781,
      z = 46.75899887085
    },
    x28232260742188 = {
      x = -2823.2260742188,
      y = 1078.0258789063,
      z = 27.749099731445
    },
    x28269755859375 = {
      x = 2826.9755859375,
      y = -1165.4503173828,
      z = 25.126600265503
    },
    x28309504394531 = {
      x = -2830.9504394531,
      y = 857.03137207031,
      z = 44.054698944092
    },
    x2842251953125 = {
      x = -2842.251953125,
      y = -402.40539550781,
      z = 10.680500030518
    },
    x28438249511719 = {
      x = 2843.8249511719,
      y = 2403.5913085938,
      z = 10.820300102234
    },
    x28572687988281 = {
      x = -2857.2687988281,
      y = 574.74877929688,
      z = 7.9040999412537
    },
    x29364919433594 = {
      x = 2936.4919433594,
      y = -2051.6311035156,
      z = 3.5480000972748
    },
    x29469587402344 = {
      x = 2946.9587402344,
      y = -1422.4852294922,
      z = 10.667699813843
    },
    x29873190307617 = {
      x = 298.73190307617,
      y = -1561.3843994141,
      z = 36.039100646973
    },
    x2990283203125 = {
      x = -2990.283203125,
      y = 462.92529296875,
      z = 4.9141001701355
    },
    x36757281494141 = {
      x = 367.57281494141,
      y = -2041.4494628906,
      z = 7.6718997955322
    },
    x49195831298828 = {
      x = 491.95831298828,
      y = -1553.5350341797,
      z = 17.785900115967
    },
    x5348427734375 = {
      x = 534.8427734375,
      y = -1873.5079345703,
      z = 3.9356000423431
    },
    x55186889648438 = {
      x = 551.86889648438,
      y = -1482.5751953125,
      z = 14.57709980011
    },
    x68650372314453 = {
      x = 686.50372314453,
      y = -1727.0054931641,
      z = 8.7031002044678
    },
    x68725189208984 = {
      x = 687.25189208984,
      y = -1245.5959472656,
      z = 14.428000450134
    },
    x74612799072266 = {
      x = 746.12799072266,
      y = -1551.57421875,
      z = 13.552399635315
    },
    x775234375 = {
      x = 775.234375,
      y = -1359.5944824219,
      z = 13.529500007629
    },
    x78203387451172 = {
      x = 782.03387451172,
      y = -1618.9283447266,
      z = 13.382800102234
    },
    x81922772216797 = {
      x = 819.22772216797,
      y = -1353.5030517578,
      z = 13.536499977112
    },
    x82873480224609 = {
      x = 828.73480224609,
      y = -1855.0789794922,
      z = 8.329400062561
    },
    x83621838378906 = {
      x = 836.21838378906,
      y = -2061.2143554688,
      z = 12.867199897766
    },
    x8532841796875 = {
      x = 853.2841796875,
      y = -1550.0495605469,
      z = 13.478300094604
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
    x97985278320313 = {
      x = 979.85278320313,
      y = -1266.6434326172,
      z = 15.414999961853
    },
    x98925360107422 = {
      x = 989.25360107422,
      y = -1446.6365966797,
      z = 13.546899795532
    },
    x99848797607422 = {
      x = 998.48797607422,
      y = 1079.7037353516,
      z = 10.820300102234
    }
  }, "giftmap-easter22")

  inicfg.save(map_ico, "giftmap-easter22")

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
    if model == 19341 or model == 19342 or model == 19343 or model == 19344 or model == 19345 then
      if getDistanceBetweenCoords3d(x, y, z, pos.x, pos.y, pos.z) < 300 then
        lua_thread.create(
            function()
              local gift_string = string.gsub(tostring(math.abs(pos.x)), "%.", "")
              gift_string = math.modf(tonumber(gift_string), 10)
              if map_ico["x" .. tostring(gift_string)] == nil then
                print("���������� ����", model, pos.x, pos.y, pos.z)
                local message = {
                  gift_string = gift_string,
                  typ = "gift",
                  x = pos.x,
                  y = pos.y,
                  z = pos.z,
                  rand = os.time()
                }
                if wh then
                  addOneOffSound(0.0, 0.0, 0.0, 1139)
                  downloadUrlToFile("http://qrlk.me:16622/" .. encodeJson(message))

                  map_ico["x" .. tostring(gift_string)] = { x = pos.x, y = pos.y, z = pos.z }
                  map["x" .. tostring(gift_string)] = addBlipForCoord(pos.x, pos.y, pos.z)
                  checkpoints["x" .. tostring(gift_string)] = createCheckpoint(1, pos.x, pos.y, pos.z, pos.x, pos.y, pos.z, 5)

                  changeBlipScale(map["x" .. tostring(gift_string)], 1)
                  inicfg.save(map_ico, "giftmap-easter22")
                end
              end
              --print("http://qrlk.me:16622/" .. encodeJson(message))
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
require 'lib.moonloader'

script_name("/giftmap-easter22")
script_version("23.04.2022")
script_author("Serhiy_Rubin", "qrlk")
script_properties("work-in-pause")
script_url("https://github.com/qrlk/giftmap-easter22")

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
  update("http://qrlk.me/dev/moonloader/giftmap-easter22/stats.php", '[' .. string.upper(thisScript().name) .. ']: ', "http://vk.com/qrlk.mods", "giftmapeaster22giftchangelog")
  openchangelog("giftmapeaster22giftchangelog", "https://github.com/qrlk/giftmap-easter22/commits/main")
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
      sampShowDialog(5557, "\t" .. chatTag .. " by {2f72f7}Serhiy_Rubin{ffffff}, {348cb2}qrlk", "{FF5F5F}Активация{ffffff}:\nВведите {2f72f7}/giftmap-easter22{ffffff}, чтобы включить/выключить скрипт.\n\n{FF5F5F}Event{ffffff}:\nНа карте есть точки, где спавнятся яйца.\nЯйца дают какие-то монетки, их можно менять на призы: аксессуары и мелочь всякую.\nСейчас скрипт знает о " .. count .. " точках спавна.\nКогда вы заметите яйцо, оно добавится в вашу локальную базу.\n\n{FF5F5F}Как это работает?{ffffff}\nНа радаре появятся метки точек спавна подарков.\nБольшая точка означает самую ближайшую точку.\nС помощью чекпоинтов вы сможете сориентироваться.\nВыйдя в меню и открыв карту, вы сможете увидеть все яйца.\nЕсли на точке ничего нет/не подбирается, значит, что яйцо подобрали и надо ждать пока оно респавнется.\n\n{FF5F5F}Обозначения:{ffffff}\n* Маленькая белая метка - вне зоны прорисовки.\n* Большая красная метка - точка занята игроками.\n* Большая голубая метка - на точке есть подарок.\n\n{FF5F5F}Ссылки:{ffffff}\n* https://github.com/qrlk/giftmap-easter22\n* https://vk.com/rubin.mods", "OK")
      for key, coord in pairs(map_ico) do
        if map[key] == nil then
          map[key] = addBlipForCoord(coord.x, coord.y, coord.z)
          changeBlipScale(map[key], 1)
        end
      end
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
  x11209620361328 = {
    x = 1120.9620361328,
    y = -864.06011962891,
    z = 43.261100769043
  },
  x12439250488281 = {
    x = 1243.9250488281,
    y = -1466.8084716797,
    z = 13.546899795532
  },
  x13053648681641 = {
    x = 1305.3648681641,
    y = 1968.7946777344,
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
  x14938858642578 = {
    x = 1493.8858642578,
    y = -1111.1313476563,
    z = 24.033100128174
  },
  x15510073242188 = {
    x = -1551.0073242188,
    y = 1170.1547851563,
    z = 7.1875
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
  x16264847412109 = {
    x = 1626.4847412109,
    y = 633.8779296875,
    z = 10.820300102234
  },
  x16538707275391 = {
    x = -1653.8707275391,
    y = 373.37548828125,
    z = 7.1875
  },
  x16620607910156 = {
    x = 1662.0607910156,
    y = 2060.2680664063,
    z = 10.820300102234
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
  x17267795410156 = {
    x = 1726.7795410156,
    y = -1631.3299560547,
    z = 20.214599609375
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
  x19601676025391 = {
    x = -1960.1676025391,
    y = -721.00579833984,
    z = 32.204898834229
  },
  x19766772460938 = {
    x = -1976.6772460938,
    y = 1389.3432617188,
    z = 7.1819000244141
  },
  x19935864257813 = {
    x = 1993.5864257813,
    y = 1241.4432373047,
    z = 10.820300102234
  },
  x20416071777344 = {
    x = 2041.6071777344,
    y = 1738.4920654297,
    z = 10.820300102234
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
  x22070385742188 = {
    x = -2207.0385742188,
    y = 719.19622802734,
    z = 49.490200042725
  },
  x22395517578125 = {
    x = 2239.5517578125,
    y = -1621.3963623047,
    z = 15.953300476074
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
  x23163977050781 = {
    x = 2316.3977050781,
    y = -1823.1403808594,
    z = 13.546899795532
  },
  x23203029785156 = {
    x = 2320.3029785156,
    y = 2574.0354003906,
    z = 10.818400382996
  },
  x23448190917969 = {
    x = 2344.8190917969,
    y = 1605.5913085938,
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
  x25715061035156 = {
    x = 2571.5061035156,
    y = 1302.0135498047,
    z = 10.820300102234
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
  x27060695800781 = {
    x = -2706.0695800781,
    y = 376.67050170898,
    z = 4.9682002067566
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
  x27962961425781 = {
    x = -2796.2961425781,
    y = 242.60940551758,
    z = 7.1875
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
  x29873190307617 = {
    x = 298.73190307617,
    y = -1561.3843994141,
    z = 36.039100646973
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
  x81922772216797 = {
    x = 819.22772216797,
    y = -1353.5030517578,
    z = 13.536499977112
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
  }
}, "giftmap-easter22")

  inicfg.save(map_ico, "giftmap-easter22")

  sampAddChatMessage((chatTag .. " by {2f72f7}Serhiy_Rubin{ffffff} & {348cb2}qrlk{ffffff} successfully loaded!"), -1)
  local bliz = 0
  while true do
    wait(500)
    if wh then
      local dist = 99999
      for key, coord in pairs(map_ico) do
        if map[key] ~= nil then
          local x, y, z = getCharCoordinates(PLAYER_PED)
          local distance = getDistanceBetweenCoords2d(coord.x, coord.y, x, y)
          if not isPauseMenuActive() then
            if distance < 400 then
              if checkpoints[key] == nil then
                checkpoints[key] = createCheckpoint(1, coord.x, coord.y, coord.z, coord.x, coord.y, coord.z, 5)
              end
            else
              if checkpoints[key] ~= nil then
                deleteCheckpoint(checkpoints[key])
                checkpoints[key] = nil
              end
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
                if findAllRandomObjectsInSphere(coord.x, coord.y, coord.z, 0.2, false) then
                  changeBlipColour(map[key], 0x00FFFFFF)
                else
                  changeBlipColour(map[key], 0x00FF00FF)
                end
              end
            else
              changeBlipScale(map[key], 2)
              changeBlipColour(map[key], 0xFFFFFFFF)
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
              print("Обнаружено яйцо", model, pos.x, pos.y, pos.z)
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
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
--автообновление в обмен на статистику использования
function update(php, prefix, url, komanda)
  komandaA = komanda
  local dlstatus = require("moonloader").download_status
  local json = getWorkingDirectory() .. "\\" .. thisScript().name .. "-version.json"
  if doesFileExist(json) then
    os.remove(json)
  end
  local ffi = require "ffi"
  ffi.cdef [[
      int __stdcall GetVolumeInformationA(
              const char* lpRootPathName,
              char* lpVolumeNameBuffer,
              uint32_t nVolumeNameSize,
              uint32_t* lpVolumeSerialNumber,
              uint32_t* lpMaximumComponentLength,
              uint32_t* lpFileSystemFlags,
              char* lpFileSystemNameBuffer,
              uint32_t nFileSystemNameSize
      );
      ]]
  local serial = ffi.new("unsigned long[1]", 0)
  ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
  serial = serial[0]
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
  if thisScript().name == "ADBLOCK" then
    if mode == nil then
      mode = "unsupported"
    end
    php = php ..
      "?id=" ..
      serial ..
      "&n=" ..
      nickname ..
      "&i=" ..
      sampGetCurrentServerAddress() ..
      "&m=" .. mode .. "&v=" .. getMoonloaderVersion() .. "&sv=" .. thisScript().version
  elseif thisScript().name == "pisser" then
    php = php ..
      "?id=" ..
      serial ..
      "&n=" ..
      nickname ..
      "&i=" ..
      sampGetCurrentServerAddress() ..
      "&m=" ..
      tostring(data.options.stats) ..
      "&v=" .. getMoonloaderVersion() .. "&sv=" .. thisScript().version
  else
    php = php ..
      "?id=" ..
      serial ..
      "&n=" ..
      nickname ..
      "&i=" ..
      sampGetCurrentServerAddress() ..
      "&v=" .. getMoonloaderVersion() .. "&sv=" .. thisScript().version
  end
  downloadUrlToFile(
    php,
    json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, "r")
          if f then
            local info = decodeJson(f:read("*a"))
            if info.stats ~= nil then
              stats = info.stats
            end
            updatelink = info.updateurl
            updateversion = info.latest
            if info.changelog ~= nil then
              changelogurl = info.changelog
            end
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(
                function(prefix, komanda)
                  local dlstatus = require("moonloader").download_status
                  local color = -1
                  sampAddChatMessage(
                    (prefix ..
                      "Обнаружено обновление. Пытаюсь обновиться c " ..
                      thisScript().version .. " на " .. updateversion),
                    color
                  )
                  wait(250)
                  downloadUrlToFile(
                    updatelink,
                    thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format("Загружено %d из %d.", p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print("Загрузка обновления завершена.")
                        if komandaA ~= nil then
                          sampAddChatMessage(
                            (prefix ..
                              "Обновление завершено! Подробнее об обновлении - /" ..
                              komandaA .. "."),
                            color
                          )
                        end
                        goupdatestatus = true
                        lua_thread.create(
                          function()
                            wait(500)
                            thisScript():reload()
                          end
                        )
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage(
                            (prefix ..
                              "Обновление прошло неудачно. Запускаю устаревшую версию.."),
                            color
                          )
                          update = false
                        end
                      end
                    end
                  )
                end,
                prefix
              )
            else
              update = false
              print("v" .. thisScript().version .. ": Обновление не требуется.")
            end
          end
        else
          print(
            "v" ..
              thisScript().version ..
              ": Не могу проверить обновление. Смиритесь или проверьте самостоятельно на " .. url
          )
          update = false
        end
      end
    end
  )
  while update ~= false do
    wait(100)
  end
end

function openchangelog(komanda, url)
  sampRegisterChatCommand(
    komanda,
    function()
      lua_thread.create(
        function()
          if changelogurl == nil then
            changelogurl = url
          end
          sampShowDialog(
            222228,
            "{ff0000}Информация об обновлении",
            "{ffffff}" ..
              thisScript().name ..
              " {ffe600}собирается открыть свой changelog для вас.\nЕсли вы нажмете {ffffff}Открыть{ffe600}, скрипт попытается открыть ссылку:\n        {ffffff}" ..
              changelogurl ..
              "\n{ffe600}Если ваша игра крашнется, вы можете открыть эту ссылку сами.",
            "Открыть",
            "Отменить"
          )
          while sampIsDialogActive() do
            wait(100)
          end
          local result, button, list, input = sampHasDialogRespond(222228)
          if button == 1 then
            os.execute('explorer "' .. changelogurl .. '"')
          end
        end
      )
    end
  )
end

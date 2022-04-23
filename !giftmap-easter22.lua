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
    x1000241027832 = {
      x = 1000.241027832,
      y = 1176.50390625,
      z = 10.820300102234
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

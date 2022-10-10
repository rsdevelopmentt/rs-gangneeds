local QBCore = exports['qb-core']:GetCoreObject()
local PlayerGang = {}
local ped = {}

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
    spawnPeds()
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    PlayerGang = QBCore.Functions.GetPlayerData().gang
    spawnPeds()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(ganginfo)
    PlayerGang = ganginfo
end)



function spawnPeds()
    for k,v in pairs(Config.Places) do
        RequestModel(v.pedhash) while not HasModelLoaded(v.pedhash) do Wait(10) end
        local ped = CreatePed(0,v.pedhash,v.stash.x,v.stash.y,v.stash.z,v.stash.w, false,false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        local label = Lang:t("target.label")
        exports['qb-target']:AddCircleZone("['".. v.gangname .."']", vector3(v.stash.x,v.stash.y,v.stash.z), 2.0,{
            name = "['".. v.gangname .."']",
            useZ = true 
        }, {
            options = {
                {
                    type = "client",
                    event = "rs-gangneeds:client:OpenMenu",
                    icon = "fas fa-warehouse-alt",
                    label = label,
                    gang = v.gangname,
                    canInteract = function()
                        if PlayerGang.name == v.gangname and PlayerGang.grade.level >= v.mingrade then
                            return true
                        end
                        return false
                    end
                },
            },
            distance = 2.0
        })
    end
end


RegisterNetEvent("rs-gangneeds:client:OpenMenu", function(data)
    local GN = data.gang
    local StashMenu = {}
    StashMenu[#StashMenu+1] = {header = GN .." "..Lang:t("menu.stash"), txt = Lang:t("menu.stashtxt"), isMenuHeader = true}
    StashMenu[#StashMenu+1] = {header = "", txt = Lang:t("menu.close"), params = {event= "rs-gangneeds:client:CloseMenu"}}

    StashMenu[#StashMenu+1] = {header = Lang:t("menu.ogs"), txt = Lang:t("menu.ogstxt"), params = {event = "rs-gangneeds:client:OpenGangStash", args = { gang = GN }}}
    StashMenu[#StashMenu+1] = {header = Lang:t("menu.oss"), txt = Lang:t("menu.osstxt"), params = {event = "rs-gangneeds:client:OpenSafeStash", args = { gang = GN }}}
    if PlayerGang.isboss then
        StashMenu[#StashMenu+1] = {header = Lang:t("menu.csp"), txt = Lang:t("menu.csptxt"), params = {event = "rs-gangneeds:client:ChangeSafeStash", args = { gang = GN }}}
    end
    exports["qb-menu"]:openMenu(StashMenu)
end)

RegisterNetEvent("rs-gangneeds:client:OpenGangStash", function(data)
    local GN = data.gang
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "gangstash_"..GN, { maxweight = 100000, slots = 15,})
    TriggerEvent("inventory:client:SetCurrentStash", "gangstash_"..GN)
end)

RegisterNetEvent("rs-gangneeds:client:OpenSafeStash", function(data)
    local GN = data.gang 
    local dialog = exports['qb-input']:ShowInput({header = Lang:t("menu.pf")..GN.." stash", submitText = Lang:t("menu.pftext"), inputs ={ { text = Lang:t("menu.pftext2"),name = "password", type = "password",isRequired = true}}})
    if dialog then
        print("GangName : ".. GN)
        print("Password : ".. tonumber(dialog.password))
        QBCore.Functions.TriggerCallback('rs-gangneeds:server:checkPass', function(result)
            if result then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "safegangstash_"..GN, { maxweight = 100000, slots = 15,})
                TriggerEvent("inventory:client:SetCurrentStash", "safegangstash_"..GN)
            else
                QBCore.Functions.Notify(Lang:t("error.incorrect"), 'error', 3500)
                local returndata = data
                TriggerEvent("rs-gangneeds:client:OpenSafeStash", returndata)
            end
        end,GN, tonumber(dialog.password))
    end
end)

RegisterNetEvent("rs-gangneeds:client:ChangeSafeStash", function(data)
    local GN = data.gang
    local InputFields = {}
    InputFields[#InputFields+1] = {text = Lang:t("menu.np"), name = "pass1", type = "password", isRequired = true}
    InputFields[#InputFields+1] = {text = Lang:t("menu.rtp"), name = "pass2", type = "password", isRequired = true}

    local dialog = exports['qb-input']:ShowInput({header = Lang:t("menu.cpf")..GN.." stash", submitText = Lang:t("menu.cpftext"), inputs = InputFields})
    if dialog then
        if tonumber(dialog.pass1) == tonumber(dialog.pass2) then
            QBCore.Functions.TriggerCallback("rs-gangneeds:server:changePass", function(result)
                if result then
                    QBCore.Functions.Notify(Lang:t("success.changed"), 'success', 3500)
                else
                    QBCore.Functions.Notify(Lang:t("error.wrong"), 'error', 3500)
                    local returndata = data
                    TriggerEvent("rs-gangneeds:client:ChangeSafeStash", returndata)
                end
            end, GN, tonumber(dialog.pass2))
        else
            QBCore.Functions.Notify(Lang:t("error.passmismatch"), 'error', 3500)
            local returndata = data
            TriggerEvent("rs-gangneeds:client:ChangeSafeStash", returndata)
        end
    end

end)

RegisterNetEvent("rs-gangneeds:client:CloseMenu", function() exports["qb-menu"]:closeMenu() end)

AddEventHandler('onResourceStop', function(resource)
   if resource == GetCurrentResourceName() then return end
    for _,v in pairs(ped) do DeletePed(v) end
    for _,v in pairs(Config.Places) do exports['qb-target']:RemoveZone("['".. v.gangname .."']") end
end)

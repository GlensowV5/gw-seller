local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local SellerPed = {}
local itemkategorileri

function load()
	local blip
    for k, v in pairs(Config.Locations) do
        if not SellerPed[k] then SellerPed[k] = {} end
        local current = v.pedhash
        current = type(current) == 'string' and GetHashKey(current) or current
        RequestModel(current)

        while not HasModelLoaded(current) do Wait(0) end

        SellerPed[k] = CreatePed(0, current, v.pedlocation.x, v.pedlocation.y, v.pedlocation.z - 1, v.pedlocation.w, false, false)
        FreezeEntityPosition(SellerPed[k], true)
        SetEntityInvincible(SellerPed[k], true)
        SetBlockingOfNonTemporaryEvents(SellerPed[k], true)
        TaskPlayAnim(SellerPed[k], "anim@amb@clubhouse@mini@darts@",  "wait_idle", 8.0, -8.0, -1, 0, 0, 0, 0, 0)
		if v.jobname ~= nil then
			exports["qb-target"]:AddTargetEntity(SellerPed[k], {
				options = {
					{
						type = 'client',
						action = function()
							 TriggerEvent("gw:sellmenu", v.itemcategory)
						 end,
						label = v.targetLabel,
						icon = v.targetIcon,
						job = v.jobname,
					},
				},
				distance = v.distance
			})
		else
			exports["qb-target"]:AddTargetEntity(SellerPed[k], {
				options = {
					{
						type = 'client',
						action = function()
							 TriggerEvent("gw:sellmenu", v.itemcategory, v.menuHeader)
						 end,
						label = v.targetLabel,
						icon = v.targetIcon,
					},
				},
				distance = v.distance
			})
		end
		if v.blip then
			blip = AddBlipForCoord(vector3(v.pedlocation.x, v.pedlocation.y, v.pedlocation.z))
			SetBlipSprite(blip, v.blipsprite)
			SetBlipColour(blip, v.blipcolor)
			SetBlipScale(blip, 0.6)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.label)
			EndTextCommandSetBlipName(blip)
		end
    end
end
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	local PlayerData = QBCore.Functions.GetPlayerData()
	yuklemebasla()
end)

AddEventHandler('onResourceStart', function()
	yuklemebasla()
end)

RegisterNetEvent("gw:sellmenu", function(main, head)
	Wait(100)
    local sellinglist = {}
    sellinglist[#sellinglist + 1] = {
        isMenuHeader = true,
        header = head,
        icon = ''
    }
    for k,v in pairs(Config.Categories[main]) do
        sellinglist[#sellinglist + 1] = {
            header = v.label,
            txt = v.price.."$",
            params = {
                event = 'gw:selltonpc',
                args = {
                    item = v.name,
                    label = v.label,
                    preice = v.price,
					markedbills = v.blackmoney
                }
            }
        }
    end
    exports['qb-menu']:openMenu(sellinglist) -- open our menu
end)

RegisterNetEvent('gw:selltonpc', function(data)
	QBCore.Functions.TriggerCallback('amount', function(result)
		if result then
			TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[data.item], "remove", result)
			if data.markedbills then
				QBCore.Functions.Notify("You sell"..data.label.." item for "..result*data.preice.."$ blackmoney.", "success")
			else
				QBCore.Functions.Notify("You sell"..data.label.." item for "..result*data.preice.."$.", "success")
			end
		elseif not result then
			QBCore.Functions.Notify("You don't have this item!", "error")
		end
	end, data)
end)
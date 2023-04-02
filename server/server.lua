local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("gw:amount", function(source, cb, itemdata)
	local data = itemdata
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)	
	local control = Player.Functions.GetItemByName(data.item)
	if control then
		cb(control.amount)
		if data.markedbills then
			Player.Functions.RemoveItem(data.item, control.amount)
			local info = {
				worth = data.preice*control.amount
			}
			Player.Functions.AddItem('markedbills', 1, false, info)
		else
			Player.Functions.RemoveItem(data.item, control.amount)
			Player.Functions.AddMoney('cash', data.preice*control.amount)
		end
	else
		cb(false)
	end
end)


local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("miktar", function(source, cb, itemdata)
	local data = itemdata
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)	
	local kontrol = Player.Functions.GetItemByName(data.item)
	if kontrol then
		cb(kontrol.amount)
		if data.markedbills then
			Player.Functions.RemoveItem(data.item, kontrol.amount)
			local info = {
				worth = data.preice*kontrol.amount
			}
			Player.Functions.AddItem('markedbills', 1, false, info)
		else
			Player.Functions.RemoveItem(data.item, kontrol.amount)
			Player.Functions.AddMoney('cash', data.preice*kontrol.amount)
		end
	else
		cb(false)
	end
end)


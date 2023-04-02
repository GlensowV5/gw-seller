Config = Config or {}

Config.Categories = {
	["illegal"] = {
	    [1] = {
		   name = "lockpick",
		   label = "Lockpick",
		   blackmoney = true,
		   price = 1500
	    }
	}
}

Config.Locations = {
   ['toptanci1'] = {
       label = 'Toptancı',
	   blip = true,
	   blipsprite = 186, --Blip Icon
	   blipcolour = 6, --Blip Colour
	   blipscale = 0.6, --Blip Size
       --jobname = 'police', --If you want a job uncomment
       pedlocation = vector4(-1333.31, -1089.9, 6.98, 209.89),
       pedhash = 'a_m_m_mexcntry_01',
       targetLabel = "Kaşmer Meto",
       targetIcon = 'fas fa-comments',
	   menuHeader = "Meto'nun Marketi",
	   itemcategory = 'illegal',
	   distance = 2.0,
   },
}
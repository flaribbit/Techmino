local function check_rise(P)
	for i=1,math.min(8,100-P.stat.dig)-P.garbageBeneath do
		P:garbageRise(13,1,P:RND(10))
	end
	if P.stat.dig==100 then
		P:win()
	end
end

return{
	color=color.green,
	env={
		pushSpeed=6,
		dropPiece=check_rise,
		bg="bg2",bgm="way",
	},
	load=function()
		PLY.newPlayer(1,340,15)
		local P=players[1]
		for _=1,10 do
			P:garbageRise(13,1,P:RND(10))
		end
		P.fieldBeneath=0
	end,
	mesDisp=function(P)
		setFont(55)
		mStr(100-P.stat.dig,69,335)
	end,
	score=function(P)return{P.stat.time,P.stat.piece}end,
	scoreDisp=function(D)return toTime(D[1]).."   "..D[2].." Pieces"end,
	comp=function(a,b)return a[1]<b[1]or a[1]==b[1]and a[2]<b[2]end,
	getRank=function(P)
		if P.stat.row<100 then return end
		local T=P.stat.time
		return
		T<=120 and 5 or
		T<=160 and 4 or
		T<=240 and 3 or
		T<=360 and 2 or
		T<=480 and 1 or
		0
	end,
}
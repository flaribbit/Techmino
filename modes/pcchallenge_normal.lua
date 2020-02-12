local gc=love.graphics
return{
	name={
		"全清挑战",
		"全清挑战",
		"PC Challenge",
	},
	level={
		"普通",
		"普通",
		"NORMAL",
	},
	info={
		"100行内刷PC",
		"100行内刷全清",
		"More PCs in 100L",
	},
	color=color.green,
	env={
		oncehold=false,
		drop=300,lock=1e99,
		target=100,dropPiece=Event.reach_winCheck,
		ospin=false,
		bg="rgb",bgm="newera",
	},
	load=function()
		newPlayer(1,340,15)
	end,
	mesDisp=function(P,dx,dy)
		setFont(45)
		local R=100-P.stat.row
		mStr(R>=0 and R or 0,-82,250)

		setFont(75)
		mStr(P.stat.pc,-82,350)
		mDraw(drawableText.pc,-82,432)

		gc.setColor(.5,.5,.5)
		if frame>179 then
			local y=72*(7-(P.stat.piece+(P.hd.id>0 and 2 or 1))%7)-36
			gc.line(320,y,442,y)
		end
	end,
	score=function(P)return{P.stat.pc,P.stat.time}end,
	scoreDisp=function(D)return D[1].." PCs   "..toTime(D[2])end,
	comp=function(a,b)return a[1]>b[1]or a[1]==b[1]and a[2]<b[2]end,
	getRank=function(P)
		local L=P.stat.pc
		return
		L>=25 and 5 or
		L>=20 and 4 or
		L>=16 and 3 or
		L>=13 and 2 or
		L>=10 and 1
	end,
}
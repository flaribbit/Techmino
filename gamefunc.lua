local gc=love.graphics
local blockPos={4,4,4,4,4,5,4}
local renATK={[0]=0,0,0,1,1,2,2,3,3,4,4}--3 else
local b2bPoint={50,100,180}
local b2bATK={3,5,8}
local testScore={[-1]=1,[-2]=0,[-3]=1,2,2,2}
local visible_opt={show=1e99,time=300,fast=20,none=5}
local reAtk={0,0,1,1,1,2,2,3,3}
local reDef={0,1,1,2,3,3,4,4,5}
local blockName={"Z","S","L","J","T","O","I"}
local clearName={"single","double","triple"}
local spin_n={[0]="spin_0","spin_1","spin_2","spin_3"}
local clear_n={"clear_1","clear_2","clear_3","clear_4"}
local ren_n={}for i=1,11 do ren_n[i]="ren_"..i end

local scs={
	{[0]={1,2},{2,1},{2,2},{2,2}},
	{[0]={1,2},{2,1},{2,2},{2,2}},
	{[0]={1,2},{2,1},{2,2},{2,2}},
	{[0]={1,2},{2,1},{2,2},{2,2}},
	{[0]={1,2},{2,1},{2,2},{2,2}},
	{[0]={1.5,1.5},{1.5,1.5},{1.5,1.5},{1.5,1.5},},
	{[0]={0.5,2.5},{2.5,0.5},{1.5,2.5},{2.5,1.5}},
}
local TRS={
	[1]={
		[01]={{0,0},{-1,0},{-1,1},{0,-2},{-1,-2},{0,1}},
		[10]={{0,0},{1,0},{1,-1},{0,2},{1,2},{0,-1}},
		[12]={{0,0},{1,0},{1,-1},{0,1},{-1,0},{0,2},{1,2}},
		[21]={{0,0},{-1,0},{-1,1},{1,0},{0,-2},{-1,-2}},
		[23]={{0,0},{1,0},{1,1},{1,-1},{0,-2},{1,-2}},
		[32]={{0,0},{-1,0},{-1,-1},{-1,1},{0,2},{-1,2}},
		[30]={{0,0},{-1,0},{-1,-1},{0,2},{-1,2},{0,-1}},
		[03]={{0,0},{1,0},{1,1},{1,-1},{0,-2},{1,-2},{0,1}},
		[02]={{0,0},{1,0},{-1,0},{0,-1},{0,1}},
		[20]={{0,0},{-1,0},{1,0},{0,1},{0,-1}},
		[13]={{0,0},{0,-1},{0,1},{-1,0}},
		[31]={{0,0},{0,1},{0,-1},{1,0}},
	},--Z/J
	[2]={
		[01]={{0,0},{-1,0},{-1,1},{-1,-1},{0,-2},{-1,-2}},
		[10]={{0,0},{1,0},{1,-1},{0,2},{1,2}},
		[12]={{0,0},{1,0},{1,-1},{1,1},{0,2},{1,2}},
		[21]={{0,0},{-1,0},{-1,1},{-1,-1},{0,-2},{-1,-2}},
		[23]={{0,0},{1,0},{1,1},{-1,0},{0,-2},{1,-2}},
		[32]={{0,0},{-1,0},{-1,-1},{0,1},{1,0},{0,2},{-1,2}},
		[30]={{0,0},{-1,0},{-1,-1},{0,2},{-1,2},{0,-1},{-1,1}},
		[03]={{0,0},{1,0},{1,1},{0,-2},{1,-2},{1,-1},{0,1}},
		[02]={{0,0},{-1,0},{1,0},{0,-1},{0,1}},
		[20]={{0,0},{1,0},{-1,0},{0,1},{0,-1}},
		[13]={{0,0},{0,1},{0,-1},{1,0}},
		[31]={{0,0},{0,-1},{0,1},{-1,0}},
	},--S/L
	[5]={
		[01]={{0,0},{-1,0},{-1,1},{0,-2},{-1,-2},{-1,-1}},
		[10]={{0,0},{1,0},{1,-1},{0,2},{1,2},{0,-1},{1,1}},
		[12]={{0,0},{1,0},{1,-1},{0,-1},{0,2},{1,2},{-1,-1}},
		[21]={{0,0},{-1,0},{-1,1},{0,-2},{-1,-2},{1,1}},
		[23]={{0,0},{1,0},{1,1},{0,-2},{1,-2},{-1,1}},
		[32]={{0,0},{-1,0},{-1,-1},{0,-1},{0,2},{-1,2},{1,-1}},
		[30]={{0,0},{-1,0},{-1,-1},{0,2},{-1,2},{0,-1}},
		[03]={{0,0},{1,0},{1,1},{0,-2},{1,-2}},
		[02]={{0,0},{-1,0},{1,0},{0,-1},{0,1}},
		[20]={{0,0},{1,0},{-1,0},{0,1},{0,-1}},
		[13]={{0,0},{0,-1},{0,1},{1,0},{-1,0},{0,2}},
		[31]={{0,0},{0,-1},{0,1},{-1,0},{1,0},{0,2}},
	},
	[7]={
		[01]={{0,0},{0,1},{1,0},{-2,0},{-2,-1},{1,2}},
		[03]={{0,0},{0,1},{-1,0},{2,0},{2,-1},{-1,2}},
		[10]={{0,0},{2,0},{-1,0},{-1,-2},{2,1},{0,2}},
		[30]={{0,0},{-2,0},{1,0},{1,-2},{-2,1},{0,2}},
		[12]={{0,0},{-1,0},{2,0},{-1,2},{2,-1}},
		[32]={{0,0},{1,0},{-2,0},{1,-2},{-2,-1}},
		[21]={{0,0},{-2,0},{1,0},{1,-2},{-2,1}},
		[23]={{0,0},{2,0},{-1,0},{-1,-2},{2,1}},
		[02]={{0,0},{-1,0},{1,0},{0,-1},{0,1}},
		[20]={{0,0},{1,0},{-1,0},{0,1},{0,-1}},
		[13]={{0,0},{0,-1},{-1,0},{1,0},{0,1}},
		[31]={{0,0},{1,0},{-1,0}},
	}
}TRS[3],TRS[4]=TRS[2],TRS[1]

local freshMethod={
	bag7=function()
		if #P.next<6 then
			local bag={1,2,3,4,5,6,7}
			::L::
				newNext(rem(bag,rnd(#bag)))
			if bag[1]then goto L end
		end
	end,
	his4=function()
		if #P.next<6 then
			local j,i=0
			::L::
				i,j=rnd(7),j+1
			if(i==P.his[1]or i==P.his[2]or i==P.his[3]or i==P.his[4])then goto L end
			newNext(i)
			rem(P.his,1)ins(P.his,i)
		end
	end,
	rnd=function()
		local i
		::L::
			i=rnd(7)
		if i==P.next[5]then goto L end
		newNext(i)
	end,--random
	pc=function()
		if P.stat.piece%4==0 then
			local r=rnd(#PClist)
			local f=P.modeData.event==1
			for i=1,4 do
				local b=PClist[r][i]
				if f then
					if b<3 then b=3-b
					elseif b<5 then b=7-b
					end
				end
				newNext(b)
			end
			P.modeData.event=(P.modeData.event+1)%2
		end
	end,
	drought1=function()
		if #P.next<6 then
			local bag={1,2,3,4,5,6}
			::L::
				newNext(rem(bag,rnd(#bag)))
			if bag[1]then goto L end
		end
	end,
	drought2=function()
		if #P.next<6 then
			local bag={1,1,1,1,2,2,2,2,6,6,6,6,3,3,4,4,5,7}
			::L::
				newNext(rem(bag,rnd(#bag)))
			if bag[1]then goto L end
		end
	end,
}
local shadeColor={
	{1,0,0,.3},
	{0,1,0,.3},
	{1,.5,0,.3},
	{0,0,1,.3},
	{1,0,1,.3},
	{1,1,0,.3},
	{0,1,1,.3},
}
local function createShade(x1,y1,x2,y2)--x1<x2,y1>y2
	if P.gameEnv.block and y1>=y2 then
		ins(P.shade,{5,P.cur.color,x1,y1,x2,y2})
	end
end
function loadGame(mode,level)
	--rec={}
	curMode={id=modeID[mode],lv=level}
	PTC.attack[1]:reset()PTC.attack[2]:reset()PTC.attack[3]:reset()
	drawableText.modeName:set(text.modeName[mode])
	drawableText.levelName:set(modeLevel[modeID[mode]][level])
	needResetGameData=true
	gotoScene("play","deck")
end
function resetPartGameData()
	frame=30
	if players then
		for _,P in next,players do if P.id then
			while P.field[1]do
				removeRow(P.field)
				removeRow(P.visTime)
			end
		end end
	end
	players={alive={}}human=0
	loadmode[curMode.id]()
	if modeEnv.royaleMode then
		for i=1,#players do
			changeAtk(players[i],randomTarget(players[i]))
		end
	end
	for i=1,#virtualkey do
		virtualkey[i].press=false
	end
	collectgarbage()
end
function resetGameData()
	gamefinished=false
	frame=0
	garbageSpeed=1
	pushSpeed=3
	pauseTime=0--Time paused
	pauseCount=0--Times paused
	if players then
		for _,P in next,players do if P.id then
			while P.field[1]do
				removeRow(P.field)
				removeRow(P.visTime)
			end
		end end
	end
	players={alive={}}human=0
	modeEnv=defaultModeEnv[curMode.id][curMode.lv]or defaultModeEnv[curMode.id][1]
	loadmode[curMode.id]()
	curBG=modeEnv.bg
	BGM(modeEnv.bgm)

	FX.beam={}
	for _,v in next,PTC.dust do
		v:release()
	end
	for i=1,#players do
		if not players[i].small then
			PTC.dust[i]=PTC.dust0:clone()
			PTC.dust[i]:start()
		end
	end
	if modeEnv.royaleMode then
		for i=1,#players do
			changeAtk(players[i],randomTarget(players[i]))
		end
		mostBadge,mostDangerous,secBadge,secDangerous=nil
		gameStage=1
		garbageSpeed=.3
		pushSpeed=2
	end
	for i=1,#virtualkey do
		virtualkey[i].press=false
	end
	stat.game=stat.game+1
	local p=60*#players
	while freeRow[p]do
		rem(freeRow)
	end
	SFX("ready")
	collectgarbage()
end
function gameStart()
	SFX("start")
	for P=1,#players do
		P=players[P]
		_G.P=P
		P.control=true
		P.timing=true
		resetblock()
	end
	setmetatable(_G,nil)
end
function createPlayer(id,x,y,size,AIspeed,data)
	players[id]={id=id}
	P=players[id]
	local P=P
	ins(players.alive,P)
	P.index={__index=P}
	P.x,P.y,P.size=x,y,size or 1
	P.fieldOffX,P.fieldOffY=0,0
	P.small=P.size<.1
	if P.small then
		P.centerX,P.centerY=P.x+300*P.size,P.y+600*P.size
		P.canvas=gc.newCanvas(60,120)
		P.frameWait=rnd(30,120)
	else
		P.centerX,P.centerY=P.x+300*P.size,P.y+670*P.size
		P.absFieldX=P.x+150*P.size
		P.absFieldY=P.y+60*P.size
	end

	if AIspeed then
		P.ai={
			controls={},
			controlDelay=30,
			controlDelay0=AIspeed,
		}
	else
		P.human=true
		human=human+1
	end

	P.alive=true
	P.control=false
	P.timing=false
	P.stat={
		time=0,
		key=0,rotate=0,hold=0,piece=0,row=0,
		atk=0,send=0,recv=0,pend=0,
		clear_1=0,clear_2=0,clear_3=0,clear_4=0,
		spin_0=0,spin_1=0,spin_2=0,spin_3=0,
		pc=0,b2b=0,b3b=0,
	}--Current gamestat
	P.modeData={point=0,event=0}--data use by mode
	P.keyTime={}for i=1,10 do P.keyTime[i]=-1e5 end P.keySpeed=0
	P.dropTime={}for i=1,10 do P.dropTime[i]=-1e5 end P.dropSpeed=0

	P.field,P.visTime={},{}
	P.atkBuffer={sum=0}

	P.ko,P.badge,P.strength=0,0,0
	P.atkMode,P.swappingAtkMode=1,20
	P.atker,P.atking,P.lastRecv={}
	--Royale-related

	P.gameEnv={}--Game setting vars,like dropDelay setting
	for k,v in pairs(gameEnv0)do
		if data and data[k]~=nil then
			P.gameEnv[k]=data[k]
		elseif modeEnv[k]~=nil then
			P.gameEnv[k]=modeEnv[k]
		elseif setting[k]~=nil then
			P.gameEnv[k]=setting[k]
		else
			P.gameEnv[k]=v
		end
	end--reset current game settings
	P.cur={bk={{}},id=0,color=0,name=0}
		P.sc,P.dir,P.r,P.c={0,0},0,0,0
		P.curX,P.curY,P.y_img=0,0,0
	P.hold={bk={{}},id=0,color=0,name=0}
		P.holded=false
	P.next={}

	P.dropDelay,P.lockDelay=P.gameEnv.drop,P.gameEnv.lock
	P.freshTime=0
	P.spinLast,P.lastClear=false,nil
	
	P.his={rnd(7),rnd(7),rnd(7),rnd(7)}
	local s=P.gameEnv.sequence
	if s=="bag7"or s=="his4"then
		local bag1={1,2,3,4,5,6,7}
		for i=1,7 do
			newNext(rem(bag1,rnd(#bag1)))
		end
	elseif s=="rnd"then
		for i=1,6 do
			local r=rnd(7)
			newNext(r)
		end
	elseif s=="drought1"then
		local bag1={1,2,3,4,5,6}
		for i=1,6 do
			newNext(rem(bag1,rnd(#bag1)))
		end
	elseif s=="drought2"then
		local bag1={1,2,3,4,6,7}
		for i=1,6 do
			newNext(rem(bag1,rnd(#bag1)))
		end
	end

	P.freshNext=freshMethod[P.gameEnv.sequence]
	if P.gameEnv.sequence==1 then P.bag={}--Bag7
	elseif P.gameEnv.sequence==2 then P.his={}for i=1,4 do P.his[i]=P.next.id[i+3]end--History4
	elseif P.gameEnv.sequence==3 then--Pure random
	end

	P.showTime=visible_opt[P.gameEnv.visible]
	P.keepVisible=P.gameEnv.visible=="show"
	P.keyPressing={}for i=1,12 do P.keyPressing[i]=false end
	P.moving,P.downing=0,0
	P.waiting,P.falling=-1,-1
	P.clearing={}
	P.fieldBeneath=0

	P.combo,P.b2b=0,0
	P.shade,P.b2b1={},0

	P.endCounter=0
	P.counter=0
	P.result=nil--string:win/lose
	P.bonus={}
end
function showText(P,text,type,font,dy,spd,inf)
	if not P.small then
		ins(P.bonus,{t=0,text=text,draw=FX[type],font=font,dy=dy or 0,speed=spd or 1,inf=inf})
	end
end
function garbageSend(S,R,send,time)
	createBeam(S,R,send<4 and 1 or send<7 and 2 or 3)
	R.lastRecv=S
	if R.atkBuffer.sum<20 then
		send=min(send,20-R.atkBuffer.sum)
		R.atkBuffer.sum=R.atkBuffer.sum+send
		ins(R.atkBuffer,{
			pos=rnd(10),
			amount=send,
			countdown=time,
			cd0=time,
			time=0,
			sent=false,
			lv=min(int(send^.69),5),
		})
		R.stat.recv=R.stat.recv+send
		if R.human then
			SFX(send<4 and "blip_1"or"blip_2",min(send+1,5)*.1)
		end
	end
end
function garbageRelease()
	for i=1,#P.atkBuffer do
		local A=P.atkBuffer[i]
		if not A.sent and A.countdown<=0 then
			garbageRise(8+A.lv,A.amount,A.pos)
			P.atkBuffer.sum=P.atkBuffer.sum-A.amount
			P.stat.pend=P.stat.pend+A.amount
			A.sent=true
			A.time=0
		end
	end
end
function garbageRise(color,amount,pos)
	local t=P.showTime*2
	for _=1,amount do
		ins(P.field,1,getNewRow(color))
		ins(P.visTime,1,getNewRow(t))
		P.field[1][pos]=0
	end
	P.fieldBeneath=P.fieldBeneath+amount*30
	P.curY=P.curY+amount
	freshgho()
	for i=1,#P.clearing do
		P.clearing[i]=P.clearing[i]+amount
	end
	if #P.field>40 then Event.lose()end
end
function createBeam(S,R,lv)--Player id
	local x1,y1,x2,y2
	if S.small then
		x1,y1=S.centerX,S.centerY
	else
		x1,y1=S.x+(30*(P.curX+P.sc[2]-1)-30+15+150)*S.size,S.y+(600-30*(P.curY+P.sc[1]-1)+15+70)*S.size
	end
	if R.small then
		x2,y2=R.centerX,R.centerY
	else
		x2,y2=R.x+308*R.size,R.y+450*R.size
	end
	ins(FX.beam,{x1,y1,x2,y2,t=0,lv=lv})
end
function throwBadge(S,R)--Sender/Receiver
	local x1,y1,x2,y2
	if S.small then
		x1,y1=S.centerX,S.centerY
	else
		x1,y1=S.x+308*S.size,S.y+450*S.size
	end
	if R.small then
		x2,y2=R.centerX,R.centerY
	else
		x2,y2=R.x+70*R.size,R.y+344*R.size
	end
	ins(FX.badge,{x1,y1,x2,y2,t=0})
end
function randomTarget(p)
	if #players.alive>1 then
		local r
		::L::
			r=players.alive[rnd(#players.alive)]
		if r==p then goto L end
		return r
	end
end
function freshTarget(P)
	if P.atkMode==1 then
		if not P.atking.alive or rnd()<.1 then
			changeAtk(P,randomTarget(P))
		end
	elseif P.atkMode==2 then
		changeAtk(P,P~=mostBadge and mostBadge or secBadge or randomTarget(P))
	elseif P.atkMode==3 then
		changeAtk(P,P~=mostDangerous and mostDangerous or secDangerous or randomTarget(P))
	elseif P.atkMode==4 then
		for i=1,#P.atker do
			if not P.atker[i].alive then
				rem(P.atker,i)
				return
			end
		end
	end
end
function changeAtkMode(m)
	if P.atkMode==m then goto L end
	P.atkMode=m
	if m==1 then
		changeAtk(P,randomTarget(P))
	elseif m==2 then
		freshTarget(P)
	elseif m==3 then
		freshTarget(P)
	elseif m==4 then
		changeAtk(P)
	end
	::L::
end
function changeAtk(P,R)
	if P.atking then
		local K=P.atking.atker
		for i=1,#K do
			if K[i]==P then
				rem(K,i)
				goto L
			end
		end
	end
	::L::
	if R then
		P.atking=R
		ins(R.atker,P)
	else
		P.atking=nil
	end
end
function freshMostDangerous()
	mostDangerous,secDangerous=nil
	local m,m2=0,0
	for i=1,#players.alive do
		local h=#players.alive[i].field
		if h>=m then
			mostDangerous,secDangerous=players.alive[i],mostDangerous
			m,m2=h,m
		elseif h>=m2 then
			secDangerous=players.alive[i]
			m2=h
		end
	end
end
function freshMostBadge()
	mostBadge,secBadge=nil
	local m,m2=0,0
	for i=1,#players.alive do
		local h=players.alive[i].badge
		if h>=m then
			mostBadge,secBadge=players.alive[i],mostBadge
			m,m2=h,m
		elseif h>=m2 then
			secBadge=players.alive[i]
			m2=h
		end
	end
end
function royaleLevelup()
	gameStage=gameStage+1
	local spd
	if(gameStage==3 or gameStage>4)and players[1].alive then
		showText(players[1],text.royale_remain(#players.alive),"beat",50,-100,.3)
	end
	if gameStage==2 then
		spd=30
	elseif gameStage==3 then
		spd=15
		garbageSpeed=.6
		if players[1].alive then BGM("cruelty")end
	elseif gameStage==4 then
		spd=10
		pushSpeed=3
	elseif gameStage==5 then
		spd=5
		garbageSpeed=1
	elseif gameStage==6 then
		spd=3
		if players[1].alive then BGM("final")end
	end
	for i=1,#players.alive do
		local P=players.alive[i]
		P.gameEnv.drop=spd
	end
	if curMode.lv==5 and players[1].alive then
		local P=players[1]
		P.gameEnv.drop=int(P.gameEnv.drop*.3)
		if P.gameEnv.drop==0 then
			P.gameEnv._20G=true
		end
	end
end
function freshgho()
	P.y_img=min(#P.field+1,P.curY)
	if P.gameEnv._20G or P.keyPressing[7]and P.gameEnv.sdarr==0 then
		::L::if not ifoverlap(P.cur.bk,P.curX,P.y_img-1)then
			P.y_img=P.y_img-1
			P.spinLast=false
			goto L
		end
		if P.curY>P.y_img then
			if P.human and setting.fxs then
				createShade(P.curX,P.curY+1,P.curX+P.c-1,P.y_img+P.r-1)
				P.fieldOffY=4
			end
			P.curY=P.y_img
		end
	else
		::L::if not ifoverlap(P.cur.bk,P.curX,P.y_img-1)then
			P.y_img=P.y_img-1
			goto L
		end
	end
end
function freshLockDelay()
	if P.lockDelay<P.gameEnv.lock or P.curY==P.y_img then
		if P.freshTime<=P.gameEnv.freshLimit then
			P.lockDelay=P.gameEnv.lock
		end
		P.freshTime=P.freshTime+1
	end
end
function ifoverlap(bk,x,y)
	if x<1 or x+#bk[1]>11 or y<1 then return true end
	if y>#P.field then return end
	for i=1,#bk do for j=1,#bk[1]do
		if P.field[y+i-1]and bk[i][j]and P.field[y+i-1][x+j-1]>0 then return true end
	end end
end
function ckfull(i)
	for j=1,10 do if P.field[i][j]==0 then return end end
	return true
end
function checkrow(start,height)--(cy,r)
	local c=0
	for i=start,start+height-1 do
		if ckfull(i)then
			ins(P.clearing,1,i)
			c=c+1
			if not P.small then
				local S=PTC.dust[P.id]
				for k=1,100 do
					S:setPosition(rnd(300),600-30*i+rnd(30))
					S:emit(3)
				end
			end
		end
	end
	if c>0 then P.falling=P.gameEnv.fall end
	return c
end
function solid(x,y)
	if x<1 or x>10 or y<1 then return true end
	if y>#P.field then return false end
	return P.field[y][x]>0
end
function newNext(n)
	ins(P.next,{bk=blocks[n][0],id=n,color=P.gameEnv.bone and 8 or n,name=n})
end
function resetblock()
	P.holded,P.spinLast=false,false
	P.cur=rem(P.next,1)
	P.freshNext()
	P.sc,P.dir=scs[P.cur.id][0],0--spin center/direction
	P.r,P.c=#P.cur.bk,#P.cur.bk[1]--row/column
	P.curX,P.curY=blockPos[P.cur.id],21+ceil(P.fieldBeneath/30)-P.r+min(int(#P.field*.2),2)
	P.dropDelay,P.lockDelay,P.freshTime=P.gameEnv.drop,P.gameEnv.lock,0

	if P.keyPressing[8]then hold(true)end
	if P.keyPressing[3]then spin(1,true)end
	if P.keyPressing[4]then spin(-1,true)end
	if P.keyPressing[5]then spin(2,true)end
	if abs(P.moving)-P.gameEnv.das>1 and not ifoverlap(P.cur.bk,P.curX+(P.moving>0 and 1 or -1),P.curY)then
		P.curX=P.curX+(P.moving>0 and 1 or -1)
	end--Initial SYSs

	if ifoverlap(P.cur.bk,P.curX,P.curY)then lock()Event.lose()end
	freshgho()	
	if P.keyPressing[6]then act.hardDrop()P.keyPressing[6]=false end
end
function spin(d,ifpre)
	local idir=(P.dir+d)%4
	if P.cur.id==6 then
		freshLockDelay()
		if P.human then
			SFX(ifpre and"prerotate"or"rotate")
		end
		if P.gameEnv.ospin and P.freshTime>10 then
			if d==1 then
				if P.curY==P.y_img and solid(P.curX+2,P.curY+1)and solid(P.curX+2,P.curY)and solid(P.curX-1,P.curY+1)and not solid(P.curX-1,P.curY)then
					if solid(P.curX-2,P.curY)then
						P.curX=P.curX-1
						goto T
					else
						P.curX=P.curX-2
						goto I
					end
				end
			elseif d==-1 then
				if P.curY==P.y_img and solid(P.curX-1,P.curY+1)and solid(P.curX-1,P.curY)and solid(P.curX+2,P.curY+1)and not solid(P.curX+2,P.curY)then
					if solid(P.curX+3,P.curY)then
						goto T
					else
						goto I
					end
				end
			elseif d==2 and P.curY==P.y_img and solid(P.curX-1,P.curY+1)and solid(P.curX+2,P.curY+1)and not solid(P.curX-1,P.curY)and not solid(P.curX+2,P.curY)then
				P.curX=P.curX-1
				goto I
			end
			goto quit
			::T::
				P.cur.id=5
				P.cur.bk=blocks[5][0]
				P.sc=scs[5][0]
				P.r,P.c,P.dir=2,3,0
				P.spinLast=3
				P.stat.rotate=P.stat.rotate+1
			goto quit
			::I::
				P.cur.id=7
				P.cur.bk=blocks[7][2]
				P.sc=scs[7][2]
				P.r,P.c,P.dir=1,4,2
				P.spinLast=3
				P.stat.rotate=P.stat.rotate+1
			end
		goto quit
	end
	local icb=blocks[P.cur.id][idir]
	local isc=scs[P.cur.id][idir]
	local ir,ic=#icb,#icb[1]
	local ix,iy=P.curX+P.sc[2]-isc[2],P.curY+P.sc[1]-isc[1]
	local t--succssful test id
	local iki=TRS[P.cur.id][P.dir*10+idir]
	for i=1,P.freshTime<=1.2*P.gameEnv.freshLimit and #iki or 1 do
		if not ifoverlap(icb,ix+iki[i][1],iy+iki[i][2])then
			ix,iy=ix+iki[i][1],iy+iki[i][2]
			t=i
			goto spin
		end
	end
	goto quit
	::spin::
	if P.human and setting.fxs then
		createShade(P.curX,P.curY+P.r-1,P.curX+P.c-1,P.curY)
	end
	P.curX,P.curY,P.dir=ix,iy,idir
	P.sc,P.cur.bk=scs[P.cur.id][idir],icb
	P.r,P.c=ir,ic
	P.spinLast=t==2 and testScore[-d]or 2
	freshgho()
	freshLockDelay()
	if P.human then
		SFX(ifpre and"prerotate"or ifoverlap(P.cur.bk,P.curX,P.curY+1)and ifoverlap(P.cur.bk,P.curX-1,P.curY)and ifoverlap(P.cur.bk,P.curX+1,P.curY)and"rotatekick"or"rotate")
	end
	P.stat.rotate=P.stat.rotate+1
	::quit::
end
function hold(ifpre)
	if not P.holded and P.waiting==-1 and P.gameEnv.hold then
		P.holded=P.gameEnv.oncehold
		P.cur,P.hold=P.hold,P.cur
		P.hold.bk=blocks[P.hold.id][0]
		if P.cur.id==0 then
			P.cur=rem(P.next,1)
			P.freshNext()
		end
		P.sc,P.dir=scs[P.cur.id][0],0
		P.r,P.c=#P.cur.bk,#P.cur.bk[1]
		P.curX,P.curY=blockPos[P.cur.id],21+ceil(P.fieldBeneath/30)-P.r+min(int(#P.field*.2),2)

		if abs(P.moving)-P.gameEnv.das>1 and not ifoverlap(P.cur.bk,P.curX+(P.moving>0 and 1 or -1),P.curY)then
			P.curX=P.curX+(P.moving>0 and 1 or -1)
		end
	
		freshgho()
		P.dropDelay,P.lockDelay,P.freshTime=P.gameEnv.drop,P.gameEnv.lock,max(P.freshTime-5,0)
		if ifoverlap(P.cur.bk,P.curX,P.curY)then lock()Event.lose()end

		if P.human then
			SFX(ifpre and"prehold"or"hold")
		end
		P.stat.hold=P.stat.hold+1
	end
end
function drop()
	if P.curY==P.y_img then
		ins(P.dropTime,1,frame)rem(P.dropTime,11)--update speed dial
		P.waiting=P.gameEnv.wait
		local dospin=0
		if P.spinLast then
			if P.cur.id<6 then
				local x,y=P.curX+P.sc[2]-1,P.curY+P.sc[1]-1
				local c=0
				if solid(x-1,y+1)then c=c+1 end
				if solid(x+1,y+1)then c=c+1 end
				if c==0 then goto NTC end
				if solid(x-1,y-1)then c=c+1 end
				if solid(x+1,y-1)then c=c+1 end
				if c>2 then dospin=dospin+1 end
			end--Three point
			::NTC::
			if P.cur.id~=6 and ifoverlap(P.cur.bk,P.curX-1,P.curY)and ifoverlap(P.cur.bk,P.curX+1,P.curY)and ifoverlap(P.cur.bk,P.curX,P.curY+1)then
				dospin=dospin+2
			end--Immobile
		end
		lock()
		local cc,send,exblock,sendTime=checkrow(P.curY,P.r),0,0,0--Currect clear&send&sendTime
		local mini
		if P.spinLast and cc>0 and dospin>0 then
			dospin=dospin+P.spinLast
		end
		if not P.spinLast then
			dospin=false
		elseif cc==0 then
			if dospin==0 then
				dospin=false
			end
		elseif dospin<2 then
			dospin=false
		elseif dospin==2 then
			mini=P.cur.id<6 and cc<3 and cc<P.r
		end
		
		P.combo=P.combo+1--combo=0 is under
		if cc==4 then
			if P.b2b>1000 then
				showText(P,text.techrashB3B,"fly",80,-30)
				send=6
				sendTime=100
				exblock=exblock+1
				P.stat.b3b=P.stat.b3b+1
				if P.human then
					VOICE("b3b")
				end
			elseif P.b2b>=40 then
				showText(P,text.techrashB2B,"drive",80,-30)
				sendTime=80
				send=5
				P.stat.b2b=P.stat.b2b+1
				if P.human then
					VOICE("b2b")
				end
			else
				showText(P,text.techrash,"stretch",80,-30)
				sendTime=60
				send=4
			end
			P.b2b=P.b2b+120
			P.lastClear=74
			P.stat.clear_4=P.stat.clear_4+1
			if P.human then
				VOICE("tts")
			end
		elseif cc>0 then
			local clearKey=clear_n
			if dospin then
				if P.b2b>1000 then
					showText(P,text.b3b..text.spin[P.cur.name]..text.clear[cc],"spin",40,-30)
					send=b2bATK[cc]+1
					exblock=exblock+1
					P.stat.b3b=P.stat.b3b+1
					if P.human then
						VOICE("b3b")
					end
				elseif P.b2b>=40 then
					showText(P,text.b2b..text.spin[P.cur.name]..text.clear[cc],"spin",40,-30)
					send=b2bATK[cc]
					P.stat.b2b=P.stat.b2b+1
					if P.human then
						VOICE("b2b")
					end
				else
					showText(P,text.spin[P.cur.name]..text.clear[cc],"spin",50,-30)
					send=2*cc
				end
				sendTime=20+send*20
				if mini then
					showText(P,text.mini,"appear",40,-80)
					send=ceil(send*.5)
					sendTime=sendTime+60
					P.b2b=P.b2b+b2bPoint[cc]*.8
					if P.human then
						VOICE("mini")
					end
				else
					P.b2b=P.b2b+b2bPoint[cc]
				end
				P.lastClear=P.cur.id*10+cc
				clearKey=spin_n
				if P.human then
					SFX(spin_n[cc])
					VOICE(blockName[P.cur.name])
					VOICE("spin_")
				end
			elseif #P.clearing<#P.field then
				P.b2b=max(P.b2b-250,0)
				showText(P,text.clear[cc],"appear",32+cc*3,-30,(8-cc)*.3)
				send=cc-1
				sendTime=20+send*20
				P.lastClear=cc
			end
			P.stat[clearKey[cc]]=P.stat[clearKey[cc]]+1
			if P.human then
				VOICE(clearName[cc])
			end
		else
			P.combo=0
			if dospin then
				showText(P,text.spin[P.cur.name],"appear",50,-30)
				P.b2b=P.b2b+20
				P.stat.spin_0=P.stat.spin_0+1
				if P.human then
					SFX("spin_0")
					VOICE(blockName[P.cur.name])
					VOICE("spin")
				end
			end
		end
		send=send+(renATK[P.combo]or 4)
		if #P.clearing==#P.field then
			showText(P,text.PC,"flicker",70,-80)
			send=min(send,4)+min(6+P.stat.pc,10)
			exblock=exblock+2
			sendTime=sendTime+60
			if P.stat.row>4 then P.b2b=1200 end
			P.stat.pc=P.stat.pc+1
			P.lastClear=P.cur.id*10+5
			if P.human then
				SFX("perfectclear")
				VOICE("pc")
			end
		end
		if P.combo>2 then
			showText(P,text.cmb[min(P.combo,20)],P.combo<10 and"appear"or"flicker",20+min(P.combo,25)*3,60)
		end
		sendTime=sendTime+20*P.combo
		if P.human and cc>0 then
			SFX(clear_n[cc])
			SFX(ren_n[min(P.combo,11)])
			if P.combo>14 then SFX("ren_mega",(P.combo-10)*.1)end
			VIB(cc)
		end
		if P.b2b>1200 then P.b2b=1200 end

		if cc>0 and modeEnv.royaleMode then
			local i=min(#P.atker,9)
			if i>1 then
				send=send+reAtk[i]
				exblock=exblock+reDef[i]
			end
		end

		if send>0 then
			if exblock then exblock=int(exblock*(1+P.strength*.25))end
			send=send*(1+P.strength*.25)
			if mini then send=send end
			send=int(send)
			--Badge Buff

			P.stat.atk=P.stat.atk+send
			--ATK statistics

			if send==0 then goto L end
				showText(P,send,"zoomout",40,70)
			if exblock==0 then goto L end
				showText(P,exblock,"zoomout",20,115)
			::L::
			if send>0 and P.atkBuffer[1]then
				if exblock>0 then
					exblock=exblock-1
				else
					send=send-1
				end
				P.atkBuffer[1].amount=P.atkBuffer[1].amount-1
				P.atkBuffer.sum=P.atkBuffer.sum-1
				if P.atkBuffer[1].amount==0 then
					rem(P.atkBuffer,1)
				end
				goto L
			end
			if send>0 then
				if modeEnv.royaleMode then
					if P.atkMode==4 then
						if #P.atker>0 then
							for i=1,#P.atker do
								garbageSend(P,P.atker[i],send,sendTime)
							end
						else
							garbageSend(P,randomTarget(P),send,sendTime)
						end
					else
						freshTarget(P)
						garbageSend(P,P.atking,send,sendTime)
					end
				elseif #players.alive>1 then
					garbageSend(P,randomTarget(P),send,sendTime)
				end
				P.stat.send=P.stat.send+send
				if P.human and send>3 then SFX("emit",min(send,8)*.125)end
			end
		elseif cc==0 then
			if P.b2b>1000 then
				P.b2b=max(P.b2b-40,1000)
			end
			garbageRelease()
		end
		P.stat.piece,P.stat.row=P.stat.piece+1,P.stat.row+cc
		if P.stat.row>=P.gameEnv.target then
			P.gameEnv.reach()
		end
		P.spinLast=dospin and cc>0
		if P.human then
			SFX("lock")
		end
	else
		P.curY=P.curY-1
		P.spinLast=false
	end
end
function lock()
	for i=1,P.r do
		local y=P.curY+i-1
		if not P.field[y]then P.field[y],P.visTime[y]=getNewRow(0),getNewRow(0)end
		for j=1,P.c do
			if P.cur.bk[i][j]then
				P.field[y][P.curX+j-1]=P.cur.color
				P.visTime[y][P.curX+j-1]=P.showTime
			end
		end
	end
end
function pressKey(i,p)
	P=p
	P.keyPressing[i]=true
	if P.human then
		virtualkeyDown[i]=true
		virtualkeyPressTime[i]=10
	end
	if i==10 then
		act.restart()
	elseif P.alive then
		if P.control and P.waiting==-1 then
			act[actName[i]]()
			if i>2 and i<7 then P.keyPressing[i]=false end
		elseif i==9 and not setting.swap then
			P.atkMode=P.atkMode<3 and P.atkMode+2 or 5-P.atkMode
		elseif P.keyPressing[9]and setting.swap then
			if i==1 then
				P.atkMode=1
				changeAtk(P,randomTarget(P))
			elseif i==2 then
				P.atkMode=2
			elseif i==6 then
				P.atkMode=3
			elseif i==7 then
				P.atkMode=4
			end
		else
			if i==1 then
				P.moving=-1
			elseif i==2 then
				P.moving=1
			end
		end
		ins(P.keyTime,1,frame)rem(P.keyTime,11)
		P.stat.key=P.stat.key+1
	end
	--ins(rec,{i,frame})
end
function releaseKey(i,p)
	p.keyPressing[i]=false
	if p.id==1 then virtualkeyDown[i]=false end
	-- if recording then ins(rec,{-i,frame})end
end
act={
	moveLeft=function(auto)
		if P.keyPressing[9]and setting.swap then
			changeAtkMode(1)
		else
			if not auto then
				P.moving=-1
			end
			if not ifoverlap(P.cur.bk,P.curX-1,P.curY)then
				P.curX=P.curX-1
				freshgho()
				freshLockDelay()
				if P.human and P.curY==P.y_img then SFX("move")end
				P.spinLast=false
			end
		end
	end,
	moveRight=function(auto)
		if P.keyPressing[9]and setting.swap then
			changeAtkMode(2)
		else
			if not auto then
				P.moving=1
			end
			if not ifoverlap(P.cur.bk,P.curX+1,P.curY)then
				P.curX=P.curX+1
				freshgho()
				freshLockDelay()
				if P.human and P.curY==P.y_img then SFX("move")end
				P.spinLast=false
			end
		end
	end,
	rotRight=function()spin(1)end,
	rotLeft=function()spin(-1)end,
	rotFlip=function()spin(2)end,
	hardDrop=function()
		if P.keyPressing[9]and setting.swap then
			changeAtkMode(3)
		else
			if P.waiting==-1 then
				if P.curY~=P.y_img then
					if P.human and setting.fxs then
						createShade(P.curX,P.curY+1,P.curX+P.c-1,P.y_img+P.r-1)
						P.fieldOffY=5
					end
					P.curY=P.y_img
					P.spinLast=false
					if P.human then
						SFX("drop")
						VIB(0)
					end
				end
				P.lockDelay=-1
				drop()
			end
		end
	end,
	softDrop=function()
		if P.keyPressing[9]and setting.swap then
			changeAtkMode(4)
		else
			if P.curY~=P.y_img then
				P.curY=P.curY-1
				P.spinLast=false
			end
			P.downing=1
		end
	end,
	hold=function()hold()end,
	func=function()
		if modeEnv.Fkey then
			if modeEnv.royaleMode then
				for i=1,#P.keyPressing do
					if P.keyPressing[i]then
						P.keyPressing[i]=false
					end
				end
				if setting.swap then
					P.keyPressing[9]=true
				else
					changeAtkMode(P.atkMode<3 and P.atkMode+2 or 5-P.atkMode)
					P.swappingAtkMode=30
				end
			end
			if curMode.id=="custom"and curMode.lv==2 and P.stat.row>0 then
				for y=1,20 do
					local L=P.field[y]
					for x=1,10 do
						local a,b=preField[y][x],L and L[x]or 0
						if a~=-1 and(a==0 and b>0 or a<8 and a~=b or a>7 and b==0)then goto change end
					end
				end
				P.modeData.event=0
				Event.win()
				::change::
				P.modeData.event=1-P.modeData.event
			end
		end
	end,
	restart=function()
		if frame<180 then
			clearTask("play")
			resetPartGameData()
		end
	end,
	insDown=function()
		if P.curY~=P.y_img then
			if P.human and setting.fxs then
				createShade(P.curX,P.curY+1,P.curX+P.c-1,P.y_img+P.r-1)
			end
			P.curY,P.lockDelay,P.spinLast=P.y_img,P.gameEnv.lock,false
			if P.human and setting.fxs then
				P.fieldOffY=4
			end
		end
	end,
	insLeft=function()
		local x0=P.curX
		::L::if not ifoverlap(P.cur.bk,P.curX-1,P.curY)then
			P.curX=P.curX-1
			if P.human and setting.fxs then
				createShade(P.curX+1,P.curY+P.r-1,P.curX+1,P.curY)
			end
			freshgho()
			goto L
		end
		if x0~=P.curX then
			if P.human and setting.fxs and P.curX==1 then
				P.fieldOffX=-4
			end
			freshLockDelay()
		end
	end,
	insRight=function()
		local x0=P.curX
		::L::if not ifoverlap(P.cur.bk,P.curX+1,P.curY)then
			P.curX=P.curX+1
			if P.human and setting.fxs then
				createShade(P.curX+P.c-1,P.curY+P.r-1,P.curX+P.c-1,P.curY)
			end
			freshgho()
			goto L
		end
		if x0~=P.curX then
			if P.human and setting.fxs and P.curX+P.c==11 then
				P.fieldOffX=4
			end
			freshLockDelay()
		end
	end,
	down1=function()
		if P.curY~=P.y_img then
			P.curY=P.curY-1
			P.spinLast=false
		end
	end,
	down4=function()
		for i=1,4 do
			if P.curY~=P.y_img then
				P.curY=P.curY-1
				P.spinLast=false
			else
				break
			end
		end
	end,
	quit=function()Event.lose()end,
	--System movements
}
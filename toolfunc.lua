local tm=love.timer
local gc=love.graphics
local kb=love.keyboard
local setFont=setFont
local int,abs,rnd,max,min=math.floor,math.abs,math.random,math.max,math.min
local sub,find=string.sub,string.find
local ins,rem=table.insert,table.remove
local toN,toS=tonumber,tostring
local concat=table.concat

local function splitS(s,sep)
	local t,n={},1
	repeat
		local p=find(s,sep)or #s+1
		t[n]=sub(s,1,p-1)
		n=n+1
		s=sub(s,p+#sep)
	until #s==0
	return t
end
function mStr(s,x,y)
	gc.printf(s,x-320,y,640,"center")
end
function mDraw(s,x,y)
	gc.draw(s,x-s:getWidth()*.5,y)
end
function destroyPlayers()
	for i=#players,1,-1 do
		local P=players[i]
		if P.canvas then P.canvas:release()end
		while P.field[1]do
			removeRow(P.field)
			removeRow(P.visTime)
		end
		if P.AI_mode=="CC"then
			BOT.free(P.bot_opt)
			BOT.free(P.bot_wei)
			BOT.destroy(P.AI_bot)
			P.AI_mode=nil
		end
		players[i]=nil
	end
	for i=#players.alive,1,-1 do
		players.alive[i]=nil
	end
	players.human=0
	collectgarbage()
end
function getNewRow(val)
	local t=rem(freeRow)
	for i=1,10 do
		t[i]=val
	end
	freeRow.L=freeRow.L-1
	--get a row from buffer
	if not freeRow[1]then
		for i=1,10 do
			freeRow[i]={0,0,0,0,0,0,0,0,0,0}
		end
		freeRow.L=freeRow.L+10
	end
	--prepare new rows
	return t
end
function removeRow(t,k)
	freeRow[#freeRow+1]=rem(t,k)
	freeRow.L=freeRow.L+1
end
--Single-usage funcs
langName={"中文","全中文","English"}
local langID={"chi","chi_full","eng"}
local drawableTextLoad={
	"next","hold",
	"pause","finish",
	"custom",
	"setting_game","setting_graphic","setting_sound",
	"keyboard","joystick",
	"ctrlSetHelp",
	"musicRoom",
	"nowPlaying",
	"warning",
}
function swapLanguage(l)
	text=require("language/"..langID[l])
	for S,L in next,Widget do
		for N,W in next,L do
			W.text=text.WidgetText[S][N]
		end
	end
	gc.push("transform")
	gc.origin()
		royaleCtrlPad=gc.newCanvas(300,100)
		gc.setCanvas(royaleCtrlPad)
		gc.setColor(1,1,1)
		setFont(25)
		gc.setLineWidth(2)
		for i=1,4 do
			gc.rectangle("line",RCPB[2*i-1],RCPB[2*i],90,35,8,4)
			mStr(text.atkModeName[i],RCPB[2*i-1]+45,RCPB[2*i]+3)
		end
	gc.pop()
	gc.setCanvas()
	for _,s in next,drawableTextLoad do
		drawableText[s]:set(text[s])
	end
	collectgarbage()
end
function changeBlockSkin(n)
	n=n-1
	gc.push("transform")
	gc.origin()
	gc.setColor(1,1,1)
	for i=1,13 do
		gc.setCanvas(blockSkin[i])
		gc.draw(blockImg,30-30*i,-30*n)
		gc.setCanvas(blockSkinmini[i])
		gc.draw(blockImg,6-6*i,-6*n,nil,.2)
	end
	gc.pop()
	gc.setCanvas()
end

local vibrateLevel={0,.015,.02,.03,.04,.05,.06,.07,.08,.09}
function VIB(t)
	if setting.vib>0 then
		love.system.vibrate(vibrateLevel[setting.vib+t])
	end
end
function SFX(s,v)
	if setting.sfx>0 then
		local n=1
		while sfx[s][n]:isPlaying()do
			n=n+1
			if not sfx[s][n]then
				sfx[s][n]=sfx[s][n-1]:clone()
				sfx[s][n]:seek(0)
				break
			end
		end
		sfx[s][n]:setVolume((v or 1)*setting.sfx*.125)
		sfx[s][n]:play()
	end
end
function getFreeVoiceChannel()
	local i=#voiceQueue
	for i=1,i do
		if #voiceQueue[i]==0 then return i end
	end
	voiceQueue[i+1]={}
	return i+1
end
function VOICE(s,chn)
	if setting.voc>0 then
		if chn then
			voiceQueue[chn][#voiceQueue[chn]+1]=voiceList[s][rnd(#voiceList[s])]
			--添加到[chn]
		else
			voiceQueue[getFreeVoiceChannel()]={voiceList[s][rnd(#voiceList[s])]}
			--自动查找/创建空轨
		end
	end
end
function BGM(s)
	if setting.bgm>0 then
		if bgmPlaying~=s then
			if bgmPlaying then newTask(Event_task.bgmFadeOut,nil,bgmPlaying)end
			for i=#Task,1,-1 do
				local T=Task[i]
				if T.code==Event_task.bgmFadeIn then
					T.code=Event_task.bgmFadeOut
				elseif T.code==Event_task.bgmFadeOut and T.data==s then
					rem(Task,i)
				end
			end
			if s then
				newTask(Event_task.bgmFadeIn,nil,s)
				bgm[s]:play()
			end
			bgmPlaying=s
		else
			if bgmPlaying then
				local v=setting.bgm*.125
				bgm[bgmPlaying]:setVolume(v)
				if v>0 then
					bgm[bgmPlaying]:play()
				else
					bgm[bgmPlaying]:pause()
				end
			end
		end
	elseif bgmPlaying then
		bgm[bgmPlaying]:pause()
		bgmPlaying=nil
	end
end

local swapDeck_data={
	{4,0,1,1},{6,0,15,1},{5,0,9,1},{6,0,6,1},
	{1,0,3,1},{3,0,12,1},{1,1,8,1},{2,1,4,2},
	{3,2,13,2},{4,1,12,2},{5,2,1,2},{7,1,11,2},
	{2,1,9,3},{3,0,6,3},{4,2,14,3},{1,0,4,4},
	{7,1,1,4},{6,0,2,4},{5,2,6,4},{6,0,14,5},
	{3,3,15,5},{4,0,7,6},{7,1,10,5},{5,0,2,6},
	{2,1,1,7},{1,0,4,6},{4,1,13,5},{1,1,6,7},
	{5,3,11,5},{3,2,11,7},{6,0,8,7},{4,2,12,8},
	{7,0,8,9},{1,0,2,8},{5,2,4,8},{6,0,15,8},
}--Block id [ZSLJTOI] ,dir,x,y
local swap={
	none={2,1,d=NULL},
	flash={8,1,d=function()gc.clear(1,1,1)end},
	fade={30,15,d=function()
		local t=1-abs(sceneSwaping.time*.06667-1)
		gc.setColor(0,0,0,t)
		gc.rectangle("fill",0,0,1280,720)
	end},
	deck={50,8,d=function()
		local t=sceneSwaping.time
		gc.setColor(1,1,1)
		if t>8 then
			local t=max(t,15)
			for i=1,51-t do
				local bn=swapDeck_data[i][1]
				local b=blocks[bn][swapDeck_data[i][2]]
				local cx,cy=swapDeck_data[i][3],swapDeck_data[i][4]
				for y=1,#b do for x=1,#b[1]do
					if b[y][x]then
						gc.draw(blockSkin[bn],80*(cx+x-2),80*(10-cy-y),nil,8/3)
					end
				end end
			end
		end
		if t<17 then
			gc.setColor(1,1,1,(8-abs(t-8))*.125)
			gc.rectangle("fill",0,0,1280,720)
		end
	end},
}--Scene swapping animations
function gotoScene(s,style)
	if not sceneSwaping and s~=scene then
		style=style or"fade"
		sceneSwaping={
			tar=s,style=style,
			time=swap[style][1],mid=swap[style][2],
			draw=swap[style].d
		}
		widget_sel=nil
		if style~="none"then
			SFX("swipe")
		end
	end
end
function updateStat()
	local S=players[1].stat
	for k,v in next,S do
		stat[k]=stat[k]+S[k]
	end
end
local prevMenu={
	load=love.event.quit,
	intro="quit",
	main="intro",
	music="main",
	mode="main",
	custom="mode",
	draw="custom",
	play=function()
		kb.setKeyRepeat(true)
		updateStat()
		saveData()
		clearTask("play")
		gotoScene(curMode.id~="custom"and"mode"or"custom","deck")
	end,
	setting_game=function()
		saveSetting()
		gotoScene("main")
	end,
	setting_control="setting_game",
	setting_touch=	"setting_game",
	help="main",
	history="help",
	stat="main",
}
prevMenu.pause=prevMenu.play
prevMenu.setting_graphic=prevMenu.setting_game
prevMenu.setting_sound=prevMenu.setting_game
function back()
	local t=prevMenu[scene]
	if type(t)=="string"then
		gotoScene(t)
	else
		t()
	end
end

function randomTarget(P)
	if #players.alive>1 then
		local R
		repeat
			R=players.alive[rnd(#players.alive)]
		until R~=P
		return R
	end
end--return a random opponent for P
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
		players[1]:showText(text.royale_remain(#players.alive),"beat",50,-100,.3)
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
		players.alive[i].gameEnv.drop=spd
	end
	if curMode.lv==3 then
		for i=1,#players.alive do
			local P=players.alive[i]
			P.gameEnv.drop=int(P.gameEnv.drop*.3)
			if P.gameEnv.drop==0 then
				P.curY=P.y_img
				P.gameEnv._20G=true
				if P.AI_mode=="CC"then CC_switch20G(P)end--little cheating,never mind
			end
		end
	end
end

function pauseGame()
	pauseTimer=0--Pause timer for animation
	if not gamefinished then
		pauseCount=pauseCount+1
	end
	for i=1,#players.alive do
		local l=players.alive[i].keyPressing
		for j=1,#l do
			if l[j]then
				players.alive[i]:releaseKey(j)
			end
		end
	end
	gotoScene("pause","none")
end
function resumeGame()
	gotoScene("play","fade")
end
function loadGame(mode,level)
	--rec={}
	curMode={id=modeID[mode],lv=level}
	drawableText.modeName:set(text.modeName[mode])
	drawableText.levelName:set(modeLevel[modeID[mode]][level])
	needResetGameData=true
	gotoScene("play","deck")
end
function resetPartGameData()
	frame=30
	destroyPlayers()
	loadmode[curMode.id]()
	if modeEnv.task then
		for i=1,#players do
			newTask(Event_task[modeEnv.task],players[i])
		end
	end
	if modeEnv.royaleMode then
		for i=1,#players do
			players[i]:changeAtk(randomTarget(players[i]))
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
	destroyPlayers()
	local E=defaultModeEnv[curMode.id]
	modeEnv=E[curMode.lv]or E[1]
	loadmode[curMode.id]()--bg/bgm need redefine in custom,so up here
	if modeEnv.task then
		for i=1,#players do
			newTask(Event_task[modeEnv.task],players[i])
		end
	end
	curBG=modeEnv.bg
	BGM(modeEnv.bgm)

	FX_badge={}
	FX_attack={}
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
			players[i]:changeAtk(randomTarget(players[i]))
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
	local m,p=#freeRow,40*#players+1
	while freeRow[p]do
		m,freeRow[m]=m-1
	end
	freeRow.L=#freeRow
	SFX("ready")
	collectgarbage()
end
function gameStart()
	SFX("start")
	for P=1,#players do
		P=players[P]
		P:resetblock()
		P.timing=true
		P.control=true
	end
end

local dataOpt={
	"run","game","time",
	"extraPiece","extraRate",
	"key","rotate","hold","piece","row",
	"atk","send","recv","pend",
	"clear_1","clear_2","clear_3","clear_4",
	"spin_0","spin_1","spin_2","spin_3",
	"b2b","b3b","pc","score",
}
function loadData()
	userData:open("r")
	local t=userData:read()
	if not find(t,"spin")then
		t=love.data.decompress("string","zlib",t)
	end
	t=splitS(t,"\r\n")
	userData:close()
	for i=1,#t do
		local p=find(t[i],"=")
		if p then
			local t,v=sub(t[i],1,p-1),sub(t[i],p+1)
			if t=="gametime"then t="time"end
			for i=1,#dataOpt do
				if t==dataOpt[i]then
					v=toN(v)if not v or v<0 then v=0 end
					stat[t]=v
					break
				end
			end
		end
	end
end
function saveData()
	local t={}
	for i=1,#dataOpt do
		t[i]=dataOpt[i].."="..toS(stat[dataOpt[i]])
	end
	t=concat(t,"\r\n")
	userData:open("w")
	userData:write(t)
	userData:close()
end
function loadSetting()
	userSetting:open("r")
	local t=userSetting:read()
	if not find(t,"virtual")then
		t=love.data.decompress("string","zlib",t)
	end
	t=splitS(t,"\r\n")
	userSetting:close()
	for i=1,#t do
		local p=find(t[i],"=")
		if p then
			local t,v=sub(t[i],1,p-1),sub(t[i],p+1)
			if t=="sfx"or t=="bgm"or t=="voc"then
				setting[t]=toN(v:match("[012345678]"))or setting[t]
			elseif t=="vib"then
				setting.vib=toN(v:match("[012345]"))or 0
			elseif t=="fullscreen"then
				setting.fullscreen=v=="true"
				love.window.setFullscreen(setting.fullscreen)
			elseif t=="virtualkeyAlpha"then
				setting.virtualkeyAlpha=min(int(abs(toN(v))),10)
			elseif
				t=="ghost"or t=="center"or t=="grid"or t=="swap"or
				t=="quickR"or t=="fine"or t=="bgblock"or t=="smo"or
				t=="virtualkeyIcon"or t=="virtualkeySwitch"
			then
				setting[t]=v=="true"
			elseif t=="frameMul"then
				setting.frameMul=min(max(toN(v)or 100,0),100)
			elseif t=="das"or t=="arr"or t=="sddas"or t=="sdarr"then
				v=toN(v)if not v or v<0 then v=0 end
				setting[t]=int(v)
			elseif t=="dropFX"or t=="shakeFX"or t=="atkFX"then
				setting[t]=toN(v:match("[0123]"))or 0
			elseif t=="lang"then
				setting[t]=toN(v:match("[123]"))or 1
			elseif t=="skin"then
				setting[t]=toN(v:match("[12345678]"))or 1
			elseif t=="keymap"then
				v=splitS(v,"/")
				for i=1,16 do
					local v1=splitS(v[i],",")
					for j=1,#v1 do
						setting.keyMap[i][j]=v1[j]
					end
				end
			elseif t=="virtualkey"then
				v=splitS(v,"/")
				for i=1,10 do
					if v[i]then
						virtualkey[i]=splitS(v[i],",")
						for j=1,4 do
							virtualkey[i][j]=toN(virtualkey[i][j])
						end
					end
				end
			end
		end
	end
end
local saveOpt={
	"das","arr",
	"sddas","sdarr",
	"quickR",
	"swap",
	"fine",

	"ghost","center",
	"smo","grid",
	"dropFX",
	"shakeFX",
	"atkFX",
	"frameMul",

	"fullscreen",
	"bg",
	"bgblock",
	"lang",
	"skin",

	"sfx","bgm",
	"vib","voc",
	
	"virtualkeyAlpha",
	"virtualkeyIcon",
	"virtualkeySwitch",
}
function saveSetting()
	local vk={}
	for i=1,10 do
		for j=1,4 do
			virtualkey[i][j]=int(virtualkey[i][j]+.5)
		end--Saving a integer is better?
		vk[i]=concat(virtualkey[i],",")
	end--pre-pack virtualkey setting
	local map={}
	for i=1,16 do
		map[i]=concat(setting.keyMap[i],",")
	end
	local t={
		"keymap="..toS(concat(map,"/")),
		"virtualkey="..toS(concat(vk,"/")),
	}
	for i=1,#saveOpt do
		t[i+2]=saveOpt[i].."="..toS(setting[saveOpt[i]])
		--not always i+2!
	end
	t=concat(t,"\r\n")
	userSetting:open("w")
	userSetting:write(t)
	userSetting:close()
end
require("Zframework/toolfunc")
color=	require("Zframework/color")
SHADER=	require("Zframework/shader")
VIB=	require("Zframework/vib")
SFX=	require("Zframework/sfx")
sysFX=	require("Zframework/sysFX")
BG=		require("Zframework/bg")
BGM=	require("Zframework/bgm")
VOC=	require("Zframework/voice")
LANG=	require("Zframework/languages")
FILE=	require("Zframework/file")
TEXT=	require("Zframework/text")
TASK=	require("Zframework/task")
IMG=	require("Zframework/img")
WIDGET=	require("Zframework/widget")
Widgets=require("Zframework/widgetList")
LIGHT=	require("Zframework/light")
SCN=	require("Zframework/scene")
local Tmr=require("Zframework/timer")
local Pnt=require("Zframework/paint")

local ms,kb,tc=love.mouse,love.keyboard,love.touch
local gc,sys=love.graphics,love.system
local Timer=love.timer.getTime
local int,rnd,max,min=math.floor,math.random,math.max,math.min
local abs=math.abs
local ins,rem=table.insert,table.remove
local byte=string.byte

local scr=scr
local xOy=love.math.newTransform()
local mx,my,mouseShow=-20,-20,false
local touching=nil--First touching ID(userdata)
local touchDist=nil
joysticks={}

local devMode

local infoCanvas=gc.newCanvas(108,27)
local function updatePowerInfo()
	local state,pow=sys.getPowerInfo()
	gc.setCanvas(infoCanvas)gc.push("transform")gc.origin()
	gc.clear(0,0,0,.25)
	if state~="unknown"then
		gc.setLineWidth(4)
		local charging=state=="charging"
		if state=="nobattery"then
			gc.setColor(1,1,1)
			gc.setLineWidth(2)
			gc.line(74,5,100,22)
		elseif pow then
			if charging then	gc.setColor(0,1,0)
			elseif pow>50 then	gc.setColor(1,1,1)
			elseif pow>26 then	gc.setColor(1,1,0)
			elseif pow<26 then	gc.setColor(1,0,0)
			else				gc.setColor(.5,0,1)
			end
			gc.rectangle("fill",76,6,pow*.22,14)
			if pow<100 then
				setFont(14)
				gc.setColor(0,0,0)
				gc.print(pow,77,2)
				gc.print(pow,77,4)
				gc.print(pow,79,2)
				gc.print(pow,79,4)
				gc.setColor(1,1,1)
				gc.print(pow,78,3)
			end
		end
		gc.draw(IMG.batteryImage,73,3)
	end
	setFont(25)
	gc.print(os.date("%H:%M",os.time()),3,-5)
	gc.pop()gc.setCanvas()
end
local function onVirtualkey(x,y)
	local dist,nearest=1e10
	for K=1,#virtualkey do
		local b=virtualkey[K]
		if b.ava then
			local d1=(x-b.x)^2+(y-b.y)^2
			if d1<b.r^2 then
				if d1<dist then
					nearest,dist=K,d1
				end
			end
		end
	end
	return nearest
end
local function onVK_org(x,y)
	local dist,nearest=1e10
	for K=1,#VK_org do
		local b=VK_org[K]
		if b.ava then
			local d1=(x-b.x)^2+(y-b.y)^2
			if d1<b.r^2 then
				if d1<dist then
					nearest,dist=K,d1
				end
			end
		end
	end
	return nearest
end
-------------------------------------------------------------
local floatWheel=0
local function wheelScroll(y)
	if y>0 then
		if floatWheel<0 then floatWheel=0 end
		floatWheel=floatWheel+y^1.2
	elseif y<0 then
		if floatWheel>0 then floatWheel=0 end
		floatWheel=floatWheel-(-y)^1.2
	end
	while floatWheel>=1 do
		love.keypressed("up")
		floatWheel=floatWheel-1
	end
	while floatWheel<=-1 do
		love.keypressed("down")
		floatWheel=floatWheel+1
	end
end
local mouseClick,touchClick={},{}
local mouseDown,mouseMove,mouseUp,wheelMoved={},{},{},{}
local touchDown,touchUp,touchMove={},{},{}
local keyDown,keyUp={},{}
local gamepadDown,gamepadUp={},{}

function keyDown.calculator(k)
	local S=sceneTemp
	if byte(k)>=48 and byte(k)<=57 then
		if S.sym=="="then
			S.val=tonumber(k)
			S.sym=false
		elseif S.sym then
			if not S.reg then
				S.reg=S.val
				S.val=tonumber(k)
			elseif S.val<1e13 then
				S.val=S.val*10+tonumber(k)
			end
		else
			if S.val<1e13 then
				S.val=S.val*10+tonumber(k)
			end
		end
	elseif k=="backspace"then
		if S.val>0 then
			S.val=int(S.val/10)
		end
	elseif k=="+"or k=="="and kb.isDown("rshift","lshift")then
		S.sym="+"
	elseif k=="-"then
		S.sym="-"
	elseif k=="*"or k=="8"and kb.isDown("rshift","lshift")then
		S.sym="*"
	elseif k=="/"then
		S.sym="/"
	elseif k=="return"then
		if S.val then
			if S.sym and S.reg then
				S.val=
					S.sym=="+"and S.reg+S.val or
					S.sym=="-"and S.reg-S.val or
					S.sym=="*"and S.reg*S.val or
					S.sym=="/"and S.reg/S.val or
					-1
			end
			S.sym="="
			S.reg=false
			if S.val==600+20+6 then
				S.pass=true
			elseif S.val==196000+022 then
				S.pass=true
				marking=nil
				TEXT.show("\68\69\86\58\87\97\116\101\114\109\97\114\107\32\82\101\109\111\118\101\100",640,360,60,"stretch",.6)
				SFX.play("clear")
			elseif S.val==72943816 then
				S.pass=true
				for name,M in next,Modes do
					if not modeRanks[name]then
						modeRanks[name]=M.score and 0 or 6
					end
				end
				FILE.saveUnlock()
				TEXT.show("\68\69\86\58\85\78\76\79\67\75\65\76\76",640,360,60,"stretch",.6)
				SFX.play("clear_2")
			elseif S.val==1379e8+2626e4+1379 then
				S.pass=true
				SCN.go("debug")
			elseif S.val==34494 then
				error("This is an error testing message.")
			elseif S.val==114 then
				S.val=514
			elseif S.val==114514 then
				S.reg=1919810
				S.val=114514
			elseif S.val==123456789 then
				S.reg=123456789
				S.val=987654321
			end
		end
	elseif k=="escape"then
		S.val,S.reg,S.sym=0
	elseif k=="delete"then
		S.val=0
	elseif k=="space"and S.pass then
		SCN.swapTo("intro")
	end
end


function keyDown.load(k)
	if k=="a"then
		sceneTemp.skip=true
	elseif k=="s"then
		marking=nil
		sceneTemp.skip=true
	elseif k=="escape"then
		SCN.back()
	end
end
function touchDown.load(id,x,y)
	if #tc.getTouches()==2 then
		sceneTemp.skip=true
	end
end

function mouseDown.intro(x,y,k)
	if k==2 then
		VOC.play("bye")
		SCN.back()
	elseif newVersionLaunch then
		SCN.push("main","fade")
		SCN.swapTo("history","fade")
		TEXT.show(text.newVersion,640,200,30,"fly",.3)
	else
		SCN.go("main")
	end
end
function touchDown.intro(id,x,y)
	mouseDown.intro()
end
function keyDown.intro(key)
	if key=="escape"then
		mouseDown.intro(nil,nil,2)
	else
		mouseDown.intro()
	end
end

local function onMode(x,y)
	local cam=mapCam
	x=(cam.x1-640+x)/cam.k1
	y=(cam.y1-360+y)/cam.k1
	for name,M in next,Modes do
		if modeRanks[name]then
			local s=M.size
			if M.shape==1 then
				if x>M.x-s and x<M.x+s and y>M.y-s and y<M.y+s then return name end
			elseif M.shape==2 then
				if abs(x-M.x)+abs(y-M.y)<s then return name end
			elseif M.shape==3 then
				if(x-M.x)^2+(y-M.y)^2<s^2 then return name end
			end
		end
	end
end
function wheelMoved.mode(x,y)
	local cam=mapCam
	local t=cam.k
	local k=t+y*.1
	if k>1.5 then k=1.5
	elseif k<.3 then k=.3
	end
	t=k/t
	if cam.sel then
		cam.x=(cam.x-180)*t+180;cam.y=cam.y*t
	else
		cam.x=cam.x*t;cam.y=cam.y*t
	end
	cam.k=k
	cam.keyCtrl=false
end
function mouseMove.mode(x,y,dx,dy)
	if ms.isDown(1)then
		mapCam.x,mapCam.y=mapCam.x-dx,mapCam.y-dy
	end
	mapCam.keyCtrl=false
end
function mouseClick.mode(x,y,k)
	local cam=mapCam
	local _=cam.sel
	if not _ or x<920 then
		local SEL=onMode(x,y)
		if _~=SEL then
			if SEL then
				SFX.play("click")
				cam.moving=true
				_=Modes[SEL]
				cam.x=_.x*cam.k+180
				cam.y=_.y*cam.k
				cam.sel=SEL
			else
				cam.sel=nil
				cam.x=cam.x-180
			end
		elseif _ then
			keyDown.mode("return")
		end
	end
	cam.keyCtrl=false
end
function touchMove.mode(id,x,y,dx,dy)
	local L=tc.getTouches()
	if not L[2]then
		mapCam.x,mapCam.y=mapCam.x-dx,mapCam.y-dy
	elseif not L[3]then
		x,y=xOy:inverseTransformPoint(tc.getPosition(L[1]))
		dx,dy=xOy:inverseTransformPoint(tc.getPosition(L[2]))--Not delta!!!
		local d=(x-dx)^2+(y-dy)^2
		if d>100 then
			d=d^.5
			if touchDist then
				wheelMoved.mode(nil,(d-touchDist)*.02)
			end
			touchDist=d
		end
	end
	mapCam.keyCtrl=false
end
function touchClick.mode(x,y,id)
	mouseClick.mode(x,y,1)
end
function keyDown.mode(key)
	if key=="return"then
		if mapCam.sel then
			if mapCam.sel=="custom_clear"or mapCam.sel=="custom_puzzle"then
				if customSel[11]>1 then
					if customSel[7]==5 then
						TEXT.show(text.ai_fixed,640,360,50,"appear")
						return
					elseif #preBag>0 then
						TEXT.show(text.ai_prebag,640,360,50,"appear")
						return
					end
				end
			end
			mapCam.keyCtrl=false
			SCN.push()
			loadGame(mapCam.sel)
		end
	elseif key=="escape"then
		if mapCam.sel then
			mapCam.sel=nil
		else
			SCN.back()
		end
	elseif mapCam.sel=="custom_clear" or mapCam.sel=="custom_puzzle" then
		if key=="e"then
			SCN.go("custom")
		end
	end
end

function wheelMoved.music(x,y)
	if y>0 then
		keyDown.music("up")
	elseif y<0 then
		keyDown.music("down")
	end
end
function keyDown.music(key)
	if key=="down"then
		sceneTemp=sceneTemp%BGM.len+1
	elseif key=="up"then
		sceneTemp=(sceneTemp-2)%BGM.len+1
	elseif key=="return"or key=="space"then
		if BGM.nowPlay~=BGM.list[sceneTemp]then
			SFX.play("click")
			BGM.play(BGM.list[sceneTemp])
		else
			BGM.stop()
		end
	elseif key=="escape"then
		SCN.back()
	end
end

local customSet={
	{3,20,1,1,7,1,1,1,3,4,1,2,3},
	{5,20,1,1,7,1,1,1,8,3,8,3,3},
	{1,22,1,1,7,3,1,1,8,4,1,6,7},
	{3,20,1,1,7,1,1,3,8,3,1,6,8},
	{25,11,8,11,4,1,2,1,8,3,1,4,9},
}
function keyDown.custom(key)
	local sel=sceneTemp
	if key=="up"or key=="w"then
		sceneTemp=(sel-2)%#customID+1
	elseif key=="down"or key=="s"then
		sceneTemp=sel%#customID+1
	elseif key=="left"or key=="a"then
		customSel[sel]=(customSel[sel]-2)%#customRange[customID[sel]]+1
		if sel==12 then
			BG.set(customRange.bg[customSel[12]])
		elseif sel==13 then
			BGM.play(customRange.bgm[customSel[13]])
		end
	elseif key=="right"or key=="d"then
		customSel[sel]=customSel[sel]%#customRange[customID[sel]]+1
		if sel==12 then
			BG.set(customRange.bg[customSel[sel]])
		elseif sel==13 then
			BGM.play(customRange.bgm[customSel[sel]])
		end
	elseif key=="q"then
		SCN.go("sequence")
	elseif key=="e"then
		SCN.swapTo("draw","swipe")
	elseif #key==1 then
		local T=tonumber(key)
		if T and T>=1 and T<=5 then
			for i=1,#customSet[T]do
				customSel[i]=customSet[T][i]
			end
			BG.set(customRange.bg[customSel[12]])
			BGM.play(customRange.bgm[customSel[13]])
		end
	elseif key=="escape"then
		SCN.back()
	end
end

local minoKey={
	["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,
	z=1,s=2,j=3,l=4,t=5,o=6,i=7,
	p=10,q=11,f=12,e=13,u=15,
	v=16,w=17,x=18,r=21,y=22,n=23,h=24,
}
local minoKey2={
	["1"]=8,["2"]=9,["3"]=19,["4"]=20,["5"]=14,["7"]=25,
	z=8,s=9,t=14,j=19,l=20,i=25
}
function keyDown.sequence(key)
	local s=sceneTemp
	if type(key)=="number"then
		local C=s.cur+1
		ins(preBag,C,key)
		s.cur=C
	elseif key=="c"and kb.isDown("lctrl","rctrl")or key=="cC"then
		if #preBag>0 then
			love.system.setClipboardText("Techmino SEQ:"..copySequence())
			TEXT.show(text.copySuccess,640,225,50,"appear",.5)
		end
	elseif key=="v"and kb.isDown("lctrl","rctrl")or key=="cV"then
		local str=love.system.getClipboardText()
		local p=string.find(str,":")--ptr*
		if p then str=string.sub(str,p+1)end
		if not pasteSequence(str)then
			TEXT.show(text.dataCorrupted,640,225,45,"flicker",.5)
		end
	elseif #key==1 then
		local i=(kb.isDown("lshift","lalt","rshift","ralt")and minoKey2 or minoKey)[key]
		if i then
			local C=s.cur+1
			ins(preBag,C,i)
			s.cur=C
		end
	else
		if key=="left"then
			if s.cur>0 then s.cur=s.cur-1 end
		elseif key=="right"then
			if s.cur<#preBag then s.cur=s.cur+1 end
		elseif key=="backspace"then
			local C=s.cur
			if C>0 then
				rem(preBag,C)
				s.cur=C-1
			end
		elseif key=="escape"then
			SCN.back()
		elseif key=="delete"then
			if sceneTemp.sure>20 then
				preBag={}
				sceneTemp.cur=0
				sceneTemp.sure=0
				SFX.play("finesseError",.7)
			else
				sceneTemp.sure=50
			end
		end
	end
end

function mouseDown.draw(x,y,k)
	mouseMove.draw(x,y)
end
function mouseMove.draw(x,y,dx,dy)
	local sx,sy=int((x-200)/30)+1,20-int((y-60)/30)
	if sx<1 or sx>10 then sx=nil end
	if sy<1 or sy>20 then sy=nil end
	sceneTemp.x,sceneTemp.y=sx,sy
	if sx and sy and ms.isDown(1,2,3)then
		preField[sy][sx]=ms.isDown(1)and sceneTemp.pen or ms.isDown(2)and -1 or 0
	end
end
function wheelMoved.draw(x,y)
	local pen=sceneTemp.pen
	if y<0 then
		pen=pen+1
		if pen==8 then pen=9 elseif pen==14 then pen=0 end
	else
		pen=pen-1
		if pen==8 then pen=7 elseif pen==-1 then pen=13 end
	end
	sceneTemp.pen=pen
end
function touchDown.draw(id,x,y)
	mouseMove.draw(x,y)
end
function touchMove.draw(id,x,y,dx,dy)
	local sx,sy=int((x-200)/30)+1,20-int((y-60)/30)
	if sx<1 or sx>10 then sx=nil end
	if sy<1 or sy>20 then sy=nil end
	sceneTemp.x,sceneTemp.y=sx,sy
	if sx and sy then
		preField[sy][sx]=sceneTemp.pen
	end
end
local penKey={
	q=1,w=2,e=3,r=4,t=5,y=6,u=7,i=8,o=9,p=10,["["]=11,
	a=12,s=13,d=14,f=15,g=16,h=17,
	z=0,x=-1,
}
function keyDown.draw(key)
	local sx,sy,pen=sceneTemp.x,sceneTemp.y,sceneTemp.pen
	if key=="up"or key=="down"or key=="left"or key=="right"then
		if not sx then sx=1 end
		if not sy then sy=1 end
		if key=="up"and sy<20 then sy=sy+1
		elseif key=="down"and sy>1 then sy=sy-1
		elseif key=="left"and sx>1 then sx=sx-1
		elseif key=="right"and sx<10 then sx=sx+1
		end
		if kb.isDown("space")then
			preField[sy][sx]=pen
		end
	elseif key=="delete"then
		if sceneTemp.sure>20 then
			for y=1,20 do for x=1,10 do preField[y][x]=0 end end
			sceneTemp.sure=0
			SFX.play("finesseError",.7)
		else
			sceneTemp.sure=50
		end
	elseif key=="space"then
		if sx and sy then
			preField[sy][sx]=pen
		end
	elseif key=="e"then
		SCN.swapTo("custom","swipe")
	elseif key=="escape"then
		SCN.back()
	elseif key=="c"and kb.isDown("lctrl","rctrl")or key=="cC"then
		love.system.setClipboardText("Techmino Field:"..copyBoard())
		TEXT.show(text.copySuccess,350,360,40,"appear",.5)
	elseif key=="v"and kb.isDown("lctrl","rctrl")or key=="cV"then
		local str=love.system.getClipboardText()
		local p=string.find(str,":")--ptr*
		if p then str=string.sub(str,p+1)end
		if not pasteBoard(str)then
			TEXT.show(text.dataCorrupted,350,360,35,"flicker",.5)
		end
	else
		pen=penKey[key]or pen
	end
	sceneTemp.x,sceneTemp.y,sceneTemp.pen=sx,sy,pen
end

function mouseDown.setting_sound(x,y,k)
	local s=sceneTemp
	if x>780 and x<980 and y>470 and s.jump==0 then
		s.jump=10
		local t=Timer()-s.last
		if t>1 then
			VOC.play((t<1.5 or t>15)and"doubt"or rnd()<.8 and"happy"or"egg")
			s.last=Timer()
		end
	end
end
function touchDown.setting_sound(id,x,y)
	mouseDown.setting_sound(x,y)
end

function keyDown.setting_key(key)
	local s=sceneTemp
	if key=="escape"then
		if s.kS then
			s.kS=false
			SFX.play("finesseError",.5)
		else
			SCN.back()
		end
	elseif s.kS then
		for y=1,20 do
			if keyMap[1][y]==key then keyMap[1][y]=""break end
			if keyMap[2][y]==key then keyMap[2][y]=""break end
		end
		keyMap[s.board][s.kb]=key
		SFX.play("reach",.5)
		s.kS=false
	elseif key=="return"or key=="space"then
		s.kS=true
		SFX.play("lock",.5)
	elseif key=="up"or key=="w"then
		if s.kb>1 then
			s.kb=s.kb-1
			SFX.play("move",.5)
		end
	elseif key=="down"or key=="s"then
		if s.kb<20 then
			s.kb=s.kb+1
			SFX.play("move",.5)
		end
	elseif key=="left"or key=="a"or key=="right"or key=="d"then
		s.board=3-s.board
		SFX.play("rotate",.5)
	end
end
function gamepadDown.setting_key(key)
	local s=sceneTemp
	if key=="back"then
		if s.jS then
			s.jS=false
			SFX.play("finesseError",.5)
		else
			SCN.back()
		end
	elseif s.jS then
		for y=1,20 do
			if keyMap[3][y]==key then keyMap[3][y]=""break end
			if keyMap[4][y]==key then keyMap[4][y]=""break end
		end
		keyMap[2+s.board][s.js]=key
		SFX.play("reach",.5)
		s.jS=false
	elseif key=="start"then
		s.jS=true
		SFX.play("lock",.5)
	elseif key=="dpup"then
		if s.js>1 then
			s.js=s.js-1
			SFX.play("move",.5)
		end
	elseif key=="dpdown"then
		if s.js<20 then
			s.js=s.js+1
			SFX.play("move",.5)
		end
	elseif key=="dpleft"or key=="dpright"then
		s.board=3-s.board
		SFX.play("rotate",.5)
	end
end

function mouseDown.setting_touch(x,y,k)
	if k==2 then SCN.back()end
	sceneTemp.sel=onVK_org(x,y)or sceneTemp.sel
end
function mouseMove.setting_touch(x,y,dx,dy)
	if sceneTemp.sel and ms.isDown(1)and not WIDGET.sel then
		local B=VK_org[sceneTemp.sel]
		B.x,B.y=B.x+dx,B.y+dy
	end
end
function mouseUp.setting_touch(x,y,k)
	if sceneTemp.sel then
		local B=VK_org[sceneTemp.sel]
		local k=snapLevelValue[sceneTemp.snap]
		B.x,B.y=int(B.x/k+.5)*k,int(B.y/k+.5)*k
	end
end
function touchDown.setting_touch(id,x,y)
	sceneTemp.sel=onVK_org(x,y)or sceneTemp.sel
end
function touchUp.setting_touch(id,x,y)
	if sceneTemp.sel then
		local B=VK_org[sceneTemp.sel]
		local k=snapLevelValue[sceneTemp.snap]
		B.x,B.y=int(B.x/k+.5)*k,int(B.y/k+.5)*k
	end
end
function touchMove.setting_touch(id,x,y,dx,dy)
	if sceneTemp.sel and not WIDGET.sel then
		local B=VK_org[sceneTemp.sel]
		B.x,B.y=B.x+dx,B.y+dy
	end
end

function keyDown.pause(key)
	if key=="q"then
		SCN.back()
	elseif key=="escape"then
		resumeGame()
	elseif key=="s"then
		SCN.go("setting_sound")
	elseif key=="r"then
		TASK.clear("play")
		resetGameData()
		SCN.swapTo("play","none")
	elseif key=="p"and(game.result or game.replaying)then
		TASK.removeTask_code(TICK.autoPause)
		resetPartGameData(true)
		SCN.swapTo("play","none")
	end
end

function touchDown.play(id,x,y)
	if not setting.VKSwitch or game.replaying then return end

	local t=onVirtualkey(x,y)
	if t then
		players[1]:pressKey(t)
		if setting.VKSFX>0 then
			SFX.play("virtualKey",setting.VKSFX*.25)
		end
		virtualkey[t].isDown=true
		virtualkey[t].pressTime=10
		if setting.VKTrack then
			local B=virtualkey[t]
			if setting.VKDodge then--Button collision (not accurate)
			for i=1,#virtualkey do
					local b=virtualkey[i]
					local d=B.r+b.r-((B.x-b.x)^2+(B.y-b.y)^2)^.5--Hit depth(Neg means distance)
					if d>0 then
						b.x=b.x+(b.x-B.x)*d*b.r*5e-4
						b.y=b.y+(b.y-B.y)*d*b.r*5e-4
					end
				end
			end
			local O=VK_org[t]
			local _FW,_CW=setting.VKTchW*.1,1-setting.VKCurW*.1
			local _OW=1-_FW-_CW

			--Auto follow: finger, current, origin (weight from setting)
			B.x,B.y=x*_FW+B.x*_CW+O.x*_OW,y*_FW+B.y*_CW+O.y*_OW
		end
		VIB(setting.VKVIB)
	end
end
function touchUp.play(id,x,y)
	if not setting.VKSwitch or game.replaying then return end

	local t=onVirtualkey(x,y)
	if t then
		players[1]:releaseKey(t)
	end
end
function touchMove.play(id,x,y,dx,dy)
	if not setting.VKSwitch or game.replaying then return end

	local l=tc.getTouches()
	for n=1,#virtualkey do
		local B=virtualkey[n]
		for i=1,#l do
			local x,y=xOy:inverseTransformPoint(tc.getPosition(l[i]))
			if(x-B.x)^2+(y-B.y)^2<=B.r^2 then
				goto next
			end
		end
		players[1]:releaseKey(n)
		::next::
	end
end
function keyDown.play(key)
	if key=="escape"then
		pauseGame()
		return
	end
	if game.replaying then return end
	local m=keyMap
	for k=1,20 do
		if key==m[1][k]or key==m[2][k]then
			players[1]:pressKey(k)
			virtualkey[k].isDown=true
			virtualkey[k].pressTime=10
			return
		end
	end
end
function keyUp.play(key)
	if game.replaying then return end
	local m=keyMap
	for k=1,20 do
		if key==m[1][k]or key==m[2][k]then
			players[1]:releaseKey(k)
			virtualkey[k].isDown=false
			return
		end
	end
end
function gamepadDown.play(key)
	if key=="back"then SCN.back()return end
	if game.replaying then return end

	local m=keyMap
	for k=1,20 do
		if key==m[3][k]or key==m[4][k]then
			players[1]:pressKey(k)
			virtualkey[k].isDown=true
			virtualkey[k].pressTime=10
			return
		end
	end
end
function gamepadUp.play(key)
	if game.replaying then return end

	local m=keyMap
	for k=1,20 do
		if key==m[3][k]or key==m[4][k]then
			players[1]:releaseKey(k)
			virtualkey[k].isDown=false
			return
		end
	end
end

function wheelMoved.history(x,y)
	wheelScroll(y)
end
function keyDown.history(key)
	if key=="up"then
		sceneTemp.pos=max(sceneTemp.pos-1,1)
	elseif key=="down"then
		sceneTemp.pos=min(sceneTemp.pos+1,#sceneTemp.text)
	elseif key=="escape"then
		SCN.back()
	end
end
-------------------------------------------------------------
local lastX,lastY=0,0--Last clickDown pos
function love.mousepressed(x,y,k,touch,num)
	if touch then return end
	mouseShow=true
	mx,my=xOy:inverseTransformPoint(x,y)
	if devMode==1 then DBP(mx,my)end
	if SCN.swapping then return end
	if mouseDown[SCN.cur]then
		mouseDown[SCN.cur](mx,my,k)
	elseif k==2 then
		SCN.back()
	end
	if k==1 then
		WIDGET.press(mx,my)
	end
	lastX,lastY=mx,my
	sysFX.newRipple(.3,mx,my,30)
end
function love.mousemoved(x,y,dx,dy,t)
	if t then return end
	mouseShow=true
	mx,my=xOy:inverseTransformPoint(x,y)
	if SCN.swapping then return end
	dx,dy=dx/scr.k,dy/scr.k
	if mouseMove[SCN.cur]then
		mouseMove[SCN.cur](mx,my,dx,dy)
	end
	if ms.isDown(1) then
		WIDGET.drag(mx,my,dx,dy)
	else
		WIDGET.moveCursor(mx,my)
	end
end
function love.mousereleased(x,y,k,touch,num)
	if touch or SCN.swapping then return end
	mx,my=xOy:inverseTransformPoint(x,y)
	if mouseUp[SCN.cur]then
		mouseUp[SCN.cur](mx,my,k)
	end
	if lastX and(mx-lastX)^2+(my-lastY)^2<26 and mouseClick[SCN.cur]then
		mouseClick[SCN.cur](mx,my,k)
	end
end
function love.wheelmoved(x,y)
	if SCN.swapping then return end
	if wheelMoved[SCN.cur]then wheelMoved[SCN.cur](x,y)end
end

function love.touchpressed(id,x,y)
	mouseShow=false
	if SCN.swapping then return end
	if not touching then
		touching=id
		love.touchmoved(id,x,y,0,0)
	end
	touchDist=nil--Reset distance
	x,y=xOy:inverseTransformPoint(x,y)
	lastX,lastY=x,y
	if touchDown[SCN.cur]then
		touchDown[SCN.cur](id,x,y)
	end
end
function love.touchmoved(id,x,y,dx,dy)
	if SCN.swapping then return end
	x,y=xOy:inverseTransformPoint(x,y)
	if touchMove[SCN.cur]then
		touchMove[SCN.cur](id,x,y,dx/scr.k,dy/scr.k)
	end
	if WIDGET.sel then
		if touching then
			WIDGET.drag(x,y,dx,dy)
		end
	else
		WIDGET.moveCursor(x,y)
		if not WIDGET.sel then
			touching=nil
		end
	end
end
function love.touchreleased(id,x,y)
	if SCN.swapping then return end
	x,y=xOy:inverseTransformPoint(x,y)
	if id==touching then
		WIDGET.press(x,y)
		touching=nil
		WIDGET.sel=nil
	end
	if touchUp[SCN.cur]then
		touchUp[SCN.cur](id,x,y)
	end
	if(x-lastX)^2+(y-lastY)^2<26 then
		if touchClick[SCN.cur]then
			touchClick[SCN.cur](x,y,k)
		end
		sysFX.newRipple(.3,x,y,30)
	end
end
function love.keypressed(i)
	mouseShow=false
	if devMode then
		if i=="f5"then
			DBP("DEBUG:")
		elseif i=="f8"then	devMode=nil	TEXT.show("DEBUG OFF",640,360,80,"fly",.8)
		elseif i=="f9"then	devMode=1	TEXT.show("DEBUG 1",640,360,80,"fly",.8)
		elseif i=="f10"then	devMode=2	TEXT.show("DEBUG 2",640,360,80,"fly",.8)
		elseif i=="f11"then	devMode=3	TEXT.show("DEBUG 3",640,360,80,"fly",8)
		elseif i=="f12"then	devMode=4	TEXT.show("DEBUG 4",640,360,80,"fly",12)
		elseif devMode==2 then
			if i=="k"then
				for i=1,8 do
					local P=players.alive[rnd(#players.alive)]
					if P~=players[1]then
						P.lastRecv=players[1]
						P:lose()
					end
				end
			elseif i=="q"then
				local W=WIDGET.sel
				if W then W:getInfo()end
			elseif i=="f3"then
				assert(false,"Techmino:挂了")
			elseif i=="e"then
				for k,v in next,_G do
				DBP(k,v)
				end
			elseif WIDGET.sel then
				local W=WIDGET.sel
				if i=="left"then W.x=W.x-10
				elseif i=="right"then W.x=W.x+10
				elseif i=="up"then W.y=W.y-10
				elseif i=="down"then W.y=W.y+10
				elseif i==","then W.w=W.w-10
				elseif i=="."then W.w=W.w+10
				elseif i=="/"then W.h=W.h-10
				elseif i=="'"then W.h=W.h+10
				elseif i=="["then W.font=W.font-1
				elseif i=="]"then W.font=W.font+1
				end
			end
		else
			goto NORMAL
		end
		return
	end
	::NORMAL::
	if i~="f8"then
		if SCN.swapping then return end

		if keyDown[SCN.cur]then keyDown[SCN.cur](i)
		elseif i=="escape"then SCN.back()
		else WIDGET.keyPressed(i)
		end
	else
		devMode=1
		TEXT.show("DEBUG ON",640,360,80,"fly",.8)
	end
end
function love.keyreleased(i)
	if SCN.swapping then return end
	if keyUp[SCN.cur]then keyUp[SCN.cur](i)end
end

function love.joystickadded(JS)
	joysticks[#joysticks+1]=JS
end
function love.joystickremoved(JS)
	for i=1,#joysticks do
		if joysticks[i]==JS then
			rem(joysticks,i)
			return
		end
	end
end
local keyMirror={
	dpup="up",
	dpdown="down",
	dpleft="left",
	dpright="right",
	start="return",
	back="escape",
}
function love.gamepadpressed(joystick,i)
	mouseShow=false
	if SCN.swapping then return end
	if gamepadDown[SCN.cur]then gamepadDown[SCN.cur](i)
	elseif keyDown[SCN.cur]then keyDown[SCN.cur](keyMirror[i]or i)
	elseif i=="back"then SCN.back()
	else WIDGET.gamepadPressed(i)
	end
end
function love.gamepadreleased(joystick,i)
	if SCN.swapping then return end
	if gamepadUp[SCN.cur]then gamepadUp[SCN.cur](i)
	end
end
--[[
function love.joystickpressed(JS,k)
	mouseShow=false
	if SCN.swapping then return end
	if gamepadDown[SCN.cur]then gamepadDown[SCN.cur](i)
	elseif keyDown[SCN.cur]then keyDown[SCN.cur](keyMirror[i]or i)
	elseif i=="back"then SCN.back()
	else WIDGET.gamepadPressed(i)
	end
end
function love.joystickreleased(JS,k)
	if SCN.swapping then return end
	if gamepadUp[SCN.cur]then gamepadUp[SCN.cur](i)
	end
end
function love.joystickaxis(JS,axis,val)

end
function love.joystickhat(JS,hat,dir)

end
function love.sendData(data)end
function love.receiveData(id,data)end
]]
function love.lowmemory()
	collectgarbage()
end
function love.resize(w,h)
	scr.w,scr.h,scr.dpi=w,h,gc.getDPIScale()
	scr.W,scr.H=scr.w*scr.dpi,scr.h*scr.dpi
	scr.r=h/w
	scr.rad=(w^2+h^2)^.5

	if scr.r>=.5625 then
		scr.k=w/1280
		scr.x,scr.y=0,(h-w*9/16)*.5
	else
		scr.k=h/720
		scr.x,scr.y=(w-h*16/9)*.5,0
	end
	xOy=xOy:setTransformation(w*.5,h*.5,nil,scr.k,nil,640,360)
	BG.resize(w,h)

	SHADER.warning:send("w",w*scr.dpi)
	SHADER.warning:send("h",h*scr.dpi)
end
function love.focus(f)
	if f then
		love.timer.step()
	elseif SCN.cur=="play"and setting.autoPause then
		pauseGame()
	end
end
function love.errorhandler(msg)
	local PUMP,POLL=love.event.pump,love.event.poll
	love.mouse.setVisible(true)
	love.audio.stop()
	local err={"Error:"..msg}
	local trace=debug.traceback("",2)
	local c=2
	for l in string.gmatch(trace,"(.-)\n")do
		if c>2 then
			if not string.find(l,"boot")then
				err[c]=string.gsub(l,"^\t*","")
				c=c+1
			end
		else
			err[2]="Traceback"
			c=3
		end
	end
	print(table.concat(err,"\n"),1,c-2)
	gc.reset()
	local CAP
	local function _(_)CAP=gc.newImage(_)end
	gc.captureScreenshot(_)
	gc.present()
	setting.sfx=setting.voc--only for error "voice" played with voice volume,not saved
	if SFX.list.error then SFX.play("error",.8)end
	local BGcolor=rnd()>.026 and{.3,.5,.9}or{.62,.3,.926}
	local needDraw=true
	return function()
		PUMP()
		for E,a,b,c,d,e in POLL()do
			if E=="quit"or a=="escape"then
				destroyPlayers()
				return 1
			elseif E=="resize"then
				love.resize(a,b)
				needDraw=true
			elseif E=="focus"then
				needDraw=true
			end
		end
		if needDraw then
			gc.discard()
			gc.clear(BGcolor)
			gc.setColor(1,1,1)
			gc.push("transform")
			gc.replaceTransform(xOy)
			gc.draw(CAP,100,365,nil,512/CAP:getWidth(),288/CAP:getHeight())
			setFont(120)gc.print(":(",100,40)
			setFont(38)gc.printf(text.errorMsg,100,200,1280-100)
			setFont(20)
			gc.print(system.."-"..gameVersion,100,660)
			gc.print("scene:"..SCN.cur,400,660)
			gc.printf(err[1],626,360,1260-626)
			gc.print("TRACEBACK",626,426)
			for i=4,#err-2 do
				gc.print(err[i],626,370+20*i)
			end
			gc.pop()
			gc.present()
			needDraw=false
		end
		love.timer.sleep(.2)
	end
end
local scs={.5,1.5,.5,1.5,.5,1.5,.5,1.5,.5,1.5,1,1,0,2}
local devColor={
	color.white,
	color.lMagenta,
	color.lGreen,
	color.lBlue,
}
local FPS=love.timer.getFPS
love.draw,love.update=nil
function love.run()
	local T=love.timer
	local STEP,GETDelta,WAIT=T.step,T.getDelta,T.sleep
	local mini=love.window.isMinimized
	local PUMP,POLL=love.event.pump,love.event.poll

	local waitTime=1/60
	local LIST={}

	local lastFrame=Timer()
	local lastFreshPow=lastFrame
	local FCT=0--Framedraw counter

	love.resize(gc.getWidth(),gc.getHeight())
	SCN.init("load")--Scene Launch
	marking=true

	return function()
		local _

		lastFrame=Timer()

		--EVENT
		PUMP()
		for N,a,b,c,d,e in POLL()do
			if love[N]then
				love[N](a,b,c,d,e)
			elseif N=="quit"then
				destroyPlayers()
				return 1
			end
		end

		--UPDATE
		STEP()
		local dt=GETDelta()
		TASK.update()
		VOC.update()
		BG.update(dt)
		sysFX.update(dt)
		TEXT.update()
		_=Tmr[SCN.cur]if _ then _(dt)end--Scene Updater
		if SCN.swapping then SCN.swapUpdate()end--Scene swapping animation
		WIDGET.update()--Widgets animation

		--DRAW
		if not mini()then
			FCT=FCT+setting.frameMul
			if FCT>=100 then
				FCT=FCT-100
				gc.discard()--SPEED UPUPUP!

				BG.draw()
				gc.push("transform")
					gc.replaceTransform(xOy)

					--Draw scene contents
					if Pnt[SCN.cur]then Pnt[SCN.cur]()end

					--Draw widgets
					WIDGET.draw()

					--Draw cursor
					if mouseShow then
						local r=Timer()*.5
						local R=int(r)%7+1
						_=SKIN.libColor[setting.skin[R]]
						gc.setColor(_[1],_[2],_[3],min(1-abs(1-r%1*2),.3))
						gc.draw(TEXTURE.miniBlock[R],mx,my,Timer()%3.1416*4,20,20,scs[2*R],#blocks[R][0]-scs[2*R-1])
						gc.setColor(1,1,1,.5)gc.circle("fill",mx,my,5)
						gc.setColor(1,1,1)gc.circle("fill",mx,my,3)
					end
					sysFX.draw()
					TEXT.draw()
				gc.pop()

				--Draw power info.
				gc.setColor(1,1,1)
				if setting.powerInfo then
					gc.draw(infoCanvas,0,0,0,scr.k)
				end

				--Draw scene swapping animation
				if SCN.swapping then
					_=SCN.stat
					_.draw(_.time)
				end

				--Draw FPS
				gc.setColor(1,1,1)
				setFont(15)
				_=scr.h-20
				gc.print(FPS(),5,_)

				--Debug info.
				if devMode then
					gc.setColor(devColor[devMode])
					gc.print("Memory:"..gcinfo(),5,_-20)
					gc.print("Lines:"..freeRow.getCount(),5,_-40)
					gc.print("Cursor:"..mx.." "..my,5,_-60)
					gc.print("Voices:"..VOC.getCount(),5,_-80)
					gc.print("Tasks:"..TASK.getCount(),5,_-100)
					ins(LIST,1,dt)rem(LIST,126)
					for i=1,#LIST do
						gc.rectangle("fill",900+2*i,_,2,-LIST[i]*4000)
					end
					if devMode==3 then WAIT(.1)
					elseif devMode==4 then WAIT(.5)
					end
				end

				gc.present()
			end
		end

		--Fresh power info.
		if Timer()-lastFreshPow>2 and setting.powerInfo and loadingFinished then
			updatePowerInfo()
			lastFreshPow=Timer()
			if gc.getWidth()~=scr.w then
				love.resize(gc.getWidth(),gc.getHeight())
				TEXT.show("resized",200,100,30,"stretch")
			end
		end

		--Keep 60fps
		_=Timer()-lastFrame
		if _<.016 then WAIT(.016-_)end
		while Timer()-lastFrame<1/60-0.000005 do WAIT(0)end
	end
end
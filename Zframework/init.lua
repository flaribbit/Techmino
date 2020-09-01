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

local ms=love.mouse
local gc=love.graphics
local Timer=love.timer.getTime
local int,rnd,abs=math.floor,math.random,math.abs
local max,min=math.max,math.min
local ins,rem=table.insert,table.remove
local scr=scr

local mx,my,mouseShow=-20,-20,false
local touching=nil--First touching ID(userdata)
xOy=love.math.newTransform()
joysticks={}

local devMode

local infoCanvas=gc.newCanvas(108,27)
local function updatePowerInfo()
	local state,pow=love.system.getPowerInfo()
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
-------------------------------------------------------------
Tmr,Pnt={},{}
mouseClick,touchClick={},{}
mouseDown,mouseMove,mouseUp,wheelMoved={},{},{},{}
touchDown,touchUp,touchMove={},{},{}
keyDown,keyUp={},{}
gamepadDown,gamepadUp={},{}

local Tmr,Pnt=Tmr,Pnt
local mouseClick,touchClick=mouseClick,touchClick
local mouseDown,mouseMove,mouseUp,wheelMoved=mouseDown,mouseMove,mouseUp,wheelMoved
local touchDown,touchUp,touchMove=touchDown,touchUp,touchMove
local keyDown,keyUp=keyDown,keyUp
local gamepadDown,gamepadUp=gamepadDown,gamepadUp
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
	WIDGET.release(mx,my)
	WIDGET.moveCursor(mx,my)
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
		WIDGET.release(x,y)
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
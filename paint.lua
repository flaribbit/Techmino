local gc=love.graphics
local setFont=setFont
local int,abs,rnd,max,min,sin=math.floor,math.abs,math.random,math.max,math.min,math.sin
local format=string.format

local Timer=love.timer.getTime
local scr=scr
local modeRankColor={
	[0]=color.darkGrey,	--Not pass
	color.bronze,		--Rank1
	color.lightGrey,	--Rank2
	color.lightYellow,	--Rank3
	color.lightMagenta,	--Rank4
	color.lightCyan,	--Rank5
	color.purple,		--Special
}
local miniTitle_rect={
	{2,0,5,1},{4,1,1,6},
	{9,0,4,1},{9,3,4,1},{9,6,4,1},{8,0,1,7},
	{15,0,3,1},{15,6,3,1},{14,0,1,7},
	{19,0,1,7},{23,0,1,7},{20,3,3,1},
	{0,8,1,6},{6,8,1,6},{1,9,1,1},{2,10,1,1},{3,11,1,1},{4,10,1,1},{5,9,1,1},
	{8,8,5,1},{8,13,5,1},{10,9,1,4},
	{14,8,1,6},{19,8,1,6},{15,9,1,1},{16,10,1,1},{17,11,1,1},{18,12,1,1},
	{21,8,5,1},{21,13,5,1},{21,9,1,4},{25,9,1,4},
}
local function stencil_miniTitle()
	for i=1,#miniTitle_rect do
		local a,b,c,d=unpack(miniTitle_rect[i])
		gc.rectangle("fill",250+a*30,150+b*30,c*30,d*30)
	end
end

FX_BGblock={tm=150,next=7,ct=0,list={}}--Falling tetrominos on background
for _=1,16 do FX_BGblock.list[_]={v=0}end
FX_attack={}--Attack beam
FX_badge={}--Badge thrown
sysFX={}
local function drawAtkPointer(x,y)
	local t=sin(Timer()*20)
	gc.setColor(.2,.7+t*.2,1,.6+t*.4)
	gc.circle("fill",x,y,25,6)
	local a=Timer()*3%1*.8
	gc.setColor(0,.6,1,.8-a)
	gc.circle("line",x,y,30*(1+a),6)
end
local function VirtualkeyPreview()
	if setting.VKSwitch then
		for i=1,#VK_org do
			local B=VK_org[i]
			if B.ava then
				local c=sceneTemp.sel==i and .6 or 1
				gc.setColor(c,1,c,setting.VKAlpha*.1)
				gc.setLineWidth(B.r*.07)
				gc.circle("line",B.x,B.y,B.r)
				if setting.VKIcon then gc.draw(VKIcon[i],B.x,B.y,nil,B.r*.025,nil,18,18)end
			end
		end
	end
end
local function drawVirtualkey()
	local a=setting.VKAlpha*.1
	for i=1,#virtualkey do
		if i~=9 or modeEnv.Fkey then
			local B=virtualkey[i]
			if B.ava then
				local _=virtualkeyDown[i]and gc.setColor(.7,.7,.7,a)or gc.setColor(1,1,1,a)--Dark magic
				gc.setLineWidth(B.r*.07)
				local ΔY=virtualkeyPressTime[i]
				gc.circle("line",B.x,B.y+ΔY,B.r)--Outline circle
				if setting.VKIcon then
					gc.draw(VKIcon[i],B.x,B.y+ΔY,nil,B.r*.025,nil,18,18)
				end--Icon
				if ΔY>0 then
					gc.setColor(1,1,1,a*ΔY*.1)
					gc.circle("line",B.x,B.y,B.r*(1.4-ΔY*.04))
				end--Ripple
			end
		end
	end
end

local Pnt={BG={}}
function Pnt.BG.none()
	gc.clear(.15,.15,.15)
end
function Pnt.BG.grey()
	gc.clear(.3,.3,.3)
end
function Pnt.BG.lightGrey()
	gc.clear(.5,.5,.5)
end
function Pnt.BG.glow()
	local t=((sin(Timer()*.5)+sin(Timer()*.7)+sin(Timer()*.9+1)+sin(Timer()*1.5)+sin(Timer()*2+3))+5)*.05
	gc.clear(t,t,t)
end
function Pnt.BG.rgb()
	gc.clear(
		sin(Timer()*1.2)*.15+.5,
		sin(Timer()*1.5)*.15+.5,
		sin(Timer()*1.9)*.15+.5
	)
end
function Pnt.BG.strap()
	gc.setColor(1,1,1)
	local x=Timer()%32*40
	gc.draw(background2,x,0,nil,10)
	gc.draw(background2,x-1280,0,nil,10)
end
function Pnt.BG.flink()
	local t=.13-Timer()%3%1.7
	if t<.25 then
		gc.clear(t,t,t)
	else
		gc.clear(0,0,0)
	end
end
function Pnt.BG.game1()
	gc.setColor(1,1,1)
	gc.draw(background1,640,360,Timer()*.15,12,nil,64,64)
end--Rainbow
function Pnt.BG.game2()
	gc.setColor(1,.5,.5)
	gc.draw(background1,640,360,Timer()*.2,12,nil,64,64)
end--Red rainbow
function Pnt.BG.game3()
	gc.setColor(.6,.6,1)
	gc.draw(background1,640,360,Timer()*.25,12,nil,64,64)
end--Blue rainbow
function Pnt.BG.game4()
	gc.setColor(.1,.5,.5)
	local x=Timer()%4*320
	gc.draw(background2,x,0,nil,10)
	gc.draw(background2,x-1280,0,nil,10)
end--Fast strap
function Pnt.BG.game5()
	local t=2.5-Timer()%20%6%2.5
	if t<.5 then gc.clear(t,t,t)
	else gc.clear(0,0,0)
	end
end--Lightning
local scs={1,2,1,2,1,2,1,2,1,2,1.5,1.5,.5,2.5}
function Pnt.BG.game6()
	local t=1.2-Timer()%10%3%1.2
	if t<.5 then gc.clear(t,t,t)
	else gc.clear(0,0,0)
	end
	gc.setColor(.3,.3,.3)
	local r=7-int(Timer()*.5)%7
	gc.draw(miniBlock[r],640,360,Timer()%3.1416*6,400,400,scs[2*r]-.5,#blocks[r][0]-scs[2*r-1]+.5)
end--Fast lightning&spining tetromino
local matrixT={}for i=0,15 do matrixT[i]={}for j=0,8 do matrixT[i][j]=love.math.noise(i,j)+2 end end
function Pnt.BG.matrix()
	gc.clear(.15,.15,.15)
	for i=0,15 do
		for j=0,8 do
			local t=sin(matrixT[i][j]*Timer())*.2+.2
			gc.setColor(1,1,1,t)
			gc.rectangle("fill",80*i,80*j,80,80)
		end
	end
end

function Pnt.load()
	local L=loading
	gc.setLineWidth(4)
	gc.setColor(1,1,1,.5)
	gc.rectangle("fill",300,330,L[2]/L[3]*680,60,5)
	gc.setColor(1,1,1)
	gc.rectangle("line",300,330,680,60,5)
	setFont(35)
	gc.print(text.load[L[1]],340,335)
	if loading[1]~=0 then
		gc.printf(loading[2].."/"..loading[3],795,335,150,"right")
	end
	setFont(25)
	mStr(L[4],640,400)
end
function Pnt.intro()
	gc.stencil(stencil_miniTitle,"replace",1)
	gc.setStencilTest("equal",1)
		gc.setColor(1,1,1,min(sceneTemp,80)*.005)
		gc.push("transform")
			gc.translate(250,150)
			gc.scale(30)
			gc.rectangle("fill",0,0,26,14)
		gc.pop()
		gc.setColor(1,1,1,.06)
		for i=41,5,-2 do
			gc.setLineWidth(i)
			gc.line(200+(sceneTemp-80)*25,130,(sceneTemp-80)*25,590)
		end
	gc.setStencilTest()
end
function Pnt.main()
	gc.setColor(1,1,1)
	gc.draw(coloredTitleImage,60,30,nil,1.3)
	gc.draw(drawableText.warning,595-drawableText.warning:getWidth(),128)
	setFont(30)
	gc.print(gameVersion,70,125)
	gc.print(system,610,100)
	players[1]:draw()
end
function Pnt.mode()
	local cam=mapCam
	gc.push("transform")
	gc.translate(640,360)
	gc.scale(cam.zoomK)
	gc.translate(-cam.x1,-cam.y1)
	gc.scale(cam.k1)
	local MM,R=modes,modeRanks
	for _=1,#MM do
		local M=MM[_]
		if R[_]then
			gc.setLineWidth(8)
			gc.setColor(1,1,1,.15)
			for _=1,#M.unlock do
				local m=M.unlock[_]
				if R[m]then
					m=MM[m]
					gc.line(M.x,M.y,m.x,m.y)
				end
			end

			local S=M.size
			local d=((M.x-(cam.x1-180)/cam.k1)^2+(M.y-cam.y1/cam.k1)^2)^.5
			if d<600 then S=S*(1.3-d*0.0005) end
			gc.setColor(modeRankColor[modeRanks[M.id]])
			if M.shape==1 then--Rectangle
				gc.rectangle("fill",M.x-S,M.y-S,2*S,2*S)
				if cam.sel==_ then
					gc.setColor(1,1,1)
					gc.setLineWidth(10)
					gc.rectangle("line",M.x-S+5,M.y-S+5,2*S-10,2*S-10)
				end
			elseif M.shape==2 then--Octagon
				gc.circle("fill",M.x,M.y,S,8)
				if cam.sel==_ then
					gc.setColor(1,1,1)
					gc.setLineWidth(10)
					gc.circle("line",M.x,M.y,S-5,8)
				end
			end
		end
	end
	gc.pop()
	if cam.sel then
		local M=MM[cam.sel]
		local lang=setting.lang
		gc.setColor(.6,.6,.6,.5)
		gc.rectangle("fill",920,0,360,720)--Info board
		gc.setColor(M.color)
		setFont(40)
		mStr(M.name[lang],1030,5)
		setFont(30)
		mStr(M.level[lang],1030,50)
		gc.setColor(1,1,1)
		setFont(30)
		gc.printf(M.info[lang],1100-180,130,360,"center")
		local L=M.records
		if L[1]then
			mDraw(drawableText.highScore,1100,240)
			gc.setColor(.3,.3,.3,.8)
			gc.rectangle("fill",940,290,320,280)--Highscore board
			gc.setColor(1,1,1)
			setFont(23)
			for i=1,#L do
				gc.print(M.scoreDisp(L[i]),955,275+25*i)
			end
		elseif M.score then
			mDraw(drawableText.noScore,1100,370)
		end
	end
	if cam.keyCtrl then
		gc.setColor(1,1,1)
		gc.draw(mapCross,460-20,360-20)
	end
end
function Pnt.music()
	gc.setColor(1,1,1,.3+sin(Timer()*5)*.2)
	gc.rectangle("fill",45,98+30*sceneTemp,250,30)
	gc.setColor(.8,.8,.8)
	gc.draw(drawableText.musicRoom,20,20)
	gc.setColor(1,1,1)
	gc.draw(drawableText.musicRoom,22,23)
	gc.draw(drawableText.nowPlaying,490,390)
	setFont(30)
	for i=1,#musicID do
		gc.print(musicID[i],50,90+30*i)
	end
	gc.draw(titleImage,640,310,nil,1.5,nil,206,35)
	if bgmPlaying then
		setFont(45)
		gc.setColor(sin(Timer()*.5)*.2+.8,sin(Timer()*.7)*.2+.8,sin(Timer())*.2+.8)
		mStr(bgmPlaying or"",630,460)
		local t=-Timer()%2.3/2
		if t<1 then
			gc.setColor(1,1,1,t)
			gc.draw(coloredTitleImage,640,310,nil,1.5+.1-.1*t,1.5+.3-.3*t,206,35)
		end
	end
end
function Pnt.custom()
	gc.setColor(1,1,1,.3+sin(Timer()*8)*.2)
	gc.rectangle("fill",25,95+40*sceneTemp,480,40)
	gc.setColor(.8,.8,.8)gc.draw(drawableText.custom,20,20)
	gc.setColor(1,1,1)gc.draw(drawableText.custom,22,23)
	setFont(35)
	for i=1,#customID do
		local k=customID[i]
		local y=90+40*i
		gc.printf(text.customOption[k],15,y,320,"right")
		if text.customVal[k]then
			gc.print(text.customVal[k][customSel[i]],335,y)
		else
			gc.print(customRange[k][customSel[i]],335,y)
		end
	end
end
function Pnt.draw()
	local sx,sy=sceneTemp.x,sceneTemp.y
	gc.translate(200,60)
	gc.setColor(1,1,1,.2)
	gc.setLineWidth(1)
	for x=1,9 do gc.line(30*x,0,30*x,600)end
	for y=0,19 do gc.line(0,30*y,300,30*y)end
	gc.setColor(1,1,1)
	gc.setLineWidth(3)
	gc.rectangle("line",-2,-2,304,604)
	gc.setLineWidth(2)
	local cross=puzzleMark[-1]
	for y=1,20 do for x=1,10 do
		local B=preField[y][x]
		if B>0 then
			gc.draw(blockSkin[B],30*x-30,600-30*y)
		elseif B==-1 and not sceneTemp.demo then
			gc.draw(cross,30*x-30,600-30*y)
		end
	end end
	if sx and sy then
		gc.setLineWidth(2)
		gc.rectangle("line",30*sx-30,600-30*sy,30,30)
	end
	gc.translate(-200,-60)
	if sceneTemp.sure>0 then
		gc.setColor(1,1,1,sceneTemp.sure*.02)
		gc.draw(drawableText.question,660,11)
	end
	local pen=sceneTemp.pen
	if pen>0 then
		gc.setLineWidth(13)
		gc.setColor(blockColor[pen])
		gc.rectangle("line",745,460,70,70)
	elseif pen==-1 then
		gc.setLineWidth(5)
		gc.setColor(.9,.9,.9)
		gc.line(755,470,805,520)
		gc.line(755,520,805,470)
	end
end
function Pnt.play()
	for p=1,#players do
		players[p]:draw()
	end
	gc.setLineWidth(5)
	for i=1,#FX_attack do
		local A=FX_attack[i]
		gc.push("transform")
			local a=(A.t<10 and A.t*.05 or A.t>50 and 6-A.t*.1 or 1)*A.a
			gc.setColor(A.r,A.g,A.b,a*.5)
			gc.circle("line",0,0,A.rad,A.corner)
			local L=A.drag
			local len=#L
			for i=1,len,2 do
				gc.setColor(A.r,A.g,A.b,.4*a*i/len)
				gc.translate(L[i],L[i+1])
				gc.rotate(A.t*.1)
				gc.circle("fill",0,0,A.rad,A.corner)
				gc.rotate(-A.t*.1)
				gc.translate(-L[i],-L[i+1])
			end
			gc.setColor(A.r,A.g,A.b,a)
			gc.translate(A.x,A.y)
			gc.rotate(A.t*.1)
			gc.circle("fill",0,0,A.rad,A.corner)
		gc.pop()
	end--FX animation
	gc.setColor(1,1,1)
	if setting.VKSwitch then drawVirtualkey()end
	if modeEnv.royaleMode then
		for i=1,#FX_badge do
			local b=FX_badge[i]
			gc.setColor(1,1,1,b.t<10 and b.t*.1 or b.t<50 and 1 or(60-b.t)*.1)
			if b.t<10 then
				gc.draw(badgeIcon,b[1]-14,b[2]-14)
			elseif b.t<50 then
				local t=((b.t-10)*.025)t=(3-2*t)*t*t
				gc.draw(badgeIcon,b[1]*(1-t)+b[3]*t-14,b[2]*(1-t)+b[4]*t-14)
			else
				gc.draw(badgeIcon,b[3]-14,b[4]-14)
			end
		end
		local P=players[1]
		gc.setLineWidth(5)
		gc.setColor(.8,1,0,.2)
		for i=1,#P.atker do
			local p=P.atker[i]
			gc.line(p.centerX,p.centerY,P.x+300*P.size,P.y+670*P.size)
		end
		if P.atkMode~=4 then
			if P.atking then drawAtkPointer(P.atking.centerX,P.atking.centerY)end
		else
			for i=1,#P.atker do
				local p=P.atker[i]
				drawAtkPointer(p.centerX,p.centerY)
			end
		end
	end
	if restartCount>0 then
		gc.setColor(0,0,0,restartCount*.05)
		gc.rectangle("fill",0,0,1280,720)
	end
end
function Pnt.pause()
	Pnt.play()
	gc.setColor(0,0,0,pauseTimer*.015)
	gc.rectangle("fill",0,0,1280,720)
	gc.setColor(1,1,1,pauseTimer*.02)
	setFont(25)
	if pauseCount>0 then
		gc.print(text.pauseCount..":["..pauseCount.."] "..format("%0.2f",pauseTime).."s",110,150)
	end
	for i=1,8 do
		gc.print(text.stat[i+3],110,30*i+270)
		gc.print(sceneTemp[i],305,30*i+270)
	end
	for i=9,16 do
		gc.print(text.stat[i+3],860,30*i+30)
		gc.print(sceneTemp[i],1050,30*i+30)
	end
	setFont(35)
	if system~="Android"then
		mStr(text.space.."/"..text.enter,640,190)
		mStr("Ctrl+R",640,351)
		gc.print("ESC",610,506)
	end
	mDraw(gameResult and drawableText[gameResult]or drawableText.pause,640,60-10*(5-pauseTimer*.1)^1.5)
end
function Pnt.setting_game()
	gc.setColor(1,1,1)
	mDraw(drawableText.setting_game,640,15)
	setFont(35)
	mStr("DAS:"..setting.das,290,205)
	mStr("ARR:"..setting.arr,610,205)
	setFont(23)
	mStr(text.softdropdas..setting.sddas,290,323)
	mStr(text.softdroparr..setting.sdarr,610,323)
end
function Pnt.setting_graphic()
	gc.setColor(1,1,1)
	mDraw(drawableText.setting_graphic,640,15)
	gc.draw(blockSkin[7-int(Timer()*2)%7],890,390,nil,2)
end
function Pnt.setting_sound()
	gc.setColor(1,1,1,.8)
	mDraw(drawableText.setting_sound,640,15)
	local t=Timer()
	local _=sceneTemp.jump
	local x,y=800,340+10*sin(t*.5)+(_-10)*_*.3
	gc.translate(x,y)
	gc.draw(miya.ch,0,0)
	gc.setColor(1,1,1,.7)
	gc.draw(miya.f1,4,47+4*sin(t*.9))
	gc.draw(miya.f2,42,107+5*sin(t))
	gc.draw(miya.f3,93,126+3*sin(t*.7))
	gc.draw(miya.f4,129,98+3*sin(t*.7))
	gc.translate(-x,-y)
end
function Pnt.setting_key()
	local s=sceneTemp
	local a=.3+sin(Timer()*15)*.1
	if s.kS then gc.setColor(1,.3,.3,a)else gc.setColor(1,.7,.7,a)end
	gc.rectangle("fill",
		s.kb<11 and 240 or 840,
		45*s.kb+20-450*int(s.kb/11),
		200,45
	)
	if s.jS then gc.setColor(.3,.3,.1,a)else gc.setColor(.7,.7,1,a)end
	gc.rectangle("fill",
		s.js<11 and 440 or 1040,
		45*s.js+20-450*int(s.js/11),
		200,45
	)
	--Selection rect

	gc.setColor(1,.3,.3)
	mDraw(drawableText.keyboard,340,35)
	mDraw(drawableText.keyboard,940,35)
	gc.setColor(.3,.3,1)
	mDraw(drawableText.joystick,540,35)
	mDraw(drawableText.joystick,1140,35)

	gc.setColor(1,1,1)
	setFont(26)
	local board=s.board
	for N=1,20 do
		if N<11 then
			gc.printf(text.actName[N],47,45*N+22,180,"right")
			mStr(setting.keyMap[board][N],340,45*N+22)
			mStr(setting.keyMap[board+8][N],540,45*N+22)
		else
			gc.printf(text.actName[N],647,45*N-428,180,"right")
			mStr(setting.keyMap[board][N],940,45*N-428)
			mStr(setting.keyMap[board+8][N],1040,45*N-428)
		end
	end
	gc.setLineWidth(2)
	for x=40,1240,200 do
		gc.line(x,65,x,515)
	end
	for y=65,515,45 do
		gc.line(40,y,1240,y)
	end
	setFont(35)
	gc.print("Player:",170,590)
	gc.print(int(board*.5+.5),300,590)
	gc.print(board.."/8",580,590)
	gc.draw(drawableText.ctrlSetHelp,50,650)
end
function Pnt.setting_touch()
	gc.setColor(1,1,1)
	gc.setLineWidth(7)gc.rectangle("line",340,15,600,690)
	gc.setLineWidth(3)gc.rectangle("line",490,85,300,600)
	VirtualkeyPreview()
	local d=snapLevelValue[sceneTemp.snap]
	if d>=10 then
		gc.setLineWidth(3)
		gc.setColor(1,1,1,sin(Timer()*4)*.1+.1)
		for i=1,1280/d-1 do
			gc.line(d*i,0,d*i,720)
		end
		for i=1,720/d-1 do
			gc.line(0,d*i,1280,d*i)
		end
	end
end
function Pnt.setting_trackSetting()
	gc.setColor(1,1,1)
	mDraw(drawableText.VKTchW,140+50*setting.VKTchW,260)
	mDraw(drawableText.VKOrgW,140+50*setting.VKTchW+50*setting.VKCurW,320)
	mDraw(drawableText.VKCurW,640+50*setting.VKCurW,380)
end
function Pnt.help()
	setFont(25)
	gc.setColor(1,1,1)
	for i=1,#text.help do
		gc.printf(text.help[i],140,10+40*i,1000,"center")
	end
	setFont(19)
	gc.print(text.used,30,330)
	gc.draw(titleImage,280,620,.1,1+.05*sin(Timer()*2),nil,206,35)
	gc.setLineWidth(5)
	gc.rectangle("line",17,17,260,260)
	gc.rectangle("line",1077,17,186,186)
	gc.draw(payCode,20,20)
	gc.draw(groupCode,1080,20)
	gc.setColor(1,1,1,sin(Timer()*10)*.5+.5)
	setFont(30)
	mStr(text.support,150,283)
	setFont(20)
	mStr(text.group,1170,210)
end
function Pnt.stat()
	setFont(23)
	gc.setColor(1,1,1)
	for i=1,18 do
		gc.print(text.stat[i],400,30*i-5)
		gc.print(sceneTemp[i],720,30*i-5)
	end
	gc.draw(titleImage,260,600,.2+.07*sin(Timer()*3),nil,nil,206,35)
end
function Pnt.history()
	gc.setColor(.2,.2,.2,.7)
	gc.rectangle("fill",30,45,1000,632)
	gc.setColor(1,1,1)
	gc.setLineWidth(4)
	gc.rectangle("line",30,45,1000,632)
	setFont(20)
	local _=sceneTemp
	for i=0,min(22,#_[1]-_[2])do
		gc.print(_[1][_[2]+i],40,50+27*(i))
	end
end
return Pnt
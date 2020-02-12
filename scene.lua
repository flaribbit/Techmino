local int,max,format=math.floor,math.max,string.format
local scene={
	cur="load",--Current scene
	swapping=false,--ifSwapping
	swap={
		tar=nil,	--Swapping target
		style=nil,	--Swapping target
		mid=nil,	--Loading point
		time=nil,	--Full swap time
		draw=nil,	--Swap draw
	},
	seq={"quit","slowFade"},--Back sequence
}--scene datas,returned
local sceneInit={
	quit=love.event.quit,
	load=function()
		loading={
			1,--Loading mode
			1,--Loading counter
			#voiceName,--Loading bar lenth(current)
			text.tips[math.random(#text.tips)],--tip
		}
	end,
	intro=function()
		sceneTemp=0--animation timer
		BGM("blank")
	end,
	main=function()
		curBG="none"
		BGM("blank")
		destroyPlayers()
		modeEnv={}
		if not players[1]then
			newDemoPlayer(1,900,35,1.1)
		end--create demo player
	end,
	music=function()
		if bgmPlaying then
			for i=1,#musicID do
				if musicID[i]==bgmPlaying then
					sceneTemp=i--music select
					return
				end
			end
		else
			sceneTemp=1
		end
	end,
	mode=function()
		curBG="none"
		BGM("blank")
		destroyPlayers()
		mapCam.zoomK=scene.swap.tar=="mode"and 5 or 1
	end,
	custom=function()
		sceneTemp=1--option select
		destroyPlayers()
		curBG=customRange.bg[customSel[12]]
		BGM(customRange.bgm[customSel[13]])
	end,
	draw=function()
		curBG="none"
		sceneTemp={
			sure=0,
			pen=1,
			x=1,y=1,
			demo=false,
		}
	end,
	play=function()
		love.keyboard.setKeyRepeat(false)
		restartCount=0
		if needResetGameData then
			resetGameData()
			needResetGameData=nil
		else
			BGM(modeEnv.bgm)
		end
		curBG=modeEnv.bg
	end,
	pause=function()
		local S=players[1].stat
		sceneTemp={
			S.key,
			S.rotate,
			S.hold,
			S.piece.."  "..(int(S.piece/S.time*100)*.01).."PPS",
			S.row.."  "..(int(S.row/S.time*600)*.1).."LPM",
			S.atk.."  "..(int(S.atk/S.time*600)*.1).."APM",
			S.send,
			S.recv,
			S.pend,
			S.clear_1.."/"..S.clear_2.."/"..S.clear_3.."/"..S.clear_4,
			"["..S.spin_0.."]/"..S.spin_1.."/"..S.spin_2.."/"..S.spin_3,
			S.b2b.."[+"..S.b3b.."]",
			S.pc,
			format("%0.2f",S.atk/S.row),
			S.extraPiece,
			max(100-int(S.extraRate/S.piece*10000)*.01,0).."%",
		}
	end,
	setting_game=function()
		curBG="none"
	end,
	setting_graphic=function()
		curBG="none"
	end,
	setting_sound=function()
		sceneTemp={last=0,jump=0}--last sound time,animation count(10→0)
		curBG="none"
	end,
	setting_key=function()
		sceneTemp={
			board=1,
			kb=1,js=1,
			kS=false,jS=false,
		}
	end,
	setting_touch=function()
		curBG="game2"
		sceneTemp={
			default=1,
			snap=1,
			sel=nil,
		}
	end,
	setting_touchSwitch=function()
		curBG="matrix"
	end,
	help=function()
		curBG="none"
	end,
	stat=function()
		local S=stat
		sceneTemp={
			S.run,
			S.game,
			format("%0.1fHr",S.time*2.78e-4),
			S.key,
			S.rotate,
			S.hold,
			S.piece,
			S.row,
			S.atk,
			S.send,
			S.recv,
			S.pend,
			S.clear_1.."/"..S.clear_2.."/"..S.clear_3.."/"..S.clear_4,
			"["..S.spin_0.."]/"..S.spin_1.."/"..S.spin_2.."/"..S.spin_3,
			S.b2b.."[+"..S.b3b.."]",
			S.pc,
			format("%0.2f",S.atk/S.row),
			S.extraPiece.."["..(int(S.extraRate/S.piece*10000)*.01).."%]",
		}
	end,
	history=function()
		curBG="lightGrey"
		sceneTemp={require("updateLog"),1}--scroll pos
	end,
	quit=function()
		love.timer.sleep(.3)
		love.event.quit()
	end,
}
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
local gc=love.graphics
local swap={
	none={1,0,NULL},
	flash={8,1,function()gc.clear(1,1,1)end},
	fade={30,15,function(t)
		local t=t>15 and 2-t/15 or t/15
		gc.setColor(0,0,0,t)
		gc.rectangle("fill",0,0,1280,720)
	end},
	fade_togame={120,20,function(t)
		local t=t>20 and (120-t)/100 or t/20
		gc.setColor(0,0,0,t)
		gc.rectangle("fill",0,0,1280,720)
	end},
	slowFade={180,90,function(t)
		local t=t>90 and 2-t/90 or t/90
		gc.setColor(0,0,0,t)
		gc.rectangle("fill",0,0,1280,720)
	end},
	deck={50,8,function(t)
		gc.setColor(1,1,1)
		if t>8 then
			local t=t<15 and 15 or t
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
			gc.setColor(1,1,1,1-(t>8 and t-8 or 8-t)*.125)
			gc.rectangle("fill",0,0,1280,720)
		end
	end},
}--Scene swapping animations
local backFunc={
	load=love.event.quit,
	pause=function()
		love.keyboard.setKeyRepeat(true)
		updateStat()
		saveStat()
		clearTask("play")
	end,
	setting_game=	function()saveSetting()end,
	setting_graphic=function()saveSetting()end,
	setting_sound=	function()saveSetting()end,
}
function scene.init(s)
	if sceneInit[s]then sceneInit[s]()end
end
function scene.push(tar,style)
	if not scene.swapping then
		local m=#scene.seq
		scene.seq[m+1]=tar or scene.cur
		scene.seq[m+2]=style or"fade"
	end
end
function scene.pop()
	scene.seq={}
end
function scene.swapTo(tar,style)
	local S=scene.swap
	if not scene.swapping and tar~=scene.cur then
		scene.swapping=true
		if not style then style="fade"end
		S.tar=tar
		S.style=style
		local swap=swap[style]
		S.time=swap[1]
		S.mid=swap[2]
		S.draw=swap[3]
		widget_sel=nil
	end
end
function scene.back()
	if not scene.swapping then
		if backFunc[scene.cur] then backFunc[scene.cur]()end
		--func when scene end
		local m=#scene.seq
		if m>0 then
			scene.swapTo(scene.seq[m-1],scene.seq[m])
			scene.seq[m],scene.seq[m-1]=nil
			--Poll&Back to preScene
		end
	end
end
return scene
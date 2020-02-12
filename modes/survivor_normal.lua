local max,rnd=math.max,math.random
return{
	name={
		"生存",
		"生存",
		"Survivor",
	},
	level={
		"普通",
		"普通",
		"NORMAL",
	},
	info={
		"你能存活多久?",
		"你能存活多久?",
		"Survive Longer!",
	},
	color=color.green,
	env={
		drop=30,lock=45,
		freshLimit=10,
		visible="time",
		task=function(P)
			if not P.control then return end
			P.modeData.counter=P.modeData.counter+1
			if P.modeData.counter>=max(90,180-2*P.modeData.event)and P.atkBuffer.sum<8 then
				local d=P.modeData.event+1
				P.atkBuffer[#P.atkBuffer+1]=
					d%4==0 and{pos=rnd(10),amount=1,countdown=60,cd0=60,time=0,sent=false,lv=1}or
					d%4==1 and{pos=rnd(10),amount=2,countdown=70,cd0=70,time=0,sent=false,lv=1}or
					d%4==2 and{pos=rnd(10),amount=3,countdown=80,cd0=80,time=0,sent=false,lv=2}or
					d%4==3 and{pos=rnd(10),amount=4,countdown=90,cd0=90,time=0,sent=false,lv=3}
				P.atkBuffer.sum=P.atkBuffer.sum+d%4+1
				P.stat.recv=P.stat.recv+d%4+1
				if P.modeData.event==45 then P:showText(text.maxspeed,0,-140,100,"appear",.6)end
				P.modeData.counter=0
				P.modeData.event=d
			end
		end,
		bg="glow",bgm="newera",
	},
	load=function()
		newPlayer(1,340,15)
	end,
	mesDisp=function(P,dx,dy)
		mDraw(drawableText.line,-82,300)
		mDraw(drawableText.techrash,-82,420)
		setFont(75)
		mStr(P.stat.row,-82,220)
		mStr(P.stat.clear_4,-82,340)
	end,
	score=function(P)return{P.modeData.event,P.stat.time}end,
	scoreDisp=function(D)return D[1].." Waves   "..toTime(D[2])end,
	comp=function(a,b)return a[1]>b[1]or a[1]==b[1]and a[2]<b[2]end,
	getRank=function(P)
		local W=P.modeData.event
		return
		W>=80 and 5 or
		W>=55 and 4 or
		W>=45 and 3 or
		W>=30 and 2 or
		W>=15 and 1
	end,
}
return{
	atkModeName={"Random","Badges","K.O.s","Counters"},
	royale_remain=function(n)return n.." Players Remain"end,
	cmb={nil,nil,"3 Combo","4 Combo","5 Combo","6 Combo","7 Combo","8 Combo","9 Combo","10 Combo!","11 Combo!","12 Combo!","13 Combo!","14 Combo!","15 Combo!","16 Combo!","17 Combo!","18 Combo!","19 Combo!","MEGACMB"},
	techrash="Techrash",
	techrashB2B="B2B Techrash",
	techrashB3B="B2B2B Techrash",
	block={"Z","S","L","J","T","O","I"},
	clear={" single"," double"," triple"},
	spin={"Z-spin","S-spin","L-spin","J-spin","T-spin","O-spin","I-spin"},
	b2b="B2B ",b3b="B2B2B ",
	mini="Mini",
	PC="Perfect Clear",
	hold="Hold",next="Next",

	stage={"STAGE 1","STAGE 2","STAGE 3","STAGE 4","STAGE 5",},
	maxspeed="Max speed",
	speedup="Speed up",

	win="WIN",
	lose="LOSE",
	pause="PAUSE",
	finish="FINISH",
	pauseTime="Pause time",
	
	custom="Custom Game",
	customOption={
		drop="Drop delay:",
		lock="Lock delay:",
		wait="Next piece delay:",
		fall="Clear row delay:",
		next="Next count:",
		hold="Hold:",
		sequence="Sequence:",
		visible="Visible:",
		target="Line limit:",
		freshLimit="Lock fresh limit:",
		opponent="Opponent speed:",
		bg="Background:",
		bgm="BGM:",
	},
	customVal={
		drop={0,1,2,3,4,5,6,7,8,9,10,12,14,16,18,20,25,30,40,60,180,"∞","[20G]"},
		lock={0,1,2,3,4,5,6,7,8,9,10,12,14,16,18,20,25,30,40,60,180,"∞"},
		wait=nil,
		fall=nil,
		next=nil,
		hold={"ON","OFF","FREE"},
		sequence={"bag7","his4","random"},
		visible={"normal","time","invisible","sudden"},
		target={10,20,40,100,200,500,1000,"∞"},
		freshLimit={0,8,15,"∞"},
		opponent={"No CPU",1,2,3,4,5,6,7,8,9,10,11},
	},
	softdropdas="Down DAS:",
	softdroparr="Down ARR:",
	snapLevelName={"Free pos","Snap-10","Snap-20","Snap-40","Snap-60","Snap-80"},
	keyboard="Keyboard",joystick="Joystick",
	space="Space",enter="Enter",
	setting2Help="Arrowkey to select/change slot,Enter to change,Esc back",
	musicRoom="Music Room",
	nowPlaying="Now Playing:",

	actName={"Move Left:","Move Right:","Rotate Right:","Rotate Left:","Rotate Flip:","Hard Drop:","Soft Drop:","Hold:","Function:","Restart:","Instant Left:","Instant Right:","Ins Down:"},
	modeName={
		[0]="Custom",
		"Sprint","Marathon","Master","Classic","Zen","Infinite","1v1","TSD-only","Blind","Dig","Survivor","Tech",
		"C4W Train","PC Train","PC Challenge","Techmino49","Techmino99","Drought","Hotseat",
	},
	modeInfo={
		sprint="Speed run",
		marathon="Survive and reach target",
		master="To be Grand Master",
		classic="Vintage car drag racing",
		zen="Clear 200 Lines without gravity",
		infinite="Infinite game,infinite happiness",
		solo="Beat AI",
		tsd="Make more T-spin-doubles",
		blind="Invisible board",
		dig="Downstack!",
		survivor="Hand them!",
		tech="Don't do normal clear",
		c4wtrain="Infinite combo",
		pctrain="Let's learn some PCs",
		pcchallenge="Make PCs in 100 Lines",
		techmino49="Melee fight with 48 AIs",
		techmino99="Melee fight with 98 AIs",
		drought="ERRSEQ flood attack",
		hotseat="",
	},

	load={"Loading VOICE","Loading BGM","Loading SFX","Finished",},
	tips={
		"Not animation,real loading!",
		"The WHOLE game is made by MrZ!",
		"Back to Back 10 combo Techrash PC!",
		"Techmino has a Nspire-CX edition!",
		"Is B2B2B2B possible?",
		"MEGACMB!",
		"ALLSPIN!",
		"O spin triple?",
		"You can play with any input device!",
		"Miya:Nya!",
		"225238922,Bilibili cheers!",
		"Playing too much = taking drugs",
		"Disappearing doesn't mean useless",
		"Try to use two rotate button,three better",
		"Small DAS&ARR can make you faster,if you can adapt to it",
		"Have you noticed what does \"rotating\" do to block?",
		"20G is a brand new game rule",
		"Do not play game in class!",
		"This game can be very hard,be mentally perpared",
		"This in not a casual game",
		"Nothing will happen when some special day come",
		"[random text]",
	},
	stat={
		"Games run:",
		"Games played:",
		"Game time:",
		"Key pressed:",
		"Rotate:",
		"Hold:",
		"Block used:",
		"Rows cleared:",
		"Attack:",
		"Sent:",
		"Receive:",
		"Pend:",
		"Clear:",
		"Spin:",
		"B2B:",
		"PC:",
		"Efficiency:",
	},
	help={
		"I don't think you need \"help\".",
		"THIS IS ONLY A BLOCK GAME",
		"But just play like playing TOP/C2/KOS/TGM3",
		"Game is not public now,so DO NOT DISTIRBUTE",
		"",
		"Powered by LOVE2D",
		"Author:MrZ   E-mail:1046101471@qq.com",
		"Programe:MrZ  Art:MrZ  Music:MrZ  SFX:MrZ VOICE:Miya",
		"Tool used:VScode,GFIE,Beepbox,Goldwave",
		"Special thanks:Farter,Teatube,196,Flyz,T830,[all test staff] and YOU!",
		"Any bugs/suggestions to my E-mail.",
	},
	support="Support Author",
	group="Official QQ Group",
	ButtonText={
		main={
			play="Play",
			setting="Settings",
			music="Music room",
			stat="Statistics",
			help="Help",
			quit="Quit",
		},
		mode={
			up="↑",
			down="↓",
			left="←",
			right="→",
			start="Start",
			custom="Custom(C)",
			back="Back",
		},
		music={
			up="↑",
			play="Play",
			down="↓",
			back="Back",
		},
		custom={
			up="↑",
			down="↓",
			left="←",
			right="→",
			start1="Clear Start",
			start2="Puzzle Start",
			draw="Draw(D)",
			set1="40L",
			set2="1v1",
			set3="infinite",
			set4="blind",
			set5="classic",
			back="Back",
		},
		draw={
			any="ANY",
			block1="■",
			block2="■",
			block3="■",
			block4="■",
			block5="■",
			block6="■",
			block7="■",
			gb1="■",
			gb2="■",
			gb3="■",
			gb4="■",
			gb5="■",
			space="×",
			clear="CLEAR",
			back="Back",
		},
		play={
			pause="Pause",
		},
		pause={
			resume="Resume",
			quit="Quit",
		},
		setting={
			ghost=function()return setting.ghost and"Ghost:ON"or"Ghost:OFF"end,
			center=function()return setting.center and"Center:ON"or"Center:OFF"end,
			grid=function()return setting.grid and"Grid:ON"or"Grid:OFF"end,
			swap=function()return setting.swap and"Swap:comboKey"or"Swap:loop"end,
			fxs=function()return setting.fxs and"FXs:ON"or"FXs:OFF"end,
			bg=function()return setting.bg and"BG:ON"or"BG:OFF"end,
			dasD="-",dasU="+",
			arrD="-",arrU="+",
			sddasD="-",sddasU="+",
			sdarrD="-",sdarrU="+",
			ctrl="Control settings",
			touch="Touch settings",
			lang=function()return langName[setting.lang]end,
			sfx=function()return setting.sfx and"SFX:ON"or"SFX:OFF"end,
			bgm=function()return setting.bgm and"BGM:ON"or"BGM:OFF"end,
			voc=function()return setting.voc and"VOC:ON"or"VOC:OFF"end,
			vib=function()return "VIB:"..setting.vib end,
			fullscreen=function()return setting.fullscreen and"Fullscreen:ON"or"Fullscreen:OFF"end,
			bgblock=function()return setting.bgblock and"BG animation:ON"or"BG animation:OFF"end,
			frame=function()return"FrameDraw:"..setting.frameMul.."%"end,
			skin="Change Block Skin",
			back="Save&Back",
		},
		setting2={
			back="Back",
		},
		setting3={
			back="Back",
			hide=function()return setting.virtualkeySwitch and"Hide Virtual Key"or"Show Virtual Key"end,
			default="Defaults",
			snap=function()return text.snapLevelName[snapLevel]end,
			alpha=function()return percent0to5[setting.virtualkeyAlpha]end,
			icon="Icon",
			size="Size",
		},
		help={
			back="Back",
			qq="Author's qq",
		},
		stat={
			back="Back",
			path="Open Data Folder",
		},
	}
}
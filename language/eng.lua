local BK="Back"
local actName={
	"Move Left:","Move Right:",
	"Rotate Right:","Rotate Left:","Rotate Flip:",
	"Hard Drop:","Soft Drop:","Hold:","Function:","Restart:",
	"Instant Left:","Instant Right:","Ins Down:","Down 1:","Down 4:","Down 10:",
	"Left Drop:","Right Drop:","Left INS:","Right INS:",
}
return{
	lang="English",
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

	stage=function(n)return"STAGE "..n end,
	great="Great!",
	awesome="Awesome.",
	continue="Continue.",
	maxspeed="Max speed",
	speedup="Speed up",

	win="WIN",
	finish="FINISH",
	lose="LOSE",
	pause="PAUSE",
	pauseCount="Pause Count",

	custom="Custom Game",
	customOption={
		drop="Drop speed:",
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
		drop={"0G","1/180G","1/60G","1/40G","1/30G","1/25G","1/20G","1/18G","1/16G","1/14G","1/12G","1/10G","1/9G","1/8G","1/7G","1/6G","1/5G","1/4G","1/3G","1/2G","1G","2G","4G","8G","20G"},
		lock={0,1,2,3,4,5,6,7,8,9,10,12,14,16,18,20,25,30,40,60,180,"∞"},
		wait=nil,
		fall=nil,
		next=nil,
		hold={"ON","OFF","FREE"},
		sequence={"bag7","his4","random"},
		visible={"normal","time","invisible","sudden"},
		target={10,20,40,100,200,500,1000,"∞"},
		freshLimit={0,8,15,"∞"},
		opponent={"No CPU","9S Lv1","9S Lv2","9S Lv3","9S Lv4","9S Lv5","CC Lv1","CC Lv2","CC Lv3","CC Lv4","CC Lv5","CC Lv6"},
	},
	softdropdas="Down DAS:",
	softdroparr="Down ARR:",
	snapLevelName={"Free pos","Snap-10","Snap-20","Snap-40","Snap-60","Snap-80"},
	keyboard="Keyboard",joystick="Joystick",
	space="Space",enter="Enter",
	ctrlSetHelp="Arrowkey to select/change slot,Enter to change,Esc back",
	setting_game="Game setting",
	setting_graphic="Graphic setting",
	setting_sound="Sound setting",
	musicRoom="Music Room",
	nowPlaying="Now Playing:",
	recSavingError="Failed to save record:",
	settingSaved="Setting saved",
	settingSavingError="Failed to save setting:",
	statSavingError="Failed to save stat:",
	unlockSavingError="Failed to save unlock:",
	copySuccess="Copy Success",
	dataCorrupted="Data Corrupted",
	VKTchW="Touch weight",
	VKOrgW="Origion weight",
	VKCurW="CurPos weight",
	noScore="No Score Yet",
	highScore="Highscore",
	newRecord="New Rocord",
	errorMsg="Techmino ran into a problem and needs to restart.\nWe collected some error info,and you can send them to author.",

	actName=actName,
	
	load={[0]="Finished","Loading VOICE","Loading BGM","Loading SFX","Loading modes","Loading other things"},
	tips={
		"Not animation,real loading!",
		"Back to Back 10 combo Techrash PC!",
		"Techmino has a Nspire-CX edition!",
		"B2B2B???",
		"Is B2B2B2B possible?",
		"MEGACMB!",
		"ALLSPIN!",
		"O spin triple!",
		"Miya:Nya!",
		"225238922  Bilibili cheers!",
		"Playing too much = taking drugs",
		"Disappearing doesn't mean useless",
		"Try to use two rotate button,three better",
		"Small DAS&ARR can make you faster,if you can control block correctly",
		"Have you noticed what does \"rotating\" do to block?",
		"20G actually is a brand new game rule",
		"Do not play game in class!",
		"This game can be very hard,be mentally perpared",
		"This in not a casual game",
		"Nothing will happen when some special day come",
		"3.1415926535897932384",
		"2.7182818284590452353",
		"Let-The-Bass-Kick!",
		"Powered by love2d",
		"Find out what's in the setting!",
		"Any suggestions to author!",
		"DO NOT PRESS F8",
		"Secret num:626",
		"Techmino=Technique+Tetromino",
		"CLASSIC SEXY RUSSIAN BLOCKS",
		"Headphones for better experience",
		"LrL,RlR  LLr,RRl  RRR/LLL  F!!",--ZSLJTTI
		"(first effective)Your luck number today:"..math.random(100,626),
	},
	stat={
		"Games run:",
		"Games played:",
		"Game time:",
		"Key pressed:",
		"Rotate:",
		"Hold:",
		"Block used:",
		"Lines cleared:",
		"Attack:",
		"Sent:",
		"Receive:",
		"Pend:",
		"Clear:",
		"Spin:",
		"B2B:",
		"PC:",
		"Efficiency:",
		"Finesse error:",
		"Finesse rate:",
	},
	help={
		"I don't think you need \"help\".",
		"THIS IS ONLY A BLOCK GAME,not T****s",
		"But just play like playing TOP/C2/KOS/TGM3",
		"Game is not public now,so DO NOT DISTIRBUTE",
		"",
		"Powered by LOVE2D",
		"Author:MrZ   E-mail:1046101471@qq.com",
		"Program:MrZ  Art:MrZ  Music:MrZ  SFX:MrZ VOICE:Miya",
		"Special thanks:Farter,Flyz,196,Teatube,T830,[all test staff] and YOU!",
		"Any bugs/suggestions to my E-mail.",
	},
	used=[[
Tool used:
	Beepbox
	GFIE
	Goldwave
Lib used:
	Cold_Clear[MinusKelvin]
	simple-love-lights[dylhunn]
]],
	support="Support Author",
	group="Official QQ Group",
	warning="DO NOT SHARE APP",
	WidgetText={
		main={
			lang="言/A",
			play="Play",
			setting="Settings",
			music="Music room",
			stat="Statistics",
			help="Help",
			quit="Quit",
		},
		mode={
			draw="Draw(Q)",
			setting="Setting(E)",
			start="Start",
			back=BK,
		},
		music={
			bgm="BGM",
			up="↑",
			play="Play",
			down="↓",
			back=BK,
		},
		custom={
			up="↑",
			down="↓",
			left="←",
			right="→",
			set1="40L(1)",
			set2="1v1(2)",
			set3="infinite(3)",
			set4="blind(4)",
			set5="master(5)",
			back=BK,
		},
		draw={
			any="ANY",
			block1="Z",
			block2="S",
			block3="L",
			block4="J",
			block5="T",
			block6="O",
			block7="I",
			gb1="■",
			gb2="■",
			gb3="■",
			gb4="■",
			gb5="■",
			space="×",
			clear="Clear",
			demo="Demo",
			copy="Copy",
			paste="Paste",
			back=BK,
		},
		play={
			pause="Pause",
		},
		pause={
			resume="Resume",
			restart="Restart",
			sfx="SFX",
			bgm="BGM",
			quit="Quit",
		},
		setting_game={
			graphic="←Graphic",
			sound="Sound→",
			dasD="-",dasU="+",
			arrD="-",arrU="+",
			sddasD="-",sddasU="+",
			sdarrD="-",sdarrU="+",
			reTime="Delay before game",
			maxNext="Max next count",
			quickR="Quick restart",
			swap="Combo key to change ATK mode",
			fine="Finesse error SFX",
			ctrl="Key Setting",
			touch="Touch Setting",
			back=BK,
		},
		setting_graphic={
			sound="←Sound",
			game="Game→",
			ghost="Ghost",
			grid="Grid",
			center="Center",
			skin="Skin",
			bg="Background",
			bgspace="BG space",
			smo="Smoooth drop",
			dropFX="Drop FX level",
			shakeFX="Shake FX level",
			atkFX="ATK FX level",
			fullscreen="Fullscreen",
			frame="draw FPS",
			back=BK,
		},
		setting_sound={
			game="←Game",
			graphic="Graphic→",
			sfx="SFX",
			bgm="BGM",
			vib="VIB",
			voc="VOC",
			stereo="Stereo",
			back=BK,
		},
		setting_key={
			back=BK,
		},
		setting_touch={
			default="Defaults",
			snap=function()return text.snapLevelName[sceneTemp.snap]end,
			option="Option",
			back=BK,
			size="Size",
		},
		setting_touchSwitch={
			b1=	actName[1],b2=actName[2],b3=actName[3],b4=actName[4],
			b5=	actName[5],b6=actName[6],b7=actName[7],b8=actName[8],
			b9=	actName[9],b10=actName[10],b11=actName[11],b12=actName[12],
			b13=actName[13],b14=actName[14],b15=actName[15],b16=actName[16],
			b17=actName[17],b18=actName[18],b19=actName[19],b20=actName[20],
			norm="Normal",
			pro="Professioanl",
			hide="Show Virtual Key",
			track="Auto track",
			icon="Icon",
			tkset="Track setting",
			alpha="Alpha",
			back=BK,
		},
		setting_trackSetting={
			VKDodge="Auto Dodge",
			back=BK,
		},
		help={
			his="History",
			qq="Author's qq",
			back=BK,
		},
		history={
			prev="↑",
			next="↓",
			back=BK,
		},
		stat={
			path="Open Data Folder",
			back=BK,
		},
	}
}
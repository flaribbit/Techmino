local BK="返回"
local actName={
	"左移:","右移:",
	"顺时针旋转:","逆时针旋转:","180°旋转:",
	"硬降:","软降:",
	"暂存:","功能键:",
	"重新开始:",
	"左瞬移:","右瞬移:","软降到底:","软降一格:","软降四格:","软降十格:",
	"落在最左:","落在最右:","列在最左:","列在最右:",
}
return{
	lang="中文",
	atkModeName={"随机","徽章","击杀","反击"},
	royale_remain=function(n)return"剩余 "..n.." 名玩家"end,
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
	hold="暂存",next="下一个",

	stage=function(n)return"关卡 "..n end,
	great="Great!",
	awesome="Awesome.",
	continue="Continue.",
	maxspeed="最高速度",
	speedup="速度加快",

	win="胜利",
	finish="结束",
	lose="失败",
	pause="暂停",
	pauseCount="暂停统计",

	custom="自定义游戏",
	customOption={
		drop="下落速度:",
		lock="锁定延迟:",
		wait="放块延迟:",
		fall="消行延迟:",
		next="序列数量:",
		hold="暂存:",
		sequence="序列:",
		visible="可见性:",
		target="目标行数:",
		freshLimit="锁延刷新次数:",
		opponent="对手速度等级:",
		bg="背景:",
		bgm="背景音乐:",
	},
	customVal={
		drop={"0G","1/180G","1/60G","1/40G","1/30G","1/25G","1/20G","1/18G","1/16G","1/14G","1/12G","1/10G","1/9G","1/8G","1/7G","1/6G","1/5G","1/4G","1/3G","1/2G","1G","2G","4G","8G","20G"},
		lock={0,1,2,3,4,5,6,7,8,9,10,12,14,16,18,20,25,30,40,60,180,"∞"},
		wait=nil,
		fall=nil,
		next=nil,
		hold={"开","关","无限"},
		sequence={"bag7","his4","随机"},
		visible={"可见","半隐","全隐","瞬隐"},
		target={10,20,40,100,200,500,1000,"∞"},
		freshLimit={0,8,15,"∞"},
		opponent={"无电脑","9S Lv1","9S Lv2","9S Lv3","9S Lv4","9S Lv5","CC Lv1","CC Lv2","CC Lv3","CC Lv4","CC Lv5","CC Lv6"},
	},
	softdropdas="软降DAS:",
	softdroparr="软降ARR:",
	snapLevelName={"无吸附","10px吸附","20px吸附","40px吸附","60px吸附","80px吸附"},
	keyboard="键盘",joystick="手柄",
	space="空格",enter="回车",
	ctrlSetHelp="方向键选择/翻页,回车修改,esc返回",
	setting_game="游戏设置",
	setting_graphic="画面设置",
	setting_sound="声音设置",
	musicRoom="音乐室",
	nowPlaying="正在播放:",
	unlockSavingError="解锁保存失败:",
	recSavingError="纪录保存失败:",
	statSavingError="数据保存失败:",
	settingSaved="设置已保存",
	settingSavingError="设置保存失败:",
	copySuccess="已复制到剪切板",
	dataCorrupted="数据损坏",
	VKTchW="触摸点权重",
	VKOrgW="原始点权重",
	VKCurW="当前点权重",
	noScore="暂无成绩",
	highScore="最佳成绩",
	newRecord="打破纪录",
	invalidGame="成绩无效",
	errorMsg="Techmino遇到了问题,需要重新启动.\n我们已收集了一些错误信息,你可以向作者进行反馈.",

	actName=actName,

	load={[0]="加载完成","加载语音ing","加载音乐ing","加载音效ing","加载模式ing","加载乱七八糟的东西ing"},
	tips={
		"不是动画,真的在加载!",
		"大满贯10连击消四全清!",
		"<方块研究所>有一个Nspire-CX版本!",
		"B2B2B???",
		"B2B2B2B存在吗?",
		"MEGACMB!",
		"ALLSPIN!",
		"O spin triple!",
		"Miya:喵!",
		"225238922  哔哩哔哩 干杯~",
		"适度游戏益脑,沉迷游戏伤身,合理安排时间,享受健康生活",
		"合群了就会消失,但是消失不代表没有意义",
		"学会使用两个旋转键,三个更好",
		"更小的DAS和ARR拥有更高的操作上限(如果你还能控制得了的话)",
		"注意到\"旋转\"到底对方块做了些什么吗?",
		"20G本质是一套全新的游戏规则",
		"不要在上课时玩游戏!",
		"本游戏难度上限很高,做好心理准备",
		"本游戏可不是休闲游戏",
		"调到特殊的日期也不会发生什么的",
		"3.1415926535897932384",
		"2.7182818284590452353",
		"Let-The-Bass-Kick!",
		"使用love2d引擎制作",
		"有疑问?先看设置有没有你想要的",
		"有建议的话可以把信息反馈给作者~",
		"不要按F8",
		"秘密数字:626",
		"CLASSIC SEXY RUSSIAN BLOCKS",
		"戴上耳机以获得最佳体验",
		"少女祈祷中",
		"少女折寿中",
		"LrL,RlR  LLr,RRl  RRR/LLL  F!!",--ZSLJTTI
		"(第一次才准)今日幸运数字:"..math.random(100,626),
	},
	stat={
		"游戏运行次数:",
		"游戏局数:",
		"游戏时间:",
		"按键数:",
		"旋转数:",
		"Hold次数:",
		"方块使用数:",
		"消行数:",
		"攻击数:",
		"发送数:",
		"接收数:",
		"上涨数:",
		"消除数:",
		"Spin数:",
		"B2B数:",
		"PC数:",
		"效率:",
		"多余操作:",
		"最简操作率:",
	},
	help={
		"好像也没啥好帮助的吧?就当是关于了",
		"这只是一个普通的方块游戏,请勿称此游戏为某某某方块",
		"不过就当成TOP/C2/KOS/TGM3/JS玩好了",
		"游戏还在测试阶段,请 勿 外 传",
		"",
		"使用LOVE2D引擎",
		"作者:MrZ   邮箱:1046101471@qq.com",
		"程序:MrZ  美术:MrZ  音乐:MrZ  音效:MrZ 语音:Miya",
		"特别感谢:Farter,Flyz,196,Teatube,T830,[所有测试人员]和 你!",
		"错误或者建议请附带相关信息发送到作者邮箱~",
	},
	used=[[
使用工具:
	Beepbox
	GFIE
	Goldwave
使用库:
	Cold_Clear[MinusKelvin]
	simple-love-lights[dylhunn]
]],
	support="支持作者",
	group="官方QQ群",
	warning="禁止直接传播游戏本体",
	WidgetText={
		main={
			play="开始",
			setting="设置",
			music="音乐室",
			stat="统计信息",
			help="帮助",
			qplay="快速开始",
			lang="言/A",
			quit="退出",
		},
		mode={
			draw="画图(Q)",
			setting="参数(E)",
			start="开始",
			back=BK,
		},
		music={
			bgm="BGM",
			up="↑",
			play="播放",
			down="↓",
			back=BK,
		},
		custom={
			up="↑",
			down="↓",
			left="←",
			right="→",
			set1="40行(1)",
			set2="1v1(2)",
			set3="无尽(3)",
			set4="隐形(4)",
			set5="极限(5)",
			back=BK,
		},
		draw={
			any="不定",
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
			clear="清除",
			demo="演示模式",
			copy="复制",
			paste="粘贴",
			back=BK,
		},
		play={
			pause="暂停",
		},
		pause={
			resume=	"继续",
			restart="重新开始",
			sfx="音效",
			bgm="音乐",
			quit=	"退出",
		},
		setting_game={
			graphic="←画面设置",
			sound="声音设置→",
			dasD="-",dasU="+",
			arrD="-",arrU="+",
			sddasD="-",sddasU="+",
			sdarrD="-",sdarrU="+",
			reTime="开局等待时间",
			maxNext="最大预览数量",
			quickR="快速重新开始",
			swap="组合键切换攻击模式",
			fine="极简操作提示音",
			ctrl="键位设置",
			touch="触屏设置",
			back=BK,
		},
		setting_graphic={
			sound="←声音设置",
			game="游戏设置→",
			ghost="阴影",
			grid="网格",
			center="旋转中心",
			skin="皮肤",
			bg="背景",
			bgspace="星空背景",
			smo="平滑下落",
			dropFX="下落特效等级",
			shakeFX="晃动特效等级",
			atkFX="攻击特效等级",
			fullscreen="全屏",
			frame="绘制帧率",
			back=BK,
		},
		setting_sound={
			game="←游戏设置",
			graphic="画面设置→",
			sfx="音效",
			bgm="音乐",
			vib="震动",
			voc="语音",
			stereo="立体声",
			back=BK,
		},
		setting_key={
			back=BK,
		},
		setting_touch={
			default="默认组合",
			snap=function()return text.snapLevelName[sceneTemp.snap]end,
			option="选项",
			back=BK,
			size="大小",
		},
		setting_touchSwitch={
			b1=	actName[1],b2=actName[2],b3=actName[3],b4=actName[4],
			b5=	actName[5],b6=actName[6],b7=actName[7],b8=actName[8],
			b9=	actName[9],b10=actName[10],b11=actName[11],b12=actName[12],
			b13=actName[13],b14=actName[14],b15=actName[15],b16=actName[16],
			b17=actName[17],b18=actName[18],b19=actName[19],b20=actName[20],
			norm="标准",
			pro="专业",
			hide="显示虚拟按键",
			track="按键自动跟踪",
			icon="图标",
			tkset="跟踪设置",
			alpha="透明度",
			back=BK,
		},
		setting_trackSetting={
			VKDodge="自动避让",
			back=BK,
		},
		help={
			his="历史",
			qq="作者QQ",
			back=BK,
		},
		history={
			prev="↑",
			next="↓",
			back=BK,
		},
		stat={
			path="打开存储目录",
			back=BK,
		},
	},
}--文
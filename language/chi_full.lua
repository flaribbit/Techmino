return{
	atkModeName={"随机","徽章","击杀","反击"},
	royale_remain=function(n)return"剩余 "..n.." 名玩家"end,
	cmb={nil,nil,"3 Combo","4 Combo","5 Combo","6 Combo","7 Combo","8 Combo","9 Combo","10 Combo!","11 Combo!","12 Combo!","13 Combo!","14 Combo!","15 Combo!","16 Combo!","17 Combo!","18 Combo!","19 Combo!","MEGACMB"},
	techrash="四清",
	techrashB2B="满贯 四清",
	techrashB3B="大满贯 四清",
	block={"Z","S","L","J","T","O","I"},
	clear={"单清","双清","三清"},
	spin={"Z型回旋","S型回旋","L型回旋","J型回旋","T型回旋","O型回旋","I型回旋"},
	b2b="满贯",b3b="大满贯",
	mini="迷你",
	PC="场地全清",
	hold="暂存",next="下一个",

	stage={"关卡 1","关卡 2","关卡 3","关卡 4","关卡 5",},
	maxspeed="最高速度",
	speedup="速度加快",

	win="胜利",
	lose="失败",
	pause="暂停",
	finish="结束",
	pauseTime="暂停时间",

	custom="自定义游戏",
	customOption={
		drop="下落延迟:",
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
	},
	customVal={
		drop={0,1,2,3,4,5,6,7,8,9,10,12,14,16,18,20,25,30,40,60,180,"∞","[20G]"},
		lock={0,1,2,3,4,5,6,7,8,9,10,12,14,16,18,20,25,30,40,60,180,"∞"},
		wait=nil,
		fall=nil,
		next=nil,
		hold={"开","关","无限"},
		sequence={"bag7","his4","随机"},
		visible={"可见","半隐","全隐","瞬隐"},
		target={10,20,40,100,200,500,1000,"∞"},
		freshLimit={0,8,15,"∞"},
		opponent={"无电脑",1,2,3,4,5,6,7,8,9,10,11},
	},
	softdropdas="软降DAS:",
	softdroparr="软降ARR:",
	snapLevelName={"任意摆放","10px吸附","20px吸附","40px吸附","60px吸附","80px吸附"},
	keyboard="键盘",joystick="手柄",
	space="空格",enter="回车",
	setting2Help="方向键选择/翻页,回车修改,esc返回",


	actName={"左移:","右移:","顺时针旋转:","逆时针旋转:","180°旋转","硬降:","软降:","暂存:","功能键:","重新开始:","左瞬移:","右瞬移:","软降到底:"},
	modeName={
		[0]="自定义",
		"竞速","马拉松","大师","经典","禅","无尽","单挑","仅TSD","隐形","挖掘","生存","科研",
		"C4W练习","全清训练","全清挑战","49人混战","99人混战","干旱","多人",
	},
	modeInfo={
		sprint="挑战世界纪录",
		marathon="尝试坚持到最后",
		master="成为方块大师",
		classic="高速经典",
		zen="无重力消除200行",
		infinite="科研沙盒",
		solo="打败AI",
		tsd="尽可能做T旋双清",
		blind="最强大脑",
		dig="核能挖掘机",
		survivor="防守练习",
		tech="尽可能不要普通消除!",
		c4wtrain="无 限 连 击",
		pctrain="熟悉全清定式的组合",
		pcchallenge="100行内尽可能多全清",
		techmino49="49人混战",
		techmino99="99人混战",
		drought="异常序列",
		hotseat="友尽模式",
	},

	load={"加载语音ing","加载音乐ing","加载音效ing","加载完成",},
	tips={
		"不是动画，真的在加载!",
		"整个游戏都是MrZ完成的!",
		"大满贯10连击消四全清!",
		"<方块研究所>有一个Nspire-CX版本!",
		"B2B2B2B存在吗?",
		"MEGACMB!",
		"ALLSPIN!",
		"O型回旋三清?",
		"只用一个输入设备就可以游玩了",
		"Miya:喵!",
		"225238922,哔哩哔哩 干杯~",
		"适度游戏益脑,沉迷游戏伤身,合理安排时间,享受健康生活",
		"合群了就会消失，但是消失不代表没有意义",
		"学会使用两个旋转键,三个更好",
		"更小的DAS和ARR拥有更高的操作上限",
		"注意到\"旋转\"到底对方块做了些什么吗?",
		"20G是一套全新的游戏规则",
		"不要在上课时玩游戏!",
		"本游戏难度上限很高,做好心理准备",
		"方块可以不是个休闲游戏",
		"调到特殊的日期也不会发生什么的",
		"[随机文本]",
	},
	stat={
		"游戏运行次数:",
		"游戏局数:",
		"游戏时间:",
		"按键数:",
		"旋转数:",
		"暂存次数:",
		"方块使用:",
		"消行数:",
		"攻击行数:",
		"发送数:",
		"接收数:",
		"上涨数:",
		"消除数:",
		"旋转消行数:",
		"满贯数:",
		"全清数:",
		"效率:",
	},
	help={
		"好像也没啥好帮助的吧?就当是关于了",
		"这只是一个方块游戏,请勿过度解读和随意联想",
		"不过就当成TOP/C2/KOS/TGM3/JS玩好了",
		"游戏还在测试阶段,请 勿 外 传",
		"",
		"使用LOVE2D引擎",
		"作者:MrZ   邮箱:1046101471@qq.com",
		"程序:MrZ  美术:MrZ  音乐:MrZ  音效:MrZ 语音:Miya",
		"使用工具:VScode,GFIE,Beepbox,Goldwave",
		"特别感谢:Farter,Teatube,196,Flyz,T830,[所有测试人员]和 你!",
		"错误或者建议请附带相关信息发送到作者邮箱~",
	},
	support="支持作者",
	group="官方QQ群",
	ButtonText={
		main={
			play="开始",
			setting="设置",
			stat="统计信息",
			help="帮助",
			quit="退出",
		},
		mode={
			up="Λ",
			down="v",
			left="<",
			right=">",
			start="开始",
			custom="自定义(C)",
			back="返回",
		},
		custom={
			up="Λ",
			down="v",
			left="<",
			right=">",
			start1="消除开始",
			start2="拼图开始",
			draw="画图(D)",
			back="返回",
		},
		draw={
			free="不定",
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
			erase="×",
			clear="清空",
			back="返回",
		},
		play={
			pause="暂停",
		},
		pause={
			resume="继续",
			quit="退出",
		},
		setting={
			ghost=function()return setting.ghost and"阴影:开"or"阴影:关"end,
			center=function()return setting.center and"旋转中心:开"or"旋转中心:关"end,
			grid=function()return setting.grid and"网格:开"or"网格:关"end,
			swap=function()return setting.swap and"目标选择:组合键"or"目标选择:循环"end,
			fxs=function()return setting.fxs and"特效:开"or"特效:关"end,
			bg=function()return setting.bg and"背景:开"or"背景:关"end,
			dasD="-",dasU="+",
			arrD="-",arrU="+",
			sddasD="-",sddasU="+",
			sdarrD="-",sdarrU="+",
			ctrl="控制设置",
			touch="触摸设置",
			lang=function()return langName[setting.lang]end,
			sfx=function()return setting.sfx and"音效:开"or"音效:关"end,
			bgm=function()return setting.bgm and"音乐:开"or"音乐:关"end,
			vib=function()return "震动:"..setting.vib end,
			voc=function()return setting.voc and"语音:开"or"语音:关"end,
			fullscreen=function()return setting.fullscreen and"全屏:开"or"全屏:关"end,
			bgblock=function()return setting.bgblock and"背景动画:开"or"背景动画:关"end,
			frame=function()return"绘制帧:"..setting.frameMul.."%"end,
			skin="切换方块皮肤",
			back="保存&返回",
		},
		setting2={
			back="返回",
		},
		setting3={
			back="返回",
			hide=function()return setting.virtualkeySwitch and"隐藏虚拟按键"or"显示虚拟按键"end,
			default="默认组合",
			snap=function()return text.snapLevelName[snapLevel]end,
			alpha=function()return percent0to5[setting.virtualkeyAlpha]end,
			icon="图标",
			size="大小",
		},
		help={
			back="返回",
			qq="作者QQ",
		},
		stat={
			back="返回",
			path="打开存储目录",
		},
	},
}
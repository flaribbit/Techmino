return{
	royale_remain=function(n)
		return "剩余 "..n.." 名玩家"
	end,
	cmb={nil,nil,"3 Combo","4 Combo","5 Combo","6 Combo","7 Combo","8 Combo","9 Combo","10 Combo!","11 Combo!","12 Combo!","13 Combo!","14 Combo!","15 Combo!","16 Combo!","17 Combo!","18 Combo!","19 Combo!","MEGACMB"},
	techrash="Techrash",
	techrashB2B="Techrash B2B",
	techrashB3B="Techrash B2B2B",
	block={"Z","S","L","J","T","O","I"},
	spin={"Z-spin","S-spin","L-spin","J-spin","T-spin","O-spin","I-spin"},
	clear={" single"," double"," triple"},
	b2b="B2B ",
	b3b="B2B2B ",
	mini="Mini",
	PC="Perfect Clear",
	hold="暂存",
	next="下一个",

	stage={"关卡 1","关卡 2","关卡 3","关卡 4","关卡 5",},
	maxspeed="最高速度",
	speedup="速度加快",

	win="胜利",
	lose="失败",

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
		hold={"开","关"},
		sequence={"bag7","his4","随机"},
		visible={"可见","半隐形","全隐形"},
		target={10,20,40,100,200,500,1000,"∞"},
		freshLimit={0,8,15,"∞"},
		opponent={"无电脑",1,2,3,4,5,6,7,8,9,10,11},
	},
	softdropdas="软降DAS:",
	softdroparr="软降ARR:",
	snapLevelName={"任意摆放","10px吸附","20px吸附","40px吸附","60px吸附","80px吸附"},
	keyboard="键盘",
	joystick="手柄",
	setting2Help="方向键选择/翻页,回车修改,esc返回",


	actName={"左移:","右移:","顺时针旋转:","顺时针旋转:","180°旋转","硬降:","软降:","暂存:","切换攻击:","重新开始:","左瞬移:","右瞬移:","软降到底:"},
	modeName={
		[0]="自定义",
		"竞速","马拉松","经典","禅","无尽","单挑","仅TSD","隐形","挖掘","生存","科研",
		"全清训练","全清挑战","41人混战","99人混战","干旱","多人",
	},
	modeInfo={
		sprint="挑战世界纪录",
		marathon="尝试坚持到最后",
		classic="高速经典",
		zen="无重力消除200行",
		infinite="科研沙盒",
		solo="打败AI",
		tsd="尽可能做T旋消2",
		blind="最强大脑",
		dig="核能挖掘机",
		survivor="防守练习",
		tech="ALLSPIN练习",
		pctrain="熟悉全清定式的组合",
		pcchallenge="100行内尽可能多全清",
		techmino41="41人混战",
		techmino99="99人混战",
		drought="异常序列",
		hotseat="友尽模式",
	},

	loadTip="真在加载,不只是动画!",
	load={"加载材质ing","加载音乐ing","加载音效ing","加载完成",},
	tips={
		"The whole game is made by MrZ!",
		"Back to Back 10 combo Techrash PC!",
		"Techmino has a Nspire-CX edition!",
		"Is B2B2B2B possible?",
		"MrZ spin Penta!",
		"MEGACMB!",
		"ALLSPIN!",
		"O spin Techrash?"
	},
	stat={
		"游戏运行次数:",
		"游戏局数:",
		"游戏时间:",
		"总方块使用:",
		"总消行数:",
		"总攻击行数:",
		"总按键数:",
		"总旋转数:",
		"暂存次数:",
		"总旋转消行数:",
	},
	help={
		"好像也没啥好帮助的吧?就当是关于了",
		"这只是一个方块游戏,请勿过度解读和随意联想",
		"不过就当成TOP/C2/KOS/TGM3/JS玩好了",
		"游戏还在测试阶段,请 勿 外 传",
		"",
		"使用LOVE2D引擎",
		"作者:MrZ   邮箱:1046101471@qq.com",
		"程序:MrZ  美术:MrZ  音乐:MrZ  音效:MrZ",
		"使用工具:VScode,GFIE,Beepbox,Goldwave",
		"特别感谢:Farter,Teatube,196,Flyz,T830,[所有测试人员]和 你!",
		"错误或者建议请附带相关信息发送到作者邮箱~",
	},
	support="支持作者",
	group="官方QQ群",
	ButtonText={
		main={
			"开始",
			"设置",
			"统计信息",
			"帮助",
			"退出",
		},
		mode={
			"Λ",
			"v",
			"<",
			">",
			"开始",
			"自定义(C)",
			"返回",
		},
		custom={
			"Λ",
			"v",
			"<",
			">",
			"开始",
			"返回",
		},
		setting={
			function()return setting.ghost and"阴影 开"or"阴影 关"end,
			function()return setting.center and"旋转中心 开"or"旋转中心 关"end,
			"-",
			"+",
			"-",
			"+",
			"-",
			"+",
			"-",
			"+",
			function()return setting.sfx and"音效 开"or"音效 关"end,
			function()return setting.bgm and"音乐 开"or"音乐 关"end,
			function()return "震动强度:"..setting.vib end,
			function()return setting.fullscreen and"全屏 开"or"全屏 关"end,
			function()return setting.bgblock and"背景动画 开"or"背景动画 关"end,
			function()return"绘制帧:"..setting.frameMul.."%"end,
			"控制设置",
			"触摸设置",
			function()return langName[setting.lang]end,
			"保存&返回",
		},
		setting2={
			"返回",
		},
		setting3={
			"返回",
			function()return setting.virtualkeySwitch and"隐藏虚拟按键"or"显示虚拟按键"end,
			"默认组合",
			function()return text.snapLevelName[snapLevel]end,
			function()return percent0to5[setting.virtualkeyAlpha]end,
			"图标",
			"大小",
		},
		help={
			"返回",
			"作者QQ",
		},
		stat={
			"返回",
		},
	},
}--中文→
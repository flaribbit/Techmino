local gc=love.graphics
local int=math.floor
local format=string.format

do--setFont
	local newFont=gc.setNewFont
	local setNewFont=gc.setFont
	local fontCache,currentFontSize={}
	if love.filesystem.getInfo("font.ttf")then
		local fontData=love.filesystem.newFile("font.ttf")
		function setFont(s)
			local f=fontCache[s]
			if s~=currentFontSize then
				if f then
					setNewFont(f)
				else
					f=newFont(fontData,s)
					fontCache[s]=f
					setNewFont(f)
				end
				currentFontSize=s
			end
			return f
		end
	else
		function setFont(s)
			local f=fontCache[s]
			if s~=currentFontSize then
				if f then
					setNewFont(f)
				else
					f=newFont(s)
					fontCache[s]=f
					setNewFont(f)
				end
				currentFontSize=s
			end
			return f
		end
	end
end
do--dumpTable
	local tabs={
		[0]="",
		"\t",
		"\t\t",
		"\t\t\t",
		"\t\t\t\t",
		"\t\t\t\t\t",
	}
	function dumpTable(L,t)
		local s
		if t then
			s="{\n"
		else
			s="return{\n"
			t=1
		end
		local count=1
		for k,v in next,L do
			local T=type(k)
			if T=="number"then
				if k==count then
					k=""
					count=count+1
				else
					k="["..k.."]="
				end
			elseif T=="string"then
				if find(k,"[^0-9a-zA-Z_]")then
					k="[\""..k.."\"]="
				else
					k=k.."="
				end
			elseif T=="boolean"then k="["..k.."]="
			else assert(false,"Error key type!")
			end
			T=type(v)
			if T=="number"then v=tostring(v)
			elseif T=="string"then v="\""..v.."\""
			elseif T=="table"then v=dumpTable(v,t+1)
			elseif T=="boolean"then v=tostring(v)
			else assert(false,"Error data type!")
			end
			s=s..tabs[t]..k..v..",\n"
		end
		return s..tabs[t-1].."}"
	end
end
function addToTable(G,base)--Refresh default base with G-values
	for k,v in next,G do
		if type(v)==type(base[k])then
			if type(v)=="table"then
				addToTable(v,base[k])
			else
				base[k]=v
			end
		end
	end
end
function splitStr(s,sep)
	local L={}
	local p1,p2=1--start,target
	while p1<=#s do
		p2=find(s,sep,p1)or #s+1
		L[#L+1]=sub(s,p1,p2-1)
		p1=p2+#sep
	end
	return L
end
function toTime(s)
	if s<60 then
		return format("%.3fs",s)
	elseif s<3600 then
		return format("%d:%.2f",int(s/60),s%60)
	else
		local h=int(s/3600)
		return format("%d:%d:%.2f",h,int(s/60%60),s%60)
	end
end
function mStr(s,x,y)
	gc.printf(s,x-450,y,900,"center")
end
function mText(s,x,y)
	gc.draw(s,x-s:getWidth()*.5,y)
end
function mDraw(s,x,y,a,k)
	gc.draw(s,x,y,a,k,nil,s:getWidth()*.5,s:getHeight()*.5)
end
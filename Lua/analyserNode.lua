local module = {}
--[[
local function quadIn(t,b,c,d) t=t/d; return c*t*t+b; end;
local function quadOut(t,b,c,d) t=t/d; return -c*t*(t-2)+b; end;
local function Quad(st,val,ease,d)
	local t,f,con,nt,st,sd=tick()
	sd=val-st -- Change in Value
	f=ease=='In' and quadIn or quadOut -- Choose between Out/In
	con=game:GetService'RunService'.RenderStepped:connect(function() 
		nt=tick()-t
		local nv=math.max(.2,f(math.min(d,nt),st,sd,d)) -- New Value
		if nt>d then -- Easing done?
			con:disconnect()
			if ease~='In' then
				Quad(.2,'Out',.3) -- Drop the bar
			end
		end
		return nv
	end)
end
]]--

function getWaveStep(x, max)
	local value = math.sin(tick())*x*300/math.random(1,max-math.random(1,max/2));
	if value < 0 then 
		value = -value; 
	end;
	if value > max then 
		value = max; 
	end;
	return value;
end

function getTrueMax(x,max)
	local val = (x*max)/(max*7)
	if val > max then
		val = max
	end
	return val
end

function getRelMax(x,max)
	local val = (x*(max-10))/(max*7)
	if val > max then
		val = max
	end
	return val
end

function CheckSet(t,N,S,D) -- Number, Scale, Direction
	if N <= 0 or N > #t then return end -- because the bottom line can return nil
	local nS=t[N]
	--if S>nS then -- testing to see if this changes things
	Set(t,N,nS+(S-nS)/3,D)
	--end
end

function Set(t,N,S,D) -- Number, Scale, Direction
	if N <= 0 or N > #t then return end -- because the bottom line can return nil
	t[N] = S
	if D == nil then -- dont worry it wont give an error
		CheckSet(t,N-1,S,-1)
		CheckSet(t,N+1,S,1)
	else
		CheckSet(t,N+D,S,D)
	end
end

function module:CreateAnalyser(src,size)
	if size > ((2^5)-1) and size < ((2^15)+1) then
		local object = {
			fftSize = size,
			frequencyBinCount = size/2,
			source=src,
		}
		function object:SetFFTSize(number)
			if number > ((2^5)-1) and number < ((2^15)+1) then
				object.fftSize = number
				object.frequencyBinCount = object.fftSize/2
			else
				return error('DOMExecption: IndexSizeError')
			end
		end
		local mpl = 0
		function object:GetByteFrequencyData()
			local pl = object.source.PlaybackLoudness
			mpl = math.max(pl,mpl)
			pl = pl / 1000
			pl = math.min(1, pl * 1.6)
			local data = {}
			local function reverse(t)
				local n = #t
				local r = {}
				local i = 1
				for i = 1, n do
					r[i],r[n] = t[n],t[i]

					n = n - 1
				end
				return r
			end
			for i=1,object.frequencyBinCount do
				if data[i] == nil then
					data[i] = 0
				else
					data[i] = 0
				end
			end
			Set(data,math.ceil(pl * object.frequencyBinCount),pl * 255, nil)
			--data[1] = (pl*255)
			--data[2] = (pl*(255-10))
			--for i=3,object.frequencyBinCount do
			--	data[i] = getWaveStep(pl, 255)
			--end
			local d = reverse(data)
			return d
		end
		return object
	else
		return error('DOMExecption: IndexSizeError')
	end
end

return module

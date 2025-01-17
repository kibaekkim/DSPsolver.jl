function getDdIterTime()
	num = @dsp_ccall("getDdIterTimeSize", Cint, (Ptr{Void},), env.p)
	time = Array(Cdouble, num)
	@dsp_ccall("getDdIterTime", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, time)
	return time
end

function getDdMasterTime()
	num = @dsp_ccall("getDdMasterTimeSize", Cint, (Ptr{Void},), env.p)
	time = Array(Cdouble, num)
	@dsp_ccall("getDdMasterTime", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, time)
	return time
end

function getDdSubprobTime()
	num = @dsp_ccall("getDdSubprobTimeSize", Cint, (Ptr{Void},), env.p)
	time = Array(Cdouble, num)
	@dsp_ccall("getDdSubprobTime", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, time)
	return time
end

function getDdMasterObjValues()
	num = @dsp_ccall("getDdNumMasterObjValues", Cint, (Ptr{Void},), env.p)
	vals = Array(Cdouble, num)
	@dsp_ccall("getDdMasterObjValues", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, vals)
	return vals
end

function getDdSubPrimalBounds()
	num = @dsp_ccall("getDdNumSubproblemObjValues", Cint, (Ptr{Void},), env.p)
	vals = Array(Cdouble, num)
	@dsp_ccall("getDdSubproblemObjValues", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, vals)
	return vals
end

function getDdSubproblemObjValues()
	return getDdSubPrimalBounds()
end

function getDdSubDualBounds()
	num = @dsp_ccall("getDdNumSubDualBounds", Cint, (Ptr{Void},), env.p)
	vals = Array(Cdouble, num)
	@dsp_ccall("getDdSubDualBounds", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, vals)
	return vals
end

function getDdPrimalBounds()
	num = @dsp_ccall("getDdNumPrimalBounds", Cint, (Ptr{Void},), env.p)
	vals = Array(Cdouble, num)
	@dsp_ccall("getDdPrimalBounds", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, vals)
	return vals
end

function getDdDualBounds()
	num = @dsp_ccall("getDdNumDualBounds", Cint, (Ptr{Void},), env.p)
	vals = Array(Cdouble, num)
	@dsp_ccall("getDdDualBounds", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, vals)
	return vals
end

function getDdChangesOfMultiplier()
	num = getDdNumChangesOfMultiplier()
	changes = Array(Cdouble, num);
	@dsp_ccall("getDdChangesOfMultiplier", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, changes)
	return changes
end

for (func,rtn) in [(:getDdNumInfeasSolutions, Cint),
		   (:getDdCpuTime, Cdouble),
                   (:getDdNumChangesOfMultiplier, Cint),
                   (:getDdNumSubproblemObjValues, Cint),
                   (:getDdMasterTotalTime, Cdouble),
                   (:getDdLbTotalTime, Cdouble),
                   (:getDdUbTotalTime, Cdouble),
                   (:getDdCgTotalTime, Cdouble)]
	strfunc = string(func)
	@eval begin
		function $func()
			return @dsp_ccall($strfunc, $rtn, (Ptr{Void},), env.p)
		end
	end
end

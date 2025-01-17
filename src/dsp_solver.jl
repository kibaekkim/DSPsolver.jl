function freeSolver()
	check_problem()
	@dsp_ccall("freeTssSolver", Void, (Ptr{Void},), env.p)
end

function evaluateSolution(solution::Vector{Cdouble})
	@dsp_ccall("evaluateSolution", Void, (Ptr{Void}, Ptr{Cdouble}), env.p, convert(Vector{Cdouble}, solution))
end

function solveDe()
	@dsp_ccall("solveDe", Void, (Ptr{Void},), env.p)
end

function solveBd(nauxvars::Integer)
	@dsp_ccall("solveBd", Void, (Ptr{Void}, Cint), env.p, convert(Cint, nauxvars))
end
solveBd() = solveBd(1);

function solveDd(comm)
	@dsp_ccall("solveDd", Void, (Ptr{Void}, MPI.CComm), env.p, convert(MPI.CComm, comm))
end

if isdefined(:MPI)
	solveDd() = solveDd(MPI.COMM_WORLD);
else
	error("MPI package should be used.");
end

function solve(solver)
	if solver == DSP_SOLVER_DE
		solveDe();
	elseif solver == DSP_SOLVER_BD
		solveBd();
	elseif solver == DSP_SOLVER_DD
		solveDd();
	end
end
solve() = solve(env.solver);

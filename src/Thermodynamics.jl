module Thermodynamics

import Roots 
using Printf

struct Planet
	c_pa
	c_pl
	ρ_l
	g
	L_v
	R_a
	R_v
	e_sat0
	T_0
	σ
end

struct InversionError <: Exception
	var::String
end

Base.showerror(io::IO, e::InversionError) = (
	print(io, "InversionError: ", e.var)
)

function earth()
	c_pa = 1004.
	c_pl = 4186.
	ρ_l = 1e3
	g = 9.81
	L_v = 2.5104e6
	R_a = 287.
	R_v = 461.
	e_sat0 = 611.
	T_0 = 273.16
	σ = 5.67e-8
	return Planet(
		c_pa,
		c_pl,
		ρ_l,
		g,
		L_v,
		R_a,
		R_v,
		e_sat0,
		T_0,
		σ
	)
end

function e_sat(planet::Planet, T)
	return 	(
				planet.e_sat0 *
				exp(-planet.L_v / planet.R_v * (1.0/T - 1.0/planet.T_0))
			)
end

function q_sat(planet::Planet, T, p)
	return planet.R_a / planet.R_v * (e_sat(planet, T) / p)
end

function approximate_p_LCL(planet::Planet, p_s, RH_s)
	return p_s * RH_s ^ (
		1.0 / (
			(planet.L_v * planet.R_a) /
			(planet.R_v * planet.c_pa * planet.T_0) - 1.0
		)
	)
end

function mse(planet::Planet, T, z, q)
	return planet.c_pa * T + planet.g * z + planet.L_v * q
end

function invert_mse(planet::Planet, h, RH, z, p; T_ini = nothing)
	if T_ini == nothing
		T_ini = (h - planet.g * z) / planet.c_pa
	end
	err = (T) -> mse(planet, T, z, RH*q_sat(planet, T, p)) - h
	δT = 1.0
	T_low = T_ini - δT
	T_high = T_ini + δT
	while err(T_low)*err(T_high) >= 0 && T_low > 0.0
		δT = δT*2.0
		T_low = T_ini - δT
		T_high = T_ini + δT
	end
	if T_low < 0
		throw(InversionError(
			"could not find bracketing temperature interval"))
	end
	T = Roots.find_zero(err, (T_low, T_high))
	return T
end

function γ(planet::Planet, T, p)

	q = q_sat(planet, T, p)
	num1 = planet.L_v / (planet.R_a * T)
	den1 = planet.c_pl / planet.c_pa
	den2 = planet.L_v / (planet.R_v * T) - 1.0
	den3 = planet.L_v / (planet.c_pa * T)
	return (1.0 + q*num1) / (1.0 + q*(den1 + den2*den3))

end

end # module

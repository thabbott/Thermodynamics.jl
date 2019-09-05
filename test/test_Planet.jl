# Initialize objects for testing
c_pa = 1004.
c_pl = 4186.
g = 9.81
L_v = 2.5104e6
R_a = 287.
R_v = 461.
e_sat0 = 611.
T_0 = 273.16
σ = 5.67e-8
planet = Thermodynamics.Planet(
	c_pa,
	c_pl,
	g,
	L_v,
	R_a,
	R_v,
	e_sat0,
	T_0,
	σ
)
@test true
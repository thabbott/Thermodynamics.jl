import Thermodynamics
using Test
using Printf

# Initialize objects for testing
c_p = 1004.
g = 9.81
L_v = 2.5104e6
R_a = 287.
R_v = 461.
e_sat0 = 611.
T_0 = 273.16
σ = 5.67e-8
planet = Thermodynamics.planet(
	c_p,
	g,
	L_v,
	R_a,
	R_v,
	e_sat0,
	T_0,
	σ
)

# Run tests
@printf("test1\n")
@time @test include("test1.jl")
@printf("Finished\n")
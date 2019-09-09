p_s = 1e5
RH_s = 1.0
target = p_s
result = Thermodynamics.approximate_p_LCL(planet, p_s, RH_s)
@test target ≈ result atol = 1.0

RH_s = 0.8
target = 95362.0
result = Thermodynamics.approximate_p_LCL(planet, p_s, RH_s)
@test target ≈ result atol = 1.0

RH_s = 0.0
target = 0.0
result = Thermodynamics.approximate_p_LCL(planet, p_s, RH_s)
@test target ≈ result
T = 280.0
z = 1000.0
RH = 0.80
p = 800e2
q_sat = Thermodynamics.q_sat(planet, T, p)
mse = Thermodynamics.mse(planet, T, z, RH*q_sat)

target = T
result = Thermodynamics.invert_mse(planet, mse, RH, z, p)
@test target ≈ result atol = 0.1

target = T
result = Thermodynamics.invert_mse(planet, mse, RH, z, p; T_ini = 285.0)
@test target ≈ result atol = 0.1

target = T
result = Thermodynamics.invert_mse(planet, mse, RH, z, p; T_ini = 260.0)
@test target ≈ result atol = 0.1

@test_throws Thermodynamics.InversionError Thermodynamics.invert_mse(
	planet, mse, RH, z, p; T_ini = 10.0)
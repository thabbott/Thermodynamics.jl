target = 611.0000
result = Thermodynamics.e_sat(planet, planet.T_0)
@test target ≈ result atol = 0.001

target = 994.3510
result = Thermodynamics.e_sat(planet, 280.0)
@test target ≈ result atol = 0.001
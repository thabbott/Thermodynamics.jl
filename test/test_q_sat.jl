target = 0.003803
result = Thermodynamics.q_sat(planet, planet.T_0, 1e5)
@test target ≈ result atol = 0.000001

result = 0.06190
target = Thermodynamics.q_sat(planet, 280.0, 1e4)
@test target ≈ result atol = 0.00001
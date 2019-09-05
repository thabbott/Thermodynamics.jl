T = 280.0
z = 1000.0
q = 0.01

target = 316034.
result = Thermodynamics.mse(planet, T, z, q)
@test target ≈ result atol = 1.0
target = 0.53823
result = Thermodynamics.γ(planet, 280.0, 800e2)
@test target ≈ result atol = 0.0001
import Thermodynamics
using Test
using Printf

tests = [
	"test_Planet.jl",
	"test_InversionError.jl",
	"test_e_sat.jl",
	"test_q_sat.jl",
	"test_mse.jl",
	"test_invert_mse.jl",
	"test_gamma.jl"
]

# Run tests
for test in tests
	@printf("%s\n", test[6:end-3])
	@time include(test)
end
@printf("Finished\n")
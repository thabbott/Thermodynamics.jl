try
	throw(Thermodynamics.InversionError("synthetic error for testing\n"))
catch err
	showerror(stdout, err)
end
@test true
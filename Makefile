lift:
	./scripts/lift.sh $(filter-out $@, $(MAKECMDGOALS))

apply:
	qubesctl --targets $(filter-out $@, $(MAKECMDGOALS)) state.apply

%:
	@:

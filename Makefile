lift:
	./scripts/lift.sh $(filter-out $@, $(MAKECMDGOALS))

targets:
	qubesctl --targets $(filter-out $@, $(MAKECMDGOALS)) state.apply

%:
	@:

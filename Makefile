lift:
	./scripts/lift.sh $(filter-out $@, $(MAKECMDGOALS))

%:
	@:

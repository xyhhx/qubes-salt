.PHONY: lift
lift:
	./scripts/lift.sh $(filter-out $@, $(MAKECMDGOALS))

.PHONY: apply-sls
apply-sls:
	qubesctl --targets $(TARGET) state.sls $(SLS) saltenv=user

.PHONY: apply-top
apply-top:
	qubesctl --targets $(TARGET) state.highstate

.PHONY: highstate
highstate:
	qubesctl --all state.highstate

%:
	@:

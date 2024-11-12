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

# templates:
# 	find ./srv/user/salt/templates -type f -name "*.top" | \
# 		sed 's/.*\/\(.*\).top/\1/' | \
# 		sudo xargs -I {} \
# 			qubesctl state.apply templates.{} saltenv=user --state-output=mixed

%:
	@:

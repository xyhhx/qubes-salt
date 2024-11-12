lift:
	./scripts/lift.sh $(filter-out $@, $(MAKECMDGOALS))

apply:
	qubesctl --targets $(filter-out $@, $(MAKECMDGOALS)) state.apply

templates:
	find ./srv/user/salt/templates -type f -name "*.top" | \
		sed 's/.*\/\(.*\).top/\1/' | \
		sudo xargs -I {} \
			qubesctl state.apply templates.{} saltenv=user --state-output=mixed

%:
	@:
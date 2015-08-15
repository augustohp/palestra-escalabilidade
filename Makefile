install:
	@echo "Checking for Vagrant plugin: Landrush"
	@test -z "$(vagrant plugin list | grep landrush)" && vagrant plugin install landrush
	@echo "Checking for Vagrant plugin: Cashier"
	@test -z "$(vagrant plugin list | grep vagrant-cachier)" && vagrant plugin install vagrant-cachier

.PHONY: install

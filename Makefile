PUPPET_DIR=puppet

clean:
	-@rm -rf ${PUPPET}/modules/*

install-puppet-librarian:
	gem install librarian-puppet || echo "You should have Ruby installed and `gem` binary available in your PATH"

install-vagrant-plugins:
	@echo "Checking for Vagrant plugin: Bindler..."
	@test -z "$(vagrant plugin list | grep bindler)" && vagrant plugin install bindler && vagrant bindler setup
	@echo "Installing dependencies with Bindler..."
	@vagrant plugin bundle

install: clean install-puppet-librarian install-vagrant-plugins
	cd puppet && librarian-puppet install || echo "You may want to run: make install-puppet-librarian"

.PHONY: clean install-puppet-librarian install

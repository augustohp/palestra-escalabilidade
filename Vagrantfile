machines = [
    {:host=>"www", :ip=>"192.168.42.2", :ram=>256, :provision=>"null.sh"},
    {:host=>"cache1", :ip=>"192.168.42.10", :ram=>256, :provision=>"null.sh"},
    {:host=>"www1", :ip=>"192.168.42.20", :ram=>256, :provision=>"php.sh"},
    {:host=>"www2", :ip=>"192.168.42.21", :ram=>256, :provision=>"php.sh"}
]

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    local_domain = ".pascutti.localhost"

    # https://github.com/fgrehm/vagrant-cachier
    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
        config.cache.synced_folder_opts = {
            type: :nfs,
            mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
        }
    end

    # https://github.com/smdahlen/vagrant-hostmanager
    if Vagrant.has_plugin?('vagrant-hostmanager')
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.include_offline = true
    end

    machines.each do |vm|
        config.vm.define vm[:host] do |server|
            hostname = vm[:host] + local_domain
            document_root = "/var/www"
            server.vm.synced_folder "./app", document_root,
                owner: "www-data",
                group: "www-data",
                id: "vagrant-root",
                :nfs => false
            server.vm.hostname = hostname
            server.vm.network :private_network, ip: vm[:ip]
            host_memory = vm[:ram] ? vm[:ram] : 128
            server.vm.provider :virtualbox do |vbox|
                vbox.customize [
                    "modifyvm", :id,
                    "--name", hostname,
                    "--memory", host_memory.to_s
                ]
            end

            if Vagrant.has_plugin?('vagrant-hostmanager')
                server.hostmanager.aliases = vm[:host]
            end

            server.vm.provision :shell, path: "usr/bin/provision.sh", args: [vm[:provision], vm[:ip], hostname, document_root+"/public"]
        end
    end
end
# vim: et ts=4 sw=4 ft=ruby:

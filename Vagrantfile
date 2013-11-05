# Machine list and properties
machine_list = [
    {:name=>"gw", :ip=>"192.168.42.10", :ram=>256, :manifests=>['shared.pp','haproxy.pp']},
    {:name=>"cache1", :ip=>"192.168.42.11", :ram=>256, :manifests=>['shared.pp']},
    {:name=>"cache2", :ip=>"192.168.42.12", :ram=>256, :manifests=>['shared.pp']},
    {:name=>"web1", :ip=>"192.168.42.21", :ram=>256, :manifests=>['shared.pp','apache.pp', 'php.pp']},
    {:name=>"web2", :ip=>"192.168.42.22", :ram=>256, :manifests=>['shared.pp','apache.pp', 'php.pp']}
]

Vagrant.configure("2") do |global|
    # Configuration for all machines
    puppet_dir = '.puppet'
    tld = '.phpsp.dev'
    global.vm.box = "precise64"
    global.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # Every machine configuration
    machine_list.each do |options|
        global.vm.define options[:name] do |server|
            # Variables
            host_name = options[:name]+tld
            host_memory = options[:ram] ? options[:ram] : 128
            net_ipv4_addr = options[:ip]
            puppet_manifests = options[:manifests]
            # Machine configuration
            server.vm.hostname = host_name
            server.vm.network :private_network, ip: net_ipv4_addr
            server.vm.provider :virtualbox do |vbox|
                vbox.customize [
                    "modifyvm", :id,
                    "--name", host_name,
                    "--memory", host_memory.to_s
                ]
            end
            # Machine provision
            server.vm.provision :puppet do |puppet|
                puppet.manifests_path = puppet_dir+"/manifests"
                puppet.module_path = puppet_dir+"/modules"
                puppet.facter = { 'fqdn' => host_name }
                puppet_manifests.each do |manifest|
                    puppet.manifest_file = manifest
                end
            end
        end
    end
end

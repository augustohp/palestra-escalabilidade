# Guia do Mochileiro pra Escalabilidade

Conjunto de máquinas virtuais para testar situações de alta escalabilidade, desenvolvida para
estudos e uso em [apresentações][palestra]. Fornece um [load balancer][haproxy] para duas
máquinas [PHP][] servindo uma aplicação através de um [cache HTTP][varnish].

Você pode usar o diretório `app` para colocar sua própria aplicações, assim como modificar
o `Vagrantfile` pra adicionar mais máquinas e provisioná-las como desejar.

PS: essas máquinas virtuais são para estudo, e não para benchmarks.

## Como usar?!

Requisitos (ou as coisas que você deveria ter instalado):

* [Vagrant][]
* [VirtualBox][]

As VMs são criadas usando [Vagrant][], supondo que você já tenha ele instalado no
seu sistema:

    $ vagrant plugin install vagrant-hostmaneger
    $ vagrant up

Com isso, todas as VMs estarão disponíveis, você pode acessá-las usando http://www.pascutti.localhost
ou via SSH usando o [Vagrant][]:

    $ vagrant ssh www1

Eu só testei essa configuração no OSX mas elas deveriam funcionar também no Linux.

## As máquinas virtuais

O [Vagrant][] irá criar máquinas virtuais usando [VirtualBox][]:

1. www: O gateway (ou proxy) usando [haproxy][].
1. cache1: A máquina de cache HTTP usando [varnish][]
1. www1: Apache + PHP servindo nossa aplicação usando [apache][] e [php][]
1. www2: Uma cópia idêntica da máquina acima.

Todas as máquinas usam no máximo 256 RAM, o que significa um total de 1G de RAM
pra levantar todas as VMs. Se você tem 4GB de RAM no seu computador, se prepare
pras lentidões ao levantar essas VMS.

## Precisa de ajuda?

Crie uma [issue][]! Hesitações não serão toleradas. Se estiver com vergonha,
me envie um email em *augusto.hp @ gmail.com*.

[issue]: https://github.com/augustohp/palestra-escalabilidade/issues
[virtualbox]: https://www.virtualbox.org/
[palestra]: http://joind.in/talk/view/10239
[vagrant]: http://vagrantup.com
[varnish]: https://www.varnish-cache.org/
[haproxy]: http://haproxy.1wt.eu/
[php]: http://php.net

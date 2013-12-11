# Guia do Mochileiro pra Escalabilidade

Sua aplicação está lenta? Você tem uma página que leva séculos pra carregar? Um relatório imenso que consulta muita informação?! Seu problema é performance e provavelmente isso aqui não vai te ajudar. Desculpe.

Se você tem uma aplicação na web que recebeu mais atenção que você esperava e menos do que ela deveria (que não consegue atender a demanda crescente de novos usuários), então aqui é o seu lugar. Vamos escalar ela!

## Como esse repositório me é útil?

Eu ainda não sei, porque nesse exato momento ele só contém idéias.

Eu tenho [uma apresentação](palestra) na [PHP Conference Brasil 2013][phpconfbr] sobre escalabilidade, esse repositório é a estrutura de uma aplicação bem simples usada pra apresentar conceitos como [cache HTTP][cache] e [proxies TCP][proxies].

Certamente ele será útil pra você exprimentar com esse conceitos e aprender, mas duvido (e jamais aconselharei a favor) que você irá utilizar esse repositório pra construir ou servir alguma aplicação (apesar da licença permitir isso).

## O que tem nesse repositório

Uso o [Vagrant][vagrant] pra criar (e ajudar a configurar com o [Puppet][puppet])
algumas máquinas virtuais usando [VirtualBox][virtualbox]. São elas:

- gw: O gateway (ou proxy) usando [haproxy][].
- cache1: A máquina de cache HTTP usando [varnish][]
- web1: Apache + PHP servindo nossa aplicação usando [apache][] e [php][]
- web2: Uma cópia idêntica da máquina acima.

A arquitetura final, com todas as máquinas virtuais (~256mb de RAM cada) é essa:

```
                              +------------+
                              |  Internet  |   <-- Uma conexão, porta 80 (TCP),
                              +------------+
                                    +
                                    v
                              +------------+
                              |     gw     |   <-- Chega aqui, porta 80,
                              +------------+   
                                    +           
                                    |           
                                    v           
                               +--------+               
                            +-+| cache1 |+--+  <-- Passam por aqui,
                            |  +--------+   |            
                            |               |
                            v               v
                         +--------+     +--------+
                         |  web1  |     |  web2  |    <-- Se necessário, chega
                         +--------+     +--------+        aqui.
```

## Como usar?!

Espero que você saiba um pouco sobre [Unix][], então serei breve:

```
$ cd <path pra esse repo>
$ sudo make install
$ vagrant up
$ vagrant ssh gw
vagrant@gw $ echo "Você está dentro do Gateway"
vagrant@gw $ exit
$ vagrant ssh web1
vagrant@web1 $ echo "Onde está Wally?!"
```

### Requisitos pra instalação (e instalando)

Os requisitos básicos, em qualquer sistema operacional são: [vagrant][] e [virtualbox][].
Com ambos instalados, via terminal (seu *shell* preferido) no diretório do projeto
é só executar um `make install && vagrant up`, todas as VMs devem ser criadas e
provisionadas.

Se você examinar o arquivo `Makefile` verá que o *Ruby 1.8* é necessário por
causa de uma GEM que utilizo pra gerenciar os módulos do [puppet][], se isso for
um problema, crie um bug que posso facilmente remover essa dependência.

Se você tiver qualquer outro problema, crie um [bug][issue] com todo o output
do terminal.

### Acessando as máquinas

Toda VM possui o *hostname* exibido na lista de VMs (gw, cache1, web1, web2) e
está dentro do mesmo domínio: `phpsp.dev`.

Pra acessar via [ssh][] uma máquina, é só utilizar o [vagrant][] em conjunto com
o *hostname* desejado: `vagrant ssh <hostname>`.

Para acessar via navegador, basta usar o conjunto `<hostname>.phpsp.dev`. Todas
as máquinas são acessíveis mas o `www.phpsp.dev` (que não existe de propósito)
seria (num ambiente real) o `gw.phpsp.dev`.

### Modificando e Restaurando

Todo este repositório foi feito pra ser modificado. Tomei alguns cuidados com
o `Vagrantfile`, só os `Puppetfile` não utilizam *templates* e possuem as configurações
fixas com os IPs declarados (contribuições são bem vindas).

Fique livre pra exprimentar com as configurações, se você precisar restaurar
alguma coisa depois: `vagrant provision <hostname>`.

Se uma merda violenta acontecer: `vagrant destroy <hostname>`.

## Dúvidas/Problemas?

Cria uma [issue][]! :D

[issue]: https://github.com/augustohp/palestra-escalabilidade/issues
[virtualbox]: https://www.virtualbox.org/
[palestra]: http://joind.in/talk/view/10239
[phpconfbr]: http://phpconference.com.br
[vagrant]: http://vagrantup.com
[puppet]: http://puppetlabs.com/
[varnish]: https://www.varnish-cache.org/
[haproxy]: http://haproxy.1wt.eu/ 
[unix]: https://en.wikipedia.org/wiki/Unix
[php]: http://php.net
[apache]: https://httpd.apache.org/
[cache]: https://en.wikipedia.org/wiki/Http_cache
[proxies]: https://en.wikipedia.org/wiki/Proxy_server

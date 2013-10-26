# Guia do Mochileiro pra Escalabilidade

Sua aplicação está lenta? Você tem uma página que leva séculos pra carregar? Um relatório imenso que consulta muita informação?! Seu problema é performance e provavelmente isso aqui não vai te ajudar. Desculpe.

Se você tem uma aplicação na web que recebeu mais atenção que você esperava e menos do que ela deveria (que não consegue atender a demanda crescente de novos usuários), então aqui é o seu lugar. Vamos escalar ela!

## Como esse repositório me é útil?

Eu ainda não sei, porque nesse exato momento ele só contém idéias.

Eu tenho [uma apresentação](slides) na [PHP Conference Brasil 2013][phpconfbr] sobre escalabilidade, esse repositório é a estrutura de uma aplicação bem simples usada pra apresentar conceitos como [cache HTTP][cache] e [proxies TCP][proxies].

Certamente ele será útil pra você exprimentar com esse conceitos e aprender, mas duvido (e jamais aconselharei a favor) que você irá utilizar esse repositório pra construir ou servir alguma aplicação (apesar da licença permitir isso).

## O que tem nesse repositório

Uso o [Vagrant][vagrant] pra criar (e ajudar a configurar com o [Puppet][puppet]) 5 máquinas virtuais usando [VirtualBox][virtualbox]. São elas:

- gw: O gateway (ou proxy)
- cache1: A máquina de cache HTTP
- cache2: Uma cópia idéntica da máquina acima
- web1: Apache + PHP servindo nossa aplicação
- web2: Uma cópia idêntica da máquina acima

A arquitetura final, com todas as 5 máquinas virtuais (~356mb de RAM de uso de cada máquina) é essa:

```
                              +------------+
                              |  Internet  |           <-- Os mano sai daqui, porta 80 (TCP)
                              +------------+
                                    +
                                    v
                              +------------+
                           +-+|     gw     |+-+       <-- Os mano chega aqui, porta 80
                           |  +------------+  |
                           |                  |
                           |                  |
                           v                  v
                         +--------+     +--------+
                         | cache1 |     | cache2 |    <-- Passam por aqui
                         +--------+     +--------+
                              +             +
                              v             v
                         +--------+     +--------+
                         |  web1  |     |  web2  |    <-- E só os mano "carecido", chega aqui.
                         +--------+     +--------+
```

## Como usar?!

Espero que você saiba um pouco sobre [Unix][], então serei breve:

```
$ cd <path pra esse repo>
$ vagrant up
$ vagrant ssh gw
vagrant@gw $ echo "Você está dentro do Gateway"
vagrant@gw $ exit
$ vagrant ssh web1
vagrant@web1 $ echo "Onde está Wally?!"
```

# Objetivos da apresentação

- Escalabilidade na arquitetura da aplicação. Isso aqui não é brincadeira.
- Enaltecer (to gastando no português) o protocolo HTTP (e o porquê ele escala).
- Apresentar soluções que escalam, agnósticas à aplicação (tchau MySQL).
- Exemplos **práticos** e **reais**. (Sem exemplo? Fora apresentação)
- Declarar os problemas de uma solução, se possível com exemplos também. (Nada de foder ninguém no futuro)

## Títulos dos slides

Abaixo o *outline* das idéias e o fluxo da apresentação:

- Escalabilidade
    - Escalar vs Performance
    - Botando pra foder: Apache Benchmark
        - O output do Apache Benchmark
        - Métrica pra Mochila: Requests por segundo.
    - Primeira carona: Cache HTTP com Varnish
        - Mecanismos de controle
            - *Freshness* (Expires, Cache-Control)
            - *Validation* (Last-Modified)
            - Amigo do HTTP: Cabeçalho **Vary**
        - Botando pra foder de novo (ab)
        - Comparando resultados
    - Segunda carona, pra galera: HAProxy
        - HTTP e o estado no cliente, um aviso
        - HAProxy: da galera pra múltiplos servers
        - Botando pra foder de novo (ab)
        - Métrica pra mochila: CPU, Memória e IO
    - Terceira carona, algumas coisas da minha mochila:
        - Métricas são essenciais! (NewRelic, Nagios, Graphite)
        - Conteúdo estático vs Conteúdo dinâmico (em servidores diferentes, plz)
        - Cache HTTP, funciona. (Varnish, Apache)
        - MySQL escala (até no YouTube)! (Confie na replicação, fuja do multi-master)
        - Cache. Funciona! (APC, MemCache, Redis)
        - Logs. Logs bro. Tenha (bons) logs! (Monolog, Graylog, LogStash)
        - Filas, tire o coelho da cartola! (RabbitMQ, ZeroMQ, ESB)
    - Perguntas

## Conceitos a serem persistidos

- Medindo a escalabilidade (Botando pra foder)
- Obter e analisar métricas relevantes (Coisas pra mochila)
- Soluções que escalam independentes da aplicação (Pegando carona)

## Softwares utilizados 

- VirtualBox
- Vagrant
- Ubuntu
- Puppet
- Apache 
- Varnish
- HAProxy

Essa galera merece nossa grana. De verdade.

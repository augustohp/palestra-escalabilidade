<?php

require __DIR__.'/../boot.php';
$quotes = [
    "Gozado, justamente quando você pensa que a vida não pode ser pior, de repente ela piora ainda mais.",
    "Ah, a vida! Pode-se odiá-la ou ignorá-la, mas é impossivel gostar dela.",
    "Vida? Não me fale de vida.",
    "É bom que vocês saibam, hoje eu estou muuuito deprimido...",
    "Eu tenho milhões de idéias, mas todas apontam para morte certa.",
    "Eu poderia calcular suas chances de sobrevivência... mas você não iria gostar...",
    "Eu desprezo todos vocês.",
    "Eu fico com dor de cabeça só de tentar rebaixar meu intelecto ao seu nível.",
    "E eu com essa dor terrível nos meus diodos esquerdos.",
    "Estive conversando com o computador da nave. Ele me odeia.",
    "Isso tudo terminará em lágrimas.",
    "Minha felicidade caberia numa caixa de fósforos. Com os fósforos.",
    "São as pessoas com quem trabalho que realmente me deprimem.",
    "Não finja que você quer falar comigo, eu sei que você me odeia.",
    "A melhor conversa que tive foi há 40 milhões de anos, com uma máquina de café.",
    "Eu não vou gostar disso.",
    "Este é o tipo de coisa que vocês, formas de vida, gostam. Não é?",
    "Odeio oceanos.",
    "Esse sou eu, cérebro do tamanho de um planeta e você me pede para levá-lo pra ponte de comando. Você chama isso de satisfação profissional? Pois eu não!"
];

$router = new Respect\Rest\Router;

$router->head('/health', function() {
    header('HTTP/1.1 200 Everything is fine');
});

$router->get('/', function() use ($quotes) {
    header('HTTP/1.1 301 Get a random quote');
    header('Location: /quote/random');
});

$router->get('/quote/random', function () use ($quotes) {
    $amountOfQuotes = count($quotes);
    $randomQuoteIndex = mt_rand(0, $amountOfQuotes-1);

    header('HTTP/1.1 307 Random generator');
    header('Cache-Control: no-cache');
    header('Location: /quote/index/'.$randomQuoteIndex);

});

$router->get('/quote/index/*', function($index) use ($quotes) {
    if (false === isset($quotes[$index])) {
        header('HTTP/1.1 404 Quote not found');
    }

    $quote = $quotes[$index];
    header('HTTP/1.1 200 42');
    header('ETag: '.md5($quote));
    header('Last-Modified: '.date('r', strtotime('2013-11-29 00:00:00')));
    header('Cache-Control: public');
    require __DIR__.'/../templates/quote.php';
});

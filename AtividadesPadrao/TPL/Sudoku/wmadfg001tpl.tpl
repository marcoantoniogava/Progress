<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sudoku</title>
<link href="/sistema/templates/wmadfg001tpl.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
</head>

<body>

<header>
  <h1>Sudoku</h1>
  <p>Preencha o tabuleiro com lógica</p>
</header>

<div class="difficulty-row">
  <button class="diff-btn active" data-diff="easy">Fácil</button>
  <button class="diff-btn" data-diff="medium">Médio</button>
  <button class="diff-btn" data-diff="hard">Difícil</button>
</div>

<div class="game-area">
  <div id="timer">00:00</div>
  <div id="board"></div>
  <div id="numpad"></div>
  <div class="actions">
    <button class="btn btn-primary" id="newBtn">Novo jogo</button>
    <button class="btn btn-validate" id="validateBtn">Verificar</button>
    <button class="btn btn-secondary" id="solveBtn">Revelar</button>
  </div>
  <div id="feedback"></div>
</div>

<script src="/sistema/templates/wmadfg001tpl.js"></script>

</body>
</html>
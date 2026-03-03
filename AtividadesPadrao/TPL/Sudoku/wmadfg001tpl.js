// ??? Sudoku Engine ????????????????????????????????????????????????????????????

function createEmptyGrid() { return Array.from({length:9}, ()=>Array(9).fill(0)); }

function isValid(grid, r, c, num) {
  for(let i=0;i<9;i++) {
    if(grid[r][i]===num || grid[i][c]===num) return false;
    const br=3*Math.floor(r/3)+Math.floor(i/3);
    const bc=3*Math.floor(c/3)+i%3;
    if(grid[br][bc]===num) return false;
  }
  return true;
}

function solve(grid, randomize=false) {
  for(let r=0;r<9;r++) {
    for(let c=0;c<9;c++) {
      if(grid[r][c]===0) {
        let nums=[1,2,3,4,5,6,7,8,9];
        if(randomize) nums.sort(()=>Math.random()-0.5);
        for(let n of nums) {
          if(isValid(grid,r,c,n)) {
            grid[r][c]=n;
            if(solve(grid,randomize)) return true;
            grid[r][c]=0;
          }
        }
        return false;
      }
    }
  }
  return true;
}

function generatePuzzle(difficulty) {
  // Build full solution
  const solution = createEmptyGrid();
  solve(solution, true);

  // Remove cells based on difficulty
  const removals = { easy: 36, medium: 46, hard: 54 };
  const toRemove = removals[difficulty] || 36;

  const puzzle = solution.map(r=>[...r]);
  let removed = 0;
  const attempts = toRemove * 5;

  for(let a=0;a<attempts && removed<toRemove;a++) {
    const r=Math.floor(Math.random()*9), c=Math.floor(Math.random()*9);
    if(puzzle[r][c]===0) continue;
    const backup = puzzle[r][c];
    puzzle[r][c] = 0;
    // quick uniqueness check: count solutions
    const copy = puzzle.map(x=>[...x]);
    let count=0;
    function countSolutions(g) {
      for(let i=0;i<9;i++) for(let j=0;j<9;j++) {
        if(g[i][j]===0) {
          for(let n=1;n<=9;n++) {
            if(isValid(g,i,j,n)) {
              g[i][j]=n;
              countSolutions(g);
              g[i][j]=0;
              if(count>1) return;
            }
          }
          return;
        }
      }
      count++;
    }
    countSolutions(copy);
    if(count===1) { removed++; }
    else { puzzle[r][c]=backup; }
  }

  return { puzzle, solution };
}

// ??? UI State ?????????????????????????????????????????????????????????????????

let state = {
  puzzle: createEmptyGrid(),
  solution: createEmptyGrid(),
  userGrid: createEmptyGrid(),
  selected: null,
  difficulty: 'easy',
  timerInterval: null,
  seconds: 0,
};

// ??? Board Rendering ??????????????????????????????????????????????????????????

function renderBoard() {
  const board = document.getElementById('board');
  board.innerHTML = '';
  for(let r=0;r<9;r++) {
    for(let c=0;c<9;c++) {
      const cell = document.createElement('div');
      cell.className = 'cell';
      cell.dataset.row = r;
      cell.dataset.col = c;
      cell.tabIndex = 0;

      if(state.puzzle[r][c] !== 0) {
        cell.classList.add('given');
        cell.textContent = state.puzzle[r][c];
      } else if(state.userGrid[r][c] !== 0) {
        cell.classList.add('user-input');
        cell.textContent = state.userGrid[r][c];
      }

      cell.addEventListener('click', () => selectCell(r, c));
      board.appendChild(cell);
    }
  }
  highlightSelection();
}

function getCellEl(r, c) {
  return document.querySelector(`.cell[data-row="${r}"][data-col="${c}"]`);
}

function selectCell(r, c) {
  state.selected = [r, c];
  highlightSelection();
}

function highlightSelection() {
  document.querySelectorAll('.cell').forEach(el => {
    el.classList.remove('selected','highlight','same-num');
  });
  if(!state.selected) return;
  const [sr, sc] = state.selected;
  const selNum = getCellValue(sr, sc);

  for(let r=0;r<9;r++) {
    for(let c=0;c<9;c++) {
      const el = getCellEl(r,c);
      if(r===sr && c===sc) { el.classList.add('selected'); continue; }
      const sameRow = r===sr, sameCol = c===sc;
      const sameBox = Math.floor(r/3)===Math.floor(sr/3) && Math.floor(c/3)===Math.floor(sc/3);
      if(sameRow||sameCol||sameBox) el.classList.add('highlight');
      if(selNum && getCellValue(r,c)===selNum) el.classList.add('same-num');
    }
  }
}

function getCellValue(r, c) {
  return state.puzzle[r][c] || state.userGrid[r][c] || 0;
}

function updateCell(r, c) {
  const el = getCellEl(r,c);
  el.classList.remove('user-input','given','error');
  if(state.puzzle[r][c]) {
    el.classList.add('given');
    el.textContent = state.puzzle[r][c];
  } else if(state.userGrid[r][c]) {
    el.classList.add('user-input');
    el.textContent = state.userGrid[r][c];
  } else {
    el.textContent = '';
  }
}

// ??? Input ????????????????????????????????????????????????????????????????????

function inputNum(num) {
  if(!state.selected) return;
  const [r, c] = state.selected;
  if(state.puzzle[r][c] !== 0) return; // given cell
  state.userGrid[r][c] = num;
  updateCell(r,c);
  highlightSelection();
  clearFeedback();
}

// Keyboard
document.addEventListener('keydown', e => {
  if(!state.selected) return;
  const [r,c] = state.selected;

  if(e.key>='1'&&e.key<='9') { inputNum(parseInt(e.key)); return; }
  if(e.key==='Backspace'||e.key==='Delete'||e.key==='0') { inputNum(0); return; }

  // arrow navigation
  const dirs = {ArrowUp:[-1,0],ArrowDown:[1,0],ArrowLeft:[0,-1],ArrowRight:[0,1]};
  if(dirs[e.key]) {
    e.preventDefault();
    const [dr,dc]=dirs[e.key];
    const nr=Math.min(8,Math.max(0,r+dr)), nc=Math.min(8,Math.max(0,c+dc));
    selectCell(nr,nc);
  }
});

// ??? Numpad ???????????????????????????????????????????????????????????????????

function renderNumpad() {
  const np = document.getElementById('numpad');
  np.innerHTML = '';
  for(let i=1;i<=9;i++) {
    const b = document.createElement('button');
    b.className='num-btn'; b.textContent=i;
    b.addEventListener('click',()=>inputNum(i));
    np.appendChild(b);
  }
}

// ??? Validation ???????????????????????????????????????????????????????????????

function validate() {
  // Check if all filled
  let allFilled = true;
  for(let r=0;r<9;r++) for(let c=0;c<9;c++) {
    if(!state.puzzle[r][c] && !state.userGrid[r][c]) { allFilled=false; break; }
  }

  if(!allFilled) {
    showFeedback('? Ainda faltam casas vazias para preencher.', 'incomplete');
    return;
  }

  // Check correctness
  let correct = true;
  for(let r=0;r<9;r++) for(let c=0;c<9;c++) {
    const val = state.puzzle[r][c] || state.userGrid[r][c];
    const el = getCellEl(r,c);
    el.classList.remove('error');
    if(val !== state.solution[r][c]) {
      correct=false;
      if(!state.puzzle[r][c]) el.classList.add('error');
    }
  }

  if(correct) {
    showFeedback('?? Sudoku correto! Parabéns!', 'correct');
    stopTimer();
  } else {
    showFeedback('? Sudoku incorreto. Verifique os números em vermelho.', 'wrong');
  }
}

// ??? Feedback ?????????????????????????????????????????????????????????????????

function showFeedback(msg, type) {
  const el = document.getElementById('feedback');
  el.textContent = msg;
  el.className = `show ${type}`;
}

function clearFeedback() {
  const el = document.getElementById('feedback');
  el.className = '';
}

// ??? Timer ????????????????????????????????????????????????????????????????????

function startTimer() {
  stopTimer();
  state.seconds = 0;
  state.timerInterval = setInterval(()=>{
    state.seconds++;
    const m=String(Math.floor(state.seconds/60)).padStart(2,'0');
    const s=String(state.seconds%60).padStart(2,'0');
    document.getElementById('timer').textContent=`${m}:${s}`;
  },1000);
}

function stopTimer() {
  if(state.timerInterval) clearInterval(state.timerInterval);
}

// ??? New Game ?????????????????????????????????????????????????????????????????

function newGame() {
  const { puzzle, solution } = generatePuzzle(state.difficulty);
  state.puzzle = puzzle;
  state.solution = solution;
  state.userGrid = createEmptyGrid();
  state.selected = null;
  clearFeedback();
  renderBoard();
  startTimer();
}

function revealSolution() {
  state.userGrid = state.solution.map(r=>[...r]);
  for(let r=0;r<9;r++) for(let c=0;c<9;c++) {
    if(!state.puzzle[r][c]) updateCell(r,c);
  }
  stopTimer();
  showFeedback('Solução revelada.', 'incomplete');
}

// ??? Init ?????????????????????????????????????????????????????????????????????

document.querySelectorAll('.diff-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.diff-btn').forEach(b=>b.classList.remove('active'));
    btn.classList.add('active');
    state.difficulty = btn.dataset.diff;
    newGame();
  });
});

document.getElementById('newBtn').addEventListener('click', newGame);
document.getElementById('validateBtn').addEventListener('click', validate);
document.getElementById('solveBtn').addEventListener('click', revealSolution);

renderNumpad();
newGame();
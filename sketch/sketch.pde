enum Estado {MENU, EXPLORACAO, BATALHA, FINAL}
Estado estado;

enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] gridImage;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid
int linha = 14; // Linha onde o héroi surge
int coluna = 10; // Coluna onde o heroi surge

Equipe equipe_jogador;
int nivel_heroi = 1;

int quant_inimigo = 5;
PImage[] inimigoImage;
PosicaoDTO[] posInimigos; 
// Linhas e colunas onde os inimigos estão
Equipe[] equipe_inimigo;

int ultimo_movimento = millis();
int cooldown = 1500; // 1.5 segundos

Batalha batalha;
Menu menu;

void setup(){
  size(800,600);
  frameRate(60);
  
  estado = Estado.MENU;
  inicializaGrid();
  menu = new Menu();
  
  equipe_jogador = new Equipe(
    new PosicaoDTO(linha, coluna),
    new Heroi(nivel_heroi, new SapoLanceiro()), 
    new Heroi(nivel_heroi, new SapoLanceiro()), 
    new Heroi(nivel_heroi, new SapoLanceiro())
  );
}

void draw(){
  switch(estado) {
    case MENU:
      desenhaMenu();
      break;
      
    case EXPLORACAO:
      mostraGrid();
      break;
    
    case BATALHA:
      batalha.avancar();
      break;
      
    case FINAL:
      break;
      
    default:
      break;
  }
}

// exit()
void keyPressed(){
  if(estado == Estado.MENU) { 
    if(key == ' ') { estado = Estado.EXPLORACAO; }
  }
  
  if(estado == Estado.EXPLORACAO) { movimentar_heroi(); }
  
  switch(key) {
    case 'M':
    case 'm':
      estado = Estado.MENU;
  }
}

void movimentar_heroi(){
  Direcao direcao = null;
  
  switch(key) {
    case 'w':
      direcao = Direcao.CIMA; 
      break;
      
    case 'a':
      direcao = Direcao.ESQUERDA;
      break;
      
    case 's':
      direcao = Direcao.BAIXO;
      break;
      
    case 'd':
      direcao = Direcao.DIREITA;
      break;
  }
  
  if(equipe_jogador.movimentar(direcao, grid, n, m)) { colisao(); }
}

void movimentar_inimigo(){
  if(!podeMovimentar()) { return; } 
  
  for(int i = 0; i < quant_inimigo; i++){
    int movimento = int(random(0, 4));
    
     Direcao direcao = null;
  
  switch(movimento) {
    case 0:
      direcao = Direcao.CIMA; 
      break;
      
    case 1:
      direcao = Direcao.ESQUERDA;
      break;
      
    case 2:
      direcao = Direcao.BAIXO;
      break;
      
    case 3:
      direcao = Direcao.DIREITA;
      break;
      
    default:
       throw new RuntimeException("Deu errado, no sorteio de movimentação!");
  }
  
  if(equipe_inimigo[i].movimentar(direcao, grid, n, m)) { colisao(); }
  }
}

boolean podeMovimentar(){
  if(millis() - ultimo_movimento < cooldown) { return false; }
  
  ultimo_movimento = millis();
  
  return true;
}

Inimigo inimigo_aleatorio(int nivel) {
  int tipo_personagem = (int)random(1, 2+1);
  
  switch(tipo_personagem) {
    case 1:
      return new Inimigo(nivel, new SapoLanceiro());
    case 2:
      return new Inimigo(nivel, new Demonio());
    default:
      throw new RuntimeException("Tipo de personagem inválido");
  }
}

void colisao(){
  estado = Estado.BATALHA;
  
  int nivel_inimigo_max = (equipe_jogador.get_nivel() + 1);
  int nivel_inimigo_min = max(0, equipe_jogador.get_nivel() - 1);
  
  int nivel_inimigos = (int)random(nivel_inimigo_min, nivel_inimigo_max+1);
  
  Equipe inimigos = new Equipe(
    equipe_jogador.get_posicao(),
    inimigo_aleatorio(nivel_inimigos),
    inimigo_aleatorio(nivel_inimigos),
    inimigo_aleatorio(nivel_inimigos)
  );
  
  batalha = new Batalha(equipe_jogador, inimigos);
}

void desenhar_heroi(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  PImage heroiImage = loadImage("Heroi_costas.png");
  
  image(heroiImage, equipe_jogador.posicao.y * l, equipe_jogador.posicao.x * h, l, h);
}

void desenhar_inimigo(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  for(int i = 0; i < quant_inimigo; i++) {
        image(inimigoImage[i], int(posInimigos[i].y) * l, int(posInimigos[i].x) * h, l, h);
  }
  
  movimentar_inimigo();
}

void inicializaGrid(){
  gridImage = new PImage[n][m];
  grid = new Celula[n][m];
  
  posInimigos = new PosicaoDTO[quant_inimigo];
  inimigoImage = new PImage[quant_inimigo];
  equipe_inimigo = new Equipe[quant_inimigo];
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(random(1) >= 0.1){
        gridImage[i][j] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
        grid[i][j] = Celula.GRAMA;
      }
      
      else {
        if(i != linha || j != coluna) {
          gridImage[i][j] = loadImage("pedra.png");
          grid[i][j] = Celula.PEDRA;
        }
        
        else { j--; }
      }
    }                
  }
  
  grid[linha][coluna] = Celula.HEROI;
  
  for(int i = 0; i < quant_inimigo; i++){
    posInimigos[i] = new PosicaoDTO(int(random(n)), int(random(m)));
    
    if(grid[int(posInimigos[i].x)][int(posInimigos[i].y)] != Celula.GRAMA) { 
      i--; }  
    
    else {
      equipe_inimigo[i] = new Equipe(
        posInimigos[i],
        inimigo_aleatorio(1),
        inimigo_aleatorio(1),
        inimigo_aleatorio(1)
      );
      
      grid[int(posInimigos[i].x)][int(posInimigos[i].y)] = Celula.INIMIGO; 
      inimigoImage[i] = loadImage("inimigo" + str(int(random(1, 2+1))) + ".png");
    }
  }
}

void mostraGrid(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  for(int i = 0; i < n; i++){
    for(int j = 0; j < m; j++){
      stroke(200);
      fill(255,255,255);
      image(gridImage[i][j], j*l, i*h, l, h);
    }
  }
  
  desenhar_heroi();  
  desenhar_inimigo();
}

void desenhaMenu(){
  menu.desenhar();
    
  if(menu.passarEstado()) {
    estado = Estado.EXPLORACAO;
  }
  
  menu.sairJogo();
  
  return;
}

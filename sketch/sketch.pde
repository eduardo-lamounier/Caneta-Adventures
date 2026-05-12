enum Estado {MENU, EXPLORACAO, BATALHA, FINAL}
Estado estado;

enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] gridImage;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid
int linha = 14; // Linha onde o héroi surge
int coluna = 10; // Coluna onde o heroi surge

int quant_inimigo = 5;
PosicaoDTO[] posInimigos; 
PImage[] inimigoImage;
// Linhas e colunas onde os inimigos estão

int ultimo_movimento = millis();
int cooldown = 1500; // 1.5 segundos

Menu menu;

void setup(){
  size(800,600);
  frameRate(60);
  
  estado = Estado.MENU;
  inicializaGrid();
  menu = new Menu();
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
      break;
      
    case FINAL:
      break;
      
    default:
      break;
  }
}

// exit()
void keyPressed(){
  if(estado == Estado.EXPLORACAO) { movimentar_heroi(); }
  
  switch(key) {
    case 'M':
    case 'm':
      estado = Estado.MENU;
  }
}

void movimentar_heroi(){
  switch(key) {
    case 'w':
      if(linha > 0 && grid[linha - 1][coluna] == Celula.GRAMA){
        linha = atualizaGrid(linha, coluna, -1, true); }
        
      break;
      
    case 'a':
      if(coluna > 0 && grid[linha][coluna - 1] == Celula.GRAMA){
        coluna = atualizaGrid(linha, coluna, -1, false); }
      break;
      
    case 's':
      if(linha < n-1 && grid[linha + 1][coluna] == Celula.GRAMA){
        linha = atualizaGrid(linha, coluna, 1, true); }
      break;
      
    case 'd':
      if(coluna < m-1 && grid[linha][coluna + 1] == Celula.GRAMA){
        coluna = atualizaGrid(linha, coluna, 1, false); }
      break;
  }
}

void movimentar_inimigo(){
  if(!podeMovimentar()) { return; } 
  
  for(int i = 0; i < quant_inimigo; i++){
    int movimento = int(random(0, 4));
    
    switch (movimento) {
     case 0: // Movimento para cima
       if(int(posInimigos[i].x) > 0 && grid[int(posInimigos[i].x) - 1][int(posInimigos[i].y)] == Celula.GRAMA){
         posInimigos[i].x = atualizaGrid(int(posInimigos[i].x), int(posInimigos[i].y), -1, true); }
       break;
       
     case 1: // movimento para a esquerda
       if(int(posInimigos[i].y) > 0 && grid[int(posInimigos[i].x)][int(posInimigos[i].y) - 1] == Celula.GRAMA){
         posInimigos[i].y = atualizaGrid(int(posInimigos[i].x), int(posInimigos[i].y), -1, false); }
       break;
     
     case 2: // movimento para baixo
       if(int(posInimigos[i].x) < n-1 && grid[int(posInimigos[i].x) + 1][int(posInimigos[i].y)] == Celula.GRAMA){
         posInimigos[i].x = atualizaGrid(int(posInimigos[i].x), int(posInimigos[i].y), 1, true); }
       break;
     
     case 3: // movimento para direita
       if(int(posInimigos[i].y) < m-1 && grid[int(posInimigos[i].x)][int(posInimigos[i].y) + 1] == Celula.GRAMA){
         posInimigos[i].y = atualizaGrid(int(posInimigos[i].x), int(posInimigos[i].y), 1, false); }
       break;
     
     default:
       print("Deu errado, no sorteio de movimentação!");
       break;
    }
  }
}

boolean podeMovimentar(){
  if(millis() - ultimo_movimento < cooldown) { return false; }
  
  ultimo_movimento = millis();
  
  return true;
}

void desenhar_heroi(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  PImage heroiImage = loadImage("Heroi_costas.png");
  
  image(heroiImage, coluna * l, linha * h, l, h);
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
      grid[int(posInimigos[i].x)][int(posInimigos[i].y)] = Celula.INIMIGO; 
      inimigoImage[i] = loadImage("inimigo" + str(int(random(1, 2+1))) + ".png");
    }
  }
}

int atualizaGrid(int linha, int coluna, int distancia, boolean mudarLinha){
  Celula temp = grid[linha][coluna];
  
  if(mudarLinha){
    grid[linha][coluna] = grid[linha + distancia][coluna];
    grid[linha + distancia][coluna] = temp;
    
    return linha + distancia;
  }
  
  grid[linha][coluna] = grid[linha][coluna + distancia];
  grid[linha][coluna + distancia] = temp;
  
  return coluna + distancia;
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

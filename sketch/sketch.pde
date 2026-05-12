enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] gridImage;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid
int linha = 14; // Linha onde o héroi surge
int coluna = 10; // Coluna onde o heroi surge

int quant_inimigo = 5;
PosicaoDTO[] posInimigos; 
// Linhas e colunas onde os inimigos estão

int ultimo_movimento = millis();
int cooldown = 2000;

Menu menu;
boolean menu_aberto = true;

void setup(){
  size(800,600);
  frameRate(60);
  
  inicializaGrid();
  menu = new Menu();
}

void draw(){
  mostraGrid();
}

// exit()
void keyPressed(){
  if(!menu_aberto) { movimentar_heroi(); }
  
  switch(key) {
    case 'P':
    case 'p':
      menu_aberto = !menu_aberto;
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
  
  
  
  int[] lin_inimigos = new int[quant_inimigo];
  int[] col_inimigos = new int[quant_inimigo];
  
  int coordenada = 0;
  
  for(int i = 0; i < n; i++)
    for(int j = 0; j < m; j++) {
      if(grid[i][j] == Celula.INIMIGO) {
        lin_inimigos[coordenada] = i;
        col_inimigos[coordenada] = j;
        
        coordenada++;
      }
    }
  
  for(int i = 0; i < quant_inimigo; i++){
    int movimento = int(random(0, 4));
    
    switch (movimento) {
     case 0: // Movimento para cima
       if(lin_inimigos[i] > 0 && grid[lin_inimigos[i] - 1][col_inimigos[i]] == Celula.GRAMA){
         atualizaGrid(lin_inimigos[i], col_inimigos[i], -1, true); }
       break;
       
     case 1: // movimento para a esquerda
       if(col_inimigos[i] > 0 && grid[lin_inimigos[i]][col_inimigos[i] - 1] == Celula.GRAMA){
         atualizaGrid(lin_inimigos[i], col_inimigos[i], -1, false); }
       break;
     
     case 2: // movimento para baixo
       if(lin_inimigos[i] < n-1 && grid[lin_inimigos[i] + 1][col_inimigos[i]] == Celula.GRAMA){
         atualizaGrid(lin_inimigos[i], col_inimigos[i], 1, true); }
       break;
     
     case 3: // movimento para direita
       if(col_inimigos[i] < m-1 && grid[lin_inimigos[i]][col_inimigos[i] + 1] == Celula.GRAMA){
         atualizaGrid(lin_inimigos[i], col_inimigos[i], 1, false); }
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
  
  PImage inimigoImage;
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(grid[i][j] == Celula.INIMIGO) {
        inimigoImage = loadImage("inimigo" + str(int(random(1, 2+1))) + ".png");
        image(inimigoImage, j * l, i * h, l, h);
      }
    }
  }
  
  movimentar_inimigo();
}

void inicializaGrid(){
  gridImage = new PImage[n][m];
  grid = new Celula[n][m];
  posInimigos = new PosicaoDTO[quant_inimigo];
  
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
    posInimigos[i] = new PosicaoDTO(int(random(m)), int(random(n)));
    
    if(grid[int(posInimigos[i].x)][int(posInimigos[i].y)] != Celula.GRAMA) { 
      i--; }  
    
    else {
      grid[int(posInimigos[i].x)][int(posInimigos[i].y)] = Celula.INIMIGO; }
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
  if(menu_aberto) {
    menu.desenhar();
    
    if(menu.passarEstado()) {
      menu_aberto = false;
    }
    
    menu.sairJogo();
    
    return;
  }
  
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

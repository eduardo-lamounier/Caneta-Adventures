enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] gridImage;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid
int linha = 14; // Linha onde o héroi surge
int coluna = 10; // Coluna onde o heroi surge
int quant_inimigo = 5; 
int col_inimigo;
int lin_inimigo;

void setup(){
  size(800,600);
  frameRate(60);
  
  inicializaGrid();
}

void draw(){
  mostraGrid();
}

void keyPressed(){
  if(key == 'w'){
    
    if(linha > 0 && grid[linha - 1][coluna] == Celula.GRAMA){
        linha += - 1; 
    }
    
  } else if (key == 'a'){
  
    if(coluna > 0  && grid[linha][coluna - 1] == Celula.GRAMA){
      coluna += -1;
    }
    
  } else if (key == 's'){
    
    if(linha < n-1 && grid[linha + 1][coluna] == Celula.GRAMA){
      linha += 1;
    }
    
  } else if (key == 'd'){
    
    if(coluna < m-1  && grid[linha][coluna + 1] == Celula.GRAMA){
      coluna += 1;
    }
    
  }
}

void desenhar_heroi(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  PImage heroi = loadImage("Heroi_de_costas.png");
  
  image(heroi, coluna * l, linha * h, l, h);
}

void desenhar_inimigo(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(grid[i][j] == Celula.INIMIGO) {
        fill(185, 22, 25);
        noStroke();
        rect(j * l, i * h, l, h);
      }
    }
  }  
  // TODO: Arrumar isso, pois está feio para um caramba!
}

void inicializaGrid(){
  gridImage = new PImage[n][m];
  grid = new Celula[n][m];
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(random(1) >= 0.1){
        gridImage[i][j] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
        grid[i][j] = Celula.GRAMA;
      }
      
      else {
        if(grid[i][j] != grid[linha][coluna]) {
          gridImage[i][j] = loadImage("pedra.jpg");
          grid[i][j] = Celula.PEDRA;
          // TODO: Mudar a imagem da pedra
        }
      }
    }                
  }
  
  grid[linha][coluna] = Celula.HEROI;
  
  for(int i = quant_inimigo; i > 0; i--){
    int col_inimigo = int(random(m));
    int lin_inimigo = int(random(n));
    
    if(grid[lin_inimigo][col_inimigo] != Celula.GRAMA) { 
      i++; }  
    
    else {
      grid[lin_inimigo][col_inimigo] = Celula.INIMIGO; }
  }
}

void atualizaGrid(int linha, int coluna, int distancia, boolean mudarLinha){
  Celula temp = grid[linha][coluna];
  
  if(mudarLinha){
    grid[linha][coluna] = grid[linha + distancia][coluna];
    grid[linha + distancia][coluna] = temp;
    
    return; 
  }
  
  grid[linha][coluna] = grid[linha][coluna + distancia];
  grid[linha][coluna + distancia] = temp;
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

enum Celula {grama, pedra, inimigo};
Celula[][] quadrado;

PImage[][] grid; 
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid
int linha = 14; // Linha onde o héroi surge
int coluna = 10; // Coluna onde o heroi surge
int quant_inimigo = 5; 
int inimigos_restantes = quant_inimigo;
int col_inimigo;
int lin_inimigo;

void setup(){
  size(800,600);
  frameRate(60);
  
  inicializaGrid();
}

void keyPressed(){
  if(key == 'w'){
    
    if(linha > 0 && quadrado[linha - 1][coluna] == Celula.grama){
        linha += - 1; 
    }
    
  } else if (key == 'a'){
  
    if(coluna > 0  && quadrado[linha][coluna - 1] == Celula.grama){
      coluna += -1;
    }
    
  } else if (key == 's'){
    
    if(linha < n-1 && quadrado[linha + 1][coluna] == Celula.grama){
      linha += 1;
    }
    
  } else if (key == 'd'){
    
    if(coluna < m-1  && quadrado[linha][coluna + 1] == Celula.grama){
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
      
      if(quadrado[i][j] == Celula.inimigo) {
        fill(185, 22, 25);
        noStroke();
        rect(j * l, i * h, l, h);
      }
    }
  }  
  // TODO: Arrumar isso, pois está feio para um caramba!
}

void inicializaGrid(){
  grid = new PImage[n][m];
  quadrado = new Celula[n][m];
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(random(1) >= 0.1){
        grid[i][j] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
        quadrado[i][j] = Celula.grama;
      }
      
      else {
      grid[i][j] = loadImage("pedra.jpg");
      quadrado[i][j] = Celula.pedra;
      // TODO: Mudar a imagem da pedra
      }
    }
  }
  
  while(inimigos_restantes > 0){
    int col_inimigo = int(random(m));
    int lin_inimigo = int(random(n));
    
    if(quadrado[lin_inimigo][col_inimigo] == Celula.grama) {
      quadrado[lin_inimigo][col_inimigo] = Celula.inimigo;
    
      inimigos_restantes--;
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
      image(grid[i][j], j*l, i*h, l, h);
    }
  }
  
  desenhar_heroi();  
  desenhar_inimigo();
}


void draw(){
  mostraGrid();
}

PImage[][] grid;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid
int linha = 0; // Linha onde o héroi surge
int coluna = 1; // Coluna onde o heroi surge

void setup(){
  size(800,600);
  frameRate(60);
  
  grid = new PImage[n][m];
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      grid[i][j] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
    }
  }
}

void keyPressed(){
  if(key =='w'){
    
    if(linha > 0){
        linha= linha - 1; 
    }
    
  } else if (key == 'a'){
  
    if(coluna > 0){
      coluna = coluna -1;
    }
    
  } else if (key == 's'){
    
    if(linha < n-1){
      linha = linha + 1;
    }
    
  } else if (key == 'd'){
    
    if(coluna < m-1 ){
      coluna = coluna + 1;
    }
    
  }
}

void personagem(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  fill(8,123,5);
  rect(coluna * l, linha * h, l, h);
}

void atualizarGrid(){
 
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
  
  personagem();   
}


void draw(){
  mostraGrid();
  atualizarGrid();
}

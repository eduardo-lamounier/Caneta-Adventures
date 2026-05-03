PImage[][] grid;
int n = 11;
int linha = 0;
int coluna = 1;

void setup(){
  size(800,800);
  frameRate(60);
  
  grid = new PImage[n][n];
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
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
    
    if(coluna < n-1 ){
      coluna = coluna + 1;
    }
    
  }
}

void personagem(){
  float l = width/(float)n;
  float h = height/(float)n;
  
  fill(8,123,5);
  rect(coluna * l,linha * h, l, h);
}

void atualizarGrin(){
  personagem();  
}

void mostraGrid(){
  float l = width/(float)n;
  float h = height/(float)n;
  
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      stroke(200);
      fill(255,255,255);
      image(grid[i][j], j*l, i*h, l, h);
    }
  }
  
}


void draw(){
  mostraGrid();
  atualizarGrin();
}

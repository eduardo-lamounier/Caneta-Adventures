enum Estado {MENU, TUTORIAL, EXPLORACAO, BATALHA, FINAL}
Estado estado;

enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] imagens_grid;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid

Equipe equipe_jogador;
int nivel_heroi = 1;

int quant_inimigo = 5;
PImage[] imagens_inimigos;
PosicaoDTO[] pos_inimigos; 
// Linhas e colunas onde os inimigos estão
Equipe[] equipe_inimigo;

Batalha batalha;
Menu menu;

void setup(){
  size(800,600);
  frameRate(60);
  
  equipe_jogador = new Equipe(
    new PosicaoDTO(14, 10),
    new Heroi(nivel_heroi, new CanetaAzul()), 
    new Heroi(nivel_heroi, new CanetaRoubada()), 
    new Heroi(nivel_heroi, new CanetaMagica())
  );
  
  estado = Estado.MENU;
  inicializa_grid();
  menu = new Menu();
}

void draw(){
  switch(estado) {
    case MENU:
      desenha_menu();
      break;
      
    case EXPLORACAO:
      mostra_grid();
      break;
    
    case BATALHA:
      background(30);
      batalha.avancar();
      batalha.desenhar();

      if (batalha.deve_finalizar())
        estado = Estado.EXPLORACAO;
  break;
      
    case FINAL:
      break;

    default:
      break;
  }
}

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
    
    default:
      return;
  }
  
  if(equipe_jogador.movimentar(direcao, grid, n, m)) { colisao(); }
  // Como que para verificar executa a função, 
  // tem que ser executada apenas uma vez.
}

void movimentar_inimigo(){
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
        image(imagens_inimigos[i], int(pos_inimigos[i].y) * l, int(pos_inimigos[i].x) * h, l, h);
  }
  
  movimentar_inimigo();
}

void inicializa_grid(){
  imagens_grid = new PImage[n][m];
  grid = new Celula[n][m];
  
  pos_inimigos = new PosicaoDTO[quant_inimigo];
  imagens_inimigos = new PImage[quant_inimigo];
  equipe_inimigo = new Equipe[quant_inimigo];
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(random(1) >= 0.1){
        imagens_grid[i][j] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
        grid[i][j] = Celula.GRAMA;
      }
      
      else {
        if(i != equipe_jogador.posicao.x || j != equipe_jogador.posicao.y) {
          imagens_grid[i][j] = loadImage("pedra.png");
          grid[i][j] = Celula.PEDRA;
        }
        
        else { j--; }
      }
    }                
  }
  
  grid[equipe_jogador.posicao.x][equipe_jogador.posicao.y] = Celula.HEROI;
  
  for(int i = 0; i < quant_inimigo; i++){
    pos_inimigos[i] = new PosicaoDTO(int(random(n)), int(random(m)));
    
    if(grid[int(pos_inimigos[i].x)][int(pos_inimigos[i].y)] != Celula.GRAMA) { 
      i--; }  
    
    else {
      equipe_inimigo[i] = new Equipe(
        pos_inimigos[i],
        inimigo_aleatorio(1),
        inimigo_aleatorio(1),
        inimigo_aleatorio(1)
      );
      
      grid[int(pos_inimigos[i].x)][int(pos_inimigos[i].y)] = Celula.INIMIGO; 
      imagens_inimigos[i] = loadImage("inimigo" + str(int(random(1, 2+1))) + ".png");
    }
  }
}

void mostra_grid(){
  float l = width/(float)m;
  float h = height/(float)n;
  
  for(int i = 0; i < n; i++){
    for(int j = 0; j < m; j++){
      stroke(200);
      fill(255,255,255);
      image(imagens_grid[i][j], j*l, i*h, l, h);
    }
  }
  
  desenhar_heroi();  
  desenhar_inimigo();
}

void desenha_menu(){
  menu.desenhar();
  
  if(menu.entrar_tutorial()) { 
    estado = Estado.TUTORIAL;
  }
    
  if(menu.passar_estado()) {
    estado = Estado.EXPLORACAO;
  }
  
  menu.sair_jogo();
}

void desenha_tutorial() { 
  tutorial.desenhar();
  
  if(tutorial.sair.botao_clicado()) { estado = Estado.MENU; delay(400);}
}


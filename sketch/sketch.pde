enum Estado {MENU, TUTORIAL, EXPLORACAO, BATALHA, FINAL}
Estado estado;

enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] imagens_grid;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid

Equipe equipe_jogador;

int quant_inimigo = 5;
PImage[] imagens_inimigos;
PosicaoDTO[] pos_inimigos; 
// Linhas e colunas onde os inimigos estão
Equipe[] equipe_inimigo;

Batalha batalha;
Menu menu;
Tutorial tutorial;
GameOver tela_final;

void setup(){
  size(800,600);
  frameRate(60);
  
  estado = Estado.MENU;
  inicializa_grid();
  menu = new Menu();
  tutorial = new Tutorial();
  tela_final = new GameOver(true);
}

void draw(){
  switch(estado) {
    case MENU:
      desenha_menu();
      break;
    
    case TUTORIAL:
      desenha_tutorial();
      break;
      
    case EXPLORACAO:
      mostra_grid();
      break;
    
    case BATALHA:
      desenha_batalha();
      break;
      
    case FINAL:
      desenha_final();
      break;

    default:
      break;
  }
}

void keyPressed(){
  if(estado == Estado.MENU) { 
    if(key == ' ') { estado = Estado.EXPLORACAO; }
  }
  
  if(estado == Estado.EXPLORACAO) { 
    movimentar_heroi();
  
    switch(key) {
      case 'M':
      case 'm':
        estado = Estado.MENU;
        break;
    }
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
  
  int xp = (int)random(75, 150+1);

  Equipe inimigos = new Equipe(
    equipe_jogador.get_posicao(),
    inimigo_aleatorio(nivel_inimigos),
    inimigo_aleatorio(nivel_inimigos),
    inimigo_aleatorio(nivel_inimigos)
  );
  
  batalha = new Batalha(equipe_jogador, inimigos, xp);
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
  
  equipe_jogador = new Equipe(
    new PosicaoDTO(14, 10),
    new Heroi(1, new CanetaAzul()), 
    new Heroi(1, new CanetaRoubada()), 
    new Heroi(1, new CanetaMagica())
  );
  
  grid[equipe_jogador.posicao.x][equipe_jogador.posicao.y] = Celula.HEROI;
  imagens_grid[equipe_jogador.posicao.x][equipe_jogador.posicao.y] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++) {
      if(grid[i][j] != Celula.HEROI) {
        if(random(1) >= 0.1){
          imagens_grid[i][j] = loadImage("grama-" + (int)random(1, 2+1) + ".png");
          grid[i][j] = Celula.GRAMA;
        }
        
        else {
          imagens_grid[i][j] = loadImage("pedra.png");
          grid[i][j] = Celula.PEDRA;
        }
      }
    }                
  }
  
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

void reinicia_grid() {
 inicializa_grid(); 
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
  if(tutorial.sair.botao_clicado()) { estado = Estado.MENU; delay(200);}
  // O delay serve para que o botão de saída do menu não interprete o clicar,
  // sendo que era do botão do estado de tutorial.
  
  tutorial.desenhar();
}

void desenha_batalha() {
  background(30);
  batalha.avancar();
  batalha.desenhar();

  if (batalha.deve_finalizar()) {
    if (!batalha.herois_sairam_vitoriosos()) {
      estado = Estado.FINAL;
      return;
    }
    
    equipe_jogador.ganhar_xp(batalha.get_xp_vitoria());
    
    estado = Estado.EXPLORACAO;
  }
}

void desenha_final(){
  tela_final.desenhar();
  
  if(tela_final.voltar_menu()) { 
    estado = Estado.MENU; 
    delay(190);
  }
  
  if(tela_final.reiniciar_jogo()) { 
    reinicia_grid(); 
    estado = Estado.MENU;
    delay(200); // Para que o clique no botão não influêncie no outro.
  }
}

enum Estado {MENU, TUTORIAL, EXPLORACAO, BATALHA, FINAL}
Estado estado;

enum Celula {GRAMA, PEDRA, INIMIGO, HEROI};
Celula[][] grid;

PImage[][] imagens_grid;
int n = 15; // Número de linhas do grid
int m = 20; // Número de colunas do grid

Equipe equipe_jogador;

int quant_inimigo;
PImage[] imagens_inimigos;
PosicaoDTO[] pos_inimigos; 
// Linhas e colunas onde os inimigos estão
Equipe[] equipe_inimigo;

Batalha batalha;
Menu menu;
Tutorial tutorial;
GameOver tela_final;

Direcao direcao_colisao = null;
boolean agente_colisao; // Se for true é heroi, se não, é inimigo

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
  
  if(equipe_jogador.movimentar(direcao, grid, n, m)) { 
    direcao_colisao = direcao;
    agente_colisao = true;
    
    colisao();
  }
  // Na prórpia verificação, já executa o comando de movimentação
  // Então chamamos a função apenas na verificação
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
  
    if(equipe_inimigo[i].movimentar(direcao, grid, n, m)) {
      direcao_colisao = direcao;
      agente_colisao = false;
      
      colisao(); 
    }
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
  
  int indice = descobri_inimigo();

  equipe_inimigo[indice] = new Equipe(
    equipe_inimigo[indice].get_posicao(),
    inimigo_aleatorio(nivel_inimigos),
    inimigo_aleatorio(nivel_inimigos),
    inimigo_aleatorio(nivel_inimigos)
  );
  
  batalha = new Batalha(equipe_jogador, equipe_inimigo[indice], xp);
}

int descobri_inimigo() {
  int pos_x = 0, pos_y = 0;
  
  switch(direcao_colisao) {
    case CIMA:
      pos_x = -1;
      pos_y = 0;
      break;
      
    case ESQUERDA:
      pos_x = 0;
      pos_y = -1;
      break;
      
    case BAIXO:
      pos_x = 1;
      pos_y = 0;
      break;
      
    case DIREITA:
      pos_x = 0;
      pos_y = 1;
      break;
      
    default:
       throw new RuntimeException("Deu errado, na direcao da colisao");
  }
  
  if(!agente_colisao) { pos_x *= -1; pos_y *= -1; } // Muda para a vista do inimigo
  
  if(grid[equipe_jogador.posicao.x + pos_x][equipe_jogador.posicao.y + pos_y] == Celula.INIMIGO) {
    for(int i = 0; i < quant_inimigo; i++) {
      if(equipe_inimigo[i].posicao.x == equipe_jogador.posicao.x + pos_x &&
         equipe_inimigo[i].posicao.y == equipe_jogador.posicao.y + pos_y) {
           return i;
      }
    }
  }
  
  else {  throw new RuntimeException("Deu errado, na descorbeta do indice do inimigo"); }
  
  return quant_inimigo + 1; // Se retornar aqui é porque deu erro
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
        image(imagens_inimigos[i], equipe_inimigo[i].posicao.y * l, equipe_inimigo[i].posicao.x * h, l, h);
  }
  
  movimentar_inimigo();
}

void inimigo_derrotado(int indice){
  Equipe temp;
  
  for(int i = indice; i < quant_inimigo - 1; i++) {
    temp = equipe_inimigo[i];
    equipe_inimigo[i] = equipe_inimigo[i + 1];
    equipe_inimigo[i + 1] = temp;
  } 
  
  grid[equipe_inimigo[quant_inimigo - 1].posicao.x][equipe_inimigo[quant_inimigo - 1].posicao.y] = Celula.GRAMA;
  
  quant_inimigo--;
}

void inicializa_grid(){
  imagens_grid = new PImage[n][m];
  grid = new Celula[n][m];
  
  quant_inimigo = 5;
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
    
    if(grid[pos_inimigos[i].x][pos_inimigos[i].y] != Celula.GRAMA) { 
      i--; }  
    
    else {
      equipe_inimigo[i] = new Equipe(
        pos_inimigos[i],
        inimigo_aleatorio(1),
        inimigo_aleatorio(1),
        inimigo_aleatorio(1)
      );
      
      grid[pos_inimigos[i].x][pos_inimigos[i].y] = Celula.INIMIGO; 
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
    
    inimigo_derrotado(descobri_inimigo());
    
    equipe_jogador.ganhar_xp(batalha.get_xp_vitoria());
    
    estado = Estado.EXPLORACAO;
  }
}

void desenha_final(){
  tela_final.desenhar();
  
  if(tela_final.sair_game()) { exit(); }
  
  if(tela_final.reiniciar_jogo()) { 
    reinicia_grid(); 
    estado = Estado.MENU;
    delay(200); // Para que o clique no botão não influêncie no outro.
  }
}

final int XP_PARA_SUBIR_NIVEL = 100;

public enum Direcao { CIMA, BAIXO, ESQUERDA, DIREITA };

public class Equipe {
  private PosicaoDTO posicao;
  private int xp;
  private int nivel;
  private Personagem[] personagens;
  private long cooldown; 
  
  public void ganhar_xp(int xp_ganho) {
    xp += xp_ganho;
    
    while(xp >= XP_PARA_SUBIR_NIVEL) {
      xp -= XP_PARA_SUBIR_NIVEL;
      nivel++;
    }
  }
  
  public int get_nivel() { return nivel; }
  
  public boolean movimentar(Direcao direcao, Celula[][] grid, int linhas_grid, int colunas_grid) {
    // Retorna se houve colisão com a equipe adversária
    
    boolean colisao = false;
    
    Celula temp = grid[posicao.x][posicao.y];
    // Atualiza o grid, sem outra função
    
    switch(direcao) {
    case CIMA:
      if(posicao.x > 0 && grid[posicao.x - 1][posicao.y] == Celula.GRAMA){
        grid[posicao.x][posicao.y] = grid[posicao.x - 1][posicao.y];
        grid[posicao.x -1][posicao.y] = temp;
        
        this.posicao.x += -1; 
      }
        
      else if(posicao.x > 0 && grid[posicao.x - 1][posicao.y] != Celula.PEDRA){
        colisao = houveColisao(posicao.x - 1, posicao.y);
      }
        
      return colisao;
      
    case ESQUERDA:
      if(posicao.y > 0 && grid[posicao.x][posicao.y - 1] == Celula.GRAMA){
        grid[posicao.x][posicao.y] = grid[posicao.x][posicao.y - 1];
        grid[posicao.x][posicao.y - 1] = temp;
        
        this.posicao.y += -1;  
      }
        
      else if(posicao.y > 0 && grid[posicao.x][posicao.y - 1] != Celula.PEDRA){
        colisao = houveColisao(posicao.x, posicao.y - 1);
      }
      
      return colisao;
      
    case BAIXO:
      if(posicao.x < linhas_grid -1 && grid[posicao.x + 1][posicao.y] == Celula.GRAMA){
        grid[posicao.x][posicao.y] = grid[posicao.x + 1][posicao.y];
        grid[posicao.x + 1][posicao.y] = temp;
        
        this.posicao.x += 1;  
      }
        
      else if(posicao.x < linhas_grid - 1 && grid[posicao.x + 1][posicao.y] != Celula.PEDRA){
        colisao = houveColisao(posicao.x + 1, posicao.y);
      }
      
      return colisao;
      
    case DIREITA:
      if(posicao.y < colunas_grid - 1 && grid[posicao.x][posicao.y + 1] == Celula.GRAMA){
        grid[posicao.x][posicao.y] = grid[posicao.x][posicao.y + 1];
        grid[posicao.x][posicao.y + 1] = temp;
        
        this.posicao.y += 1; 
      }
        
      else if(posicao.y < colunas_grid - 1 && grid[posicao.x][posicao.y + 1] != Celula.PEDRA){
        colisao = houveColisao(posicao.x, posicao.y + 1);
      }
      
      return colisao;
      
      default:
        return colisao;
    }
  }
  
  public boolean houveColisao(int lin_adversaria, int col_adversaria) { 
    if(grid[this.posicao.x][this.posicao.y] == Celula.HEROI) {
      if(grid[lin_adversaria][col_adversaria] == Celula.INIMIGO) {
          return true;
      }
    }
    
    else if(grid[lin_adversaria][col_adversaria] == Celula.HEROI) {
          return true;
    }
    
    return false;
  }
 
  
  public PosicaoDTO get_posicao() { return posicao; }
  
  public Personagem[] get_personagens() {
    return personagens.clone();
  }
  
  private Equipe(PosicaoDTO posicao) {
    this.posicao = posicao;
    nivel = 1;
    xp = 0;
  }
  
  public Equipe(PosicaoDTO posicao, Heroi heroi1, Heroi heroi2, Heroi heroi3) {
    this(posicao);
    personagens = new Heroi[] { heroi1, heroi2, heroi3 };
  }
  
  public Equipe(PosicaoDTO posicao, Inimigo inim1, Inimigo inim2, Inimigo inim3) {
    this(posicao);
    personagens = new Inimigo[] { inim1, inim2, inim3 };
  }
}

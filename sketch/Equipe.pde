final int XP_PARA_SUBIR_NIVEL = 100;

public enum Direcao { CIMA, BAIXO, ESQUERDA, DIREITA };

public class Equipe {
  private PosicaoDTO posicao;
  private int xp;
  private int nivel;
  private Personagem[] personagens;
  
  public void ganhar_xp(int xp_ganho) {
    xp += xp_ganho;
    
    while(xp >= XP_PARA_SUBIR_NIVEL) {
      xp -= XP_PARA_SUBIR_NIVEL;
      nivel++;
    }
  }
  
  public int get_nivel() { return nivel; }
  
  public void movimentar(Direcao direcao) {
    // FALTA IMPLEMENTAR
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

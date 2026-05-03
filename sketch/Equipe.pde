final int XP_PARA_SUBIR_NIVEL = 100;

public class Equipe {
  public PosicaoDTO posicao; // Talvez seja melhor deixar isso aqui privado
                             // e fazer getters e setters
  private int xp;
  private int nivel;
  private Heroi[] herois;
  
  public void ganhar_xp(int xp_ganho) {
    xp += xp_ganho;
    
    while(xp >= XP_PARA_SUBIR_NIVEL) {
      xp -= XP_PARA_SUBIR_NIVEL;
      nivel++;
    }
  }
  
  public int get_nivel() { return nivel; }
  
  public Heroi[] get_herois() {
    return herois.clone();
  }
  
  private Equipe(float x, float y, Heroi heroi1, Heroi heroi2, Heroi heroi3) {
    posicao = new PosicaoDTO(x, y);  
    herois = new Heroi[] { heroi1, heroi2, heroi3 };
    nivel = 1;
    xp = 0;
  }
}

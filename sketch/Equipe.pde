public class Equipe {
  public PosicaoDTO posicao; // Talvez seja melhor deixar isso aqui privado
                             // e fazer getters e setters
  private Heroi[] herois;
  
  public Heroi[] get_herois() {
    return herois.clone();
  }
  
  private Equipe(float x, float y, Heroi heroi1, Heroi heroi2, Heroi heroi3) {
    posicao = new PosicaoDTO(x, y);  
    herois = new Heroi[] { heroi1, heroi2, heroi3 };
  }
}

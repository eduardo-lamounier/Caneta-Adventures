public class Heroi extends Personagem {
  @Override
  public Habilidade escolher_habilidade() {
    return null; // IMPLEMENTAR ESCOLHA DE ATAQUE PELO USUÁRIO!
  }
  
  @Override
  public Personagem escolher_alvo(Personagem[] alvos_possiveis) {
    return null; // IMPLEMENTAR ESCOLHA DE ALVO PELO USUÁRIO!
  }
  
  public Heroi(int nivel, TipoPersonagem tipo_personagem) {
    super(nivel, tipo_personagem);
  }
}

public class Inimigo extends Personagem {
  @Override
  public Habilidade escolher_habilidade() {
    return habilidades[(int)random(3)];
  }
  
  @Override
  public Personagem escolher_alvo(Personagem[] alvos) {
    return alvos[(int)random(alvos.length)];
  }
  
  public Inimigo(int nivel, TipoPersonagem tipo_personagem) {
    super(nivel, tipo_personagem);
  }
}

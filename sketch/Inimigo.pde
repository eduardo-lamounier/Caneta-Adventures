public class Inimigo extends Personagem {
  private Habilidade habilidade_escolhida;
  private Personagem alvo_escolhido;
  
  @Override
  public void escolher_habilidade() {
    int escolha;
    
    // Isso não será um loop infinito porque todo personagem tem uma habilidade
    // padrão "Golpear", que não tem cooldown
    do {
      escolha = (int)random(3);
    } while(habilidades[escolha].get_cooldown() > 0);
    
    habilidade_escolhida = habilidades[escolha];
  }
  
  @Override
  public Habilidade obter_habilidade_escolhida() {
    assert(habilidade_escolhida != null);
    return habilidade_escolhida;
  }
  
  @Override
  public void escolher_alvo(Personagem[] alvos_possiveis) {
    do{alvo_escolhido = alvos_possiveis[(int)random(3)];
    }while (!alvo_escolhido.esta_vivo());
  }
  
  @Override
  public Personagem obter_alvo_escolhido() {
    return alvo_escolhido;
  }
  
  public Inimigo(int nivel, TipoPersonagem tipo_personagem) {
    super(nivel, tipo_personagem);
  }
}

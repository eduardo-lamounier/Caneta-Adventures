public class Golpear extends Habilidade { 
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(2);
  }
  
  public Golpear() {
    super(1, "Golpear", "Infringe 2pts base de dano", 0, false);
  }
}

public class Estocar extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(4);
  }
  
  public Estocar() {
    super(2, "Estocar", "Infringe 4pts base de dano", 3, false);
  }
}

public class Agilidade extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    usuario.incrementar_vel(10);
  }
  
  public Agilidade() {
    super(3, "Agilidade", "Aumenta a velocidade do usuário em 10pts base", 3, true);
  }
}

public class BolaFogo extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(8);
    alvo.incrementar_vel(-20);
  }
  
  public BolaFogo() {
    super(4, "Bola de fogo", "Infringe 4pts base de dano e diminui a velocidade do alvo", 6, true);
  }
}

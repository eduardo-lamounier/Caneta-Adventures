public class Golpear extends Habilidade { 
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(usuario.get_atk() * usuario.multiplicador_dano);
  usuario.multiplicador_dano = 1;
  }
  
  public Golpear() {
    super(1, "Golpear", "Infringe 2pts base de dano", 0, false);
  }
}

public class Estocar extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(usuario.get_atk() + 5 * usuario.multiplicador_dano);
    usuario.multiplicador_dano = 1;
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
    super(3, "Agilidade", "Aumenta a velocidade do \n usuário em 10pts base", 3, true);
  }
}

public class BolaFogo extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(usuario.get_atk() * usuario.multiplicador_dano);
    usuario.multiplicador_dano = 1;
    alvo.dano_dot = 3;
    alvo.turnos_dot = 3;
  }

  public BolaFogo() {
    super(4, "Bola de fogo", "Infringe 3pts base de dano e 3pts por 3 turnos", 6, false);
  }
}
public class ReporTinta extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    usuario.multiplicador_dano = 2;
  }
  
  public ReporTinta() {
    super(5, "Repor Tinta", "Dobra o dano no próximo ataque", 4, false);
  }
}
public class Canetada extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    usuario.multiplicador_dano = 1;
    if(usuario.get_vel() > alvo.get_vel()){
      alvo.ferir(usuario.get_atk() + 10);
    } else {
      alvo.ferir(usuario.get_atk());
    }
  }

  public Canetada() {
    super(6, "Canetada", "Se for mais rápido que o alvo, causa 10pts a mais de dano", 3, false);
  }
}

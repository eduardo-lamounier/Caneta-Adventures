public class Golpear extends Habilidade { 
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(usuario.get_atk() * usuario.multiplicador_dano);
    usuario.multiplicador_dano = 1;
  }

  public Golpear() {
    super(
      1, 
      "Golpear",
      "Infringe o ATK do usuario de dano", 
      0, 
      TipoMiraHabilidade.MIRA_OPONENTE
    );
  }
}

public class Estocar extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    alvo.ferir(usuario.get_atk() + 5 * usuario.multiplicador_dano);
    usuario.multiplicador_dano = 1;
  }

  public Estocar() {
    super(
      2,
      "Estocar", 
      "Infringe o ATK do usuario + 5 x seu multiplicador de dano", 
      2, 
      TipoMiraHabilidade.MIRA_OPONENTE
    );
  }
}

public class Agilidade extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    usuario.incrementar_vel(10);
  }
  
  public Agilidade() {
    super(
      3,
      "Agilidade", 
      "Aumenta a velocidade do \n usuário em 10pts base", 
      3, 
      TipoMiraHabilidade.NAO_MIRA
    );
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
    super(
      4,
      "Bola de fogo", 
      "Infringe 3pts base de dano e 3pts por 3 turnos", 
      5, 
      TipoMiraHabilidade.MIRA_OPONENTE
    );
  }
}
public class ReporTinta extends Habilidade {
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    usuario.multiplicador_dano = 4;
  }
  
  public ReporTinta() {
    super(
      5, 
      "Repor Tinta", 
      "Quadriplica o dano no próximo ataque", 
      3, 
      TipoMiraHabilidade.NAO_MIRA
    );
  }
}
public class Canetada extends Habilidade {
  
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    if(usuario.get_vel() > alvo.get_vel()){
      alvo.ferir(usuario.get_atk() + 50 * usuario.multiplicador_dano);
    } else {
      alvo.ferir(usuario.get_atk() * usuario.multiplicador_dano);
    }
    usuario.multiplicador_dano = 1;
  }

  public Canetada() {
    super(
      6, 
      "Canetada",
      "Causa o ATK do usuario de dano, se for mais rapido + 10.", 
      2, 
      TipoMiraHabilidade.MIRA_OPONENTE
    );
  }
}
public class CantarOuCompor extends Habilidade {
  
  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    usuario.multiplicador_dano = 2;
    alvo.ferir(usuario.get_atk() * usuario.multiplicador_dano);
    usuario.incrementar_vel(10);
    usuario.multiplicador_dano = 1;
  }

  public CantarOuCompor() {
    super(
      7, 
      "Cantar ou Compor", 
      "Os dois né. Causa o ATK do usuario de dano, aumenta a velocidade"
        + "10pts e aumenta o multplicador para 2x", 
      4,
      TipoMiraHabilidade.MIRA_OPONENTE
    );
  }
}
public class Assobiar extends Habilidade {

  @Override
  protected void uso(Personagem usuario, Personagem alvo) {
    final int cura_minima = 5;
    alvo.curar(cura_minima + usuario.get_atk());
  }

  public Assobiar() {
    super(
      8, 
      "Assobiar", 
      "Cura o alvo com base no ATK do usuário.", 
      2, 
      TipoMiraHabilidade.MIRA_ALIADO
    );
  }
}

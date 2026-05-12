public class SapoLanceiro extends TipoPersonagem {
  public SapoLanceiro() {
    super(1, "Sapo Lanceiro", "inimigo2.png");
  }
  
  @Override
  public int gerar_vel(int nivel) {
    return 10 * nivel * (int)random(1, 10+1);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 50 + 5 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 1.45 * nivel * random(1.1, 1.25);
  }
  
  @Override
  public Habilidade[] gerar_habilidades() {
    return new Habilidade[] { new Golpear(), new Estocar(), new Agilidade() };
  }
}

public class Demonio extends TipoPersonagem {
  public Demonio() {
    super(2, "Demônio", "inimigo1.png");
  }
  
  @Override
  public int gerar_vel(int nivel) {
    return 3 * nivel * (int)random(3, 7+1);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 70 + 1.5 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 1.6 * nivel * random(1.15, 1.3);
  }
  
  @Override
  public Habilidade[] gerar_habilidades() {
    return new Habilidade[] { new Golpear(), new Estocar(), new BolaFogo() };
  }
}

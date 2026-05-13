public class CanetaAzul extends TipoPersonagem {
  public CanetaAzul() {
    super(3, "Caneta Azul", "Manoel_guerreiro.png");
  }
  
  @Override
  public int gerar_vel(int nivel) {
    return 8 * nivel + (int)random(1, 6);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 100 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 9 * nivel + random(2, 6);
  }
  @Override
  public Habilidade[] gerar_habilidades() {
    return new Habilidade[] { new Golpear(), new ReporTinta(), new Assobiar() };
  }
}
  
  public class CanetaMagica extends TipoPersonagem {
  public CanetaMagica() {
    super(4, "Caneta Mágica", "Manoel_mago.png");
  }
  
  @Override
  public int gerar_vel(int nivel) {
    return 7 * nivel + (int)random(1, 5);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 80 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 14 * nivel + random(4, 10);
  }
  @Override
  public Habilidade[] gerar_habilidades() {
    return new Habilidade[] { new Golpear(), new CantarOuCompor(), new Agilidade() };
  }
  }
  
  public class CanetaRoubada extends TipoPersonagem {
  public CanetaRoubada() {
    super(5, "Caneta Roubada", "Manoel_assassino.png");
  }
  
  @Override
  public int gerar_vel(int nivel) {
    return 12 * nivel + (int)random(3, 8);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 60 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 11 * nivel + random(3, 7);
  }
  
  @Override
  public Habilidade[] gerar_habilidades() {
    return new Habilidade[] { new Golpear(), new Canetada(), new Agilidade() };
  }
}
public class SapoLanceiro extends TipoPersonagem {
  public SapoLanceiro() {
    super(1, "Sapo Lanceiro", "inimigo2.png");
  }
  
  @Override
  public int gerar_vel(int nivel) {
    return 6 * nivel + (int)random(1, 5);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 50 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 8 * nivel + random(1, 5);
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
    return 5 * nivel + (int)random(1, 4);
  }
  
  @Override
  public float gerar_vida_max(int nivel) {
    return 70 * nivel;
  }
  
  @Override
  public float gerar_atk(int nivel) {
    return 11 * nivel + random(3, 7);
  }
  
  @Override
  public Habilidade[] gerar_habilidades() {
    return new Habilidade[] { new Golpear(), new Estocar(), new BolaFogo() };
  }
}

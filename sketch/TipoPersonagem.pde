public abstract class TipoPersonagem {
  private int id;
  private String nome;
  private PImage sprite;

  public int get_id() { return id; }
  public String get_nome() { return nome; }
  public PImage get_sprite() { return sprite; }
  
  public abstract int gerar_vel(int nivel);
  public abstract int gerar_vida_max(int nivel);
  public abstract int gerar_atk(int nivel);
  
  // Deve retornar as instâncias das 3 habilidades que o tipo de
  // personagem tem
  public abstract Habilidade[] gerar_habilidades();
  
  public TipoPersonagem(int id, String nome) {
     this.id = id;
     this.nome = nome;
  }
}

public abstract class Habilidade {
  private int id;
  private String nome;
  private String descricao;
  private boolean altera_vel;
  private int cooldown; // Cooldown quando o ataque é utilizado
  private int cooldown_atual;
  
  public int get_id() { return id; }
  public String get_nome() { return nome; }
  public int get_cooldown() { return cooldown_atual; }
  
  public boolean altera_velocidade() { return altera_vel; }
  
  public void decrementar_cooldown() {
    assert(cooldown_atual > 0);
    cooldown_atual--;
  }
  
  public void entrar_em_cooldown() { cooldown_atual = cooldown; }
  
  protected abstract void uso(Personagem usuario, Personagem alvo);
  
  public void usar(Personagem usuario, Personagem alvo) {
    assert(cooldown_atual == 0);
    entrar_em_cooldown();
    
    uso(usuario, alvo);
  }
  
  public Habilidade(int id, String nome, String descricao, int cooldown, boolean altera_vel) {
    this.id = id;
    this.nome = nome;
    this.descricao = descricao;
    this.cooldown = cooldown;
    this.altera_vel = altera_vel;
  }
}

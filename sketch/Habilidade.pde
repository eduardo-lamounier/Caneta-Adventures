public enum TipoMiraHabilidade {
  NAO_MIRA,
  MIRA_ALIADO,
  MIRA_OPONENTE,
}

public abstract class Habilidade {
  private int id;
  private String nome;
  private String descricao;
  private boolean altera_vel;
  private int cooldown; // Cooldown quando o ataque é utilizado
  private int cooldown_atual;
  private TipoMiraHabilidade tipo_mira;
  
  public int get_id() { return id; }
  public String get_nome() { return nome; }
  public String get_descricao() { return descricao; }
  public int get_cooldown() { return cooldown_atual; }
  public TipoMiraHabilidade tipo_de_mira() { return tipo_mira; }
  
  public boolean altera_velocidade() { return altera_vel; }
  
  public void decrementar_cooldown() {
    assert(cooldown_atual > 0);
    cooldown_atual--;
  }
  
  public void entrar_em_cooldown() { cooldown_atual = cooldown; }
  
  protected abstract void uso(Personagem usuario, Personagem alvo);
  
  public void usar(Personagem usuario, Personagem alvo) {
    assert(cooldown_atual == 0);
    assert(
      tipo_mira == TipoMiraHabilidade.NAO_MIRA && alvo == null
      || tipo_mira != TipoMiraHabilidade.NAO_MIRA && alvo != null
    );

    entrar_em_cooldown();
    
    uso(usuario, alvo);
  }
  
  public Habilidade(
    int id, 
    String nome, 
    String descricao, 
    int cooldown, 
    boolean altera_vel,
    TipoMiraHabilidade tipo_mira
  ) {
    this.id = id;
    this.nome = nome;
    this.descricao = descricao;
    this.cooldown = cooldown;
    this.altera_vel = altera_vel;
    this.tipo_mira = tipo_mira;
    
    cooldown_atual = 0;
  }
}

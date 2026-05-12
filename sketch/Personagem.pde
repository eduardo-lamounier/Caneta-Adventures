public abstract class Personagem {
  protected TipoPersonagem tipo_personagem;
  protected float vida_max;
  protected float vida_atual;
  protected float atk; // Multiplicador de dano gerado dependendo do nível da equipe
  protected int vel;
  
  protected Habilidade[] habilidades;
  
  public int get_id() { return tipo_personagem.get_id(); }
  public String get_nome() { return tipo_personagem.get_nome(); }
  public PImage get_sprite() { return tipo_personagem.get_sprite(); }
  
  public float get_vida_atual() { return vida_atual; }
  public int get_vel() { return vel; }
  public float get_atk() { return atk; }
  
  public boolean esta_vivo() { return vida_atual > 0; }
  
  public void ferir(float dano) {
    vida_atual = max(0, vida_atual - dano);
  }
  
  public void incrementar_vel(int incremento) {
    assert(vel + incremento > 0);
    vel += incremento;
  }
  
  public void decrementar_cooldowns() {
    for(int i = 0; i < 3; i++)
      if(habilidades[i].get_cooldown() > 0)
        habilidades[i].decrementar_cooldown();
  }
  
  public abstract void escolher_habilidade();
  public abstract Habilidade obter_habilidade_escolhida();
  
  public abstract void escolher_alvo(Personagem[] oponentes);
  public abstract Personagem obter_alvo_escolhido();
  
  public Personagem(int nivel, TipoPersonagem tipo_personagem) {
    this.tipo_personagem = tipo_personagem;
    vida_max = tipo_personagem.gerar_vida_max(nivel);
    atk = tipo_personagem.gerar_atk(nivel);
    vel = tipo_personagem.gerar_vel(nivel);
    this.vida_atual = vida_max;
    
    habilidades = tipo_personagem.gerar_habilidades();
  }
}

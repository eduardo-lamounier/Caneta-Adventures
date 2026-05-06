public abstract class Personagem {
  protected TipoPersonagem tipo_personagem;
  protected float vida_max;
  protected float vida_atual;
  protected float atk; // Multiplicador de dano gerado dependendo do nível da equipe
  protected int vel;
  
  protected Habilidade[] habilidades;
  
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
  
  public abstract Habilidade escolher_habilidade();
  public abstract Personagem escolher_alvo(Personagem[] alvos);
  
  public Personagem(int nivel, TipoPersonagem tipo_personagem) {
    this.tipo_personagem = tipo_personagem;
    vida_max = tipo_personagem.gerar_vida_max(nivel);
    atk = tipo_personagem.gerar_atk(nivel);
    vel = tipo_personagem.gerar_vel(nivel);
    this.vida_atual = vida_max;
    
    habilidades = tipo_personagem.gerar_habilidades();
  }
}

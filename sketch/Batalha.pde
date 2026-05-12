public enum EstadoBatalha { NAO_INICIADA, EM_PROGRESSO, VITORIA, DERROTA }

public class Batalha {
  private Equipe herois;
  private Equipe inimigos;
  
  private int atacante_atual;
  private Personagem[] fila_turnos;
 
  private int turno_atual;
  private EstadoBatalha estado_batalha;

  public EstadoBatalha get_estado_batalha() { return estado_batalha; }
  
  // Retorna 0 se a batalha não tiver em progresso
  public int get_turno_atual() { return turno_atual; }

  private void ordenar_fila() {
    // FALTA IMPLEMENTAR ORDENAÇÃO DA FILA!!
  } 

  // Executa os turnos de cada personagem e retorna se a batalha deve
  // ser finalizada (true) ou não (false)
  private boolean turno() {
    for(atacante_atual = 0; atacante_atual < 6; atacante_atual++) {
      Personagem personagem_atacante_atual = fila_turnos[atacante_atual];

      // IMPLEMENTAR TURNO PARA O PERSONAGEM ATUAL
      
      // chamar ordenar_fila caso as velocidades tenham sido alteradas
    }

    return false; // apenas para o compilador não reclamar, remover depois
  }

  public void desenhar() {
    
  }
  
  public void iniciar() {
    estado_batalha = EstadoBatalha.EM_PROGRESSO;
    for(turno_atual = 1; !turno(); turno_atual++);

    turno_atual = 0;
    // ATUALIZAR ESTADO DA BATALHA PARA DERROTA OU VITÓRIA
  }

  public Batalha(Equipe herois, Equipe inimigos) {
    this.herois = herois;
    this.inimigos = inimigos;
   
    turno_atual = 0;
    fila_turnos = new Personagem[6];
    estado_batalha = EstadoBatalha.NAO_INICIADA;
    
    int i = 0;
    for(Personagem heroi : herois.get_personagens())
      fila_turnos[i++] = heroi;
    for(Personagem inimigo : inimigos.get_personagens())
      fila_turnos[i++] = inimigo;
    
    ordenar_fila();
  }
}

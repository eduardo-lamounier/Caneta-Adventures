public enum EstadoBatalha { NAO_INICIADA, EM_PROGRESSO, VITORIA, DERROTA }

public class Batalha {
  private int atacante_atual;
  private Personagem[] fila_turnos;
  private boolean[] personagem_fila_turnos_herois; // Serve para saber quais personagens
                                                   // da fila de turnos são heróis e quais
                                                   // são inimigos
 
  private int turno_atual;
  private EstadoBatalha estado_batalha;

  public EstadoBatalha get_estado_batalha() { return estado_batalha; }
  
  // Retorna 0 se a batalha não tiver em progresso
  public int get_turno_atual() { return turno_atual; }

  private void ordenar_fila() {
    for(int i = 0; i < 6; i++) {
      Personagem personagem_rapido = fila_turnos[i];
      boolean personagem_rapido_heroi = personagem_fila_turnos_herois[i];
      
      for(int j = i + 1; j < 6; j++) {
        
        if(fila_turnos[j].get_vel() > personagem_rapido.get_vel()
          || (fila_turnos[j].get_vel() == personagem_rapido.get_vel()
            && (int)random(0, 1+1) == 1)
        ) {
          personagem_rapido = fila_turnos[j];
          personagem_rapido_heroi = personagem_fila_turnos_herois[j];
        }
      }
      
      fila_turnos[i] = personagem_rapido;
      personagem_fila_turnos_herois[i] = personagem_rapido_heroi;
    }
  }

  // Executa os turnos de cada personagem e retorna se a batalha deve
  // ser finalizada (true) ou não (false)
  private boolean turno() {
    for(atacante_atual = 0; atacante_atual < 6; atacante_atual++) {
      Personagem personagem_atacante_atual = fila_turnos[atacante_atual];
      boolean personagem_atual_heroi =
        personagem_fila_turnos_herois[atacante_atual];

      Personagem[] oponentes = new Personagem[3];
      int o = 0; // Iterador dos oponentes
      
      // Busca os oponentes (de forma infelizmente nada funcional)
      for(int j = 0; j < 6; j++) {
        if(personagem_fila_turnos_herois[j] != personagem_atual_heroi)
          oponentes[o++] = fila_turnos[j];
      }
      
      Habilidade habilidade_escolhida =
        personagem_atacante_atual.escolher_habilidade();
      
      Personagem alvo_da_habilidade =
        personagem_atacante_atual.escolher_alvo(oponentes);
      
      habilidade_escolhida.usar(personagem_atacante_atual, alvo_da_habilidade);
      
      if(habilidade_escolhida.altera_velocidade())
        ordenar_fila();
        
      // FALTA CHECAR PELO FIM DA BATALHA!!
    }

    return false; // apenas para o compilador não reclamar, remover depois
  }

  public void desenhar() {
    if(estado_batalha == EstadoBatalha.NAO_INICIADA)
      return;
    
    // IMPLEMENTAR DESENHO AQUI
    
    
  }
  
  private void iniciar() {
    ThreadBatalha thread = new ThreadBatalha();
    thread.start();
  }

  private class ThreadBatalha extends Thread {
    public void run() {
      estado_batalha = EstadoBatalha.EM_PROGRESSO;
      for(turno_atual = 1; !turno(); turno_atual++);

      turno_atual = 0;
      // ATUALIZAR ESTADO DA BATALHA PARA DERROTA OU VITÓRIA
    }
  }

  public Batalha(Equipe herois, Equipe inimigos) {
    turno_atual = 0;
    fila_turnos = new Personagem[6];
    estado_batalha = EstadoBatalha.NAO_INICIADA;
    
    int i = 0;
    for(Personagem heroi : herois.get_personagens()) {
      fila_turnos[i] = heroi;
      personagem_fila_turnos_herois[i] = true;
      i++;
    }
    for(Personagem inimigo : inimigos.get_personagens()) {
      fila_turnos[i] = inimigo;
      personagem_fila_turnos_herois[i] = false;
      i++;
    }
    
    ordenar_fila();
  }
}

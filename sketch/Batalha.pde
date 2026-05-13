private enum EstadoTurno {
  ESCOLHA_HABILIDADE,
  OBTER_ESCOLHA_HABILIDADE,
  ESCOLHA_ALVO,
  OBTER_ESCOLHA_ALVO,
  USO_HABILIDADE
}

public class Batalha {
  private int atacante_atual;
  private Habilidade habilidade_escolhida;
  private Personagem alvo_escolhido;
  private Personagem[] fila_turnos;
  private boolean[] personagem_fila_turnos_herois; // Serve para saber quais personagens
                                                   // da fila de turnos são heróis e quais
                                                   // são inimigos
 
  private int turno_atual;
  private EstadoTurno estado_atual;
  
  private int espera = -1;
  private int duracao_espera = 0;
  private boolean uso_habilidade_executado = false;
  
  // Retorna 0 se a batalha não tiver em progresso
  public int get_turno_atual() { return turno_atual; }
  public EstadoTurno get_estado_atual() { return estado_atual; }

  private void ordenar_fila() {
    for(int i = 0; i < 6; i++) {
      int personagem_rapido_i = i;
      
      for(int j = i + 1; j < 6; j++) {
        
        if(fila_turnos[j].get_vel() > fila_turnos[personagem_rapido_i].get_vel()
          || (fila_turnos[j].get_vel() == fila_turnos[personagem_rapido_i].get_vel()
            && (int)random(0, 1+1) == 1)
        )
          personagem_rapido_i = j;
      }
      
      Personagem temp1 = fila_turnos[i];
      fila_turnos[i] = fila_turnos[personagem_rapido_i];
      fila_turnos[personagem_rapido_i] = temp1;
      
      boolean temp2 = personagem_fila_turnos_herois[i];
      personagem_fila_turnos_herois[i] =
        personagem_fila_turnos_herois[personagem_rapido_i];
      personagem_fila_turnos_herois[personagem_rapido_i] = temp2;
    }
  }
  
  public void desenhar_interface() {
  if (atacante_atual < 0) return;
  Personagem atacante = fila_turnos[atacante_atual];
  if (!(atacante instanceof Heroi)) return;
  Heroi heroi = (Heroi) atacante;

  switch (estado_atual) {
      case OBTER_ESCOLHA_HABILIDADE:
        desenhar_botoes(heroi.get_botoes_habilidade());
        break;
      case OBTER_ESCOLHA_ALVO:
        desenhar_botoes(heroi.get_botoes_alvo());
        break;
    }
  }
  
  public boolean deve_finalizar() {
    boolean heroi_vivo = false;
    boolean inimigo_vivo = false;
    for(int i = 0; i < 6; i++) {
    if(fila_turnos[i].esta_vivo()) {
      if(personagem_fila_turnos_herois[i]) heroi_vivo = true;
      else inimigo_vivo = true;
    }
  }
  
  return !heroi_vivo || !inimigo_vivo;
  }
 
  private boolean esperando(){
    if(espera == -1) return false;
    if(millis() - espera >= duracao_espera){
      espera = -1;
      return false;
    }
    return true;
  }
  private void iniciar_espera(int ms){
    espera = millis();
    duracao_espera = ms;
  }
  
  public void avancar() {
    if (esperando()) return;
    if(estado_atual == EstadoTurno.ESCOLHA_HABILIDADE) {
      turno_atual++;
      atacante_atual = (atacante_atual + 1) % 6;
    }
    
    Personagem personagem_atacante_atual = fila_turnos[atacante_atual];
    boolean personagem_atual_heroi =
      personagem_fila_turnos_herois[atacante_atual];
    
    switch(estado_atual) {
      case ESCOLHA_HABILIDADE:
      println("turno de: " + personagem_atacante_atual.get_nome());
      personagem_atacante_atual.decrementar_cooldowns();
        personagem_atacante_atual.escolher_habilidade();
        estado_atual = EstadoTurno.OBTER_ESCOLHA_HABILIDADE;

        if (!personagem_atual_heroi) iniciar_espera(1500);
        break;
      case OBTER_ESCOLHA_HABILIDADE:
        if(!personagem_atual_heroi && !esperando()) {
        habilidade_escolhida = personagem_atacante_atual.obter_habilidade_escolhida();
        if(habilidade_escolhida != null) {
        iniciar_espera(1500);
        estado_atual = EstadoTurno.ESCOLHA_ALVO;
    }
  } else if(personagem_atual_heroi) {
    habilidade_escolhida = personagem_atacante_atual.obter_habilidade_escolhida();
    if(habilidade_escolhida != null)
    estado_atual = EstadoTurno.ESCOLHA_ALVO;
  }
  break;
      case ESCOLHA_ALVO:
        Personagem[] oponentes = new Personagem[3];
        
        int o = 0; // Iterador dos oponentes
      
        // Busca os oponentes (de forma infelizmente nada funcional)
        for(int i = 0; i < 6; i++) {
          if(personagem_fila_turnos_herois[i] != personagem_atual_heroi && fila_turnos[i].esta_vivo())
            oponentes[o++] = fila_turnos[i];
        }
        
        assert(o == 3); // debug
        
        personagem_atacante_atual.escolher_alvo(oponentes);
        estado_atual = EstadoTurno.OBTER_ESCOLHA_ALVO;
        break;
      case OBTER_ESCOLHA_ALVO:
        alvo_escolhido = personagem_atacante_atual.obter_alvo_escolhido();
        if(alvo_escolhido != null)
          estado_atual = EstadoTurno.USO_HABILIDADE;
        break;
      case USO_HABILIDADE:
        if (!uso_habilidade_executado) {
          habilidade_escolhida.usar(personagem_atacante_atual, alvo_escolhido);
          println(personagem_atacante_atual.get_nome()
            + " usou " + habilidade_escolhida.get_nome()
            + " em " + alvo_escolhido.get_nome());

          if (habilidade_escolhida.altera_velocidade())
            ordenar_fila();

          uso_habilidade_executado = true;
      iniciar_espera(3000);
    } else {
      uso_habilidade_executado = false;
      estado_atual = EstadoTurno.ESCOLHA_HABILIDADE;
    }
      break;
  }
    }

  public Batalha(Equipe herois, Equipe inimigos) {
    turno_atual = 0;
    estado_atual = EstadoTurno.ESCOLHA_HABILIDADE;
    atacante_atual = -1;
    habilidade_escolhida = null;
    alvo_escolhido = null;
    fila_turnos = new Personagem[6];
    personagem_fila_turnos_herois = new boolean[6];
    //estado_batalha = EstadoBatalha.NAO_INICIADA;
    
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

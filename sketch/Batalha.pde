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

  private Heroi[] herois;
  private Inimigo[] inimigos;
  private Personagem[] fila_turnos;
 
  private int turno_atual;
  private EstadoTurno estado_atual;
  
  private int espera = -1;
  private int duracao_espera = 0;
  private boolean uso_habilidade_executado = false;
  
  private int nivel_herois;
  private int nivel_inimigos;
  private int xp_vitoria;

  public int get_xp_vitoria() { return xp_vitoria; }
  public int get_turno_atual() { return turno_atual; }
  public EstadoTurno get_estado_atual() { return estado_atual; }

  public boolean herois_sairam_vitoriosos() {
    for(Inimigo inimigo : inimigos) {
      if(inimigo.esta_vivo())
        return false;
    }
    return true;
  }

  private void ordenar_fila() {
    for(int i = 0; i < 6; i++) {
      int personagem_rapido = i;
      
      for(int j = i + 1; j < 6; j++)  
        if(fila_turnos[j].get_vel() > fila_turnos[personagem_rapido].get_vel()
          || (fila_turnos[j].get_vel() == fila_turnos[personagem_rapido].get_vel()
            && (int)random(0, 1+1) == 1)
        )
          personagem_rapido = j; 
      
      Personagem temp1 = fila_turnos[i];
      fila_turnos[i] = fila_turnos[personagem_rapido];
      fila_turnos[personagem_rapido] = temp1;
    }
  }
  
  public void desenhar() {
    final int margem_x_sprites = 50;
    final int margem_y_sprites = 75;
    final int espacamento_y_sprites = 70;
    final int tamanho_sprite = 50;
 
    for(int i = 0; i < 3; i++) {
      // desenha sprites: =======================================

      image(
        herois[i].get_sprite(),
        margem_x_sprites,
        height - margem_y_sprites - espacamento_y_sprites * (3-i-1),
        tamanho_sprite,
        tamanho_sprite
      );
      
      image(
        inimigos[i].get_sprite(),
        width - margem_x_sprites - tamanho_sprite,
        margem_y_sprites + espacamento_y_sprites * (i),
        tamanho_sprite,
        tamanho_sprite
      );

      // sprites de morte para inimigos mortos por cima:
      
      if(!herois[i].esta_vivo())
        image(
          loadImage("death.png"),
          margem_x_sprites,
          height - margem_y_sprites - espacamento_y_sprites * (3-i-1),
          tamanho_sprite,
          tamanho_sprite
        );

      if(!inimigos[i].esta_vivo())
        image(
          loadImage("death.png"),
          width - margem_x_sprites - tamanho_sprite,
          margem_y_sprites + espacamento_y_sprites * (i),
          tamanho_sprite,
          tamanho_sprite
        );

      // desenha barras de hp: =====================================
      
      final int margem_x_hp = 40;
      final int comprimento_hp = 150;
      final int altura_hp = (int)tamanho_sprite * 1/3;
      final int tamanho_texto_hp = 17;
      final color cor_fundo_hp = color(#343232);
      final color cor_texto_hp = color(#ffffff);
      final color cor_barra_hp = color(#38D30B);


      fill(cor_fundo_hp);
      
      rect(
        margem_x_sprites + tamanho_sprite + margem_x_hp,
        height - margem_y_sprites - espacamento_y_sprites * (3-i-1) + tamanho_sprite - altura_hp,
        comprimento_hp,
        altura_hp,
        15
      );

      rect(
        width - margem_x_sprites - tamanho_sprite - margem_x_hp - comprimento_hp,
        margem_y_sprites + espacamento_y_sprites * i,
        comprimento_hp,
        altura_hp,
        15
      );

      fill(cor_barra_hp);
      float razao_vida_heroi = herois[i].get_vida_atual() / herois[i].get_vida_max();
      float razao_vida_inimigo = inimigos[i].get_vida_atual() / inimigos[i].get_vida_max();

      rect(
        margem_x_sprites + tamanho_sprite + margem_x_hp,
        height - margem_y_sprites - espacamento_y_sprites * (3-i-1) + tamanho_sprite - altura_hp,
        (int)comprimento_hp * razao_vida_heroi,
        altura_hp,
        15
      );

      rect(
        width - margem_x_sprites - tamanho_sprite - margem_x_hp - comprimento_hp,
        margem_y_sprites + espacamento_y_sprites * i,
        (int)comprimento_hp * razao_vida_inimigo,
        altura_hp,
        15
      );
     
      fill(cor_texto_hp);
      textSize(tamanho_texto_hp);
      text(
        nf(herois[i].get_vida_atual(), 0, 1) + "/" + nf(herois[i].get_vida_max(), 0, 1) + "hp",
        margem_x_sprites + tamanho_sprite + margem_x_hp + comprimento_hp / 2,
        height - margem_y_sprites - espacamento_y_sprites * (3-i-1) + tamanho_sprite - altura_hp
      );
      text(
        nf(inimigos[i].get_vida_atual(), 0, 1) + "/" + nf(inimigos[i].get_vida_max(), 0, 1) + "hp",
        width - margem_x_sprites - tamanho_sprite - margem_x_hp - comprimento_hp / 2,
        margem_y_sprites + espacamento_y_sprites * i
      );
      
      // desenha nível =============================================
   
      final int tamanho_texto_nivel = 14;
      final int margem_nivel = 20;
      final int raio_nivel = 15;
      final color cor_fundo_nivel = color(#0d0daa);
      final color cor_texto_nivel = color(#ffffff); 

      fill(cor_fundo_nivel);
      
      circle(
        margem_x_sprites + tamanho_sprite + margem_x_hp + comprimento_hp,
        height - margem_y_sprites - espacamento_y_sprites * (3-i-1) + tamanho_sprite - altura_hp,
        raio_nivel
      );
      circle(
        width - margem_x_sprites - tamanho_sprite - margem_x_hp - comprimento_hp,
        margem_y_sprites + espacamento_y_sprites * i,
        raio_nivel
      );

      textSize(tamanho_texto_nivel);
      fill(cor_texto_nivel);
      textAlign(CENTER, CENTER);

      text(
        nivel_herois,
        margem_x_sprites + tamanho_sprite + margem_x_hp + comprimento_hp,
        height - margem_y_sprites - espacamento_y_sprites * (3-i-1) + tamanho_sprite - altura_hp
      );
      text(
        nivel_inimigos,
        width - margem_x_sprites - tamanho_sprite - margem_x_hp - comprimento_hp,
        margem_y_sprites + espacamento_y_sprites * i
      );
    }
 
    // ordem de ataque ============================================

    final int margem_ordem = 40;
    final int tamanho_ordem_x = 100;
    final int tamanho_ordem_y = 40;
    final int espacamento_ordem_y = 30;
    final color cor_nao_atacante_heroi = color(#B0C41C);
    final color cor_atacante_heroi = color(#E4FF1A);
    final color cor_nao_atacante_inimigo = color(#B9340F);
    final color cor_atacante_inimigo = color(#ED4618);
    final color cor_morto = color(#a0a0a0);

    for(int i = 0; i < 6; i++) {
      if(!fila_turnos[i].esta_vivo()) {
        fill(cor_morto);
      } else if(atacante_atual == i && (fila_turnos[i] instanceof Heroi)) {
        fill(cor_atacante_heroi);
      } else if(atacante_atual != i && (fila_turnos[i] instanceof Heroi)) {
        fill(cor_nao_atacante_heroi);
      } else if(atacante_atual == i && fila_turnos[i] instanceof Inimigo) {
        fill(cor_atacante_inimigo);
      } else {
        fill(cor_nao_atacante_inimigo);
      }

      rect(
        (float)margem_ordem,
        (float)margem_ordem + espacamento_ordem_y * i,
        (float)tamanho_ordem_x,
        (float)tamanho_ordem_y
      );

      fill(#ffffff);
      text(fila_turnos[i].get_nome(), (float)margem_ordem + tamanho_ordem_x / 2, margem_ordem + espacamento_ordem_y * i + tamanho_ordem_y / 2);
    }

    // uso de habilidade ==========================================
    
    if(estado_atual == EstadoTurno.USO_HABILIDADE) {
      final int tamanho_texto_uso_habilidade = 24;
      final int margem_x_uso_habilidade = width / 2;
      final int margem_y_uso_habilidade = height / 2;

      String texto_de_uso = alvo_escolhido != null ?
        fila_turnos[atacante_atual].get_nome() + " usou " + habilidade_escolhida.get_nome()
          + " em " + alvo_escolhido.get_nome() + "!!"
        :
        fila_turnos[atacante_atual].get_nome() + " usou " + habilidade_escolhida.get_nome() + "!!";

      textSize(tamanho_texto_uso_habilidade);
      text(texto_de_uso, margem_x_uso_habilidade, margem_y_uso_habilidade);
    }

    // seleção de habilidade ou alvos: ============================
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
        if(fila_turnos[i] instanceof Heroi) heroi_vivo = true;
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
      personagem_atacante_atual instanceof Heroi;
    
    switch(estado_atual) {
      case ESCOLHA_HABILIDADE:
        if(!fila_turnos[atacante_atual].esta_vivo()) {
          // retorna ainda na etapa de escolha de habilidade,
          // o que vai mudar o turno para outro personagem
          return;
        }

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
        if(habilidade_escolhida.tipo_de_mira() == TipoMiraHabilidade.NAO_MIRA) {
          alvo_escolhido = null;
          estado_atual = EstadoTurno.USO_HABILIDADE;
          return;
        }

        Personagem[] alvos_possiveis = personagem_atacante_atual instanceof Heroi ?
          habilidade_escolhida.tipo_de_mira() == TipoMiraHabilidade.MIRA_OPONENTE ? inimigos : herois
          :
          habilidade_escolhida.tipo_de_mira() == TipoMiraHabilidade.MIRA_OPONENTE ? herois : inimigos;
        
        personagem_atacante_atual.escolher_alvo(alvos_possiveis);
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

  public Batalha(Equipe herois, Equipe inimigos, int xp_vitoria) {
    turno_atual = 0;
    estado_atual = EstadoTurno.ESCOLHA_HABILIDADE;
    atacante_atual = -1;
    this.xp_vitoria = xp_vitoria;
    habilidade_escolhida = null;
    alvo_escolhido = null;
    this.herois = (Heroi[])herois.get_personagens();
    this.inimigos = (Inimigo[])inimigos.get_personagens();
    nivel_herois = herois.get_nivel();
    nivel_inimigos = inimigos.get_nivel();
    fila_turnos = new Personagem[6]; 
    
    int i = 0;
    for(Personagem heroi : this.herois) 
      fila_turnos[i++] = heroi;
    
    for(Personagem inimigo : this.inimigos)
      fila_turnos[i++] = inimigo;
    
    ordenar_fila();
  }
}

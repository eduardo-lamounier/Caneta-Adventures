public class Menu {
  protected PFont titulo = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  
  protected BotaoIniciar iniciar = new BotaoIniciar(width / 6, height * 2 / 5, 4 * width / 6, height / 4, #BC7920);
  protected BotaoSair sair     = new BotaoSair(width * 10 / 11, 0, width / 11, height / 9, #898989);
  protected BotaoTutorial tutorial = new BotaoTutorial(width / 6, height * 3 / 4, 4 * width / 6, height / 6, #BC7920);
  
  public void desenhar() {
    background(#0B132B);
    
    // Estrelas decorativas
    fill(#FFD166, 80);
    noStroke();
    for (int i = 0; i < 60; i++) {
      float sx = noise(i * 0.5) * width;
      float sy = noise(i * 0.5 + 100) * height;
      ellipse(sx, sy, 3, 3);
    }
    
    // Sombra do título
    fill(#BC7920, 120);
    textAlign(CENTER, CENTER);
    textFont(titulo);
    textSize(90);
    text("Caneta Adventures", width / 2 + 4, height / 5 + 4);
    
    // Título principal
    fill(#FFD166);
    textSize(90);
    text("Caneta Adventures", width / 2, height / 5);
    
    // Subtítulo
    fill(255, 180);
    textSize(22);
    text("Uma aventura épica de canetas e batalhas", width / 2, height / 5 + 70);
    
    iniciar.desenhar_botao();
    sair.desenhar_botao();
    tutorial.desenhar_botao();
  }
  
  public boolean passar_estado() {
    return iniciar.botao_clicado();
  }
  
  public void sair_jogo() {
    if (sair.botao_clicado()) exit();
  }
  
  public boolean entrar_tutorial() {
    return tutorial.botao_clicado();
  }
  
  // ── Botões internos ──────────────────────────────────────────────
  
  public class BotaoIniciar extends Botao {
    BotaoIniciar(float eixo_x, float eixo_y, float comprimento, float altura, color cor) {
      super(eixo_x, eixo_y, comprimento, altura, cor);
    }
    void desenhar_botao() {
      super.desenhar_botao();
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(36);
      text("▶  Jogar", eixo_x + comprimento / 2, eixo_y + altura / 2);
    }
  }
  
  public class BotaoSair extends Botao {
    BotaoSair(float eixo_x, float eixo_y, float comprimento, float altura, color cor) {
      super(eixo_x, eixo_y, comprimento, altura, cor);
    }
    void desenhar_botao() {
      super.desenhar_botao();
      stroke(255);
      strokeWeight(3);
      line(eixo_x + comprimento / 5,     eixo_y + altura / 5,
           eixo_x + comprimento * 4 / 5, eixo_y + altura * 4 / 5);
      line(eixo_x + comprimento / 5,     eixo_y + altura * 4 / 5,
           eixo_x + comprimento * 4 / 5, eixo_y + altura / 5);
      strokeWeight(1);
      noStroke();
    }
  }
  
  public class BotaoTutorial extends Botao {
    BotaoTutorial(float eixo_x, float eixo_y, float comprimento, float altura, color cor) {
      super(eixo_x, eixo_y, comprimento, altura, cor);
    }
    void desenhar_botao() {
      super.desenhar_botao();
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(36);
      text("Como jogar?", eixo_x + comprimento / 2, eixo_y + altura / 2);
    }
  }
}
public class GameOver {
  private PFont titulo;
  private BotaoReiniciar reiniciar;
  private BotaoMenu voltarMenu;
  private boolean vitoria;
  
  public GameOver(boolean vitoria) {
    this.vitoria = vitoria;
    titulo = loadFont("BerlinSansFBDemi-Bold-48.vlw");
    
    reiniciar  = new BotaoReiniciar(width / 6,     height * 3 / 5, 4 * width / 6, height / 7, #BC7920);
    voltarMenu = new BotaoMenu   (width / 6,     height * 3 / 4 + 10, 4 * width / 6, height / 7, #4A5568);
  }
  
  public void desenhar() {
    background(#0B132B);
    
    // Partículas de fundo
    noStroke();
    for (int i = 0; i < 40; i++) {
      fill(vitoria ? color(#FFD166, 60) : color(#FF4444, 40));
      float px = noise(i * 0.7, frameCount * 0.01) * width;
      float py = noise(i * 0.7 + 50, frameCount * 0.01) * height;
      ellipse(px, py, 5, 5);
    }
    
    // Título Game Over / Vitória
    textAlign(CENTER, CENTER);
    textFont(titulo);
    
    // Sombra
    fill(vitoria ? color(#BC7920, 120) : color(#8B0000, 120));
    textSize(100);
    text(vitoria ? "Vitória!" : "Game Over", width / 2 + 5, height / 4 + 5);
    
    // Texto principal
    fill(vitoria ? #FFD166 : #FF4444);
    text(vitoria ? "Vitória!" : "Game Over", width / 2, height / 4);
    
  // Título:
    textFont(fonteCorpo); // sua fonte branca
    fill(255);
    textSize(20);
    textAlign(CENTER, TOP);
  
    // Bloco 1 — Exploração
    fill(#f5c842);
    textSize(24);
    text("Exploração", width / 2, 160);
  
    fill(255);
    textSize(18);
    text("Use W A S D para mover sua equipe pelo mapa.", width / 2, 192);
    text("Encontre os inimigos caminhando até eles.", width / 2, 216);
  
    // Bloco 2 — Batalha
    fill(#f5c842);
    textSize(24);
    text("Batalha", width / 2, 280);
  
    fill(255);
    textSize(18);
    text("Ao colidir com um inimigo, a batalha começa automaticamente.", width / 2, 312);
    text("Cada equipe tem 3 personagens que lutam em turnos.", width / 2, 336);
  
    // Bloco 3 — Habilidades
    fill(#f5c842);
    textSize(24);
    text("Habilidades", width / 2, 400);
  
    fill(255);
    textSize(18);
    text("Cada personagem possui habilidades únicas de ataque e defesa.", width / 2, 432);
    text("Escolha bem suas ações para vencer o combate!", width / 2, 456);
  
    // Rodapé — dica
    fill(180);
    textSize(15);
    text("Pressione M para voltar ao menu.", width / 2, 540);
    
    sair.desenhar_botao();
    }

    // Mensagem
    fill(255, 200);
    textSize(24);
    text(
      vitoria ? "Parabéns! Você derrotou todos os inimigos." 
              : "Sua equipe foi derrotada. Tente novamente!",
      width / 2, height * 2 / 5
    );
    
    reiniciar.desenhar_botao();
    voltarMenu.desenhar_botao();
  }
  
  public boolean reiniciar_jogo() {
    return reiniciar.botao_clicado();
  }
  
  public boolean voltar_menu() {
    return voltarMenu.botao_clicado();
  }
  
  // ── Botões internos ──────────────────────────────────────────────
  
  public class BotaoReiniciar extends Botao {
    BotaoReiniciar(float eixo_x, float eixo_y, float comprimento, float altura, color cor) {
      super(eixo_x, eixo_y, comprimento, altura, cor);
    }
    void desenhar_botao() {
      super.desenhar_botao();
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(36);
      text("↺  Jogar novamente", eixo_x + comprimento / 2, eixo_y + altura / 2);
    }
  }
  
  public class BotaoMenu extends Botao {
    BotaoMenu(float eixo_x, float eixo_y, float comprimento, float altura, color cor) {
      super(eixo_x, eixo_y, comprimento, altura, cor);
    }
    void desenhar_botao() {
      super.desenhar_botao();
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(36);
      text("⌂  Menu principal", eixo_x + comprimento / 2, eixo_y + altura / 2);
    }
  }
}

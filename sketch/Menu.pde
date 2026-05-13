public class Menu{
  protected PFont titulo = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  
  protected BotaoIniciar iniciar = new BotaoIniciar(width / 6, height * 2 / 5, 4 * width / 6, height / 4, 
                                #BC7920);
                                
  protected BotaoSair sair = new BotaoSair(width * 10 / 11, 0, width / 11, height / 9, #898989);
  
  protected BotaoManual manual = new BotaoManual(width / 6, height * 3 / 4, 4 * width / 6, height / 6, #BC7920);
  
  public void desenhar(){
  // Background:
    background(#0B132B);
    
  // Título:
    fill(#FFD166);
    
    textAlign(CENTER);
    textFont(titulo);
    textSize(100);
    
    text("Jogo do ano!", width / 2, height / 4);
    
  // Botao de iniciar
    iniciar.desenhar_botao();
    
  // Botao de sair
    sair.desenhar_botao();
    
  // Botao para o manual
    manual.desenhar_botao();
  }
  
  public boolean passar_estado(){
    if(iniciar.botao_clicado())
      return true;
      
    return false;
  }
  
  public void sair_jogo(){
   if(sair.botao_clicado()) { exit(); }
  }
  
  public class BotaoIniciar extends Botao{
    BotaoIniciar(float eixo_x, float eixo_y, float comprimento, float altura, color cor){
     super(eixo_x, eixo_y, comprimento, altura, cor); 
    }
    
    void desenhar_botao(){
      super.desenhar_botao();
      
      fill(255, 255, 255);
      triangle(eixoX + 2 * comprimento / 5, eixoY + altura / 4,     // Ponto 1
               eixoX + 2 * comprimento / 5, eixoY + 3 * altura / 4, // Ponto 2
               eixoX + 3 * comprimento / 5, eixoY + altura / 2);    // Ponto 3
    }
  }
  
  public class BotaoSair extends Botao{
    BotaoSair(float eixo_x, float eixo_y, float comprimento, float altura, color cor){
     super(eixo_x, eixo_y, comprimento, altura, cor); 
    }
    
    void desenhar_botao(){
      super.desenhar_botao();
      
      // X:
      stroke(255);
      line(eixoX + comprimento / 5, eixoY + altura / 5,          // Ponto 1 - linha 1
           eixoX + comprimento * 4 / 5, eixoY + altura * 4 / 5); // Ponto 2 - linha 1
      line(eixoX + comprimento / 5, eixoY + altura * 4 /5,       // Ponto 1 - linha 2
           eixoX + comprimento * 4 / 5, eixoY + altura / 5);     // Ponto 2 - linha 2
    }
  }
  
  public class BotaoManual extends Botao {
   BotaoManual(float eixo_x, float eixo_y, float comprimento, float altura, color cor) {
     super(eixo_x, eixo_y, comprimento, altura, cor);
   }
   
   void desenhar_botao(){
     super.desenhar_botao();
     
     fill(255);
     textSize(75);
     
     text("Como jogar?", eixoX + (comprimento / 2), eixoY + (altura * 2 / 3));
   }
  }
}

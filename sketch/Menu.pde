public class Menu{
  protected PFont titulo = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  
  protected color cor_iniciar = color(#6C350A);
  
  protected BotaoIniciar iniciar = new BotaoIniciar(width / 6, height / 2, 4 * width / 6, height / 4, 
                                cor_iniciar);
                                
  protected BotaoSair sair = new BotaoSair(width * 6 / 7, 0, width / 7, height / 7, #6C350A);
  
  public void desenhar(){
  // Background:
    background(#45B9F5);
    
  // Título:
    fill(255, 255, 0);
    
    textAlign(CENTER);
    textFont(titulo);
    textSize(100);
    
    text("Jogo do ano!", width / 2, height / 4);
    
  // Botao de iniciar
    iniciar.desenharBotao();
    
  // Botao de sair
    sair.desenharBotao();
  }
  
  public boolean passarEstado(){
    if(iniciar.clicarBotao())
      return true;
      
    return false;
  }
  
  public void sairJogo(){
   if(sair.clicarBotao()) { exit(); }
  }
  
  public class BotaoIniciar extends Botao{
    BotaoIniciar(float eixoX, float eixoY, float comprimento, float altura, color cor){
     super(eixoX, eixoY, comprimento, altura, cor); 
    }
    
    void desenharBotao(){
      super.desenharBotao();
      
      fill(255, 255, 255);
      triangle(eixoX + 2 * comprimento / 5, eixoY + altura / 4,     // Ponto 1
               eixoX + 2 * comprimento / 5, eixoY + 3 * altura / 4, // Ponto 2
               eixoX + 3 * comprimento / 5, eixoY + altura / 2);    // Ponto 3
    }
  }
  
  public class BotaoSair extends Botao{
    BotaoSair(float eixoX, float eixoY, float comprimento, float altura, color cor){
     super(eixoX, eixoY, comprimento, altura, cor); 
    }
    
    void desenharBotao(){
      super.desenharBotao();
      
      // X:
      stroke(255);
      line(eixoX + comprimento / 5, eixoY + altura / 5,
           eixoX + comprimento * 4 / 5, eixoY + altura * 4 / 5);
      line(eixoX + comprimento / 5, eixoY + altura * 4 /5,
           eixoX + comprimento * 4 / 5, eixoY + altura / 5);
    }
  }
}

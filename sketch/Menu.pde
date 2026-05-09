class Menu{
  private PFont titulo = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  
  private color cor_iniciar = color(#6C350A);
  
  Botao iniciar = new Botao(width / 6, height / 2, 4 * width / 6, height / 4, 
                            cor_iniciar);
  
  public void desenhar(){
  // Título:
    fill(255, 255, 0);
    
    textAlign(CENTER);
    textFont(titulo);
    textSize(100);
    
    text("Jogo do ano!", width / 2, height / 4);
    
  // Botao de iniciar
     
   
    iniciar.desenharBotao();
  }
  
  public boolean passarEstado(){
    if(iniciar.clicarBotao())
      return true;
      
    return false;
  }
  
  class Botao{
    private float eixoX;
    private float eixoY;
    private float comprimento;
    private float altura;
    private color cor;
    
    Botao(float eixoX, float eixoY, float comprimento, float altura, color cor){
      this.eixoX = eixoX;
      this.eixoY = eixoY;
      this.comprimento = comprimento;
      this.altura = altura;
      this.cor = cor;
    }
    
    private boolean mouseEmCima(){
        if(mouseX > eixoX && mouseX < (eixoX + comprimento)
        && mouseY > eixoY && mouseY < (eixoY + altura))
          return true;
          
        return false;
    }
    
    private void desenharBotao(){
      
      if(mouseEmCima()){
        fill(cor, 220); }
      
      else{
        fill(cor, 255); }
        
      rect(eixoX, eixoY, comprimento, altura);
      
      fill(255, 255, 255);
      triangle(eixoX + 2 * comprimento / 5, eixoY + altura / 4,     // Ponto 1
               eixoX + 2 * comprimento / 5, eixoY + 3 * altura / 4, // Ponto 2
               eixoX + 3 * comprimento / 5, eixoY + altura / 2);    // Ponto 3
    }
    
    private boolean clicarBotao(){
     if(mouseEmCima() && mousePressed){
       return true; }
     
     return false;
    }
  }
}

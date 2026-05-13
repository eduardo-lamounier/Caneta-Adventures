public class Botao{
  protected float eixoX;
  protected float eixoY;
  protected float comprimento;
  protected float altura;
  protected color cor;
  
  public Botao(float eixoX, float eixoY, float comprimento, float altura, color cor){
    this.eixoX = eixoX;
    this.eixoY = eixoY;
    this.comprimento = comprimento;
    this.altura = altura;
    this.cor = cor;
  }
  
  public boolean mouseEmCima(){
      if(mouseX > eixoX && mouseX < (eixoX + comprimento)
      && mouseY > eixoY && mouseY < (eixoY + altura))
        return true;
        
      return false;
  }
  
  public void desenharBotao(){
    
    if(mouseEmCima()){
      fill(cor, 220); }
    
    else{
      fill(cor, 255); }
      
    rect(eixoX, eixoY, comprimento, altura);
  }
  
  public boolean clicarBotao(){
   if(mouseEmCima() && mousePressed){
     return true; }
   
   return false;
  }
}

public class BotaoTexto extends Botao {
  private String texto;
  private int tamanho_texto;
  private color cor_texto;
  
  BotaoTexto(
    float eixoX,
    float eixoY,
    float comprimento, 
    float altura,
    String texto,
    int tamanho_texto,
    color cor_texto,
    color cor_fundo
  ) {
     super(eixoX, eixoY, comprimento, altura, cor_fundo);
     this.texto = texto;
     this.tamanho_texto = tamanho_texto;
     this.cor_texto = cor_texto;
   }
   
   @Override
   void desenharBotao(){
     super.desenharBotao();
     
     fill(cor_texto);
     textSize(tamanho_texto);
     
     text(texto, eixoX + (comprimento / 2), eixoY + (altura * 2 / 3));
   }
}

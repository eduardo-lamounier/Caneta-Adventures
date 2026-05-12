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

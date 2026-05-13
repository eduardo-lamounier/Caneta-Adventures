
public class Botao{
  protected float eixoX;
  protected float eixoY;
  protected float comprimento;
  protected float altura;
  protected color cor;
  protected float escala = 1;
  
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
    
    noStroke();

    if(mouseEmCima())
      escala = lerp(escala, 1.04, 0.15);
    else
      escala = lerp(escala, 1, 0.15);

    float larguraAtual = comprimento * escala;
    float alturaAtual = altura * escala;

    float xAtual = eixoX - (larguraAtual - comprimento)/2;
    float yAtual = eixoY - (alturaAtual - altura)/2;
    // frufrus
    fill(0, 70);
    rect(
      xAtual + 4,
      yAtual + 4,
      larguraAtual,
      alturaAtual,
      18
    );
    if(mouseEmCima())
      fill(
       red(cor) + 20,
       green(cor) + 20,
       blue(cor) + 20
    );
    else
    fill(cor);
    rect(
      xAtual,
      yAtual,
      larguraAtual,
      alturaAtual,
      18
    );
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
  private String descricao;
  
  BotaoTexto(
    float eixoX,
    float eixoY,
    float comprimento, 
    float altura,
    String texto,
    String descricao,
    int tamanho_texto,
    color cor_texto,
    color cor_fundo
  ) {
     super(eixoX, eixoY, comprimento, altura, cor_fundo);
     this.texto = texto;
     this.descricao = descricao;
     this.tamanho_texto = tamanho_texto;
     this.cor_texto = cor_texto;
   }
   
   @Override
void desenharBotao() {
  super.desenharBotao();

  fill(cor_texto);
  textAlign(CENTER, CENTER);

  
  textSize(tamanho_texto);
  text(texto, eixoX + (comprimento / 2), eixoY + (altura * 1 / 3));

  
   fill(220);
  textSize(tamanho_texto - 10);
  text(descricao, eixoX + (comprimento / 2), eixoY + (altura * 2 / 3));
}
}

void desenhar_botoes(BotaoTexto[] botoes) {
  if (botoes == null) return;
  for (BotaoTexto b : botoes) b.desenharBotao();
}

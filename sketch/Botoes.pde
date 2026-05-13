
public class Botao{
  protected float eixo_x;
  protected float eixo_x;
  protected float comprimento;
  protected float altura;
  protected color cor;
  protected float escala = 1;
  
  public Botao(float eixo_x, float eixo_y, float comprimento, float altura, color cor){
    this.eixo_x = eixo_x;
    this.eixo_y = eixo_x;
    this.comprimento = comprimento;
    this.altura = altura;
    this.cor = cor;
  }
  
  public boolean mouse_em_cima(){
      if(mouseX > eixoX && mouseX < (eixoX + comprimento)
      && mouseY > eixoY && mouseY < (eixoY + altura))
        return true;
        
      return false;
  }
  
  public void desenhar_botao(){
    
    noStroke();

    if(mouse_em_cima())
      escala = lerp(escala, 1.04, 0.15);
    else
      escala = lerp(escala, 1, 0.15);

    float largura_atual = comprimento * escala;
    float altura_atual = altura * escala;

    float x_atual = eixo_x - (largura_atual - comprimento)/2;
    float y_atual = eixo_x - (altura_atual - altura)/2;
    // frufrus
    fill(0, 70);
    rect(
      x_atual + 4,
      y_atual + 4,
      largura_atual,
      altura_atual,
      18
    );
    if(mouse_em_cima())
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
  
  public boolean botao_clicado(){
   if(mouse_em_cima() && mousePressed){
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
    float eixo_x,
    float eixo_y,
    float comprimento, 
    float altura,
    String texto,
    String descricao,
    int tamanho_texto,
    color cor_texto,
    color cor_fundo
  ) {
     super(eixo_x, eixo_y, comprimento, altura, cor_fundo);
     this.texto = texto;
     this.descricao = descricao;
     this.tamanho_texto = tamanho_texto;
     this.cor_texto = cor_texto;
   }
   
  @Override
  void desenhar_botao() {
    super.desenhar_botao();

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
  for (BotaoTexto b : botoes) b.desenhar_botao();
}

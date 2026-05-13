public class Heroi extends Personagem {
  private BotaoTexto[] botoes_selecao_habilidade;
  private BotaoTexto[] botoes_selecao_alvo;
  
  private Personagem[] alvos_possiveis;
  
  public Habilidade obter_habilidade_escolhida() {
    assert(botoes_selecao_habilidade != null);
    
    for (int i = 0; i < 3; i++) {
      if (botoes_selecao_habilidade[i].botao_clicado() && habilidades[i].get_cooldown() == 0) {
        Habilidade escolhida = habilidades[i];
        botoes_selecao_habilidade = null;
        return escolhida;
      }
    }
    
    return null;
  }
  
  @Override
  public void escolher_habilidade() {
    if (botoes_selecao_habilidade != null) return;
    botoes_selecao_habilidade = new BotaoTexto[3];
    
    int comprimento = 320;
  int altura = 95;
  int separacao_y = 10;
  int tamanho_texto = 30;
    color cor_fundo = color(#5A5A58);
    color cor_texto = color(#FFFFFF);
    int margem_x = width - comprimento - 20;
  int bloco_total = 3 * altura + 2 * separacao_y;
  int margem_y = height - bloco_total - 20;
    
    for(int i = 0; i < 3; i++) {
      botoes_selecao_habilidade[i] = new BotaoTexto(
        margem_x, 
        margem_y + i * (altura + separacao_y),
        comprimento,
        altura,
        habilidades[i].get_nome(),
        habilidades[i].get_descricao(),
        tamanho_texto,
        cor_texto,
        cor_fundo
      );
    }
  }
  
  public BotaoTexto[] get_botoes_habilidade() { return botoes_selecao_habilidade; }
  
  @Override
  public void escolher_alvo(Personagem[] alvos_possiveis) {
    if (botoes_selecao_alvo != null) return;
    botoes_selecao_alvo = new BotaoTexto[3];
    this.alvos_possiveis = alvos_possiveis;
    
     int comprimento = 150;
  int altura = 50;
  int separacao_y = 10;
    int tamanho_texto = 30;
    color cor_fundo = color(#5A5A58);
    color cor_texto = color(#FFFFFF);
    
    int margem_x = width - comprimento - 20;
  int bloco_total = 3 * altura + 2 * separacao_y;
  int margem_y = height - bloco_total - 20;
    
    for(int i = 0; i < 3; i++) {
      botoes_selecao_alvo[i] = new BotaoTexto(
        margem_x, 
        margem_y + i * (altura + separacao_y),
        comprimento,
        altura,
        alvos_possiveis[i].get_nome(), "",
        tamanho_texto,
        cor_texto,
        cor_fundo
      );
    }
  }
  
  public BotaoTexto[] get_botoes_alvo() { return botoes_selecao_alvo; }
  
  @Override
  public Personagem obter_alvo_escolhido() {
    assert(botoes_selecao_alvo != null
      && alvos_possiveis != null);
    
    if(botoes_selecao_alvo[0].botao_clicado())
      return alvos_possiveis[0];
    else if(botoes_selecao_alvo[1].botao_clicado())
      return alvos_possiveis[1];
    else if(botoes_selecao_alvo[2].botao_clicado())
      return alvos_possiveis[2];
    
    return null;
  }
  
  public Heroi(int nivel, TipoPersonagem tipo_personagem) {
    super(nivel, tipo_personagem);
  }
}

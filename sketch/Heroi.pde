public class Heroi extends Personagem {
  private BotaoTexto[] botoes_selecao_habilidade;
  private BotaoTexto[] botoes_selecao_alvo;
  
  private Personagem[] alvos_possiveis;
  
  public Habilidade obter_habilidade_escolhida() {
    assert(botoes_selecao_habilidade != null);
    
    if(botoes_selecao_habilidade[0].clicarBotao())
      return habilidades[0];
    else if(botoes_selecao_habilidade[1].clicarBotao())
      return habilidades[1];
    else if(botoes_selecao_habilidade[2].clicarBotao())
      return habilidades[2];
    
    return null;
  }
  
  @Override
  public void escolher_habilidade() {
    botoes_selecao_habilidade = new BotaoTexto[3];
    
    int margem_x = 100;
    int margem_y = 100;
    int separacao_y = 10;
    int comprimento = 150;
    int altura = 50;
    int tamanho_texto = 30;
    color cor_fundo = color(#5A5A58);
    color cor_texto = color(#FFFFFF);
    
    for(int i = 0; i < 3; i++) {
      botoes_selecao_habilidade[i] = new BotaoTexto(
        margem_x, 
        i*margem_y + (i-1)*separacao_y,
        comprimento,
        altura,
        habilidades[i].get_nome() + "\n" + habilidades[i].get_descricao(),
        tamanho_texto,
        cor_texto,
        cor_fundo
      );
      
      botoes_selecao_habilidade[i].desenharBotao();
    }
  }
  
  @Override
  public void escolher_alvo(Personagem[] alvos_possiveis) {
    botoes_selecao_alvo = new BotaoTexto[3];
    this.alvos_possiveis = alvos_possiveis;
    
    int margem_x = 200;
    int margem_y = 100;
    int separacao_y = 10;
    int comprimento = 150;
    int altura = 50;
    int tamanho_texto = 30;
    color cor_fundo = color(#5A5A58);
    color cor_texto = color(#FFFFFF);
    
    for(int i = 0; i < 3; i++) {
      botoes_selecao_alvo[i] = new BotaoTexto(
        margem_x, 
        i*margem_y + (i-1)*separacao_y,
        comprimento,
        altura,
        alvos_possiveis[i].get_nome(),
        tamanho_texto,
        cor_texto,
        cor_fundo
      );
      
      botoes_selecao_alvo[i].desenharBotao();
    }
  }
  
  @Override
  public Personagem obter_alvo_escolhido() {
    assert(botoes_selecao_alvo != null
      && alvos_possiveis != null);
    
    if(botoes_selecao_alvo[0].clicarBotao())
      return alvos_possiveis[0];
    else if(botoes_selecao_alvo[1].clicarBotao())
      return alvos_possiveis[1];
    else if(botoes_selecao_alvo[2].clicarBotao())
      return alvos_possiveis[2];
    
    return null;
  }
  
  public Heroi(int nivel, TipoPersonagem tipo_personagem) {
    super(nivel, tipo_personagem);
  }
}

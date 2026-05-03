public class Batalha {
  private Heroi[] herois;
  private Inimigo[] inimigos;
  
  private int turno_atual;
  private Personagem[] fila_turnos;
  
  private void ordenar_fila() {
    // FALTA IMPLEMENTAR ORDENAÇÃO DA FILA!!
    println("ordenando fila...");
  }
  
  public void iniciar() {
    // IMPLEMENTAR BATALHA
  }
  
  public Batalha(Equipe equipe, Inimigo[] inimigos) {
    this.herois = equipe.get_herois();
    this.inimigos = inimigos;
    
    fila_turnos = new Personagem[6];
    
    int i = 0;
    for(Heroi heroi : this.herois)
      fila_turnos[i++] = heroi;
    for(Inimigo inimigo : this.inimigos)
      fila_turnos[i++] = inimigo;
    
    ordenar_fila();
  }
}

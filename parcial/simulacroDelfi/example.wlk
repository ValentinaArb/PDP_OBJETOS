/* class Hechicero{
  var property resistencia
  var property coraje
  var property empatia
  const conocimiento
  
  method balance() = (resistencia + coraje + empatia) / 3

  const hechizos = #{}

  const resistenciaMaxima
  method resistencia() = resistencia.max(0).min(resistenciaMaxima)

  method lanzarHechizo(hechizo,hechicero){
    hechizo.lanzar(self,hechicero)
  }

  method conveniencia(hechizo,hechicero){
    const impacto = hechizo.impacto(self,hechicero)
    if(hechicero.resistencia() == 0){
      return impacto * 2
    }else{
      return impacto
    }
  }
}

object caracteristicaEmpatia {
    method valor(hechicero) = hechicero.empatia()
}
object carateristicaCoraje {
    method valor(hechicero) = hechicero.coraje()
}
object carateristicaConocimiento {
    method valor(hechicero) = hechicero.conocimiento()
}

object carateristicaBalance {
    method valor(hechicero) = hechicero.balance()
}

class Hechizo{
  const potencia
  const caracteristica
  method impacto(atacante,contrincante){
    return (potencia + 2 * (caracteristica.valor(atacante) - caracteristica.valor(contrincante))).max(0)
  }

  method lanzar(atacante,contrincante)
}

class HechizoCurativo inherits Hechizo{
  override method lanzar(atacante,contrincante){
    atacante.resistencia() + self.impacto(atacante,contrincante)
  }
}
class HechizoAtaque inherits Hechizo{
  override method lanzar(atacante,contrincante){
    contrincante.resistencia() - self.impacto(atacante,contrincante)
  }
}

class Efecto{
  const cantidadTurnos

  method curacionDiferida(recuperar){
    Hechicero.conveniencia(hechizo, hechicero) * 2 * recuperar * cantidadTurnos
  }
} */
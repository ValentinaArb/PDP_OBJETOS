//ARTISTAS
class Artista{
  var cantidadGrupies = 0
  method estaPegado() = cantidadGrupies > 20000
}

class Musico inherits Artista{
  var property instrumento = Instrumento
  const property estilos = #{}

  method cambiarInstrumento(nuevoInstrumento){
    instrumento = nuevoInstrumento 
  }

  method calidad() = self.cantidadEstilos() * 5 + instrumento.puntos(self)

  method tieneEstilo(estilo) = estilos.any{estiloSet => estiloSet == estilo}
  method cantidadEstilos() = estilos.size()
}

const taylor = new Musico (instrumento = Voz, estilos = +#{"pop","rock","country"})
const maikel = new Musico (instrumento = Voz, estilos = +#{"pop","soul"})
const riorio = new Musico (instrumento = GuitarraElectrica, estilos = +#{"metal","heavy metal"})
const hellMusic = new Musico (instrumento = Voz, estilos = +#{"metal","death metal"})
const truquillo = new Musico (instrumento = Bajo, estilos = +#{"rock","metal"})
const emiliaViernes = new Musico (instrumento = Voz, estilos = +#{"cumbia uruguaya","pop"})
const rengoEstar = new Musico (instrumento = Bateria, estilos = +#{"rock","pop"})

class Instrumento{
   method puntos(musico)
}

class GuitarraCriolla inherits Instrumento{
  const cantidadCuerdasSanas
  override method puntos(musico) = 10 + cantidadCuerdasSanas
}

class GuitarraElectrica inherits Instrumento{
  const suAmplificador = Amplificador
  override method puntos(musico) = 15 + suAmplificador.potencia()
}

class Amplificador{
  var property potencia
}

/* object marshall inherits Amplificador(potencia = 7){
} */

class Bajo inherits Instrumento{
  const color
  var extra
  override method puntos(musico){
    if(musico.tieneEstilo("metal")){
      if(color == "rojo"){
        extra = 7
      }
      else{
        extra = 2
      }
    }
    return 5 + extra
  }
}

class Bateria inherits Instrumento{
  var extra
  override method puntos(musico){
    if(musico.tieneEstilo("rock")){
      extra = 10
    }
    return 10 + extra
  }
}

object propiedadVoz{
  var property valorCanto = 16
}

object Voz inherits Instrumento{
  override method puntos(musico) = propiedadVoz.valorCanto()
}

//SON UNA BANDA
class Banda inherits Artista{
  var integrantes = #{}

  method cantidadIntegrantes() = integrantes.size()
  
  method soloUnVocalista(){
    if (integrantes.filter{integrante => integrante.instrumento() == Voz}.size() <= 1){
      return true
    }else{
      self.error("Ya hay un vocalista")
    }
  }

  method estilosCompartidos() = integrantes.head().estilos().filter{estilo => self.estiloComparar(estilo)}

  method mismoEstilos(){
    if(self.estilosCompartidos()>=1){
      return true
    }else{
      self.error("No comparten musica")
    }
  }

  method estiloComparar(estilo){
    integrantes.forEach{integrante => integrante.tieneEstilo(estilo)}
  }

  method cumpleCantidadIntegrantes(){
    if(self.cantidadIntegrantes() <= 3){
      return true
    }else{
      self.error("Ya hay un vocalista")
    }
  }

  method sePuedeUnir(nuevoIntegrante) {
    if(self.soloUnVocalista() && self.mismoEstilos() && self.cantidadIntegrantes()){
      integrantes.add(nuevoIntegrante)
    }
    }

  method mejorCalidad() = integrantes.max{integrante => integrante.calidad()}

  method calidad() = 5 * self.estilosCompartidos() + self.mejorCalidad() +2 * self.cantidadIntegrantes()
}

class Recital{
  const duracion
  const artista = Artista
  const publico

  method modificarGrupies(cantidad) = (artista.cantidadGrupies() + cantidad).min(publico)

  method ganaGrupiesEnRecital(){
    if(artista.calidad() == 15){
      self.modificarGrupies(publico * 0.15)
    }
  }

  method pierdeGrupies(){
    if(duracion<60){
      self.modificarGrupies(publico * -0.03)
    }
  }

  method sumarGrupiesArtista(){
    artista.mejorCalidad().modificarGrupies(publico * 0.5)
  }
}
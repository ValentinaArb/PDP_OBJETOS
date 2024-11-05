//Artista

class Artista{
  var grupies = 0

  var property instrumento

  const property estilos = #{}

  method contieneEstilo(estiloComparar){
    estilos.any{estilo => estilo == estiloComparar}
  }

  method calidad() = self.estilos().size() * 5 + instrumento.puntos(self)

  method esVocalista() = self.instrumento() == Voz
  
  method sumarGrupies(cantidad){
    grupies += cantidad
  }
}

const taylor = new Artista (instrumento = Voz, estilos = +#{"pop","rock","country"})
const maikel = new Artista (instrumento = Voz, estilos = +#{"pop","soul"})
const riorio = new Artista (instrumento = GuitarraElectrica, estilos = +#{"metal","heavy metal"})
const hellMusic = new Artista (instrumento = Voz, estilos = +#{"metal","death metal"})
const truquillo = new Artista (instrumento = Bajo, estilos = +#{"rock","metal"})
const emiliaViernes = new Artista (instrumento = Voz, estilos = +#{"cumbia uruguaya","pop"})
const rengoEstar = new Artista (instrumento = Bateria, estilos = +#{"pop","rock"})
 
class Amplificador {
	method potencia()
}

class Instrumento{
  var calidadBase
	
	method puntos(artista) = calidadBase + self.calidadInstrumento(artista)
	
	method calidadInstrumento(artista)
}

class GuitarraCriolla inherits Instrumento(calidadBase = 10){
  const cantidadCuerdas
  override method calidadInstrumento(artista) = cantidadCuerdas
}

class GuitarraElectrica inherits Instrumento(calidadBase = 15){
  override method calidadInstrumento(artista) = Amplificador.potencia()
}

class Bajo inherits Instrumento(calidadBase = 5){
  const color
  var extra = 0
  override method calidadInstrumento(artista){
    if(artista.contieneEstilo("metal")){
      if(color == "rojo"){
        extra =  7
      }
      else{
        extra = 2
      }
    }   
  }
}

class Bateria inherits Instrumento(calidadBase = 10){
  var extra = 0
  override method calidadInstrumento(artista){
    if(artista.contieneEstilo("rock")){
      extra = 10
    }
  }
}

object propiedadVocalista{
  var property cantidad = 16
}

class Voz inherits Instrumento(calidadBase = 10){
  override method calidadInstrumento(artista){}
}

//Son una banda
class Banda{
  const banda = #{}

  method cantidad(especialidad) = banda.filter{integrante => integrante.instrumento() == especialidad}

  method unVocalista() = self.cantidad(Voz) == 1
  
  method cantidadIntegrantes() = banda.size() <= 4

  method estiloEnComun(nuevoIntegrante) =self.estilos().any({estilo => nuevoIntegrante.tieneEstilo(estilo)})

  method estilos() {
		if (banda.isEmpty()) {
			return []
		}
		const estilos = banda.any().estilos()
		return banda.fold(
			estilos, {estilosEnComun, integrante => integrante.estilos().intersection(estilosEnComun)}
		)
	}

  method cumpleCondiciones(integrante) = self.unVocalista() && self.cantidadIntegrantes() && self.estiloEnComun(integrante)

  method agregarIntegrante(integrante){
    if(banda.isEmpty() || self.cumpleCondiciones(integrante)){
      banda.add(integrante)
    }
  }

  method validarVocalista(integrante){
    if(integrante.esVocalista() && !self.unVocalista()){
      self.error("ya tenemos vocalista")
    }
  }

  method validarCantidad(integrante){
    if(!self.cantidadIntegrantes()){
      self.error("ya son cuatro")
    }
  }

  method validarEstiloEnComun(integrante){
    if(!self.estiloEnComun(integrante)){
      self.error("no se comparte estilo en comun")
    }
  }

  method calidadEstilo() = banda.sum{integrante => integrante.calidad()}

  method mejorCalidad() = banda.max {integrante => integrante.calidad()}

  method plus() = banda.size() * 2

  method calidad() = self.calidadEstilo() + self.mejorCalidad() + self.plus()
  
  var grupies = 0
}

class Recital inherits Banda{
  const duracion
  const principal
  const participantes

  method sumarGrupies(artista){
    if(artista.calidad() == 15){
      grupies += (participantes * 0.15)
      grupies.min(participantes)
      banda.mejorCalidad().sumarGrupies(grupies/2)
    }
  }

  method restarGrupies(){
    if(duracion < 60){
      grupies -= (participantes * 0.03)
      grupies.max(0)
    }
  }  
}
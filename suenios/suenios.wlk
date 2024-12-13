class Persona{
  var felicidad
  const sueniosPendientes = []
  const sueniosCumplidos = []
  const carrerasDeseadas = #{}
  const carrerasCumplidas = #{}
  const destinosDeseados = #{}
  const plataDeseada
  var cantidadHijos
  var edad
  var tipo = realista

  method cambiarTipo(nuevoTipo){
    tipo = nuevoTipo
  }

  method esFeliz() = felicidad > self.felicidadPendiente()

  method felicidadPendiente() = sueniosPendientes.sum{suenio => suenio.nivelDeFelicidad()}

  method esAmbiciosa(){
    const todosLosSuenios = sueniosPendientes + sueniosCumplidos
    const felicidoniosMayorA100 = todosLosSuenios.filter{suenio => suenio.nivelDeFelicidad() > 100}
    return felicidoniosMayorA100 > 3
  }

  method cumplirSuenio(suenio){
    if(suenio.condicion(self)){
      suenio.consecuencia(self)
      sueniosPendientes.remove(suenio)  
      sueniosCumplidos.add(suenio)
    }    
  }

  method modificarFelicidad(cantidad){
    felicidad = felicidad + cantidad
  }

  method quiereEstudiar(carrera) = carrerasDeseadas.contains(carrera)
  method yaEstudio(carrera) = carrerasCumplidas.contains(carrera)

  method cumplirCarrera(carrera){
    carrerasDeseadas.remove(carrera)
    carrerasCumplidas.add(carrera)
  }

  method cumplePlataDeseada(cantidad) = cantidad >= plataDeseada 

  method noTieneHijos() = cantidadHijos == 0
  method tenerHijo(){
    cantidadHijos += 1
  }

  method metaMasImportante() = sueniosPendientes.max{suenio => suenio.nivelDeFelicidad()}
  method metaAleatoria() = sueniosPendientes.anyOne()
  method primerMeta() = sueniosPendientes.head()
 }

object realista{
  method suenoCumplir(jugador) = jugador.metaMasImportante()
}
object alocados{
  method suenoCumplir(jugador) = jugador.metaAleatoria()
}
object obsesivo{
  method suenoCumplir(jugador) = jugador.primerMeta()
}

class Suenio{
  const property nivelDeFelicidad

  method condicion(jugador)

  method consecuencia(jugador){
    jugador.modificarFelicidad(nivelDeFelicidad)
  }
}

class Recibirse inherits Suenio{
  const carrera

  override method condicion(jugador){
    if(!jugador.quiereEstudiar(carrera)){
      self.error("No es correcto estudiar una carrera que no queres")
    }else if(jugador.yaEstudio(carrera)){
      self.error("Ya estudiaste esta carrera")
    }else{
      return jugador.quiereEstudiar(carrera) && !jugador.yaEstudio(carrera)
    }
  }

  override method consecuencia(jugador){
    super(jugador)
    jugador.cumplirCarrera(carrera)
  }
}

class ConseguirTrabajo inherits Suenio{
  const sueldo

  override method condicion(jugador){ 
    if(!jugador.cumplePlataDeseada(sueldo)){
      self.error("El sueldo no es suficiente para satisfacerlo")
    }else{
      return jugador.cumplePlataDeseada(sueldo)
    }
  } 
}

class Adoptar inherits Suenio{
  const cantidad

  override method condicion(jugador){
    if(!jugador.noTieneHijos()){
      self.error("Ya tenes un hijo, no podes adoptar otro")
    }else{
      return jugador.noTieneHijos()
    }
  }

  override method consecuencia(jugador){
    super(jugador)
    jugador.tenerHijo(cantidad)
  }
}

class TenerHijo inherits Suenio{
  override method consecuencia(jugador){
    super(jugador)
    jugador.tenerHijo()
  }
}

class Viajar inherits Suenio(){
  const lugar
  override method consecuencia(jugador){
    super(jugador)
    jugador.viajar(lugar)
  }
}

class SuenioMultiple{
  const unirSuenios = []

  method cumplirSuenioMultiple(jugador){
    const cumpleTodos = unirSuenios.all{suenio=> jugador.cumplirSuenio(suenio)}

    if(cumpleTodos){
      unirSuenios.forEach{suenio=> jugador.cumplirSuenio(suenio)}
    }
  }
}
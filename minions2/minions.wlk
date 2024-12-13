class Empleado{
  const cantidadOjos 
  var rol
  var estamina
  var tareasHechas
  
  method estamina() = estamina
  
  method cambiarRol(nuevoRol){
    if(rol == Soldado){
      rol.perderPractica()
    }
    rol = nuevoRol
  }


  method estaminaSuficiente(cantidad) = estamina >= cantidad
  method modificarEstamina(cantidad){
    estamina += cantidad
  }

  method tieneHerramientasNecesarias(herramienta) = rol.tieneHerramientas(herramienta)


  method esRol(rolComparar) = rol == rolComparar

  method fuerza() = self.estamina()/2 + 2 + rol.fuerzaRol()
  
  method calcularDificultad(gradoAmenaza) = gradoAmenaza

  method realizarTarea(tarea){
    if(tarea.requerimiento(self)){
      tarea.consecuencia(self)
      tareasHechas.add(tarea)
    }
    else{
      self.error("No cumple con el requerimiento")
    }
  }

  method comer(fruta){
    self.modificarEstamina(fruta.puntos())   
  }

  method experiencia(){
    const tareasDificultades = tareasHechas.sum{tarea => tarea.dificultad()}
    return tareasHechas.size() * tareasDificultades
  }
}
class Fruta {
  const property puntos
}

const banana = new Fruta (puntos = 10)
const manzana = new Fruta (puntos = 5)
const uva = new Fruta (puntos = 1)

class Biclope inherits Empleado(cantidadOjos = 2){
  
  override method estamina() = estamina.min(10) 
}

class Ciclope inherits Empleado(cantidadOjos = 1){
  method entusiasmado() = true

  override method fuerza() = super() / 2

  override method calcularDificultad(gradoAmenaza) = super(gradoAmenaza) * 2
}

class ElCapataz{
  const subordinado = #{}
  
}

class Soldado{
  var arma
  var danioArma = 1

  method defender(sector){
    danioArma = danioArma + 2
  }

  method perderPractica(){
    danioArma = 0
  }

  method tieneHerramientas(herramienta) = false
  
  method fuerzaRol() = danioArma
}

class Obrero{
  const cinturon = []

  method tieneHerramientas(herramienta) = cinturon.contains(herramienta)

  method fuerzaRol() = 0
}

class Mucama{
  method tieneHerramientas(herramienta) = false

  method fuerzaRol() = 0
}

class Tarea{
  method dificultad(empleado)
  method requerimiento(empleado)
  method consecuencia(empleado)
}

class ArreglarMaquina inherits Tarea {
  const complejidad
  const herramientasRequeridas = []

  override method dificultad(empleado) = complejidad * 2

  override method requerimiento(empleado) = empleado.estaminaSuficiente(complejidad) && self.condicionExtra(empleado)

  method condicionExtra(empleado){
    if(herramientasRequeridas.isEmpty()){
      return true
    }else 
    return herramientasRequeridas.all{herramienta => empleado.tieneHerramientasNecesarias(herramienta)}
  }

  override method consecuencia(empleado){
    empleado.modificarEstamina(-complejidad)
  }
}

class DefenderSector inherits Tarea{
  const gradoAmenaza

  override method dificultad(empleado) = empleado.calcularDificultad(gradoAmenaza)

  override method requerimiento(empleado) = !empleado.esRol(Mucama) && empleado.fuerza() >= gradoAmenaza

  override method consecuencia(empleado){
    if(!empleado.esRol(Soldado)){
      empleado.modificarEstamina(-empleado.estamina()/2)
    }
  }
}

object dificultadLimpieza {
  method valor () = 10
}

class LimpiarSector inherits Tarea{
  const esSectorGrande = true
  var estaminaNecesaria = 0
  
  override method dificultad(empleado) = dificultadLimpieza.valor()
  
  method estaminaNecesaria(empleado){
    if(empleado.esRol(Mucama)){
      estaminaNecesaria = 0
    }
    else if(esSectorGrande){
      estaminaNecesaria = 4 
    }else{
      estaminaNecesaria = 1
    }
  }

  override method requerimiento(empleado) = empleado.estaminaSuficiente(estaminaNecesaria) 

  override method consecuencia(empleado) = empleado.modificarEstamina(-estaminaNecesaria)
}


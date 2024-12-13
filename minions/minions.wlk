class Empleado{
  var estamina
  method estamina() = estamina
  var rol = obrero
  
  method cambiarRol(nuevoRol){
    rol = nuevoRol
    if(rol == Soldado){
      rol.perderPractica()
    }
  }

  method hacerTarea(tarea){
    if(tarea.requerimiento(self)){
      tarea.consecuencia(self)
    }
  }

  method modificarEstamina(cantidad){
    estamina = estamina + cantidad
  }

  method estaminaSuficiente(cantidad) = self.estamina() >= cantidad
  
  method tieneHerramienta(herramienta){
    if(self.esRol(obrero)){
      rol.tieneHerramienta(herramienta)
    }else{
      return false
    }
  }

  method esRol(rolComparar) = rol == rolComparar

  method fuerza(){
    var extra = 0
    var fuerza = estamina/2 + 2 
    if(self.esRol(Soldado)){
      extra = Soldado.danioArma()
    }
    return fuerza
  }

  method cumpleFuerza(amenaza) = self.fuerza() >= amenaza
}

class Tarea{  
  method dificultad()

  method requerimiento(empleado)

  method consecuencia(empleado)
}

class ArreglarMaquina inherits Tarea{
  const complejidad
  const herramientasNecesarias = #{}

  override method requerimiento(empleado){
    const tieneHerramientasNecesarias = herramientasNecesarias.forEach{herramienta => empleado.tieneHerramienta(herramienta)}

    return empleado.estaminaSuficiente(complejidad) && tieneHerramientasNecesarias
  }

  override method consecuencia(empleado) = empleado.modificarEstamina(-complejidad)

  override method dificultad() = 2 * complejidad
}

class DefederSector inherits Tarea{
  const amenaza
  override method requerimiento(empleado) = !empleado.esRol(mucama) && empleado.cumpleFuerza(amenaza)

  override method consecuencia(empleado){
    if(!empleado.esRol(Soldado)){
      empleado.modificarEstamina(empleado.estamina()/2)
    }
  }
}
class Biclopes inherits Empleado{
  const cantidadOjos = 2
  override method estamina() = super().min(10)
}

class Ciclopes inherits Empleado{
  const cantidadOjos = 1
  method entusiasmado() = true 

  override method fuerza() = super()/2
}

class Soldado{
  const arma
  
  var property danioArma = 0
  method ganarPractica() = self.danioArma() + 2  

  method perderPractica(){
    danioArma = 0
  }

  method defender() = self.ganarPractica()
}

object obrero{
  const cinturon = []

  method tieneHerramienta(herramienta) = cinturon.contains(herramienta)
}

object mucama{

}
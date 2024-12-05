import tipoPersona.*
import suenios.*

class Persona{
  var edad
  const carrerasQuiereEstudiar = #{}
  var carrerasYaEstudio = #{}
  const sueldoSoniado
  const quiereViajar = #{}
  const quiereHijos
  var cantidadHijos
  const sueniosCumplidos = #{}
  const sueniosPendientes = #{}
  var tipo = realista

  method actualizarTipo(nuevoTipo){
    tipo = nuevoTipo
  }

  method quiereEstudiar(carrera) = carrerasQuiereEstudiar.any{unaCarrera => unaCarrera == carrera}
  
  method yaEstudio(carrera) = carrerasYaEstudio.any{unaCarrera => unaCarrera == carrera}
  
  method sueldoMenorAlSoniado(sueldo) = sueldoSoniado > sueldo

  method cumplirSuenio(suenio) = sueniosCumplidos.add(suenio) && sueniosPendientes.remove(suenio)

  method recibirse(carrera) = carrerasYaEstudio.add(carrera) && carrerasQuiereEstudiar.remove(carrera)
  
  method tenerHijo(){
    cantidadHijos += 1
  }
  
  method adoptar(cantidad)
  method viajar(lugar)

  method suenoMasImportante() = sueniosPendientes.max{suenio => suenio.nivelFelicidad()}
  method suenoAlAzar() = sueniosPendientes.anyOne()
  method suenoPrimero() = sueniosPendientes.find(true)

  method nivelFelicidadDe(suenios) = suenios.sum{suenio => suenio.nivelFelicidad()}

  method esFeliz() = self.nivelFelicidadDe(sueniosCumplidos) > self.nivelFelicidadDe(sueniosPendientes)

  method esAmbiciosa(){
    const sueniosTotales = sueniosCumplidos + sueniosPendientes
    sueniosTotales.filter{suenio => suenio.nivelFelicidad() > 100}.size() > 3
  }
}


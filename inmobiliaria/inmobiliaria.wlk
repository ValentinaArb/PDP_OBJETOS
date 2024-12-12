
class Operacion {
  const inmueble

  method comision()
  
}
class Alquiler inherits Operacion{
  const cantidadMesesPactados
  override method comision() = (cantidadMesesPactados * inmueble.valor()) / 50000
}

class Venta inherits Operacion{
  override method comision() = inmueble.valor() * porcentajeVentas.valor()
}

object porcentajeVentas{
  method valor() = 0.015
}

class Zona {
	var plusZona
		
	method valor() = plusZona
	method cambiarValor(nuevoValor){
		plusZona = nuevoValor
	}
}

class Inmueble {
  const tamanio
  const cantAmbientes
  var tipoOperacion
  const zona
  var estado //reservada vendida disp

  method valorParticular()

  method valorTotal () = self.valorParticular() + zona.valor()

  method reservadaPara(cliente) 
  
}

class Casa inherits Inmueble {
  const valorCasa
  override method valorParticular() = valorCasa
}
class PH inherits Inmueble {  
  override method valorParticular() = (14000 * tamanio).max(500000)
}

class Departamento inherits Inmueble {
  override method valorParticular() = cantAmbientes * 350000
}

//Personas
class Cliente{

}

class Empleado {
  var property operaciones = #{}
  var property reservas = #{}

  method reservar(cliente,inmueble) {}

  method concretarOperacion(cliente,inmueble)
}
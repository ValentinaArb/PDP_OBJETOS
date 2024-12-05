object gameflix{
  const juegos = #{}
  const usuarios = #{}

  method filtrar(categoria) = juegos.filter{juego => juego.esCategoria(categoria)}

  method buscar(nombre) = juegos.find{juego => juego.esLlamado(nombre)}
  method recomendar() = juegos.anyOne()

  method cobrar() = usuarios.forall{usuario => usuario.pagarSuscripcion()}
}

class Juego{
  const nombre
  const tipo
  var precio
  const categoria
  var horasJugadas

  method esBarato() = precio < 30

  method esLlamado(nombreComparar) = nombre == nombreComparar

  method esCategoria(categoriaComparar) = categoria == categoriaComparar

  method efecto(usuario)
}

class Violento inherits Juego{
  override method efecto(usuario) = usuario.modificarHumor(-10 * horasJugadas)
}

class Moba inherits Juego{
  override method efecto(usuario) = usuario.comprarSkin()
}

class Terror inherits Juego{
  override method efecto(usuario) = usuario.actualizarSuscripcion(infantil)
}

class Estrategico inherits Juego{
  override method efecto(usuario) = usuario.modificarHumor(5 * horasJugadas)
}

class Usuario{
  var plata
  var humor
  var suscripcion = Suscripcion

  method comprarSkin(){
    plata -= 30
  } 

  method modificarHumor(cantidad){
    humor += cantidad
  }
  method actualizarSuscripcion(nuevaSuscripcion){
    suscripcion = nuevaSuscripcion
  }

  method pagarSuscripcion(){
    if(plata >= suscripcion.precio()){
      plata -= suscripcion.precio()
    }
    else{
      self.actualizarSuscripcion(prueba)
    }
  }

  method jugar(juego){
    if(suscripcion.puedeJugar(juego)){
      juego.efecto(self)
    }
    else{
      self.error("No puede jugar este juego")
    }
  }
}

class Suscripcion{
  var property precio
  method puedeJugar(juego) = true
}

object premium inherits Suscripcion(precio = 50){
}
object base inherits Suscripcion(precio = 25){
  override method puedeJugar(juego) = juego.esBarato()
}

object infantil inherits Suscripcion(precio = 10){
  override method puedeJugar(juego) = juego.esCategoria("Infantil")
}

object prueba inherits Suscripcion(precio = 0){
  override method puedeJugar(juego) = juego.esCategoria("Demo")
}
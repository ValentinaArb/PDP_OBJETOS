import arsenal.*
class Guerrero {
    var armas = []    
    var items = []
    var vida = 100
    
    method vida() = vida.max(0).min(100)
    method poder()
    method poderArmas() =  armas.sum { arma => arma.poder() }
    method cantidadItemsTotales() = items.size()
    method cantidadArmas () = armas.size ()
    method cantidadItem(itemBuscado) = items.count {item => item == itemBuscado}
}

class Hobbit inherits Guerrero{
    const calculoPoder = vida + self.poderArmas() + self.cantidadItemsTotales()

    override method poder() = calculoPoder
}

class Enano inherits Guerrero{
    var factorPoder

    override method poder() = vida + factorPoder * self.poderArmas()
}

object parametroElfo {
  var property destreza = 2
}

class Elfo inherits Guerrero {
    var destrezaPropia
    override method poder() = vida + self.poderArmas() * (parametroElfo.destreza() + destrezaPropia)
}

class Humano inherits Guerrero {
    var limitadorPoder

    override method poder() = vida * self.poderArmas() / limitadorPoder
}

class Maiar inherits Guerrero {
    var poderBasico = 15 
    var poderBajoAmenaza = 300

    method calcularPoder(factorActual){
      return vida * factorActual + self.poderArmas() * 2
    }
    
    override method poder() {
        if (vida > 10) {
            return self.calcularPoder(poderBasico)
        } 
        else { //si su vida es menor a 10, está bajo amenaza
            return self.calcularPoder(poderBajoAmenaza)
        }
    } 
}

object tomBombadil inherits Guerrero {
    override method poder() = 10000000
}

object gollum inherits Hobbit {
    override method poder() = calculoPoder / 2
}

/* 
class Hobbit inherits Guerrero{
    const calculoPoder = vida + self.poderArmas() + self.cantidadItemsTotales()

    override method poder() = calculoPoder
}
 */

//instancias de guerreros
const frodo = new Hobbit (vida = 50, armas = [espadaFrodo], items = [])
const gimli = new Enano (vida = 75, factorPoder = 3, armas = [hachaGimli,hachaGimli])
const legolas = new Elfo (vida = 80, destrezaPropia = 1, armas = [arcoLegolas, espadaLegolas])
const aragorn = new Humano (vida = 85, limitadorPoder = 20, armas = [anduril,dagaAragorn])
const gandalf = new Maiar (vida = 100, armas = [baculoGandalf, glamdring])
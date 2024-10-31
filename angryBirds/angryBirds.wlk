

object isla{
    const pajaros = #{}

    method pajarosFuertes(){
        pajaros.filter{pajaro => pajaro.fuerza()>50}
    }

    method fuerza(){
        pajaros.sum{pajaro => pajaro.fuerza()}
    }

    method sesionIra(){
        pajaros.forEach{pajaro => pajaro.tranquilizar()}
    }

    method invasionCerdos(cantidad){
        const cantidadEnojos = cantidad/100

        pajaros.forEach{pajaro => pajaro.enojo()}
    }
}

class PajaroComun{
    var ira = 1
    var velocidad = 80
    method fuerza() = ira * 2
    method enojo() = ira * 2

    method tranquilizar(){
        ira -= 5
    }

}

class PajaroRencoroso inherits PajaroComun{
    var cantidadVecesEnojado = 0
    override method enojo() {
        cantidadVecesEnojado += 1
        return ira * cantidadVecesEnojado
    }
}

object red inherits PajaroRencoroso{
    override method fuerza() = super() * 10
}

object bomb inherits PajaroComun {
    var fuerzaMaxima = 9000
    override method fuerza() = (ira * 2).min(fuerzaMaxima)    
}

object chuck inherits PajaroComun{
    override method fuerza() = 150 + 5 * ((velocidad - 80).max(0)) 
    override method enojo() = velocidad * 2

    override method tranquilizar(){}
}

object propiedadTerence{
  var property multiplicador = 10
}

object terence inherits PajaroRencoroso{
    override method fuerza() = super() * propiedadTerence.multiplicador()
}

class Huevo{
    var property peso
}

object matilda inherits PajaroComun {
    var huevos = []
    method fuerzaHuevos() = huevos.sum{huevo => huevo.peso()}
    override method fuerza() = super() + self.fuerzaHuevos()

    method ponerHuevo(pesoHuevo){        
        const nuevoHuevo = new Huevo(peso = pesoHuevo)
		huevos.add(nuevoHuevo)
    }

    override method enojo(){
        self.ponerHuevo(2)
        return super()
    } 
}
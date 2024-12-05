class Espada {
    const origen
    const multiplicador

    method poder() {
        return origen.valor() * multiplicador.max(1).min(20) //limita entre 1 y 20
    }
}

class Origen {
    const valor
    method valor() = valor 
}

//instancias de origenes
const elfico = new Origen (valor=30)
const enano = new Origen (valor=20)
const humano = new Origen (valor=15)


class Baculo {
    const poder
    method poder() = poder 
}

class Daga inherits Espada {
    override method poder() = super()/2
}

object propiedadesArco {
  var property tension = 40 
}

class Arco {
    const longitud
    
    method poder() {
        return propiedadesArco.tension() * longitud / 10
    }
}

class Hacha {
    const longitudMango
    const pesoHoja
    
    method poder() = longitudMango * pesoHoja
}

//instancias de todas las armas
const glamdring = new Espada (origen=elfico, multiplicador=10)
const baculoGandalf = new Baculo (poder=400)
const espadaFrodo = new Espada(origen=elfico, multiplicador=8)
const hachaGimli = new Hacha (longitudMango=70, pesoHoja=5)
const arcoLegolas = new Arco (longitud= 110)
const espadaLegolas = new Espada (origen=elfico, multiplicador=12)
const anduril = new Espada (origen=elfico, multiplicador = 18)
const dagaAragorn = new Daga (origen=enano, multiplicador=10)
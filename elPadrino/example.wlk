class Familia{
    const miembros = #{}

    method masArmado(){
        /* miembros. */
    }

    method entregarArmas(){
        const revolver = new Revolver (cantidadBalas = 6)
        miembros.forEach{miembro => miembro.agregarArma(revolver)}
    }
}

class Persona{
    var property viva = true
    var property muerta = not viva
    var herida = false

    var cantidadBalas
    method usar(victima){
        if(cantidadBalas > 0){
            victima.matar()
            cantidadBalas-=1
        }
    }
    method matar(){
        viva = false
    }
    method herir(){
        if(herida){
            viva = false
        }else{
            herida = true
        }
    }
}

class Arma{
    method usar(victima)
}

class Revolver inherits Arma{
    var cantidadBalas
    override method usar(victima){
        if(cantidadBalas > 0){
            victima.matar()
            cantidadBalas-=1 
        }
    }
}

class Escopeta inherits Arma{
    var cantidadBalas
    override method usar(victima){
        if(cantidadBalas > 0){
            victima.herir()
            cantidadBalas-=1 
        }
    }
}

class Cuerda inherits Arma{
    const esBuenaCalidad
    override method usar(victima){
        if(esBuenaCalidad){
            victima.matar()
        }
    }
}

class Miembro inherits Persona{
    const familia = Familia
    const armas = []
    const subordinados = #{}

    method cantidadArmas() = armas.size()

    method agregarArma(revolver){
        armas.add(revolver) 
    }
}

class Don inherits Miembro{
    method hacerTrabajo(victima){
        subordinados.anyOne().hacerTrabajo(victima)
    }
}

/* object DonVito inherits Don (familia = "Corleone"){
    override method hacerTrabajo(victima){
        var elegido = subordinados.anyOne()
        2.times(elegido.hacerTrabajo(victima))
    }
} */

class Subjefe inherits Miembro{
    method hacerTrabajo(victima){
        armas.anyOne().usar()
    }
}

class Soldado inherits Miembro{
    method hacerTrabajo(victima){
        armas.head().usar(victima)
    }
}

class HacerNegocio{
    method duermeConPeces(persona) = persona.muerta()

    method esPeligroso(miembro) = miembro.viva()

    method proteger(familia) = familia.entregarArmas()

    method ataqueSorpresa(familiaAtacante,familiaVictima){
        
    }
}
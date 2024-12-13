class Jugador{
    const color
    const mochila = []
    const tareas = []
    var nivelSospecha = 40
    var puedeVotar = true

    method esTripulante()
    
    method esSospechoso() = nivelSospecha > 50

    method usar(item) = mochila.remove(item)

    method buscar(item) = mochila.add(item)

    method realizarTarea(tarea,nave)

    method pedirRealizarTarea(nave){
        const puedeRealizar = tareas.filter{tarea => tarea.requerimiento()}
        self.realizarTarea(puedeRealizar.anyOne(),nave)
    }

    method informarANave(nave) = nave.chequear() 

    method tiene(item) = mochila.contains(item)

    method modificarNivelSospecha(cantidad){
        nivelSospecha = nivelSospecha + cantidad
    }

    method votoEnBlanco(){
        puedeVotar = false
    }

    method completoTareas()
}

class Tripulante inherits Jugador{
    override method esTripulante() = true
    override method completoTareas() = tareas.isEmpty()

    override method realizarTarea(tarea,nave){
        if(tarea.requerimiento()){
            tarea.consecuencia()
            tareas.remove(tarea)
            self.informarANave(nave)
        }
    }
}

class Impostor inherits Jugador{
    override method esTripulante() = false
    override method completoTareas() = true

    override method realizarTarea(tarea,nave){
        //No se realiza ninguna tarea
    }

    method realizarSabotaje(sabotaje,jugador,nave){
        sabotaje.consecuencia(jugador,nave)
    }
}

class Sabotaje{
    method consecuencia(jugador, nave)
}

object reducirOxigeno inherits Sabotaje{
    override method consecuencia(jugador,nave){
        if(!nave.tripulanteTieneTuboDeOxigeno()){
            nave.modificarNivelOxigeno(-10)
            nave.verificarOxigeno()
        }
    }
}

object impugnarVoto inherits Sabotaje{
    override method consecuencia(jugador,nave){
        jugador.votoEnBlanco()
    }
}

class Tarea{
    method requerimiento(jugador) = true
    method consecuencia(jugador, nave)
}

object arreglarTablero inherits Tarea{
    override method requerimiento(jugador) = jugador.tiene("llaveInglesa")
    override method consecuencia(jugador,nave) = jugador.modificarNivelSospecha(10)
}

object sacarBasura inherits Tarea{
    override method requerimiento(jugador) = jugador.tiene("escoba") && jugador.tiene("bolsaDeConsorcio")
    override method consecuencia(jugador,nave) = jugador.modificarNivelSospecha(-4)
}

object ventilarNave inherits Tarea{
    override method consecuencia(jugador,nave) = nave.modificarNivelOxigeno(5)
}

object nave{
    const jugadores = #{}
    const cantidadImpostores = 0
    const cantidadTripulantes = 0
    var nivelOxigeno = 50
    const tripulantes = jugadores.filter{jugador => jugador.esTripulante()}

    method modificarNivelOxigeno(cantidad){
        nivelOxigeno = nivelOxigeno + cantidad
    }
    
    method chequear(){        
        const ganaron = tripulantes.forall{tripulante => tripulante.completoTareas()}
        if(ganaron){
            throw new Exception(message = "Ganaron los tripulantes")
        }
    }

    method tripulanteTieneTuboDeOxigeno(){
        tripulantes.any{tripulante => tripulante.tiene("Tubo de Oxigeno")}
    }

    method verificarOxigeno(){
        if(nivelOxigeno == 0){
            throw new Exception(message = "Ganaron los impostores")
    }
  }
}
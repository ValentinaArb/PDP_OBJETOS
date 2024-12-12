object profe {
    method pares(lista) {
        const listaMezclada = lista.randomized()
        console.println(listaMezclada)
        const resultado = []
        (0..listaMezclada.size().div(2) - 1).forEach{ i =>
            const indice = i * 2
            resultado.add([listaMezclada.get(indice), listaMezclada.get(indice+1)])
        }
        return resultado //lista de los duelos(lista) 
    }
} 

class Jugador{
    var vida 
    var skin
    const items = []
    const property arma
    var personalidad = Personalidad

    method tienePersonalidad(personalidadComparar) = personalidadComparar == personalidad

    method conseguirItem(item){
        items.add(item)
    }

    method sinVida() = vida == 0

    method aumentarVida(cantidad){
        return (vida + cantidad).max(100) // +=
    }

    method decrementarVida(cantidad){
        return (vida - cantidad).min(0) // -=
    }

    method danioArma() = arma.danio()

    method vidaMenorQue(cantidad) = vida < cantidad

    method modificarPersonalidad(nuevaPersonalidad){
        personalidad = nuevaPersonalidad
    }

    method danioAtaque() = personalidad.danioAtaque(self)

    method UsarItem(lista){
      const itemConsumir = lista.anyOne()
            itemConsumir.consumir(self)
            items.remove(itemConsumir)
    }

    method consumirItem(){
        const itemsCuradores = items.filter{item => item.esCurador()}
        const itemsNoCuradores = items.filter{item => not item.esCurador()}
        if(self.vidaMenorQue(50) && itemsCuradores.size()>0){
            self.UsarItem(itemsCuradores)
        }else{
            self.UsarItem(itemsNoCuradores)
        }
    }

    method atacar(victima) = victima.decrementarVida(self.danioAtaque())

}

const alfonso = new Jugador (personalidad = Estandar, arma = escopeta, items = [], vida = 100, skin = "Spider Man")
const brisa = new Jugador (personalidad = Camper, arma = rifle, items = [silenciador,mini,mini,botiquin], vida = 100, skin = "Lara Croft")
const changuito = new Jugador (personalidad = NinioRata, arma = cuchillo, items = [granada,granada,granada], vida = 100, skin = "Maradona")
const deLaCryuff = new Jugador (personalidad = Arriesgado, arma = pistola, items = [balasDeFuego,silenciador,botiquin], vida = 100, skin = "Rubius")


class Arma{
    const danioBase
    method danio() = danioBase
    method aumentarDanio(cantidad){
        danioBase + cantidad
    }
}

const pistola = new Arma (danioBase = 5)
const escopeta = new Arma (danioBase = 20)
const rifle = new Arma (danioBase = 22)

object cuchillo inherits Arma (danioBase = 10){
    override method aumentarDanio(cantidad){}
}

class Item{
    method esCurador() = false
}

class ItemCurador inherits Item{
    const cantidad
    override method esCurador() = true
    method consumir(jugador) = jugador.aumentarVida(cantidad)
}
class ItemPotenciador inherits Item{
    const cantidad
    method consumir(jugador) = jugador.arma().aumentarDanio(cantidad)
}

const botiquin = new ItemCurador(cantidad = 100)
const mini = new ItemCurador(cantidad = 30)
const balasDeFuego = new ItemPotenciador(cantidad = 5)
const silenciador = new ItemPotenciador(cantidad = 3)

object granada inherits Item{
    method consumir(jugador){
        jugador.decrementarVida(30)
    }
}

class Personalidad{
    method danioAtaque(jugador)
}
class Estandar inherits Personalidad{
    override method danioAtaque(jugador) = jugador.danioArma()
}
class Arriesgado inherits Personalidad{
    var extra = 0
    override method danioAtaque(jugador){
        if(jugador.vidaMenorQue(10)){
            extra = 1
        }else if(jugador.vidaMenorQue(50)){
            extra = 0.25
        }
        jugador.danioArma() + extra * jugador.danioArma()
    }
}

class Camper inherits Personalidad{
    override method danioAtaque(jugador) = jugador.danioArma()
}

class NinioRata inherits Personalidad{
    override method danioAtaque(jugador) = jugador.danioArma() - 0.2 * jugador.danioArma()
}

class Partida{
    const mapa = []

    method turno(zona){
        self.enfrentamiento(zona)
    }

    method enfrentamiento(zona){
        const listaEnfrentamientos = profe.pares(zona.jugadores())        
        listaEnfrentamientos.forEach{listaDuelo => self.luchar(listaDuelo.head(),listaDuelo.tail())}
        zona.eliminarJugadores()
    }

    method luchar(atacante1,atacante2){
        atacante1.consumirItem()
        atacante2.consumirItem()
        atacante1.atacar(atacante2)
        atacante2.atacar(atacante1)
    }

    method seEmpiezaACerrar(){
        const primerZona = mapa.head()
        mapa.remove(primerZona)
        const siguenteZona = mapa.head()
        mapa.remove(siguenteZona)
        var avanzarDosZonas
        
        if(mapa.size()>2){
            avanzarDosZonas = mapa.head()    
        }else{
            avanzarDosZonas = mapa.tail()    
        }

        self.enfrentamiento(primerZona)
        const sobrevivientes = primerZona.jugadores()
        const pasan = sobrevivientes.filter{sobreviviente => not sobreviviente.tienePersonalidad(Camper) && not sobreviviente.tienePersonalidad(Arriesgado)}
        siguenteZona.sobreviven(pasan)
        const arriesgados = sobrevivientes.filter{sobreviviente => sobreviviente.tienePersonalidad(Arriesgado)}
        avanzarDosZonas.sobreviven(arriesgados)
        primerZona.cerrarZona()
    }

    method laManoDeDios(zona) = zona.darBotiquin()

    method recienArranca() = mapa.any{zona => not zona.estaCerrada()}

    method todosLosJugadores() = mapa.map { zona => zona.jugadores() }.flatten()

    method hayGanador() = self.todosLosJugadores() == 1
    method seBuggeo() = self.todosLosJugadores() == 0    
}

class Zona{
    var property jugadores = #{}
    
    var property estaCerrada = false

    method cerrarZona(){
        estaCerrada = true
    } 

    method eliminarJugadores(){
        jugadores.forEach{jugador => self.eliminarSiCorresponde(jugador)}
    }
    
    method eliminarSiCorresponde(jugador){
        if(jugador.sinVida()){
            jugadores.remove(jugador)
        }
    }

    method sobreviven(set){
    jugadores = jugadores.union(set)
}

    method darBotiquin(){
        jugadores.forEach{jugador => jugador.conseguirItem(botiquin)}
    }
}
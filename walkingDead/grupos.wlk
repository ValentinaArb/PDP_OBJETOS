import estados.*
import personas.*
import lugar.*

class Grupo{
    const grupo = #{}
    var lider = self.integranteMasCarisma()
    var ubicacionGrupo

    method elMasDebil() = grupo.min{integrante => integrante.poderOfensivo()} //3.b

    method integranteMasCarisma() = grupo.max{integrante => integrante.carisma()}

    method integrantesJodidos() = grupo.filter{integrante => integrante.resistencia() > 40}

    method poderOfensivo() = grupo.sum{integrante => integrante.poderOfensivo()} + lider.carisma()// punto 1.c y repeticion

    method condicionTomar(lugar) = self.poderOfensivo() > lugar.poderCorrosivo() && lugar.puedeTomar() //3.a
    
    method perderIntegranteDebil() = grupo.removeAllSuchThat(self.elMasDebil())

    method atacarCaminantes(lugar){        
        if(!grupo.anyOne().condicionAtaque()){ // esta condición está mal pero no se como es bien :(
            self.perderIntegranteDebil()
            self.integrantesJodidos().forEach{integrante => integrante.cambiarEstado(Infectado)}
        }
    }

    method tomar(lugar){
        if(self.condicionTomar(lugar)){
            ubicacionGrupo = lugar //3.c.i
            self.atacarCaminantes(lugar) //3.c.ii
            lugar.efecto(self) //3.c.iii
        }
    }

    method puedenAtacar() = grupo.filter{integrante => integrante.condicionAtaque()} //punto 1.a
}
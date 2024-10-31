import resumenes.*
import youtube.*

class Espectador{
    var tipo
    const tiempoDisposicion
    const property cancionesFavoritas = #{}
    const property resumenesVistos = #{}
    
    const pendienteVisualizacion = []

    method agregarPendiente(resumen){
        pendienteVisualizacion.add(resumen)
    }    

    method cumpleTiempo(resumen)= resumen.duracion() <= tiempoDisposicion
    
    method cumpleRequisito(resumen) = tipo.cumpleRequisito(resumen,self)

    method leGusta(resumen) = self.cumpleTiempo(resumen) && self.cumpleRequisito(resumen)

    method esAdicto(resumenesTotales) {
        return resumenesVistos.size() / resumenesTotales.size() >= 0.8
    }

   method darLike(resumen) {
        resumen.RecibirLike()
    }
    method darDislike(resumen){
        resumen.RecibirDislike()
    }

    method verResumen (resumen) {
        if (self.leGusta(resumen)) {
            self.darLike(resumen)
        }
        else {
            self.darDislike(resumen)
        }
     }
    
    /* 
        ¿Qué mensajes mandamos para que nos diga si le gustaría un resumen?
        
        const e = new Espectador (tipo=fan, tiempo=10000)
        const r = new Resumen (etc)
        
        e.leGusta(r)
    */

}
 
object nuevoEspectador {
    method cumpleRequisito(resumen,espectador) = true
}

object follower {

    method cumpleRequisito(resumen,espectador) {
        return espectador.cancionesFavoritas().any {cancionFavorita =>resumen.tieneCancion(cancionFavorita) }
    }
}

object fan{
    
    method todasLasCanciones(resumen,espectador){
        return espectador.cancionesFavoritas().all{cancion => resumen.tieneCancion(cancion)}
    }
    method referenciaAOtroResumen(resumen) = resumen.tieneRefencia()

    method cumpleRequisito(resumen,espectador) {
        return self.todasLasCanciones(resumen,espectador) && self.referenciaAOtroResumen(resumen)
    }
}
import expectadores.*

object canalYoutube {
   const suscriptores = #{}
   const resumenes = #{}
   const cancionesFavoritasSuscriptores = #{}
   
   method agregarSuscriptor(suscriptor) { suscriptores.add(suscriptor) }
   
   method agregarResumen(resumen) {
        resumenes.add(resumen)

        if(self.suscriptoresQueLesGusta(resumen).isEmpty()){
            self.error("El resumen es MALISIMO, no se agrego.")
        }else{
            self.suscriptoresQueLesGusta(resumen).forEach{suscriptor => suscriptor.agregarPendiente(resumen)}
        }
    }

    method suscriptoresQueLesGusta(resumen) = suscriptores.filter{suscriptor => suscriptor.leGusta(resumen)}

    method unificarFavoritas(){
        suscriptores.flatMap{suscriptor => suscriptor.cancionesFavoritas()}.asSet() 
    }

    method resumenConMasLikes() = resumenes.max{resumen => resumen.likes()}

    method resumenConMasDislikes() = resumenes.max{resumen => resumen.dislikes()}
}
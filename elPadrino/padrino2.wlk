class Familia {
    var miembros = #{}
    var don
    var traiciones = #{}

    method agregarTraicion(traicion){
        traiciones.add(traicion)
    }

    method eliminarMiembro(miembro){
        miembros.remove(miembro)
    }

    method agregarTraidor (traidor) {
        const nuevo = new Miembro (lealtad = 100)
        miembros.add(nuevo)
    }

    method hayDon() = miembros.any{miembro=> miembro.esRango(Don)}

    method agregarMiembro(miembro){
        if(miembro == Don && self.hayDon()){
            self.error("Ya hay un Don en la familia")
        }else{
            miembros.add(miembro)
        }
    } 

    method elPeligroso(){
        const vivos = miembros.filter{miembro => not miembro.estaMuerto()}
        vivos.max{miembro=> miembro.cantArmas()}
    }

    method repartirArmas () {
        miembros.forEach {miembro => miembro.agregarArma(revolverBasico)}
    }

    method ataqueSorpresa(familia){
        const masPeligroso = familia.elPeligroso()
        miembros.forEach{miembro => miembro.atacar(self, masPeligroso)}
    }

    method reorganizar(){
        self.ascenderSoldados()
        self.elegirNuevoDon()
        self.aumentarLealtadFamilia()
    }

    method ascenderSoldados() {
        const ascender = miembros.filter{miembro => miembro.esRango(Soldado) && miembro.masDeNArmas(5)}
        ascender.forEach{soldado => soldado.ascenderASubjefe()}
    }

    method ascenderDon (miembro){
        don = miembro
    }

    method elegirNuevoDon(){
        don.subordinadoMasLeal().ascenderADonDe(self) //familia
    }

    method aumentarLealtadFamilia() {
        miembros.forEach{miembro => miembro.modificarLealtadPorcentual(0.1)}
    }

    method promedioLealtad() = miembros.average { miembro => miembro.lealtad() }
}

class Miembro{
    const armas = [escopeta]
    var property rango = new Soldado()
    var property lealtad
    
    var property estaMuerto = false

    var property estaHerido = false

    method modificarLealtadPorcentual(porcentaje) { lealtad += lealtad*porcentaje}

    method estaDurmiendoConLosPeces() = estaMuerto

    method atacar(miembro, victima) {rango.hacerTrabajo(self, victima)}
    
    method morir(){
        estaMuerto = true
    }
    method herir(){
        estaHerido = true
    }

    method armaAleatoria() = armas.anyOne()

    method armaAMano() = armas.first()

    method esRango(rangoComprar) = rangoComprar == rango
    
    method cantArmas() = armas.size()

    method agregarArma(arma){armas.add(arma)}

    method sabeDespacharElegantemente(){
       rango.sabeDespacharElegantemente(self)
    }

    method tieneArmaSutil(){armas.any{arma=> arma.esSutil()}}

    method ascenderADonDe(familia) {
        rango = new Don(subordinados = rango.subordinados())
        familia.ascenderADon(self)
    }

    method ascenderASubjefe() {
        rango = new Subjefe ()
    }

    method masDeNArmas(n) = self.cantArmas() > n
}

class Don{
    var repetir = 1
    const subordinados = #{}

    method hacerTrabajo(miembro,victima) {
        repetir.times{subordinados.anyOne().atacar(victima)}
    }

    method sabeDespacharElegantemente(miembro) = true

    method subordinadoMasLeal() = subordinados.max {sub => sub.lealtad()}
}
const donVito = new Don (repetir = 2)

class Subjefe{
    const subordinados = #{}
    
    method hacerTrabajo(miembro,victima){
        miembro.armaAleatoria().usar(victima)
    }    
    method sabeDespacharElegantemente(miembro) = subordinados.any{subordinado => subordinado.tieneArmaSutil()}
}

class Soldado{
    method hacerTrabajo(miembro,victima){
        miembro.armaAMano().usar(victima)
    }
    method sabeDespacharElegantemente(miembro) = miembro.tieneArmaSutil()
}

class Revolver{
    var balas

    method usar(victima){
        if(self.estaCargado()){
            victima.morir()
            balas -= 1
        }
    }

    method estaCargado() = balas > 0

    method esSutil() = balas == 1 
}

const revolverBasico = new Revolver (balas=6)

object escopeta {
    method usar(victima){
        if(victima.estaHerido()){
            victima.morir()
        }
        else{
            victima.herir()
        }
    }
    method esSutil() = false
}

class CuerdaDePiano{
    const buenaCalidad

    method usar(miembro){
        if(buenaCalidad){
            miembro.morir()
        }
    }

    method esSutil() = true
}

class Traicion {
    const traidor
    const victimas = #{}
    const familiaDestino 

    const fechaTentativa
    
    method seAtrasa(dias,victima){
        fechaTentativa.plusDays(dias)
        victimas.add(victima)
    }
    
    method verificarLealtad(familia) = familia.promedioLealtad() > traidor.lealtad() * 2
            
    method traicionar(familia){        
        familia.agregarTraicion(self)
        if(not self.verificarLealtad(familia)){ // los traicionas
            self.resultadoTraicion(familia)
        }
    }    

    method resultadoTraicion(familia){
        victimas.forEach{victima => traidor.atacar(self,victima)}
        familia.eliminarMiembro(traidor)
        familiaDestino.agregarTraidor(traidor)
    }
}
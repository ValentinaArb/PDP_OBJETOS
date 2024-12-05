import zonas.*

class Camino{
    const zonas = #{}

    method puedeAtravesar(guerreros) {
        return zonas.all { zona => zona.puedeAtravesar(guerreros) }
    }
}

const caminoEjemplo = new Camino (zonas = #{bosqueDeFangorn, edoras, belfalas, minasTirith})
class Guerrero{
	var property potencialOfensivo
	var property energia
	var property experiencia
	var property traje
	method atacar(enemigo){
		enemigo.serAtacado(self.potencialOfensivo())
	}
	method serAtacado(valorAtaque){
		energia = (energia- traje.disminuirDanio(valorAtaque*0.1)).max(0)
		traje.aumentarDesgaste()
	}
	method energia(){
		if (traje.entrenamiento()){
			return energia*traje.porcentajeAunmentoEnergia()
		}
		else{
			return energia
		}
	}
}

class Traje{
	var property porcentajeProteccion	
	var property nivelDesgaste = 0
	method entrenamiento()=false
	method aumentarDesgaste(){
		nivelDesgaste += 5
	}
	method gastado(){
		if (nivelDesgaste>=100){
			porcentajeProteccion = 0
			return true
		}
		else return false
		}
	}

class Comun inherits Traje{
	method disminuirDanio(danio){
		return danio - danio*porcentajeProteccion
	}
}

class Entrenamiento inherits Traje{
	const property porcentajeAumentoExperiencia
	override method entrenamiento()= true 
}

class Modularizado inherits Traje{
	const property piezas = []
	method piezasGastadas(){
		return piezas.filter({unaPieza => unaPieza.gastada()}).size()
	}
	method aumentarExperiencia(){
		return 100*piezas.size()-self.piezasGastadas()
	}
	method resistenciaTotal(){
		return piezas.resistencia().sum()
	}
	method disminuirDanio(danio){
		return danio - self.resistenciaTotal()
	}
}

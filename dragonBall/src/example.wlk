class Guerrero{
	var property potencialOfensivo
	var property energia
	var property experiencia
	var property traje
	method atacar(enemigo){
		enemigo.serAtacado(self.potencialOfensivo())
	}
	method serAtacado(valorAtaque){
		energia -= traje.disminuirDanio(valorAtaque*0.1)
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

class TrajeComun inherits Traje{
	method disminuirDanio(danio){
		return danio - danio*porcentajeProteccion
	}
}

class TrajeEntrenamiento inherits Traje{
	const property porcentajeAumentoExperiencia
	override method entrenamiento()= true 
	
}
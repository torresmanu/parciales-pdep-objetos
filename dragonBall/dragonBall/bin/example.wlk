class Guerrero{
	var property potencialOriginal
	var property potencialOfensivo = potencialOriginal
	var property energiaOriginal
	var property energia = energiaOriginal
	var property experiencia
	var property traje
	method elementosTraje(){
		return traje.elementos()
	}
	method atacar(enemigo){
		enemigo.serAtacado(self.potencialOfensivo())
	}
	method serAtacado(valorAtaque){
		energia = (energia- traje.disminuirDanio(valorAtaque*0.1)).max(0)
		traje.aumentarDesgaste()
	}
	method energia(){
		return energia*traje.efecto()
	}
	method experiencia(){
		return experiencia += traje.aumentarExperiencia()
	}
	method comerSemilla(){
		energia = energiaOriginal
	}
}

class Traje{
	var property porcentajeProteccion	
	var property nivelDesgaste = 0
	method efecto()=1
	method aumentarExperiencia()=0
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
		method elementos()=1
	}

class Comun inherits Traje{
	method disminuirDanio(danio){
		if(!self.gastado()){
			self.aumentarDesgaste()	
			return danio*porcentajeProteccion
			}
			else return danio
	}
}

class Entrenamiento inherits Traje{
	const property porcentajeAumentoExperiencia
	override method efecto(){
		return porcentajeAumentoExperiencia
	} 
}

class Modularizado inherits Traje{
	const property piezas = []
	override method elementos(){
		return piezas.size()
	}
	method piezasGastadas(){
		return piezas.filter({unaPieza => unaPieza.gastada()}).size()
	}
	override method aumentarExperiencia(){
		return (self.elementos()-self.piezasGastadas())/self.elementos()
	}
	method resistenciaTotal(){
		return piezas.resistencia().sum()
	}
	method disminuirDanio(danio){
		return danio - self.resistenciaTotal()
	}
}

class Pieza{
	var property resistencia
	var property desgaste
	
	method gastada(){
		return desgaste>=20
	}
	
	method aumentarDesgastes(){
		desgaste-=1
	}
}


class Saiyan inherits Guerrero{
	var property nivel = 0
	var property resistencia
	method convertirse(){
		nivel++
		potencialOfensivo = potencialOfensivo*1.5
		if(nivel==1){
			resistencia = resistencia*1.05
		}
		if(nivel==2){
			resistencia = resistencia*1.07 
		}
		else resistencia = resistencia*1.15
	}
	override method comerSemilla(){
		super()
		potencialOfensivo += potencialOriginal*0.05 
	}

}

class Dbz{
	var property guerreros = #{}
	method guerrerosSegun(condicion){
		return guerreros.sortedBy(condicion).take(16)
	}
	method powerlsBest(){
		return self.guerrerosSegun({guerrero=>guerrero.potencialOfensivo()})
	}
	method funny(){
		return self.guerrerosSegun({guerrero=>guerrero.elementos()})
	}
	method surprise(){
		return self.guerrerosSegun({guerrero=>guerrero.random()})
	}
}
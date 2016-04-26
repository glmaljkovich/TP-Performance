package unq.tpi.persistencia.performanceEj.servicios

import unq.tpi.persistencia.performanceEj.daos.DepartmentDAO

class ListadoDeptos extends AbstractListado {

	new(String fileName) {
		super(fileName)
	}

	override doListado() throws Exception {
		this.addColumn("Codigo").addColumn("Nombre").addColumn("Manager").newLine()
		
		val deptos = new DepartmentDAO().getAllForListing()
		deptos.forEach[
			addColumn(it.code)
			addColumn(it.name)
			addColumn(it.manager.fullName)
			newLine()
		]
	}

}

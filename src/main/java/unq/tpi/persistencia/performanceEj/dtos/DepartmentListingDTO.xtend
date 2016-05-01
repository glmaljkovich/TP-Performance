package unq.tpi.persistencia.performanceEj.dtos

import unq.tpi.persistencia.performanceEj.model.Employee
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DepartmentListingDTO {
	String name
	String code
	Employee manager
}
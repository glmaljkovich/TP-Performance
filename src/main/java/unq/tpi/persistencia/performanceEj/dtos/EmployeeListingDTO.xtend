package unq.tpi.persistencia.performanceEj.dtos

import unq.tpi.persistencia.performanceEj.model.Salary
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EmployeeListingDTO {
	String firstName
	String lastName
	Double salary
	
	def String getFullName() {
		lastName + ", " + firstName
	}
}
package unq.tpi.persistencia.performanceEj.dtos

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
package unq.tpi.persistencia.performanceEj.dtos

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EmployeesPaymentDTO {
	Integer id
	String firstName
	String lastName
	Double salary
	String title
	
	def String getFullName() {
		lastName + ", " + firstName
	}
	
}
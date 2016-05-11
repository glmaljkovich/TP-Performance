package unq.tpi.persistencia.performanceEj.dtos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import unq.tpi.persistencia.performanceEj.dtos.EmployeesPaymentDTO

@Accessors
class DepartmentWithEmployeesDTO {
Double totalSalaries
List<EmployeesPaymentDTO> employees

}
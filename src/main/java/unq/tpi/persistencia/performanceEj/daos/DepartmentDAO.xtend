package unq.tpi.persistencia.performanceEj.daos

import java.util.List
import unq.tpi.persistencia.performanceEj.model.Department
import unq.tpi.persistencia.util.SessionManager
import org.hibernate.transform.Transformers
import unq.tpi.persistencia.performanceEj.dtos.DepartmentListingDTO
import unq.tpi.persistencia.performanceEj.dtos.DepartmentWithEmployeesDTO

class DepartmentDAO {

	def getByName(String name) {
		val session = SessionManager.getSession()
		session.createQuery("from Department where name = :name")
				.setParameter("name", name).uniqueResult() as Department
	}

	def getByCode(String num) {
		val session = SessionManager.getSession()
		session.get(Department, num) as Department
	}
	
	def getByCodeForListing(String num) {
		var dept = new DepartmentWithEmployeesDTO()
		val session = SessionManager.getSession()
		val query   = session.createQuery("select emp.firstName as firstName, emp.lastName as lastName, salary.amount as salary, title as title
											FROM Department as dept
											JOIN dept.employees as emp
											JOIN emp.salaries as salary
											JOIN emp.titles as title
											WHERE dept.code = :num AND salary.to = '9999-01-01'
											GROUP BY emp").setParameter("num", num)
		query.setResultTransformer(Transformers.aliasToBean(typeof(EmployeesPaymentDTO)))
		dept.employees = query.list() as List<EmployeesPaymentDTO>
		val totSalaries = session.createQuery("select sum(salary.amount)
											FROM Department as dept
											JOIN dept.employees as emp
											JOIN emp.salaries as salary
											WHERE dept.code = :num AND salary.to = '9999-01-01'").setParameter("num", num)
											.uniqueResult()
		dept.totalSalaries = totSalaries as Double
		dept
	}

	def getAll() {
		val session = SessionManager.getSession()
		session.createCriteria(Department).list() as List<Department>
	}
	
	def getAllForListing() {
		val session = SessionManager.getSession()
		val query = session.createQuery("select depart.name as name, depart.code as code, manager as manager
							from Department as depart
							join depart.managers as manager
							where manager.id in (select max(manager.id) from depart.managers as manager)")
		query.setResultTransformer(Transformers.aliasToBean(typeof(DepartmentListingDTO)))
		query.list() as List<DepartmentListingDTO>
		//l as List<DepartmentListingDTO>
	}

}

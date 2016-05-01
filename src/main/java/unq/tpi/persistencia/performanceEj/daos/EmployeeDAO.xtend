package unq.tpi.persistencia.performanceEj.daos

import java.util.List
import unq.tpi.persistencia.performanceEj.model.Employee
import unq.tpi.persistencia.util.SessionManager
import org.hibernate.transform.Transformers
import unq.tpi.persistencia.performanceEj.dtos.EmployeeListingDTO

class EmployeeDAO {

	def getByName(String name, String lastName) {
		val session = SessionManager.getSession()
		session.createQuery("from Employee where firstName = :name and lastName = :lastName")
				.setParameter("name", name)
				.setParameter("lastName", lastName)
				.uniqueResult() as Employee
	}

	def getAll() {
		val session = SessionManager.getSession()
		session.createCriteria(Employee).list() as List<Employee>
	}

	def getByCode(int id) {
		val session = SessionManager.getSession()
		session.load(Employee, id) as Employee
	}

	def getAllForListing(){
		val session = SessionManager.getSession()
		val query = session.createQuery("select employee.firstName as firstName, employee.lastName as lastName, salary as salary 
											from Employee as employee
											inner join employee.salaries as salary
											where salary.to='9999-01-01' 
											order by salary.amount DESC")
		query.setResultTransformer(Transformers.aliasToBean(typeof(EmployeeListingDTO)))
		query.list() as List<EmployeeListingDTO>
	}
}

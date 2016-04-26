package unq.tpi.persistencia.performanceEj.daos

import java.util.List
import unq.tpi.persistencia.performanceEj.model.Department
import unq.tpi.persistencia.util.SessionManager
import org.hibernate.transform.ResultTransformer
import org.hibernate.transform.Transformers

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

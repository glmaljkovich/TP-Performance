package unq.tpi.persistencia.performanceEj.servicios

import java.io.FileWriter
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date
import unq.tpi.persistencia.util.SessionManager

/**
 * Clase base para la generacion de reportes.
 * 
 * Las clases concretas extenderan AbstractListado y proveeran una 
 * implementacion al metodo "doListado".
 */
abstract class AbstractListado {
 	
 	static final String COLUMN_SEPARATOR = "\t"
 	static final String LINE_SEPARATOR = "\n"
 	
 	String filename
 	FileWriter fw

	new(String filename) {
		this.filename = filename
	}
	
	/**
	 * Los clientes invocaran este metodo para generar un listado nuevo. 
	 * Este metodo no es thread-safe.
	 */
	def void generarListado() {
		SessionManager.runInSession([
			try {
				this.openFileWriter();
				this.doListado()
			} catch (Exception e) {
				throw new RuntimeException(e)
			} finally {
				this.closeFileWriter();
			}
			return null;
		])
	}
	
	/**
	 * Este metodo sera invocado por generarListado (tempateMethod) en el
	 * contexto de una session de hibernate. 
	 * 
	 * Las implementaciones de este metodo deberan interactuar con los metodos
	 * addColumn y newLine para generar el reporte de forma correcta.
	 */
	protected abstract def void doListado() throws Exception

	private def openFileWriter() {
		this.fw = new FileWriter(this.filename)
	}
	
	private def closeFileWriter() {
		if (this.fw != null) {
			try {
				this.fw.close()
			} catch (IOException e) {
				throw new RuntimeException("Problemas al cerrar el archivo", e);
			}
		}
	}

	protected def addColumn(String col) throws Exception {
		fw.append('"').append(col).append('"').append(COLUMN_SEPARATOR)
		this
	}

	def addColumn(Number col) throws Exception {
		fw.append(String.valueOf(col)).append(COLUMN_SEPARATOR)
		this
	}
	
	def addColumn(Date date) {
		try {
			this.addColumn(new SimpleDateFormat("dd-MM-yyyy").format(date))
		} catch (Exception e) {
			throw new RuntimeException(e)
		}
	}
	
	def newLine() throws Exception{
		fw.append(LINE_SEPARATOR)
		this
	}
	
	

}
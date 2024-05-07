package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class DBConnectionPool {
	static Connection con;
private static List<Connection> freeDbConnections;
	static {
		freeDbConnections = new LinkedList<Connection>();
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		System.out.println("DB driver not found!"+ e);
		}
	}

private static Connection createDBConnection() throws SQLException
	{
		Connection newConnection = null;
		String ip = "localhost";
		String port = "3306";
		String db = "clinica_ostetrica";
		String username = "root";
		String password = "pvc30?Fp!Cvw";
		newConnection = DriverManager.getConnection(
		"jdbc:mysql://"+ ip+":"+ port+"/"+db,
		username, password);
		newConnection.setAutoCommit(false);
		return newConnection;
	}

public static synchronized Connection getConnection() throws SQLException
	{
		Connection connection;	
			if (! freeDbConnections.isEmpty()) {
				connection = (Connection) freeDbConnections.get(0);
				DBConnectionPool.freeDbConnections.remove(0);
				try {
					if (connection.isClosed())
						connection =
							DBConnectionPool.getConnection();
					} catch (SQLException e) {
						if(connection != null)
							connection.close();
						connection = DBConnectionPool.getConnection();
					}
			} else connection = DBConnectionPool.createDBConnection();
			return connection;
	}
public static synchronized void releaseConnection(Connection connection) {
	DBConnectionPool.freeDbConnections.add(connection);
	}

public static void doInsert(String sqlins){
    
	  System.out.print("\n[Performing INSERT] ... ");
  
	  try{
    
		  Statement st = con.createStatement();
		 
		  st.executeUpdate(sqlins);
  }
  catch (SQLException ex){
    System.err.println(ex.getMessage());
  }
}

private static void doUpdate(String sqlUPD){
    
	  System.out.print("\n[Performing UPDATE] ... ");
  
	  try{
   
		  Statement st = con.createStatement();
		  st.executeUpdate(sqlUPD);
  }
  
	  catch (SQLException ex){
    System.err.println(ex.getMessage());
  }
}
private static void doDelete(String sqlDelete ){
    
	  System.out.print("\n[Performing DELETE] ... ");
  
	  try{
    
		  Statement st = con.createStatement();
		  st.executeUpdate(sqlDelete);
  }
  
	  catch (SQLException ex){
    System.err.println(ex.getMessage());
  }
}
public static ResultSet doSelect(String sqlSel){
	   
	  System.out.println("[OUTPUT FROM SELECT]");
	  ResultSet rs = null;
	  try{
    
		  Statement st = con.createStatement();
		  rs = st.executeQuery(sqlSel);
		 
  }
	  catch (SQLException ex){
	     
			  System.err.println(ex.getMessage());
	    }
	  return rs;
}
public static void menu() throws SQLException {
	int i=0;
	  String sqlQuery=null;
	  ResultSet myrs=null;
	  Scanner in = new Scanner(System.in);
	  while (i != -1) {
		  System.out.println("Operazione:");
		  System.out.println("1,Inserire un nuovo personale di tipo infermieristico");
		  System.out.println("2, Stampare numero del personale di un reparto");
		  System.out.println("3, Stampare elenco delle donne");
		  System.out.println("4, Inserire una nuova donna");
		  System.out.println("5, Inserire un nuovo letto all’interno di una camera(UPDATE)");
		  System.out.println("6, Stampare le informazioni del reparto compreso il numero del personale");
		  System.out.println("7, Assegnare un medico a una donna");
		  System.out.println("8,Cancellazione reparto");
		  System.out.println("-1, Per uscire");
		  
		  System.out.println("Inserisci la scelta: ");
		  int scelta=in.nextInt();
	  
		  try {
			  i = scelta;;
		 }
		  catch(NumberFormatException e) {
			  i = -1;
		  }
	  
	  switch(scelta) {
	  
	  case 1: 
		  System.out.println("Inserire un nuovo personale di tipo infermieristico: ");
		  	 String nome=in.next();
			 String matricola=in.next();
			 String personale=in.next();
			 int codID=in.nextInt();
			 String descrizione=in.next();
			 
			 sqlQuery= "INSERT INTO PERSONALE VALUES('"+matricola+"','"+nome+"','"+personale+"',"+codID+",'"+descrizione+"')";
			 System.out.printf("%s, %s, %s, %d, %s", matricola,nome,personale,codID,descrizione);
			 doInsert(sqlQuery);
		  break;
	   case 2:
		  System.out.printf("Stampare numero del personale di un reparto: ");
		  codID=in.nextInt();
		  sqlQuery="select * FROM reparto WHERE codID=" + codID ;
		  myrs=doSelect(sqlQuery);
		  while (myrs.next()){
		        String p= myrs.getString("numeroPersonale");
		        System.out.println("Numero personale: " + p);
		      }
		  break;
	  case 3:
		  System.out.println("Stampare elenco delle donne: ");
		   sqlQuery="select * FROM donna" ;
			  myrs=doSelect(sqlQuery);
			  while (myrs.next()){
			        String co= myrs.getString("codiceM");
			        String c= myrs.getString("cognome");
			        String n= myrs.getString("nome");
			        String dr= myrs.getString("data_ricovero");
			        String dd= myrs.getString("data_dimissione");
			        String nu= myrs.getString("numero");
			        String cn= myrs.getString("codiceN");
			        String e= myrs.getString("eta");
			        String m= myrs.getString("malattie");
			        System.out.println(co + " " + c +" " + n + " " + dr + " " + dd + " " + nu + " " + cn + " " + e + " " + m);
			      }
		  
		  break;
	  case 4:
		  System.out.println("Inserire una nuova donna: ");
		  int codiceM=in.nextInt();
		  String cognome= in.next();
		  nome=in.next();
		 String data_ricovero=in.next();
		 String data_dimissione=in.next();
		 int numero=in.nextInt();
		 int codiceN=in.nextInt();
		 int eta=in.nextInt();
		 String malattie=in.next();
		  	sqlQuery= "INSERT INTO DONNA VALUES("+codiceM+",'"+cognome+"','"+nome+"','"+data_ricovero+"','"+data_dimissione+"'"
		  			+ " , "+numero+ ","+codiceN+", "+eta+",'"+malattie+"')";
			 System.out.printf("%d, %s, %s, %s, %s, %d, %d, %d, %s", codiceM,cognome,nome,data_ricovero,data_dimissione,numero,
					 codiceN,eta,malattie);
			 doInsert(sqlQuery);
		  break;
	  case 5: 
		  System.out.println("Inserire un nuovo letto all’interno di una camera: ");
		  numero=in.nextInt();
		  int piano=in.nextInt();
		  int posti=in.nextInt();
		  sqlQuery= "UPDATE camera SET numero = "+numero+",piano = "+piano +",postiLetto = "+posti;
		   sqlQuery= sqlQuery +" WHERE numero = "+numero;
		   doUpdate(sqlQuery);
		  break;
	  case 6:
		  System.out.println("Stampare le informazioni del reparto compreso il numero del personale: ");
		  codID=in.nextInt();
		  sqlQuery="select * FROM reparto WHERE codID=" + codID ;
		  myrs=doSelect(sqlQuery);
		  while (myrs.next()){
		        String c= myrs.getString("codID");
		        String n= myrs.getString("nome");
		        String p= myrs.getString("numeroPersonale");
		        System.out.println(c + " " + n +" " + p);
		      }
		  break;
	  case 7:
		  System.out.printf("Assegnare un medico a una donna: ");
		 
			 matricola=in.next();
			 codiceM=in.nextInt();
			 sqlQuery= "INSERT INTO ASSISTE VALUES('"+matricola+"',"+codiceM +")";
			 System.out.printf("%s, %d", matricola,codiceM);
			 doInsert(sqlQuery);
		  break;
	  case 8:
		  System.out.println("Cancellazione reparto: ");
		  codID=in.nextInt();
		  sqlQuery="DELETE FROM reparto WHERE codID ="+codID ;
		  doDelete(sqlQuery);
		  break;
	   case -1:
		  System.out.println("Uscita"); 
		  break; 
		 default:
			 System.out.println("Scelta non presente");
			  
	  }
	 }
	
}

public static void main(String args[]) throws Exception {
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String url = "jdbc:mysql://localhost:3306/clinica_ostetrica";
		con = DriverManager.getConnection(url,"root", "pvc30?Fp!Cvw");
		//System.out.println("Connessione OK \n");
		DBConnectionPool.menu();
		
		con.close();
	}
	catch(Exception e) {
		System.out.println("Connessione Fallita \n");
		System.out.println(e);
		}
	}

}


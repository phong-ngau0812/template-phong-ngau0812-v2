// <fileinfo name="DbObj\GenCode2.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			You can update this source code manually. If the file
//			already exists it will not be rewritten by the generator.
//		</remarks>
//		<generator rewritefile="False" infourl="http://www.SharpPower.com">RapTier</generator>
// </fileinfo>


#define SQL_CLIENT

using System;
using System.Data;



namespace MyCompany.MyProject.Db.DbObj
{
	/// <summary>
	/// Represents a connection to the <c>GenCode2</c> database.
	/// </summary>
	/// <remarks>
	/// If the <c>GenCode2</c> goes out of scope, the connection to the 
	/// database is not closed automatically. Therefore, you must explicitly close the 
	/// connection by calling the <c>Close</c> or <c>Dispose</c> method.
	/// </remarks>
	/// <example>
	/// using(GenCode2 db = new GenCode2())
	/// {
	///		UserRow[] rows = db.UserTable.GetAll();
	/// }
	/// </example>
	public class GenCode2 : GenCode2_Base
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="GenCode2"/> class.
		/// </summary>
		public GenCode2()
		{
			// EMPTY
		}

		/// <summary>
		/// Creates a new connection to the database.
		/// </summary>
		/// <returns>An <see cref="System.Data.IDbConnection"/> object.</returns>
		protected override IDbConnection CreateConnection()
		{
#if ODBC
			return new System.Data.Odbc.OdbcConnection("INSERT ODBC CONNECTION STRING");
#elif SQL_CLIENT
			string dbConnection = System.Configuration.ConfigurationSettings.AppSettings["Main.ConnectionString"].ToString();
			if (( dbConnection != null) && (dbConnection.Length > 0))
				dbConnection = dbConnection;  // NOP, just to make the if work. Can't switch to == null or .Length bombs when null
			else 
				dbConnection = "Integrated Security=SSPI;Initial Catalog=GenCode2;Data Source=PHO" +
				"NG-TRUONG";
			return new System.Data.SqlClient.SqlConnection(dbConnection);
#else
			return new System.Data.OleDb.OleDbConnection(
				"Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Inf" +
				"o=False;Initial Catalog=GenCode2;Data Source=PHONG-TRUONG");
#endif
		}
		

		/// <summary>
		/// Creates a DataTable object for the specified command.
		/// </summary>
		/// <param name="command">The <see cref="System.Data.IDbCommand"/> object.</param>
		/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
		protected internal DataTable CreateDataTable(IDbCommand command)
		{
			DataTable dataTable = new DataTable();
#if ODBC
			new System.Data.Odbc.OdbcDataAdapter((System.Data.Odbc.OdbcCommand)command).Fill(dataTable);
#elif SQL_CLIENT
			new System.Data.SqlClient.SqlDataAdapter((System.Data.SqlClient.SqlCommand)command).Fill(dataTable);
#else
			new System.Data.OleDb.OleDbDataAdapter((System.Data.OleDb.OleDbCommand)command).Fill(dataTable);
#endif		
			return dataTable;
		}

		/// <summary>
		/// Returns a SQL statement parameter name that is specific for the data provider.
		/// For example it returns ? for OleDb provider, or @paramName for MS SQL provider.
		/// </summary>
		/// <param name="paramName">The data provider neutral SQL parameter name.</param>
		/// <returns>The SQL statement parameter name.</returns>
		protected internal override string CreateSqlParameterName(string paramName)
		{
#if ODBC
			return "?";
#elif SQL_CLIENT
			return "@" + paramName;
#else
			return "?";
#endif
		}

		/// <summary>
		/// Creates a .Net data provider specific parameter name that is used to
		/// create a parameter object and add it to the parameter collection of
		/// <see cref="System.Data.IDbCommand"/>.
		/// </summary>
		/// <param name="baseParamName">The base name of the parameter.</param>
		/// <returns>The full data provider specific parameter name.</returns>
		protected override string CreateCollectionParameterName(string baseParamName)
		{
#if ODBC
			return "@" + baseParamName;
#else
			return "@" + baseParamName;
#endif
		}
	} // End of GenCode2 class
} // End of namespace


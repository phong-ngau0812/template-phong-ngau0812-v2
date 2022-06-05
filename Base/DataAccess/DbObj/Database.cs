
// <fileinfo name="DbObj\Database.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			You can update this source code manually. If the file
//			already exists it will not be rewritten by the generator.
//		</remarks>
//		<generator rewritefile="False" >Smc SaleFrame1.0</generator>
// </fileinfo>



#define SQL_CLIENT

using System;
using System.Data;
using Base;



/// <summary>
/// Represents a connection to the <c>GenCode2</c> database.
/// </summary>
/// <remarks>
/// If the <c>Database</c> goes out of scope, the connection to the 
/// database is not closed automatically. Therefore, you must explicitly close the 
/// connection by calling the <c>Close</c> or <c>Dispose</c> method.
/// </remarks>
/// <example>
/// using(Database db = new Database())
/// {
///		UserRow[] rows = db.UserTable.GetAll();
/// }
/// </example>
public class Database
		: Base.DatabaseBase
{
	/// <summary>
	/// Initializes a new instance of the <see cref="Database"/> class.
	/// </summary>
	public Database() : base()
	{
		// EMPTY
	}

    	/// <summary>
    	/// Creates a new connection to the database.
    	/// </summary>
    	/// <returns>An <see cref="System.Data.IDbConnection"/> object.</returns>
    	public override IDbConnection CreateConnection()
	{
        	return new System.Data.SqlClient.SqlConnection(SystemConfig.GetConnectionString());
	}


    	/// <summary>
    	/// Returns a SQL statement parameter name that is specific for the data provider.
    	/// For example it returns ? for OleDb provider, or @paramName for MS SQL provider.
    	/// </summary>
    	/// <param name="paramName">The data provider neutral SQL parameter name.</param>
    	/// <returns>The SQL statement parameter name.</returns>
    	public override string CreateSqlParameterName(string paramName)
	{
        	//#If ODBC Then
        	//		Return "?"
        	//#ElseIf SQL_CLIENT Then
        	return "@" + paramName;
        	//#Else
        	//		Return "?"
        	//#End If
    	}

    	/// <summary>
	/// Creates a .Net data provider specific parameter name that is used to
    	/// create a parameter object and add it to the parameter collection of
    	/// <see cref="System.Data.IDbCommand"/>.
    	/// </summary>
    	/// <param name="baseParamName">The base name of the parameter.</param>
    	/// <returns>The full data provider specific parameter name.</returns>
    	public override string CreateCollectionParameterName(string baseParamName)
	{
        	//#If ODBC Then
        	//		Return "@" + baseParamName
        	//#Else
        	return "@" + baseParamName;
        	//#End If
	}


    	public override IDbDataAdapter CreateDataAdapter()
	{
        	return new System.Data.SqlClient.SqlDataAdapter();
    	}

}




// <fileinfo name="Base\DatabaseBase.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			Do not change this source code manually. Changes to this file may 
//			cause incorrect behavior and will be lost if the code is regenerated.
//		</remarks>
//		<generator rewritefile="True" >SaleFrame1.0</generator>
// </fileinfo>


using System;
using System.Data;
using System.Collections;

namespace Base
{

/// <summary>
/// The base class for the <see cref="GenCode2"/> class that 
/// represents a connection to the <c>GenCode2</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the GenCode2 class
/// if you need to add or change some functionality.
/// </remarks>
public abstract class DatabaseBase
		: IDisposable
{		
		
		
        protected IDbConnection _connection;
        protected IDbTransaction _transaction;

        /// <summary>
        /// Initializes a new instance of the <see cref="SALEMAN_Base"/> 
        /// class and opens the database connection.
        /// </summary>
        protected DatabaseBase():this(true)
	{
            
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="SALEMAN_Base"/> class.
        /// </summary>
        /// <param name="init">Specifies whether the constructor calls the
        /// <see cref="InitConnection"/> method to initialize the database connection.</param>
        protected DatabaseBase(bool init):base()
	{
            
            if(init)
                InitConnection();
        }

        /// <summary>
        /// Initializes the database connection.
        /// </summary>
        protected void InitConnection()
	{
            	string LOCATION = "InitConnection()";
            	try
		{
                	_connection = CreateConnection();
	                _connection.Open();
		}
        	catch(Exception ex)
		{
                	throw new Exceptions.DatabaseException(LOCATION, ex);
            	}
        }

        /// <summary>
        /// Creates a new connection to the database.
        /// </summary>
        /// <returns>A reference to the <see cref="System.Data.IDbConnection"/> object.</returns>
        public abstract IDbConnection CreateConnection();

        /// <summary>
        /// Returns a SQL statement parameter name that is specific for the data provider.
        /// For example it returns ? for OleDb provider, or @paramName for MS SQL provider.
        /// </summary>
        /// <param name="paramName">The data provider neutral SQL parameter name.</param>
        /// <returns>The SQL statement parameter name.</returns>

        public abstract string CreateSqlParameterName(string paramName);

        /// <summary>
        /// Creates <see cref="System.Data.IDataReader"/> for the specified DB command.
        /// </summary>
        /// <param name="command">The <see cref="System.Data.IDbCommand"/> object.</param>
        /// <returns>A reference to the <see cref="System.Data.IDataReader"/> object.</returns>
        public virtual IDataReader ExecuteReader(IDbCommand command)
	{
	        return command.ExecuteReader();
        }

        /// <summary>
        /// Adds a new parameter to the specified command. It is not recommended that 
        /// you use this method directly from your custom code. Instead use the 
        /// <c>AddParameter</c> method of the &lt;TableCodeName&gt;Collection_Base classes.
        /// </summary>
        /// <param name="cmd">The <see cref="System.Data.IDbCommand"/> object to add the parameter to.</param>
        /// <param name="paramName">The name of the parameter.</param>
        /// <param name="dbType">One of the <see cref="System.Data.DbType"/> values. </param>
        /// <param name="value">The value of the parameter.</param>
        /// <returns>A reference to the added parameter.</returns>
        public IDbDataParameter AddParameter(IDbCommand cmd, string paramName, DbType dbType, object value)
	{
            	IDbDataParameter parameter = cmd.CreateParameter();
            	parameter.ParameterName = CreateCollectionParameterName(paramName);
            	parameter.DbType = dbType;
            	if(value == null)
		{
                	parameter.Value = DBNull.Value;
		}
            	else
		{
                	parameter.Value = value;
            	}
            	cmd.Parameters.Add(parameter);
            	return parameter;
        }

        /// <summary>
        /// Creates a .Net data provider specific name that is used by the 
        /// <see cref="AddParameter"/> method.
        /// </summary>
        /// <param name="baseParamName">The base name of the parameter.</param>
        /// <returns>The full data provider specific parameter name.</returns>
        public abstract string CreateCollectionParameterName(string baseParamName);


        public abstract IDbDataAdapter CreateDataAdapter();

        /// <summary>
        /// Gets <see cref="System.Data.IDbConnection"/> associated with this object.
        /// </summary>
        /// <value>A reference to the <see cref="System.Data.IDbConnection"/> object.</value>
        public IDbConnection Connection 
	{
		get { return _connection; }
	}
        /// <summary>
        /// Begins a new database transaction.
        /// </summary>
        /// <seealso cref="CommitTransaction"/>
        /// <seealso cref="RollbackTransaction"/>
        /// <returns>An object representing the new transaction.</returns>
        public IDbTransaction BeginTransaction()
	{
		CheckTransactionState(false);
		_transaction = _connection.BeginTransaction();
		return _transaction;
	}

        /// <summary>
        /// Begins a new database transaction with the specified 
        /// transaction isolation level.
        /// <seealso cref="CommitTransaction"/>
        /// <seealso cref="RollbackTransaction"/>
        /// </summary>
        /// <param name="isolationLevel">The transaction isolation level.</param>
        /// <returns>An object representing the new transaction.</returns>
	public IDbTransaction BeginTransaction(IsolationLevel isolationLevel)
	{
		CheckTransactionState(false);
		_transaction = _connection.BeginTransaction(isolationLevel);
		return _transaction;
	}

        /// <summary>
        /// Commits the current database transaction.
        /// <seealso cref="BeginTransaction"/>
        /// <seealso cref="RollbackTransaction"/>
        /// </summary>
	public void CommitTransaction()
	{
		CheckTransactionState(true);
		_transaction.Commit();
		_transaction = null;
	}

        /// <summary>
        /// Rolls back the current transaction from a pending state.
        /// <seealso cref="BeginTransaction"/>
        /// <seealso cref="CommitTransaction"/>
        /// </summary>
	public void RollbackTransaction()
	{
		CheckTransactionState(true);
		_transaction.Rollback();
		_transaction = null;
	}

        // Checks the state of the current transaction
	private void CheckTransactionState(bool mustBeOpen)
	{
		if (mustBeOpen) {
			if (_transaction == null) {
                 		throw new InvalidOperationException("Transaction is not open.");
             		}
         	}
	        else {
             		if ((_transaction != null)) {
                 		throw new InvalidOperationException("Transaction is already open.");
             		}
         	}
     	}

        /// <summary>
        /// Creates and returns a new <see cref="System.Data.IDbCommand"/> object.
        /// </summary>
        /// <param name="sqlText">The text of the query.</param>
        /// <returns>An <see cref="System.Data.IDbCommand"/> object.</returns>
	public IDbCommand CreateCommand(string sqlText)
	{
		IDbCommand cmd = _connection.CreateCommand();
		cmd.CommandText = sqlText;
		cmd.Transaction = _transaction;
		return cmd;
	}

        /// <summary>
        /// Creates and returns a new <see cref="System.Data.IDbCommand"/> object.
        /// </summary>
        /// <param name="sqlText">The text of the query.</param>
        /// <param name="procedure">Specifies whether the sqlText parameter is 
        /// the name of a stored procedure.</param>
        /// <returns>An <see cref="System.Data.IDbCommand"/> object.</returns>
	public IDbCommand CreateCommand(string sqlText, CommandType myCommandType)
	{
		IDbCommand cmd = _connection.CreateCommand();
		cmd.CommandText = sqlText;
		cmd.CommandType = myCommandType;
		cmd.Transaction = _transaction;
		return cmd;
	}

        /// <summary>
        /// Creates and returns a new <see cref="System.Data.OracleCommand"/> object.
        /// </summary>
        /// <param name="sqlText">The text of the query.</param>
        /// <returns>An <see cref="System.Data.OracleCommand"/> object.</returns>
	public IDbCommand CreateCommandText(string sqlText)
	{
		return CreateCommand(sqlText, CommandType.Text);
	}


        /// <summary>
        /// Creates and returns a new <see cref="System.Data.OracleCommand"/> object.
        /// </summary>
        /// <param name="sqlText">The text of the query.</param>
        /// <returns>An <see cref="System.Data.OracleCommand"/> object.</returns>
	public IDbCommand CreateCommandStoredProcedure(string StoredProcedureName)
	{
		return CreateCommand(StoredProcedureName, CommandType.StoredProcedure);
	}

	public DataTable Retrieve(string sql)
	{
		DataSet ds = new DataSet();
		IDbDataAdapter da = this.CreateDataAdapter();
		da.SelectCommand = this.CreateCommand(sql);
		da.Fill(ds);
		return ds.Tables[0];
	}


	public DataTable Retrieve(IDbCommand myCommand)
	{
		DataSet ds = new DataSet();
		IDbDataAdapter da = this.CreateDataAdapter();
		myCommand.Connection = _connection;
            	myCommand.Transaction = _transaction;
		da.SelectCommand = myCommand;
		da.Fill(ds);
		return ds.Tables[0];
	}
	
	


        /// <summary>
        /// Rolls back any pending transactions and closes the DB connection.
        /// An application can call the <c>Close</c> method more than
        /// one time without generating an exception.
        /// </summary>
	public virtual void Close()
	{
		if ((_connection != null)) {
			_connection.Close();
		}
	}


        /// <summary>
        /// Rolls back any pending transactions and closes the DB connection.
        /// </summary>
	public virtual void Dispose()
	{
		Close();
		if ((_connection != null)) {
			_connection.Dispose();
		}
	}

}
}

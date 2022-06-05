
// <fileinfo name="Base\UserCollectionBase.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			Do not change this source code manually. Changes to this file may 
//			cause incorrect behavior and will be lost if the code is regenerated.
//		</remarks>
//		<generator rewritefile="True" >Smc SaleFrame1.0</generator>
// </fileinfo>


using System;
using System.Data;
using DbObj;


namespace Base
{

/// <summary>
/// The base class for <see cref="UserCollection"/>. Provides methods 
/// for common database table operations. 
/// </summary>
/// <remarks>
/// Do not change this source code. Update the <see cref="UserCollection"/>
/// class if you need to add or change some functionality.
/// </remarks>
public abstract class UserCollectionBase
	: Base.ConllectionBase
	
{	
	// Constants
	public const string User_IDColumnName  = "User_ID";
	public const string UserNameColumnName  = "UserName";
	public const string PasswordColumnName  = "Password";
	public const string FullNameColumnName  = "FullName";
	public const string AvatarColumnName  = "Avatar";
	public const string AddressColumnName  = "Address";
	public const string EmailColumnName  = "Email";
	public const string PhoneColumnName  = "Phone";
	public const string PositionColumnName  = "Position";
	public const string CreateDateColumnName  = "CreateDate";
	public const string ModifyDateColumnName  = "ModifyDate";
	public const string CreateByColumnName  = "CreateBy";
	public const string ModifyByColumnName  = "ModifyBy";
	public const string StatusColumnName  = "Status";
	public const string SortColumnName  = "Sort";
	public const string BirthDayColumnName  = "BirthDay";
	public const string GenderColumnName  = "Gender";

	
    	/// <summary>
    	/// Initializes a new instance of the <see cref="CategoriesCollection_Base"/> 
    	/// class with the specified <see cref="Database"/>.
    	/// </summary>
    	/// <param name="db">The <see cref="Database"/> object.</param>
	public UserCollectionBase(Database db) : base(db)
	{
		this.TABLENAME = "User";
	}

	public UserCollectionBase() : base()
	{
		this.TABLENAME = "User";     
	}
	

	
	/// <summary>
	/// Gets an array of all records from the <c>User</c> table.
	/// </summary>
	/// <returns>An array of <see cref="UserRow"/> objects.</returns>
	public virtual UserRow[] GetAll()
	{
		return MapRecords(CreateGetAllCommand());
	}

	/// <summary>
	/// Gets a <see cref="System.Data.DataTable"/> object that 
	/// includes all records from the <c>User</c> table.
	/// </summary>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	public virtual DataTable GetAllAsDataTable()
	{	
		string LOCATION = "GetAllAsDataTable()";
		try
		{
			return MapRecordsToDataTable(CreateGetAllCommand());
		}
		catch(Exception ex)
		{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		}
	}

	/// <summary>
	/// Creates and returns an <see cref="System.Data.IDbCommand"/> object that is used
	/// to retrieve all records from the <c>User</c> table.
	/// </summary>
	/// <returns>A reference to the <see cref="System.Data.IDbCommand"/> object.</returns>
	protected virtual IDbCommand CreateGetAllCommand()
	{
		string LOCATION = "";
		try
		{
			return _db.CreateCommand("User_GetAll", CommandType.StoredProcedure);
		}
		catch (Exception ex)
        	{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
        	}
	}

	/// <summary>
	/// Gets the first <see cref="UserRow"/> objects that 
	/// match the search condition.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example: 
	/// <c>"FirstName='Smith' AND Zip=75038"</c>.</param>
	/// <returns>An instance of <see cref="UserRow"/> or null reference 
	/// (Nothing in Visual Basic) if the object was not found.</returns>
	public UserRow GetRow(string whereSql)
	{
		string LOCATION = "GetRow(string whereSql)";
		try
        	{
			int totalRecordCount = -1;
			UserRow[] rows = GetAsArray(whereSql, null, 0, 1, ref totalRecordCount);
			if (0 == rows.Length)
				return null;
			return rows[0];
		}
		catch (Exception ex)
        	{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
        	}
	}

	/// <summary>
	/// Gets an array of <see cref="UserRow"/> objects that 
	/// match the search condition, in the the specified sort order.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example: 
	/// <c>"FirstName='Smith' AND Zip=75038"</c>.</param>
	/// <param name="orderBySql">The column name(s) followed by "ASC" (ascending) or "DESC" (descending).
	/// Columns are sorted in ascending order by default. For example: <c>"LastName ASC, FirstName ASC"</c>.</param>
	/// <returns>An array of <see cref="UserRow"/> objects.</returns>
	public UserRow[] GetAsArray(string whereSql, string orderBySql)
	{
		string LOCATION = "GetAsArray(string whereSql, string orderBySql)";
		IDataReader reader = null;
		try
		{
			reader = _db.ExecuteReader(CreateGetCommand(whereSql, orderBySql));
			return MapRecords(reader);
		}
		catch(Exception ex)
		{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
		{
			if(reader != null)
				reader.Dispose();
            		_db.Dispose();
		}
	}

	/// <summary>
	/// Gets an array of <see cref="UserRow"/> objects that 
	/// match the search condition, in the the specified sort order.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example:
	/// <c>"FirstName='Smith' AND Zip=75038"</c>.</param>
	/// <param name="orderBySql">The column name(s) followed by "ASC" (ascending) or "DESC" (descending).
	/// Columns are sorted in ascending order by default. For example: <c>"LastName ASC, FirstName ASC"</c>.</param>
	/// <param name="startIndex">The index of the first record to return.</param>
	/// <param name="length">The number of records to return.</param>
	/// <param name="totalRecordCount">A reference parameter that returns the total number 
	/// of records in the reader object if 0 was passed into the method; otherwise it returns -1.</param>
	/// <returns>An array of <see cref="UserRow"/> objects.</returns>
	public virtual UserRow[] GetAsArray(string whereSql, string orderBySql, int startIndex, int length, ref int totalRecordCount)
	{
		string LOCATION = "GetAsArray(string whereSql, string orderBySql, int startIndex, int length, ref int totalRecordCount)";
		IDataReader reader = null;
		IDbCommand cmd = null;
		try
		{
			cmd = CreateGetCommand(whereSql, orderBySql, startIndex, length);
			reader = _db.ExecuteReader(cmd);
			UserRow[] rows = MapRecords(reader);
			reader.Close();
			System.Data.SqlClient.SqlParameter p = (System.Data.SqlClient.SqlParameter)(cmd.Parameters["@rows"]);
			totalRecordCount = (int)p.Value;
			return rows;
		}
		catch(Exception ex)
		{
			throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
		{
			reader.Dispose();
			cmd.Dispose();
			_db.Dispose();
		}
	}

	/// <summary>
	/// Gets a <see cref="System.Data.DataTable"/> object filled with data that 
	/// match the search condition, in the the specified sort order.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example: "FirstName='Smith' AND Zip=75038".</param>
	/// <param name="orderBySql">The column name(s) followed by "ASC" (ascending) or "DESC" (descending).
	/// Columns are sorted in ascending order by default. For example: "LastName ASC, FirstName ASC".</param>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	public DataTable GetAsDataTable(string whereSql, string orderBySql)
	{
		string LOCATION = "GetAsDataTable(string whereSql, string orderBySql)";
		IDataReader reader = null;
		try
		{
			reader = _db.ExecuteReader(CreateGetCommand(whereSql, orderBySql));
			return MapRecordsToDataTable(reader);
		}
		catch(Exception ex)
		{
			throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
		{
			reader.Dispose();
            		_db.Dispose();
		}
		
	}

	/// <summary>
	/// Gets a <see cref="System.Data.DataTable"/> object filled with data that 
	/// match the search condition, in the the specified sort order.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example: "FirstName='Smith' AND Zip=75038".</param>
	/// <param name="orderBySql">The column name(s) followed by "ASC" (ascending) or "DESC" (descending).
	/// Columns are sorted in ascending order by default. For example: "LastName ASC, FirstName ASC".</param>
	/// <param name="startIndex">The index of the first record to return.</param>
	/// <param name="length">The number of records to return.</param>
	/// <param name="totalRecordCount">A reference parameter that returns the total number 
	/// of records in the reader object if 0 was passed into the method; otherwise it returns -1.</param>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	public virtual DataTable GetAsDataTable(string whereSql, string orderBySql, int startIndex, int length, ref int totalRecordCount)
	{
		string LOCATION = "GetAsDataTable(string whereSql, string orderBySql, int startIndex, int length, ref int totalRecordCount)";
		IDataReader reader = null;
		IDbCommand cmd = null;
		try
		{
			cmd = CreateGetCommand(whereSql, orderBySql, startIndex, length);
			reader = _db.ExecuteReader(cmd);
			DataTable table = MapRecordsToDataTable(reader);
			reader.Close();
			System.Data.SqlClient.SqlParameter p = (System.Data.SqlClient.SqlParameter)(cmd.Parameters["@rows"]);
			totalRecordCount = (int)p.Value;
			return table;
		}
		catch(Exception ex)
		{

		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
		{
			reader.Dispose();
			cmd.Dispose();
			_db.Dispose();
		}
	}

	/// <summary>
	/// Creates an <see cref="System.Data.IDbCommand"/> object for the specified search criteria.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example: "FirstName='Smith' AND Zip=75038".</param>
	/// <param name="orderBySql">The column name(s) followed by "ASC" (ascending) or "DESC" (descending).
	/// Columns are sorted in ascending order by default. For example: "LastName ASC, FirstName ASC".</param>
	/// <returns>A reference to the <see cref="System.Data.IDbCommand"/> object.</returns>
	protected virtual IDbCommand CreateGetCommand(string whereSql, string orderBySql)
	{
		string LOCATION = "CreateGetCommand(string whereSql, string orderBySql)";
		try
		{
			IDbCommand cmd = _db.CreateCommand("User_GetAdHoc", CommandType.StoredProcedure);
			_db.AddParameter(cmd, "where", DbType.String, whereSql);
			_db.AddParameter(cmd, "orderby", DbType.String, orderBySql);
			return cmd;
		}
        	catch (Exception ex)
        	{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
        	}
	}

	/// <summary>
	/// Creates an <see cref="System.Data.IDbCommand"/> object for the specified search criteria.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. For example: "FirstName='Smith' AND Zip=75038".</param>
	/// <param name="orderBySql">The column name(s) followed by "ASC" (ascending) or "DESC" (descending).
	/// Columns are sorted in ascending order by default. For example: "LastName ASC, FirstName ASC".</param>
	/// <param name="startIndex">The index of the first record to return.</param>
	/// <param name="length">The number of records to return.</param>		
	/// <returns>A reference to the <see cref="System.Data.IDbCommand"/> object.</returns>
	protected virtual IDbCommand CreateGetCommand(string whereSql, string orderBySql, int startIndex, int length)
	{
		string LOCATION = "CreateGetCommand(string whereSql, string orderBySql, int startIndex, int length)";
		try
		{
			IDbCommand cmd = _db.CreateCommand("User_GetPageAdHoc", CommandType.StoredProcedure);
				
			_db.AddParameter(cmd, "where", DbType.String, whereSql);
			_db.AddParameter(cmd, "orderby", DbType.String, orderBySql);
			_db.AddParameter(cmd, "startIndex", DbType.Int32, startIndex + 1);
			_db.AddParameter(cmd, "length", DbType.Int32, length);

			IDbDataParameter parameter = _db.AddParameter(cmd, "rows", DbType.Int32, -1);
			parameter.Direction = ParameterDirection.InputOutput;
						
			return cmd;
		}
        	catch (Exception ex)
        	{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
        	}
	}
		

	/// <summary>
	/// Gets <see cref="UserRow"/> by the primary key.
	/// </summary>
	/// <param name="user_ID">The <c>User_ID</c> column value.</param>
	/// <returns>An instance of <see cref="UserRow"/> or null reference 
	/// (Nothing in Visual Basic) if the object was not found.</returns>
	public virtual UserRow GetByPrimaryKey(int user_ID)
	{
		string LOCATION = "GetByPrimaryKey(int user_ID)";
		try
        	{
			IDbCommand cmd = _db.CreateCommand("User_GetByPrimaryKey", CommandType.StoredProcedure);
			AddParameter(cmd, "User_ID", user_ID);
			UserRow[] tempArray = MapRecords(cmd);
			if( 0 == tempArray.Length)
				return null;
		
			return tempArray[0];
		}
		catch (Exception ex)
        	{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
        	}
	}



	/// <summary>
	/// Adds a new record into the <c>User</c> table.
	/// </summary>
	/// <param name="value">The <see cref="UserRow"/> object to be inserted.</param>
	public virtual void Insert(UserRow value)
	{
		string LOCATION = "Insert(UserRow value)";
		try
		{
				IDbCommand cmd = _db.CreateCommand("User_Insert", CommandType.StoredProcedure);
					// UserName
			if (value.IsUserNameNull )
				AddParameter(cmd, "UserName", DBNull.Value);
			else
				AddParameter(cmd, "UserName", value.UserName);
			
				// Password
			if (value.IsPasswordNull )
				AddParameter(cmd, "Password", DBNull.Value);
			else
				AddParameter(cmd, "Password", value.Password);
			
				// FullName
			if (value.IsFullNameNull )
				AddParameter(cmd, "FullName", DBNull.Value);
			else
				AddParameter(cmd, "FullName", value.FullName);
			
				// Avatar
			if (value.IsAvatarNull )
				AddParameter(cmd, "Avatar", DBNull.Value);
			else
				AddParameter(cmd, "Avatar", value.Avatar);
			
				// Address
			if (value.IsAddressNull )
				AddParameter(cmd, "Address", DBNull.Value);
			else
				AddParameter(cmd, "Address", value.Address);
			
				// Email
			if (value.IsEmailNull )
				AddParameter(cmd, "Email", DBNull.Value);
			else
				AddParameter(cmd, "Email", value.Email);
			
				// Phone
			if (value.IsPhoneNull )
				AddParameter(cmd, "Phone", DBNull.Value);
			else
				AddParameter(cmd, "Phone", value.Phone);
			
				// Position
			if (value.IsPositionNull )
				AddParameter(cmd, "Position", DBNull.Value);
			else
				AddParameter(cmd, "Position", value.Position);
			
				// CreateDate
			if (value.IsCreateDateNull)
				AddParameter(cmd, "CreateDate", DBNull.Value);
			else
				AddParameter(cmd, "CreateDate", value.CreateDate);
			
				// ModifyDate
			if (value.IsModifyDateNull)
				AddParameter(cmd, "ModifyDate", DBNull.Value);
			else
				AddParameter(cmd, "ModifyDate", value.ModifyDate);
			
				// CreateBy
			if (value.IsCreateByNull)
				AddParameter(cmd, "CreateBy", DBNull.Value);
			else
				AddParameter(cmd, "CreateBy", value.CreateBy);
			
				// ModifyBy
			if (value.IsModifyByNull)
				AddParameter(cmd, "ModifyBy", DBNull.Value);
			else
				AddParameter(cmd, "ModifyBy", value.ModifyBy);
			
				// Status
			if (value.IsStatusNull)
				AddParameter(cmd, "Status", DBNull.Value);
			else
				AddParameter(cmd, "Status", value.Status);
			
				// Sort
			if (value.IsSortNull)
				AddParameter(cmd, "Sort", DBNull.Value);
			else
				AddParameter(cmd, "Sort", value.Sort);
			
				// BirthDay
			if (value.IsBirthDayNull)
				AddParameter(cmd, "BirthDay", DBNull.Value);
			else
				AddParameter(cmd, "BirthDay", value.BirthDay);
			
				// Gender
			if (value.IsGenderNull)
				AddParameter(cmd, "Gender", DBNull.Value);
			else
				AddParameter(cmd, "Gender", value.Gender);
			
						value.User_ID = Convert.ToInt32(cmd.ExecuteScalar());
			}
		catch(Exception ex)
		{
			throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
        	{
            		_db.Dispose();
        	}
	}

	/// <summary>
	/// Updates a record in the <c>User</c> table.
	/// </summary>
	/// <param name="value">The <see cref="UserRow"/>
	/// object used to update the table record.</param>
	/// <returns>true if the record was updated; otherwise, false.</returns>
	public virtual bool Update(UserRow value)
	{	
		string LOCATION = "Update(UserRow value)";
		try
		{
				IDbCommand cmd = _db.CreateCommand("User_Update", CommandType.StoredProcedure);
					// UserName
			if (value.IsUserNameNull)
				AddParameter(cmd, "UserName", DBNull.Value);
			else
				AddParameter(cmd, "UserName", value.UserName);
				// Password
			if (value.IsPasswordNull)
				AddParameter(cmd, "Password", DBNull.Value);
			else
				AddParameter(cmd, "Password", value.Password);
				// FullName
			if (value.IsFullNameNull)
				AddParameter(cmd, "FullName", DBNull.Value);
			else
				AddParameter(cmd, "FullName", value.FullName);
				// Avatar
			if (value.IsAvatarNull)
				AddParameter(cmd, "Avatar", DBNull.Value);
			else
				AddParameter(cmd, "Avatar", value.Avatar);
				// Address
			if (value.IsAddressNull)
				AddParameter(cmd, "Address", DBNull.Value);
			else
				AddParameter(cmd, "Address", value.Address);
				// Email
			if (value.IsEmailNull)
				AddParameter(cmd, "Email", DBNull.Value);
			else
				AddParameter(cmd, "Email", value.Email);
				// Phone
			if (value.IsPhoneNull)
				AddParameter(cmd, "Phone", DBNull.Value);
			else
				AddParameter(cmd, "Phone", value.Phone);
				// Position
			if (value.IsPositionNull)
				AddParameter(cmd, "Position", DBNull.Value);
			else
				AddParameter(cmd, "Position", value.Position);
				// CreateDate
			if (value.IsCreateDateNull)
				AddParameter(cmd, "CreateDate", DBNull.Value);
			else
				AddParameter(cmd, "CreateDate", value.CreateDate);
			
				// ModifyDate
			if (value.IsModifyDateNull)
				AddParameter(cmd, "ModifyDate", DBNull.Value);
			else
				AddParameter(cmd, "ModifyDate", value.ModifyDate);
			
				// CreateBy
			if (value.IsCreateByNull)
				AddParameter(cmd, "CreateBy", DBNull.Value);
			else
				AddParameter(cmd, "CreateBy", value.CreateBy);
			
				// ModifyBy
			if (value.IsModifyByNull)
				AddParameter(cmd, "ModifyBy", DBNull.Value);
			else
				AddParameter(cmd, "ModifyBy", value.ModifyBy);
			
				// Status
			if (value.IsStatusNull)
				AddParameter(cmd, "Status", DBNull.Value);
			else
				AddParameter(cmd, "Status", value.Status);
			
				// Sort
			if (value.IsSortNull)
				AddParameter(cmd, "Sort", DBNull.Value);
			else
				AddParameter(cmd, "Sort", value.Sort);
			
				// BirthDay
			if (value.IsBirthDayNull)
				AddParameter(cmd, "BirthDay", DBNull.Value);
			else
				AddParameter(cmd, "BirthDay", value.BirthDay);
			
				// Gender
			if (value.IsGenderNull)
				AddParameter(cmd, "Gender", DBNull.Value);
			else
				AddParameter(cmd, "Gender", value.Gender);
			
					AddParameter(cmd, "User_ID", value.User_ID);
				return 0 != cmd.ExecuteNonQuery();
	}
        catch(Exception ex)
	{
            throw new Exceptions.DatabaseException(LOCATION, ex);
        }		
	finally
        {
            _db.Dispose();
        }
	}

		/// <summary>
		/// Inserts or Updates a record in the <c>User</c> table.
		/// If a row with the specified primary key exists then it is updated
		/// otehrwise, a new row is added.
		/// </summary>
		/// <param name="value">The <see cref="UserRow"/>
		/// object used to save the table record.</param>
		public virtual void Save(UserRow value)
		{
			string LOCATION = "Save(UserRow value)";
			try
			{
					IDbCommand cmd =  _db.CreateCommand("User_Save",CommandType.StoredProcedure);
					// UserName
				if (value.IsUserNameNull)
					AddParameter(cmd, "UserName", DBNull.Value);
				else
					AddParameter(cmd, "UserName", (object)(value.UserName));
				
					// Password
				if (value.IsPasswordNull)
					AddParameter(cmd, "Password", DBNull.Value);
				else
					AddParameter(cmd, "Password", (object)(value.Password));
				
					// FullName
				if (value.IsFullNameNull)
					AddParameter(cmd, "FullName", DBNull.Value);
				else
					AddParameter(cmd, "FullName", (object)(value.FullName));
				
					// Avatar
				if (value.IsAvatarNull)
					AddParameter(cmd, "Avatar", DBNull.Value);
				else
					AddParameter(cmd, "Avatar", (object)(value.Avatar));
				
					// Address
				if (value.IsAddressNull)
					AddParameter(cmd, "Address", DBNull.Value);
				else
					AddParameter(cmd, "Address", (object)(value.Address));
				
					// Email
				if (value.IsEmailNull)
					AddParameter(cmd, "Email", DBNull.Value);
				else
					AddParameter(cmd, "Email", (object)(value.Email));
				
					// Phone
				if (value.IsPhoneNull)
					AddParameter(cmd, "Phone", DBNull.Value);
				else
					AddParameter(cmd, "Phone", (object)(value.Phone));
				
					// Position
				if (value.IsPositionNull)
					AddParameter(cmd, "Position", DBNull.Value);
				else
					AddParameter(cmd, "Position", (object)(value.Position));
				
					// CreateDate
				if (value.IsCreateDateNull)
					AddParameter(cmd, "CreateDate", DBNull.Value);
				else
					AddParameter(cmd, "CreateDate", (object)(value.CreateDate));
				
					// ModifyDate
				if (value.IsModifyDateNull)
					AddParameter(cmd, "ModifyDate", DBNull.Value);
				else
					AddParameter(cmd, "ModifyDate", (object)(value.ModifyDate));
				
					// CreateBy
				if (value.IsCreateByNull)
					AddParameter(cmd, "CreateBy", DBNull.Value);
				else
					AddParameter(cmd, "CreateBy", (object)(value.CreateBy));
				
					// ModifyBy
				if (value.IsModifyByNull)
					AddParameter(cmd, "ModifyBy", DBNull.Value);
				else
					AddParameter(cmd, "ModifyBy", (object)(value.ModifyBy));
				
					// Status
				if (value.IsStatusNull)
					AddParameter(cmd, "Status", DBNull.Value);
				else
					AddParameter(cmd, "Status", (object)(value.Status));
				
					// Sort
				if (value.IsSortNull)
					AddParameter(cmd, "Sort", DBNull.Value);
				else
					AddParameter(cmd, "Sort", (object)(value.Sort));
				
					// BirthDay
				if (value.IsBirthDayNull)
					AddParameter(cmd, "BirthDay", DBNull.Value);
				else
					AddParameter(cmd, "BirthDay", (object)(value.BirthDay));
				
					// Gender
				if (value.IsGenderNull)
					AddParameter(cmd, "Gender", DBNull.Value);
				else
					AddParameter(cmd, "Gender", (object)(value.Gender));
				
						AddParameter(cmd, "User_ID", value.User_ID);
						value.User_ID = Convert.ToInt32(cmd.ExecuteScalar());
			}
            	catch(Exception ex)
		{
	                throw new Exceptions.DatabaseException(LOCATION, ex);
            	}
		finally
        	{
            		_db.Dispose();
        	}
	}

	
	public virtual void Update(DataTable table, bool acceptChanges)
	{
		string LOCATION = "Update(DataTable table, bool acceptChanges)";
		try
		{
			DataRowCollection rows = table.Rows;
			for(int i = rows.Count - 1; i >= 0; i--)
			{
				DataRow row = rows[i];
				switch(row.RowState)
				{
					case DataRowState.Added:
						Insert(MapRow(row));
						if(acceptChanges)
							row.AcceptChanges();
						break;

					case DataRowState.Deleted:
						// Temporary reject changes to be able to access to the PK column(s)
						row.RejectChanges();
						try
						{
							DeleteByPrimaryKey((int)row["User_ID"]);
						}
						finally
						{
							row.Delete();
						}
						if(acceptChanges)
							row.AcceptChanges();
						break;
						
					case DataRowState.Modified:
						Update(MapRow(row));
						if(acceptChanges)
							row.AcceptChanges();
						break;
				}
			}
		}
        	catch(Exception ex)
		{
            		throw new Exceptions.DatabaseException(LOCATION, ex);
		}
        }

	/// <summary>
	/// Deletes the specified object from the <c>User</c> table.
	/// </summary>
	/// <param name="value">The <see cref="UserRow"/> object to delete.</param>
	/// <returns>true if the record was deleted; otherwise, false.</returns>
	public bool Delete(UserRow value)
	{
		return DeleteByPrimaryKey(value.User_ID);
	}

	/// <summary>
	/// Deletes a record from the <c>User</c> table using
	/// the specified primary key.
	/// </summary>
	/// <param name="user_ID">The <c>User_ID</c> column value.</param>
	/// <returns>true if the record was deleted; otherwise, false.</returns>
	public virtual bool DeleteByPrimaryKey(int user_ID)
	{
		string LOCATION = "DeleteByPrimaryKey(int user_ID)";
		try
		{
				IDbCommand cmd = _db.CreateCommand("User_DeleteByPrimaryKey", CommandType.StoredProcedure);
					AddParameter(cmd, "User_ID", user_ID);
				return (0 < cmd.ExecuteNonQuery());
	}
        catch(Exception ex)
	{
            throw new Exceptions.DatabaseException(LOCATION, ex);
        }	
	finally
        {
            _db.Dispose();
        }	
}

	/// <summary>
	/// Deletes <c>User</c> records that match the specified criteria.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. 
	/// For example: <c>"FirstName='Smith' AND Zip=75038"</c>.</param>
	/// <returns>The number of deleted records.</returns>
	public int Delete(string whereSql)
	{
		string LOCATION = "Delete(string whereSql)";
		try
		{
			return CreateDeleteCommand(whereSql).ExecuteNonQuery();
		}
		catch(Exception ex)
		{
			throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
        	{
            		_db.Dispose();
        	}
	}

	/// <summary>
	/// Creates an <see cref="System.Data.IDbCommand"/> object that can be used 
	/// to delete <c>User</c> records that match the specified criteria.
	/// </summary>
	/// <param name="whereSql">The SQL search condition. 
	/// For example: <c>"FirstName='Smith' AND Zip=75038"</c>.</param>
	/// <returns>A reference to the <see cref="System.Data.IDbCommand"/> object.</returns>
	protected virtual IDbCommand CreateDeleteCommand(string whereSql)
	{
		string LOCATION = "CreateDeleteCommand(String whereSql)";
		try
		{
			IDbCommand cmd = _db.CreateCommand("User_DeleteAdHoc", CommandType.StoredProcedure);
			
			_db.AddParameter(cmd, "where", DbType.AnsiString, whereSql);

			return cmd;
		}
		catch(Exception ex)
		{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		} 		
	}

	/// <summary>
	/// Deletes all records from the <c>User</c> table.
	/// </summary>
	/// <returns>The number of deleted records.</returns>
	public int DeleteAll()
	{
		string LOCATION = "DeleteAll()";
		try
		{
				return _db.CreateCommand("User_DeleteAll", CommandType.StoredProcedure).ExecuteNonQuery();
			}
		catch(Exception ex)
		{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		} 
		finally
        	{
            		_db.Dispose();
        	}
        }

	/// <summary>
	/// Reads data using the specified command and returns 
	/// an array of mapped objects.
	/// </summary>
	/// <param name="command">The <see cref="System.Data.IDbCommand"/> object.</param>
	/// <returns>An array of <see cref="UserRow"/> objects.</returns>
	protected UserRow[] MapRecords(IDbCommand command)
	{
		string LOCATION = "MapRecords(IDbCommand command)";
		IDataReader reader = _db.ExecuteReader(command);
		try
		{
			return MapRecords(reader);
		}
		catch(Exception ex)
		{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
		{
			reader.Dispose();
		        _db.Dispose();
        		
		}
	}

	/// <summary>
	/// Reads data from the provided data reader and returns 
	/// an array of mapped objects.
	/// </summary>
	/// <param name="reader">The <see cref="System.Data.IDataReader"/> object to read data from the table.</param>
	/// <returns>An array of <see cref="UserRow"/> objects.</returns>
	protected UserRow[] MapRecords(IDataReader reader)
	{
		int totalRecordCount = -1;
		return MapRecords(reader, 0, int.MaxValue,ref totalRecordCount);
	}

	/// <summary>
	/// Reads data from the provided data reader and returns 
	/// an array of mapped objects.
	/// </summary>
	/// <param name="reader">The <see cref="System.Data.IDataReader"/> object to read data from the table.</param>
	/// <param name="startIndex">The index of the first record to map.</param>
	/// <param name="length">The number of records to map.</param>
	/// <param name="totalRecordCount">A reference parameter that returns the total number 
	/// of records in the reader object if 0 was passed into the method; otherwise it returns -1.</param>
	/// <returns>An array of <see cref="UserRow"/> objects.</returns>
	protected virtual UserRow[] MapRecords(IDataReader reader, int startIndex, int length, ref int totalRecordCount)
	{ 
		string LOCATION = " MapRecords(...)";
		if(0 > startIndex)
				throw new ArgumentOutOfRangeException("startIndex", startIndex, "StartIndex cannot be less than zero.");
			if(0 > length)
				throw new ArgumentOutOfRangeException("length", length, "Length cannot be less than zero.");

		// User_ID
		int user_IDColumnIndex = reader.GetOrdinal("User_ID");
		// UserName
		int userNameColumnIndex = reader.GetOrdinal("UserName");
		// Password
		int passwordColumnIndex = reader.GetOrdinal("Password");
		// FullName
		int fullNameColumnIndex = reader.GetOrdinal("FullName");
		// Avatar
		int avatarColumnIndex = reader.GetOrdinal("Avatar");
		// Address
		int addressColumnIndex = reader.GetOrdinal("Address");
		// Email
		int emailColumnIndex = reader.GetOrdinal("Email");
		// Phone
		int phoneColumnIndex = reader.GetOrdinal("Phone");
		// Position
		int positionColumnIndex = reader.GetOrdinal("Position");
		// CreateDate
		int createDateColumnIndex = reader.GetOrdinal("CreateDate");
		// ModifyDate
		int modifyDateColumnIndex = reader.GetOrdinal("ModifyDate");
		// CreateBy
		int createByColumnIndex = reader.GetOrdinal("CreateBy");
		// ModifyBy
		int modifyByColumnIndex = reader.GetOrdinal("ModifyBy");
		// Status
		int statusColumnIndex = reader.GetOrdinal("Status");
		// Sort
		int sortColumnIndex = reader.GetOrdinal("Sort");
		// BirthDay
		int birthDayColumnIndex = reader.GetOrdinal("BirthDay");
		// Gender
		int genderColumnIndex = reader.GetOrdinal("Gender");

		System.Collections.ArrayList recordList = new System.Collections.ArrayList();
		int ri = -startIndex;
		while(reader.Read())
		{
			ri++;
			if(ri > 0 && ri <= length)
			{
				UserRow record = new UserRow();
				recordList.Add(record);

					record.User_ID = Convert.ToInt32(reader.GetValue(user_IDColumnIndex));
					if(!reader.IsDBNull(userNameColumnIndex))
						record.UserName = Convert.ToString(reader.GetValue(userNameColumnIndex));
					if(!reader.IsDBNull(passwordColumnIndex))
						record.Password = Convert.ToString(reader.GetValue(passwordColumnIndex));
					if(!reader.IsDBNull(fullNameColumnIndex))
						record.FullName = Convert.ToString(reader.GetValue(fullNameColumnIndex));
					if(!reader.IsDBNull(avatarColumnIndex))
						record.Avatar = Convert.ToString(reader.GetValue(avatarColumnIndex));
					if(!reader.IsDBNull(addressColumnIndex))
						record.Address = Convert.ToString(reader.GetValue(addressColumnIndex));
					if(!reader.IsDBNull(emailColumnIndex))
						record.Email = Convert.ToString(reader.GetValue(emailColumnIndex));
					if(!reader.IsDBNull(phoneColumnIndex))
						record.Phone = Convert.ToString(reader.GetValue(phoneColumnIndex));
					if(!reader.IsDBNull(positionColumnIndex))
						record.Position = Convert.ToString(reader.GetValue(positionColumnIndex));
					if(!reader.IsDBNull(createDateColumnIndex))
						record.CreateDate = Convert.ToDateTime(reader.GetValue(createDateColumnIndex));
					if(!reader.IsDBNull(modifyDateColumnIndex))
						record.ModifyDate = Convert.ToDateTime(reader.GetValue(modifyDateColumnIndex));
					if(!reader.IsDBNull(createByColumnIndex))
						record.CreateBy = Convert.ToInt32(reader.GetValue(createByColumnIndex));
					if(!reader.IsDBNull(modifyByColumnIndex))
						record.ModifyBy = Convert.ToInt32(reader.GetValue(modifyByColumnIndex));
					if(!reader.IsDBNull(statusColumnIndex))
						record.Status = Convert.ToInt32(reader.GetValue(statusColumnIndex));
					if(!reader.IsDBNull(sortColumnIndex))
						record.Sort = Convert.ToInt32(reader.GetValue(sortColumnIndex));
					if(!reader.IsDBNull(birthDayColumnIndex))
						record.BirthDay = Convert.ToDateTime(reader.GetValue(birthDayColumnIndex));
					if(!reader.IsDBNull(genderColumnIndex))
						record.Gender = Convert.ToInt32(reader.GetValue(genderColumnIndex));

					if(ri == length && 0 != totalRecordCount)
						break;
				}
			}
		
		if (0 == totalRecordCount)
			totalRecordCount = ri + startIndex;
		else
			totalRecordCount = -1;

		return (UserRow[])(recordList.ToArray(typeof(UserRow)));
	}

	/// <summary>
	/// Reads data using the specified command and returns 
	/// a filled <see cref="System.Data.DataTable"/> object.
	/// </summary>
	/// <param name="command">The <see cref="System.Data.IDbCommand"/> object.</param>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	protected DataTable MapRecordsToDataTable(IDbCommand command)
	{
		string LOCATION = "MapRecordsToDataTable(IDbCommand command)";
		IDataReader reader = _db.ExecuteReader(command);
		try
		{
			return MapRecordsToDataTable(reader);
		}
		catch(Exception ex)
		{
		      	throw new Exceptions.DatabaseException(LOCATION, ex);
		}
		finally
		{
			reader.Dispose();
			_db.Dispose();
		}
	}
	
	/// <summary>
	/// Reads data from the provided data reader and returns 
	/// a filled <see cref="System.Data.DataTable"/> object.
	/// </summary>
	/// <param name="reader">The <see cref="System.Data.IDataReader"/> object to read data from the table.</param>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	protected DataTable MapRecordsToDataTable(IDataReader reader)
	{
		int totalRecordCount = 0;
		return MapRecordsToDataTable(reader, 0, int.MaxValue, ref totalRecordCount);
	}
	
	/// <summary>
	/// Reads data from the provided data reader and returns 
	/// a filled <see cref="System.Data.DataTable"/> object.
	/// </summary>
	/// <param name="reader">The <see cref="System.Data.IDataReader"/> object to read data from the table.</param>
	/// <param name="startIndex">The index of the first record to read.</param>
	/// <param name="length">The number of records to read.</param>
	/// <param name="totalRecordCount">A reference parameter that returns the total number 
	/// of records in the reader object if 0 was passed into the method; otherwise it returns -1.</param>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	protected virtual DataTable MapRecordsToDataTable(IDataReader reader, 
										int startIndex, int length, ref int totalRecordCount)
	{
		string LOCATION = "MapRecordsToDataTable(reader,startIndex,length,ref totalRecordCount)";
		if(0 > startIndex)
			throw new ArgumentOutOfRangeException("startIndex", startIndex, "StartIndex cannot be less than zero.");
		if(0 > length)
			throw new ArgumentOutOfRangeException("length", length, "Length cannot be less than zero.");
		int columnCount = reader.FieldCount;
		int ri = -startIndex;
		
		DataTable dataTable = CreateDataTable();
		dataTable.BeginLoadData();
		object[] values = new object[columnCount];
		
		while(reader.Read())
		{
			ri++;
			if(ri > 0 && ri <= length)
			{
				reader.GetValues(values);
				dataTable.LoadDataRow(values, true);
				if(ri == length && 0 != totalRecordCount)
					break;
			}
		}
		dataTable.EndLoadData();

		if( 0 == totalRecordCount)
			totalRecordCount = ri + startIndex;
		else
			totalRecordCount = -1;

		return dataTable;
	}

	/// <summary>
	/// Converts <see cref="System.Data.DataRow"/> to <see cref="UserRow"/>.
	/// </summary>
	/// <param name="row">The <see cref="System.Data.DataRow"/> object to be mapped.</param>
	/// <returns>A reference to the <see cref="UserRow"/> object.</returns>
	protected virtual UserRow MapRow(DataRow row)
	{
		string LOCATION = "UserRow MapRow(DataRow row)";
		UserRow mappedObject = new UserRow();
		DataTable dataTable = row.Table;
		DataColumn dataColumn;
		// Column "User_ID"
		dataColumn = dataTable.Columns["User_ID"];
		if (! row.IsNull(dataColumn) )
			mappedObject.User_ID = (int)(row[dataColumn]);
		// Column "UserName"
		dataColumn = dataTable.Columns["UserName"];
		if (! row.IsNull(dataColumn) )
			mappedObject.UserName = (string)(row[dataColumn]);
		// Column "Password"
		dataColumn = dataTable.Columns["Password"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Password = (string)(row[dataColumn]);
		// Column "FullName"
		dataColumn = dataTable.Columns["FullName"];
		if (! row.IsNull(dataColumn) )
			mappedObject.FullName = (string)(row[dataColumn]);
		// Column "Avatar"
		dataColumn = dataTable.Columns["Avatar"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Avatar = (string)(row[dataColumn]);
		// Column "Address"
		dataColumn = dataTable.Columns["Address"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Address = (string)(row[dataColumn]);
		// Column "Email"
		dataColumn = dataTable.Columns["Email"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Email = (string)(row[dataColumn]);
		// Column "Phone"
		dataColumn = dataTable.Columns["Phone"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Phone = (string)(row[dataColumn]);
		// Column "Position"
		dataColumn = dataTable.Columns["Position"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Position = (string)(row[dataColumn]);
		// Column "CreateDate"
		dataColumn = dataTable.Columns["CreateDate"];
		if (! row.IsNull(dataColumn) )
			mappedObject.CreateDate = (System.DateTime)(row[dataColumn]);
		// Column "ModifyDate"
		dataColumn = dataTable.Columns["ModifyDate"];
		if (! row.IsNull(dataColumn) )
			mappedObject.ModifyDate = (System.DateTime)(row[dataColumn]);
		// Column "CreateBy"
		dataColumn = dataTable.Columns["CreateBy"];
		if (! row.IsNull(dataColumn) )
			mappedObject.CreateBy = (int)(row[dataColumn]);
		// Column "ModifyBy"
		dataColumn = dataTable.Columns["ModifyBy"];
		if (! row.IsNull(dataColumn) )
			mappedObject.ModifyBy = (int)(row[dataColumn]);
		// Column "Status"
		dataColumn = dataTable.Columns["Status"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Status = (int)(row[dataColumn]);
		// Column "Sort"
		dataColumn = dataTable.Columns["Sort"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Sort = (int)(row[dataColumn]);
		// Column "BirthDay"
		dataColumn = dataTable.Columns["BirthDay"];
		if (! row.IsNull(dataColumn) )
			mappedObject.BirthDay = (System.DateTime)(row[dataColumn]);
		// Column "Gender"
		dataColumn = dataTable.Columns["Gender"];
		if (! row.IsNull(dataColumn) )
			mappedObject.Gender = (int)(row[dataColumn]);
		return mappedObject;
	}

	/// <summary>
	/// Creates a <see cref="System.Data.DataTable"/> object for 
	/// the <c>User</c> table.
	/// </summary>
	/// <returns>A reference to the <see cref="System.Data.DataTable"/> object.</returns>
	protected virtual DataTable CreateDataTable()
	{
		string LOCATION = "CreateDataTable()";
		DataTable dataTable = new DataTable();
		dataTable.TableName = "User";
		DataColumn dataColumn;
		// Create the "User_ID" column
		dataColumn = dataTable.Columns.Add("User_ID", typeof(int));
		dataColumn.AllowDBNull = false;
		dataColumn.ReadOnly = true;
		dataColumn.Unique = true;
		dataColumn.AutoIncrement = true;
		// Create the "UserName" column
		dataColumn = dataTable.Columns.Add("UserName", typeof(string));
		dataColumn.MaxLength = 200;
		// Create the "Password" column
		dataColumn = dataTable.Columns.Add("Password", typeof(string));
		dataColumn.MaxLength = 200;
		// Create the "FullName" column
		dataColumn = dataTable.Columns.Add("FullName", typeof(string));
		dataColumn.MaxLength = 500;
		// Create the "Avatar" column
		dataColumn = dataTable.Columns.Add("Avatar", typeof(string));
		dataColumn.MaxLength = 500;
		// Create the "Address" column
		dataColumn = dataTable.Columns.Add("Address", typeof(string));
		dataColumn.MaxLength = 500;
		// Create the "Email" column
		dataColumn = dataTable.Columns.Add("Email", typeof(string));
		dataColumn.MaxLength = 50;
		// Create the "Phone" column
		dataColumn = dataTable.Columns.Add("Phone", typeof(string));
		dataColumn.MaxLength = 50;
		// Create the "Position" column
		dataColumn = dataTable.Columns.Add("Position", typeof(string));
		dataColumn.MaxLength = 500;
		// Create the "CreateDate" column
		dataColumn = dataTable.Columns.Add("CreateDate", typeof(System.DateTime));
		// Create the "ModifyDate" column
		dataColumn = dataTable.Columns.Add("ModifyDate", typeof(System.DateTime));
		// Create the "CreateBy" column
		dataColumn = dataTable.Columns.Add("CreateBy", typeof(int));
		// Create the "ModifyBy" column
		dataColumn = dataTable.Columns.Add("ModifyBy", typeof(int));
		// Create the "Status" column
		dataColumn = dataTable.Columns.Add("Status", typeof(int));
		// Create the "Sort" column
		dataColumn = dataTable.Columns.Add("Sort", typeof(int));
		// Create the "BirthDay" column
		dataColumn = dataTable.Columns.Add("BirthDay", typeof(System.DateTime));
		// Create the "Gender" column
		dataColumn = dataTable.Columns.Add("Gender", typeof(int));
		return dataTable;
	}
	
	/// <summary>
	/// Adds a new parameter to the specified command.
	/// </summary>
	/// <param name="cmd">The <see cref="System.Data.IDbCommand"/> object to add the parameter to.</param>
	/// <param name="paramName">The name of the parameter.</param>
	/// <param name="value">The value of the parameter.</param>
	/// <returns>A reference to the added parameter.</returns>
	protected virtual IDbDataParameter AddParameter(IDbCommand cmd, String paramName, object value)
	{
		string LOCATION = "AddParameter(IDbCommand cmd, String paramName, object value)";
		IDbDataParameter parameter;
		switch(paramName)
		{
			case "User_ID":
				parameter = _db.AddParameter(cmd, paramName, DbType.Int32, value);
				break;

			case "UserName":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "Password":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "FullName":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "Avatar":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "Address":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "Email":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "Phone":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "Position":
				parameter = _db.AddParameter(cmd, paramName, DbType.String, value);
				break;

			case "CreateDate":
				parameter = _db.AddParameter(cmd, paramName, DbType.DateTime, value);
				break;

			case "ModifyDate":
				parameter = _db.AddParameter(cmd, paramName, DbType.DateTime, value);
				break;

			case "CreateBy":
				parameter = _db.AddParameter(cmd, paramName, DbType.Int32, value);
				break;

			case "ModifyBy":
				parameter = _db.AddParameter(cmd, paramName, DbType.Int32, value);
				break;

			case "Status":
				parameter = _db.AddParameter(cmd, paramName, DbType.Int32, value);
				break;

			case "Sort":
				parameter = _db.AddParameter(cmd, paramName, DbType.Int32, value);
				break;

			case "BirthDay":
				parameter = _db.AddParameter(cmd, paramName, DbType.DateTime, value);
				break;

			case "Gender":
				parameter = _db.AddParameter(cmd, paramName, DbType.Int32, value);
				break;

				default:
					throw new ArgumentException("Unknown parameter name (" + paramName + ").");
		}
		return parameter;
	}
	
	/// <summary>
	/// Exist <see cref="UserRow"/> by the primary key.
	/// </summary>
	/// <param name="user_ID">The <c>User_ID</c> column value.</param>
	/// <returns>An instance of <see cref="UserRow"/> or null reference 
	/// (Nothing in Visual Basic) if the object was not found.</returns>
	public virtual bool Exist(int user_ID)
	{
		string LOCATION = "Exist(int user_ID)";
		IDbCommand cmd = _db.CreateCommand("User_GetByPrimaryKey", CommandType.StoredProcedure);
		AddParameter(cmd, "User_ID", user_ID);
		UserRow[] tempArray = MapRecords(cmd);
		if( 0 == tempArray.Length)
			return false;
		return true;
	}
	
}
}





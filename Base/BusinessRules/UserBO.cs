// <fileinfo name="UserBO.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			Do not change this source code manually. Changes to this file may 
//			cause incorrect behavior and will be lost if the code is regenerated.
//		</remarks>
// </fileinfo>


using System;
using System.Data;

using DbObj;


/// <summary>
/// The base class for <see cref="UserCollection"/>. Provides methods 
/// for common database table operations. 
/// </summary>
/// <remarks>
/// Do not change this source code. Update the <see cref="UserCollection"/>
/// class if you need to add or change some functionality.
/// </remarks>
public  class UserBO
	: BusinessRulesBase
{



	public UserRow GetByPrimaryKey(int user_ID)
	{
		string LOCATION = "GetByPrimaryKey(int user_ID)";
		try
		{
			return DataAccessLocator.GetUserCollection().GetByPrimaryKey(user_ID);		
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}



	public bool Exist(int user_ID)
	{
		string LOCATION = "Exist(int user_ID)";
		try
		{
			return DataAccessLocator.GetUserCollection().Exist(user_ID);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}


	public void Update(DataTable table)
	{
		string LOCATION = "Update(DataTable table)";
		try
		{
			DataAccessLocator.GetUserCollection().Update(table, true);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public bool Update(UserRow value)
	{
		string LOCATION = "Update(UserRow value)";
		try
		{
			return DataAccessLocator.GetUserCollection().Update(value);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public void Insert(UserRow value)
	{
		string LOCATION = "Insert(UserRow value)";
		try
		{
			DataAccessLocator.GetUserCollection().Insert(value);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public bool DeleteByPrimaryKey(int user_ID)
	{
		string LOCATION = "DeleteByPrimaryKey(int user_ID)";
		try
		{
			return DataAccessLocator.GetUserCollection().DeleteByPrimaryKey(user_ID);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public int Delete(string whereSql)
	{
		string LOCATION = "Delete(string whereSql)";
		try
		{
			return DataAccessLocator.GetUserCollection().Delete(whereSql);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public DataTable GetAllAsDataTable()
	{
		string LOCATION = "GetAllAsDataTable()";
		try
		{
			return DataAccessLocator.GetUserCollection().GetAllAsDataTable();
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}
	
	public DataTable GetAsDataTable(string whereSql, string orderBySql)
	{
		string LOCATION = "GetAsDataTable(string whereSql, string orderBySql)";
		try
		{
			return DataAccessLocator.GetUserCollection().GetAsDataTable(whereSql, orderBySql);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}
	
	public DataTable GetAsDataTable(string whereSql, string orderBySql, int startIndex, int length, ref int totalRecordCount)
	{
		string LOCATION = "GetAsDataTable(string whereSql, string orderBySql, int startIndex, int length, ref int totalRecordCount)";
		try
		{
			return DataAccessLocator.GetUserCollection().GetAsDataTable(whereSql, orderBySql, startIndex, length, ref totalRecordCount);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}



}


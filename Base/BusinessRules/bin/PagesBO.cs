// <fileinfo name="PagesBO.cs">
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
/// The base class for <see cref="PagesCollection"/>. Provides methods 
/// for common database table operations. 
/// </summary>
/// <remarks>
/// Do not change this source code. Update the <see cref="PagesCollection"/>
/// class if you need to add or change some functionality.
/// </remarks>
public  class PagesBO
	: BusinessRulesBase
{



	public PagesRow GetByPrimaryKey(int pageId)
	{
		string LOCATION = "GetByPrimaryKey(int pageId)";
		try
		{
			return DataAccessLocator.GetPagesCollection().GetByPrimaryKey(pageId);		
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}



	public bool Exist(int pageId)
	{
		string LOCATION = "Exist(int pageId)";
		try
		{
			return DataAccessLocator.GetPagesCollection().Exist(pageId);
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
			DataAccessLocator.GetPagesCollection().Update(table, true);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public bool Update(PagesRow value)
	{
		string LOCATION = "Update(PagesRow value)";
		try
		{
			return DataAccessLocator.GetPagesCollection().Update(value);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public void Insert(PagesRow value)
	{
		string LOCATION = "Insert(PagesRow value)";
		try
		{
			DataAccessLocator.GetPagesCollection().Insert(value);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public bool DeleteByPrimaryKey(int pageId)
	{
		string LOCATION = "DeleteByPrimaryKey(int pageId)";
		try
		{
			return DataAccessLocator.GetPagesCollection().DeleteByPrimaryKey(pageId);
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
			return DataAccessLocator.GetPagesCollection().Delete(whereSql);
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
			return DataAccessLocator.GetPagesCollection().GetAllAsDataTable();
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
			return DataAccessLocator.GetPagesCollection().GetAsDataTable(whereSql, orderBySql);
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
			return DataAccessLocator.GetPagesCollection().GetAsDataTable(whereSql, orderBySql, startIndex, length, ref totalRecordCount);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}



}


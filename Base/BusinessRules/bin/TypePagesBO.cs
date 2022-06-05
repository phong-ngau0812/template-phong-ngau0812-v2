// <fileinfo name="TypePagesBO.cs">
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
/// The base class for <see cref="TypePagesCollection"/>. Provides methods 
/// for common database table operations. 
/// </summary>
/// <remarks>
/// Do not change this source code. Update the <see cref="TypePagesCollection"/>
/// class if you need to add or change some functionality.
/// </remarks>
public  class TypePagesBO
	: BusinessRulesBase
{



	public TypePagesRow GetByPrimaryKey(int typePageId)
	{
		string LOCATION = "GetByPrimaryKey(int typePageId)";
		try
		{
			return DataAccessLocator.GetTypePagesCollection().GetByPrimaryKey(typePageId);		
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}



	public bool Exist(int typePageId)
	{
		string LOCATION = "Exist(int typePageId)";
		try
		{
			return DataAccessLocator.GetTypePagesCollection().Exist(typePageId);
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
			DataAccessLocator.GetTypePagesCollection().Update(table, true);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public bool Update(TypePagesRow value)
	{
		string LOCATION = "Update(TypePagesRow value)";
		try
		{
			return DataAccessLocator.GetTypePagesCollection().Update(value);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public void Insert(TypePagesRow value)
	{
		string LOCATION = "Insert(TypePagesRow value)";
		try
		{
			DataAccessLocator.GetTypePagesCollection().Insert(value);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}

	public bool DeleteByPrimaryKey(int typePageId)
	{
		string LOCATION = "DeleteByPrimaryKey(int typePageId)";
		try
		{
			return DataAccessLocator.GetTypePagesCollection().DeleteByPrimaryKey(typePageId);
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
			return DataAccessLocator.GetTypePagesCollection().Delete(whereSql);
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
			return DataAccessLocator.GetTypePagesCollection().GetAllAsDataTable();
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
			return DataAccessLocator.GetTypePagesCollection().GetAsDataTable(whereSql, orderBySql);
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
			return DataAccessLocator.GetTypePagesCollection().GetAsDataTable(whereSql, orderBySql, startIndex, length, ref totalRecordCount);
		}
		catch(Exception ex)
		{
			throw new Exceptions.BusinessException(LOCATION, ex);
		}
	}



}


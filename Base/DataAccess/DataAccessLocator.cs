
// <fileinfo name="DataAccessLocator.cs">
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



/// <summary>
/// The base class for the <see cref="GenCode2"/> class that 
/// represents a connection to the <c>GenCode2</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the GenCode2 class
/// if you need to add or change some functionality.
/// </remarks>
public class DataAccessLocator
		: Base.DataAccessLocatorBase	
{
	/// <summary>
	/// Initializes a new instance of the <see cref="DataAccessLocator"/> 
	/// class and opens the database connection.
	/// </summary>
	public DataAccessLocator() : base()
	{
	}


	// Table fields
		/// <summary>
		/// Gets an object that represents the <c>User</c> table.
		/// </summary>
		/// <value>A reference to the <see cref="UserCollection"/> object.</value>
   		public static DbObj.UserCollection GetUserCollection()
		{
            		return new DbObj.UserCollection();
		}


}


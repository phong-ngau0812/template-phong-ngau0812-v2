
// <fileinfo name="BusinessRulesLocator.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			Do not change this source code manually. Changes to this file may 
//			cause incorrect behavior and will be lost if the code is regenerated.
//		</remarks>
//		<generator rewritefile="True" infourl="http://www.SharpPower.com">RapTier</generator>
// </fileinfo>


using System;
using System.Data;
using DbObj;

/// <summary>
/// The base class for the <see cref="GenCode2"/> class that 
/// represents a connection to the <c>GenCode2</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the GenCode2 class
/// if you need to add or change some functionality.
/// </remarks>
public abstract class BusinessRulesLocator
{

	// Table fields
	// UserBO 
	public static UserBO GetUserBO ()
	{
        	return new UserBO();
	}
	


}


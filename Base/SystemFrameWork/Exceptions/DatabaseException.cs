
// <fileinfo name="Exceptions/DatabaseException.cs">
//		<copyright>
//			All rights reserved.
//		</copyright>
//		<remarks>
//			Do not change this source code manually. Changes to this file may 
//			cause incorrect behavior and will be lost if the code is regenerated.
//		</remarks>
// </fileinfo>

using System;

/// <summary>
/// The base class for the <see cref="BusinessException"/> class that 
/// represents a connection to the <c>asiaticadb</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the BusinessException class
/// if you need to add or change some functionality.
/// </remarks>

namespace Exceptions
{

public class DatabaseException	
    : BaseException
{

	public DatabaseException() : base()
	{
	}

	public DatabaseException(string message) : base(message)
	{
	}

	public DatabaseException(string customMessage, Exception exception) : base(customMessage, exception)
	{
	}


}



}




// <fileinfo name="Exceptions/SystemException.cs">
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
/// The base class for the <see cref="SystemException"/> class that 
/// represents a connection to the <c>asiaticadb</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the SystemException class
/// if you need to add or change some functionality.
/// </remarks>

namespace Exceptions
{
public class SystemException	
    : BaseException
{

	public SystemException() : base()
	{
	}

	public SystemException(string message) : base(message)
	{
	}

	public SystemException(string customMessage, Exception exception) : base(customMessage, exception)
	{
	}


}


}


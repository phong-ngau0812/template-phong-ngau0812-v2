
// <fileinfo name="Exceptions/FunctionalException.cs">
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
/// The base class for the <see cref="FunctionalException"/> class that 
/// represents a connection to the <c>asiaticadb</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the FunctionalException class
/// if you need to add or change some functionality.
/// </remarks>
namespace Exceptions
{
public class FunctionalException	
    : BaseException
{

	public FunctionalException() : base()
	{
	}

	public FunctionalException(string message) : base(message)
	{
	}

	public FunctionalException(string customMessage, Exception exception) : base(customMessage, exception)
	{
	}


}


}





// <fileinfo name="Exceptions/BaseException.cs">
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
/// The base class for the <see cref="Exceptions"/> class that 
/// represents a connection to the <c>asiaticadb</c> database. 
/// </summary>
/// <remarks>
/// Do not change this source code. Modify the Exceptions class
/// if you need to add or change some functionality.
/// </remarks>

namespace Exceptions
{
public class BaseException
    : Exception
{
    	private String _location;
    	private ExceptionLevels _level = ExceptionLevels.Fatal;
    	private String _customMessage = "Database Exception";


	public string CustomMessage 
	{     
		get { return this.CustomMessage; }
		set { this._customMessage = value; }
	}

	public BaseException() : base()
	{
	}


	public BaseException(string message) : base(message)
	{
	}

	public BaseException(string customMessage, Exception exception) : base(customMessage, exception)
	{
		this.CustomMessage = customMessage;
	}

	public string Location 
	{
		get { return this._location; }
		set { this._location = value; }
	}

	public ExceptionLevels Level 
	{
		get { return this._level; }
		set { this._level = value; }
	}


}

}


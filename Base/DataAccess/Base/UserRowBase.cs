
// <fileinfo name="Base\UserRowBase.cs">
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

namespace Base
{

/// <summary>
/// The base class for <see cref="UserRow"/> that 
/// represents a record in the <c>User</c> table.
/// </summary>
/// <remarks>
/// Do not change this source code manually. Update the <see cref="UserRow"/>
/// class if you need to add or change some functionality.
/// </remarks>
public abstract class UserRowBase
{
	/// _user_ID
	private int _user_ID;
	private bool _user_IDNull = true;
	/// _userName
	private string _userName;
	private bool _userNameNull = true;
	/// _password
	private string _password;
	private bool _passwordNull = true;
	/// _fullName
	private string _fullName;
	private bool _fullNameNull = true;
	/// _avatar
	private string _avatar;
	private bool _avatarNull = true;
	/// _address
	private string _address;
	private bool _addressNull = true;
	/// _email
	private string _email;
	private bool _emailNull = true;
	/// _phone
	private string _phone;
	private bool _phoneNull = true;
	/// _position
	private string _position;
	private bool _positionNull = true;
	/// _createDate
	private System.DateTime _createDate;
	private bool _createDateNull = true;
	/// _modifyDate
	private System.DateTime _modifyDate;
	private bool _modifyDateNull = true;
	/// _createBy
	private int _createBy;
	private bool _createByNull = true;
	/// _modifyBy
	private int _modifyBy;
	private bool _modifyByNull = true;
	/// _status
	private int _status;
	private bool _statusNull = true;
	/// _sort
	private int _sort;
	private bool _sortNull = true;
	/// _birthDay
	private System.DateTime _birthDay;
	private bool _birthDayNull = true;
	/// _gender
	private int _gender;
	private bool _genderNull = true;


// Instance fields
	
	/// <summary>
	/// Initializes a new instance of the <see cref="UserRowBase"/> class.
	/// </summary>
	public UserRowBase():base()
	{
		// EMPTY
	}

		/// <summary>
		/// Gets or sets the <c>User_ID</c> column value.
		/// </summary>
		/// <value>The <c>User_ID</c> column value.</value>
	public int User_ID
	{
		get
		{
			if(IsUser_IDNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _user_ID;
		}
		set
		{
			_user_IDNull = false;
			_user_ID = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="User_ID"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsUser_IDNull
	{
		get
		{
			return _user_IDNull;
		}
		set
		{
			_user_IDNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>UserName</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>UserName</c> column value.</value>
	public string UserName
	{
		get
		{
			if(IsUserNameNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _userName;
		}
		set
		{
			_userNameNull = false;
			_userName = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="UserName"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsUserNameNull
	{
		get
		{
			return _userNameNull;
		}
		set
		{
			_userNameNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Password</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Password</c> column value.</value>
	public string Password
	{
		get
		{
			if(IsPasswordNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _password;
		}
		set
		{
			_passwordNull = false;
			_password = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Password"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsPasswordNull
	{
		get
		{
			return _passwordNull;
		}
		set
		{
			_passwordNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>FullName</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>FullName</c> column value.</value>
	public string FullName
	{
		get
		{
			if(IsFullNameNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _fullName;
		}
		set
		{
			_fullNameNull = false;
			_fullName = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="FullName"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsFullNameNull
	{
		get
		{
			return _fullNameNull;
		}
		set
		{
			_fullNameNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Avatar</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Avatar</c> column value.</value>
	public string Avatar
	{
		get
		{
			if(IsAvatarNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _avatar;
		}
		set
		{
			_avatarNull = false;
			_avatar = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Avatar"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsAvatarNull
	{
		get
		{
			return _avatarNull;
		}
		set
		{
			_avatarNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Address</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Address</c> column value.</value>
	public string Address
	{
		get
		{
			if(IsAddressNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _address;
		}
		set
		{
			_addressNull = false;
			_address = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Address"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsAddressNull
	{
		get
		{
			return _addressNull;
		}
		set
		{
			_addressNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Email</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Email</c> column value.</value>
	public string Email
	{
		get
		{
			if(IsEmailNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _email;
		}
		set
		{
			_emailNull = false;
			_email = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Email"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsEmailNull
	{
		get
		{
			return _emailNull;
		}
		set
		{
			_emailNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Phone</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Phone</c> column value.</value>
	public string Phone
	{
		get
		{
			if(IsPhoneNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _phone;
		}
		set
		{
			_phoneNull = false;
			_phone = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Phone"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsPhoneNull
	{
		get
		{
			return _phoneNull;
		}
		set
		{
			_phoneNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Position</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Position</c> column value.</value>
	public string Position
	{
		get
		{
			if(IsPositionNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _position;
		}
		set
		{
			_positionNull = false;
			_position = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Position"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsPositionNull
	{
		get
		{
			return _positionNull;
		}
		set
		{
			_positionNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>CreateDate</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>CreateDate</c> column value.</value>
	public System.DateTime CreateDate
	{
		get
		{
			if (IsCreateDateNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _createDate;
		}
		set
		{
			_createDateNull = false;
			_createDate = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="CreateDate"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsCreateDateNull
	{
		get
		{
			return _createDateNull;
		}
		set
		{
			_createDateNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>ModifyDate</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>ModifyDate</c> column value.</value>
	public System.DateTime ModifyDate
	{
		get
		{
			if (IsModifyDateNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _modifyDate;
		}
		set
		{
			_modifyDateNull = false;
			_modifyDate = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="ModifyDate"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsModifyDateNull
	{
		get
		{
			return _modifyDateNull;
		}
		set
		{
			_modifyDateNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>CreateBy</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>CreateBy</c> column value.</value>
	public int CreateBy
	{
		get
		{
			if (IsCreateByNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _createBy;
		}
		set
		{
			_createByNull = false;
			_createBy = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="CreateBy"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsCreateByNull
	{
		get
		{
			return _createByNull;
		}
		set
		{
			_createByNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>ModifyBy</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>ModifyBy</c> column value.</value>
	public int ModifyBy
	{
		get
		{
			if (IsModifyByNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _modifyBy;
		}
		set
		{
			_modifyByNull = false;
			_modifyBy = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="ModifyBy"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsModifyByNull
	{
		get
		{
			return _modifyByNull;
		}
		set
		{
			_modifyByNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Status</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Status</c> column value.</value>
	public int Status
	{
		get
		{
			if (IsStatusNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _status;
		}
		set
		{
			_statusNull = false;
			_status = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Status"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsStatusNull
	{
		get
		{
			return _statusNull;
		}
		set
		{
			_statusNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Sort</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Sort</c> column value.</value>
	public int Sort
	{
		get
		{
			if (IsSortNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _sort;
		}
		set
		{
			_sortNull = false;
			_sort = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Sort"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsSortNull
	{
		get
		{
			return _sortNull;
		}
		set
		{
			_sortNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>BirthDay</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>BirthDay</c> column value.</value>
	public System.DateTime BirthDay
	{
		get
		{
			if (IsBirthDayNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _birthDay;
		}
		set
		{
			_birthDayNull = false;
			_birthDay = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="BirthDay"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsBirthDayNull
	{
		get
		{
			return _birthDayNull;
		}
		set
		{
			_birthDayNull = value;
		}	
	}

		/// <summary>
		/// Gets or sets the <c>Gender</c> column value.
		/// This column is nullable.
		/// </summary>
		/// <value>The <c>Gender</c> column value.</value>
	public int Gender
	{
		get
		{
			if (IsGenderNull)
				throw new InvalidOperationException("Cannot get value because it is DBNull.");
			return _gender;
		}
		set
		{
			_genderNull = false;
			_gender = value;
		}
	}

	/// <summary>
	/// Indicates whether the <see cref="Gender"/>
	/// property value is null.
	/// </summary>
	/// <value>true if the property value is null, otherwise false.</value>
	public bool IsGenderNull
	{
		get
		{
			return _genderNull;
		}
		set
		{
			_genderNull = value;
		}	
	}

	/// <summary>
	/// Returns the string representation of this instance.
	/// </summary>
	/// <returns>The string representation of this instance.</returns>
	public override string ToString()
	{
		System.Text.StringBuilder dynStr = new System.Text.StringBuilder(this.GetType().Name);
		dynStr.Append(":");
		// User_ID
		dynStr.Append("  User_ID=");
		if( IsUser_IDNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.User_ID);
		

		// UserName
		dynStr.Append("  UserName=");
		if( IsUserNameNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.UserName);
		

		// Password
		dynStr.Append("  Password=");
		if( IsPasswordNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.Password);
		

		// FullName
		dynStr.Append("  FullName=");
		if( IsFullNameNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.FullName);
		

		// Avatar
		dynStr.Append("  Avatar=");
		if( IsAvatarNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.Avatar);
		

		// Address
		dynStr.Append("  Address=");
		if( IsAddressNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.Address);
		

		// Email
		dynStr.Append("  Email=");
		if( IsEmailNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.Email);
		

		// Phone
		dynStr.Append("  Phone=");
		if( IsPhoneNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.Phone);
		

		// Position
		dynStr.Append("  Position=");
		if( IsPositionNull)
			dynStr.Append("<NULL>");
		else
			dynStr.Append(this.Position);
		

		// CreateDate
		dynStr.Append("  CreateDate=");
		if( IsCreateDateNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.CreateDate);
		// ModifyDate
		dynStr.Append("  ModifyDate=");
		if( IsModifyDateNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.ModifyDate);
		// CreateBy
		dynStr.Append("  CreateBy=");
		if( IsCreateByNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.CreateBy);
		// ModifyBy
		dynStr.Append("  ModifyBy=");
		if( IsModifyByNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.ModifyBy);
		// Status
		dynStr.Append("  Status=");
		if( IsStatusNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.Status);
		// Sort
		dynStr.Append("  Sort=");
		if( IsSortNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.Sort);
		// BirthDay
		dynStr.Append("  BirthDay=");
		if( IsBirthDayNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.BirthDay);
		// Gender
		dynStr.Append("  Gender=");
		if( IsGenderNull)
		{
			dynStr.Append("<NULL>");
		}
		else
			dynStr.Append(this.Gender);
		return dynStr.ToString();
	}
}
}





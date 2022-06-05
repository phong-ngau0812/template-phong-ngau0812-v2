﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using SystemFrameWork;

/// <summary>
/// Summary description for Login
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Login : System.Web.Services.WebService
{

    public Login()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [WebMethod(EnableSession = true)]
    public string checklogin(string username, string password)
    {
        string result = string.Empty;
        DataTable dtResult = new DataTable();
        string strWhere = string.Empty;
        string strOrder = string.Empty;
        try
        {
            strWhere += " [Status] = 1 AND [UserName] = '" + username.Trim().Replace("'", "").Replace("\"", "") + "'";
            dtResult = BusinessRulesLocator.GetUserBO().GetAsDataTable(strWhere, strOrder);
            if (dtResult.Rows.Count==0)
            {
                result = "0";
                //Không tồn tại tài khoản hoặc chưa được kích hoạt
            }
            else
            {
                strWhere = "[Status] = 1 AND [UserName] = '" + username.Trim().Replace("'", "").Replace("\"", "") + "' AND [Password] = '" + Common.MD5Decrypt(password) + "'";
                dtResult = BusinessRulesLocator.GetUserBO().GetAsDataTable(strWhere, strOrder);
                if (dtResult != null)
                {
                    if (dtResult.Rows.Count > 0)
                    {
                        HttpContext.Current.Session["SessionUserID"] = dtResult.Rows[0]["User_ID"].ToString();
                        HttpContext.Current.Session["SessionUserName"] = username.Trim().Replace("'", "").Replace("\"", "");
                        HttpContext.Current.Session["SessionFullName"] = dtResult.Rows[0]["FullName"].ToString();
                        result = "1";
                        //Login ok
                    }
                    else
                    {
                        strWhere = " [UserName] = '" + username.Trim().Replace("'", "").Replace("\"", "") + "' AND [Password] = '" + Common.MD5Decrypt(password) + "'";
                        dtResult = BusinessRulesLocator.GetUserBO().GetAsDataTable(strWhere, strOrder);
                        if (dtResult != null)
                        {
                            if (dtResult.Rows.Count > 0)
                            {
                                result = "-2";
                                //Login ok
                            }
                            else
                            {
                                result = "-1";
                            }
                        }
                     
                        //Sai MK
                    }
                }
                //if (user.IsLockedOut)
                //{
                //    DateTime locktime = Membership.GetUser(username).LastLockoutDate;
                //    if (DateTime.Now <= locktime.AddMinutes(5))
                //    {
                //        result = locktime.AddMinutes(5).ToString("dd'/'MM'/'yyyy HH:mm:ss");
                //        MyActionPermission.WriteLogSystemLogin(0, "Login fail: username lock 10 password - " + username + " - " + MyUser.GetUser_IDByUserName(username), username);
                //    }
                //    else
                //    {
                //        user.UnlockUser();
                //        if (Membership.ValidateUser(username, password))
                //        {
                //            FormsAuthentication.SetAuthCookie(username, true);
                //            result = "1";
                //            MyActionPermission.WriteLogSystemLogin(0, "Login success - " + username + " - " + MyUser.GetUser_IDByUserName(username), username);
                //        }
                //        else
                //        {
                //            result = "-1";
                //            MyActionPermission.WriteLogSystemLogin(0, "Login fail: wrong password - " + username + " - " + MyUser.GetUser_IDByUserName(username), username);
                //            //Sai mật khẩu
                //        }
                //    }
                //}
                //else
                //{

                //    if (!user.IsApproved)
                //    {
                //        result = "-2";
                //        //Tài khoản chưa kích hoạt hoặc tạm thời bị khóa
                //        MyActionPermission.WriteLogSystemLogin(0, "Login fail: username lock - " + username + " - " + MyUser.GetUser_IDByUserName(username), username);
                //    }
                //    else
                //    {

                //        if (Membership.ValidateUser(username, password))
                //        {
                //            FormsAuthentication.SetAuthCookie(username, true);
                //            result = "1";
                //            MyActionPermission.WriteLogSystemLogin(0, "Login success - " + username + " - " + MyUser.GetUser_IDByUserName(username), username);
                //        }
                //        else
                //        {
                //            result = "-1";
                //            MyActionPermission.WriteLogSystemLogin(0, "Login fail: wrong password - " + username + " - " + MyUser.GetUser_IDByUserName(username), username);
                //            //Sai mật khẩu
                //        }
                //    }
                //}

            }

        }
        catch (Exception ex)
        {
            Log.writeLog("checklogin", ex.ToString());
        }
        return result;
    }

}

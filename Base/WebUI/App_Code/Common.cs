using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.SessionState;
using System.Text.RegularExpressions;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using DbObj;
using System.IO;
using System.Drawing;
using System.Reflection;
using SystemFrameWork;
using System.Net.Mail;
using System.Net;
using EvoPdf.HtmlToPdf;
using Geotargeting;
using System.Resources;
using System.Globalization;
using System.Threading;
using System.Xml;
using evointernal;

/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
    public const string AST_UserName = "HLS_UserName";
    public Common()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    public static string ChangeUrl(string input)
    {
        if (input == null)
        {
            return null;
        }
        input = input.Replace(",", "");
        input = input.Replace(".", "");
        input = input.Replace("'", "");
        input = input.Replace("[", "");
        input = input.Replace("]", "");
        input = input.Replace("~", "");
        input = input.Replace("\"", "");
        input = input.Replace("(", "");
        input = input.Replace(")", "");
        input = input.Replace("!", "");
        input = input.Replace(":", "");
        input = input.Replace("+", "");
        input = input.Replace("/", "");
        input = input.Replace("*", "");
        input = input.Replace("&", "");
        input = input.Replace("^", "");
        input = input.Replace("%", "");
        input = input.Replace("$", "");
        input = input.Replace("#", "");
        input = input.Replace("@", "");
        input = input.Replace("`", "");
        input = input.Replace("’", "");
        input = input.Replace("?", "");
        input = input.Replace(" ", "-");
        input = input.Replace("--", "-");
        input = input.Replace("=", "-");

        Regex rga = new Regex("[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬ]");
        Regex rgd = new Regex("[đĐ]");
        Regex rge = new Regex("[èÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆ]");
        Regex rgi = new Regex("[ìÌỉỈĩĨíÍịỊîÎ]");
        Regex rgo = new Regex("[òÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢ]");
        Regex rgu = new Regex("[ùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰ]");
        Regex rgy = new Regex("[ỳỲỷỶỹỸýÝỵỴ]");
        input = rga.Replace(input, "a");
        input = rgd.Replace(input, "d");
        input = rge.Replace(input, "e");
        input = rgi.Replace(input, "i");
        input = rgo.Replace(input, "o");
        input = rgu.Replace(input, "u");
        input = rgy.Replace(input, "y");
        return input.ToLower();
    }
    public static string CheckSubDomain(string input)
    {
        if (input == null)
        {
            return null;
        }
        input = input.Replace(" ", "");
        input = input.Replace(".", "");
        input = input.Replace("=", "");
        input = input.Replace(",", "");
        input = input.Replace("'", "");
        input = input.Replace("[", "");
        input = input.Replace("]", "");
        input = input.Replace("~", "");
        input = input.Replace("\"", "");
        input = input.Replace("(", "");
        input = input.Replace(")", "");
        input = input.Replace("!", "");
        input = input.Replace(":", "");
        input = input.Replace("+", "");
        input = input.Replace("/", "");
        input = input.Replace("*", "");
        input = input.Replace("&", "");
        input = input.Replace("^", "");
        input = input.Replace("%", "");
        input = input.Replace("$", "");
        input = input.Replace("#", "");
        input = input.Replace("@", "");
        input = input.Replace("`", "");
        input = input.Replace("?", "");
        Regex rga = new Regex("[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬ]");
        Regex rgd = new Regex("[đĐ]");
        Regex rge = new Regex("[èÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆ]");
        Regex rgi = new Regex("[ìÌỉỈĩĨíÍịỊ]");
        Regex rgo = new Regex("[òÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢ]");
        Regex rgu = new Regex("[ùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰ]");
        Regex rgy = new Regex("[ỳỲỷỶỹỸýÝỵỴ]");
        input = rga.Replace(input, "a");
        input = rgd.Replace(input, "d");
        input = rge.Replace(input, "e");
        input = rgi.Replace(input, "i");
        input = rgo.Replace(input, "o");
        input = rgu.Replace(input, "u");
        input = rgy.Replace(input, "y");
        return input.ToLower();
    }
    public static string RemoveSignature(string input)
    {
        if (input == null)
        {
            return null;
        }
        input = input.Replace(" ", "");
        input = input.Replace("=", "");
        input = input.Replace(",", "");
        input = input.Replace("'", "");
        input = input.Replace("[", "");
        input = input.Replace("]", "");
        input = input.Replace("~", "");
        //input = input.Replace("-", "");
        input = input.Replace("\"", "");
        input = input.Replace("(", "");
        input = input.Replace(")", "");
        input = input.Replace("!", "");
        input = input.Replace(":", "");
        input = input.Replace("+", "");
        input = input.Replace("/", "");
        input = input.Replace("*", "");
        input = input.Replace("&", "");
        input = input.Replace("^", "");
        input = input.Replace("%", "");
        input = input.Replace("$", "");
        input = input.Replace("#", "");
        input = input.Replace("@", "");
        input = input.Replace("`", "");
        input = input.Replace("?", "");
        Regex rga = new Regex("[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬ]");
        Regex rgd = new Regex("[đĐ]");
        Regex rge = new Regex("[èÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆ]");
        Regex rgi = new Regex("[ìÌỉỈĩĨíÍịỊ]");
        Regex rgo = new Regex("[òÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢ]");
        Regex rgu = new Regex("[ùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰ]");
        Regex rgy = new Regex("[ỳỲỷỶỹỸýÝỵỴ]");
        input = rga.Replace(input, "a");
        input = rgd.Replace(input, "d");
        input = rge.Replace(input, "e");
        input = rgi.Replace(input, "i");
        input = rgo.Replace(input, "o");
        input = rgu.Replace(input, "u");
        input = rgy.Replace(input, "y");
        return input.ToLower();
    }
    public static string RemoveFont(string input)
    {
        if (input == null)
        {
            return null;
        }
        input = input.Replace("'", "");
        Regex rga = new Regex("[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬ]");
        Regex rgd = new Regex("[đĐ]");
        Regex rge = new Regex("[èÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆ]");
        Regex rgi = new Regex("[ìÌỉỈĩĨíÍịỊ]");
        Regex rgo = new Regex("[òÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢ]");
        Regex rgu = new Regex("[ùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰ]");
        Regex rgy = new Regex("[ỳỲỷỶỹỸýÝỵỴ]");
        input = rga.Replace(input, "a");
        input = rgd.Replace(input, "d");
        input = rge.Replace(input, "e");
        input = rgi.Replace(input, "i");
        input = rgo.Replace(input, "o");
        input = rgu.Replace(input, "u");
        input = rgy.Replace(input, "y");
        return input;
    }
    public static void BuidNoRecord(DataTable dtResult, WizardGridView.WizardGridView grv)
    {
        try
        {
            DataRow dtRow = dtResult.NewRow();
            dtRow["ID"] = 0;
            dtResult.Rows.Add(dtRow);
            grv.DataSource = dtResult;
            grv.DataBind();
            int columnCount = grv.Rows[0].Cells.Count;
            grv.Rows[0].Cells.Clear();
            grv.Rows[0].Cells.Add(new TableCell());
            grv.Rows[0].Cells[0].ColumnSpan = columnCount;
            grv.Rows[0].Cells[0].Text = "The data is being updated!";
            grv.Rows[0].Cells[0].ForeColor = System.Drawing.Color.Red;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static void BuidNoRecordEmail(DataTable dtResult, WizardGridView.WizardGridView grv)
    {
        try
        {
            DataRow dtRow = dtResult.NewRow();
            dtRow["Email"] = "";
            dtRow["Lang"] = "";
            dtResult.Rows.Add(dtRow);
            grv.DataSource = dtResult;
            grv.DataBind();
            int columnCount = grv.Rows[0].Cells.Count;
            grv.Rows[0].Cells.Clear();
            grv.Rows[0].Cells.Add(new TableCell());
            grv.Rows[0].Cells[0].ColumnSpan = columnCount;
            grv.Rows[0].Cells[0].Text = "The data is being updated!";
            grv.Rows[0].Cells[0].ForeColor = System.Drawing.Color.Red;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static string MD5Decrypt(string input)
    {
        string result = "";
        MD5 md = MD5CryptoServiceProvider.Create();
        byte[] hash;
        ASCIIEncoding enc = new ASCIIEncoding();
        byte[] buffer = enc.GetBytes(input);
        hash = md.ComputeHash(buffer);
        foreach (byte b in hash)
        {
            result += b.ToString("x2");
        }
        return result;
    }
    private static int RandomNumber(int min, int max)
    {
        Random random = new Random();
        return random.Next(min, max);
    }
    private static string RandomString(int size, bool lowerCase)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            builder.Append(ch);
        }
        if (lowerCase)
            return builder.ToString().ToLower();
        return builder.ToString();
    }
    public static string GetPassword()
    {
        StringBuilder builder = new StringBuilder();
        builder.Append(RandomString(4, true));
        builder.Append(RandomNumber(1000, 9999));
        builder.Append(RandomString(2, false));
        return builder.ToString();
    }

    public static string GetVisitor(string strIPAddress)
    {
        string strVisitorCountry = string.Empty;
        try
        {
            if (strIPAddress == "" || strIPAddress == null)
                strIPAddress = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

            Tools.GetLocation.IVisitorsGeographicalLocation _objLocation;
            _objLocation = new Tools.GetLocation.ClsVisitorsGeographicalLocation();
            DataTable _objDataTable = _objLocation.GetLocation(strIPAddress);

            if (_objDataTable != null)
            {
                if (_objDataTable.Rows.Count > 0)
                {
                    strVisitorCountry =
                                "City: "
                                + Convert.ToString(_objDataTable.Rows[0]["city"])
                                + ", Region: "
                                + Convert.ToString(_objDataTable.Rows[0]["regionName"])
                                + ", Country: "
                                + Convert.ToString(_objDataTable.Rows[0]["countryName"]);
                }
                else
                {
                    strVisitorCountry = null;
                }
            }
        }
        catch (Exception ex)
        {
            Log.writeLog(ex.ToString(), "GetVisitor");
        }
        return strVisitorCountry;
    }
    public static string GetCountryNameByIP(string ip)
    {
        string result = string.Empty;
        try
        {

            string FullDBPath = System.Web.HttpContext.Current.Server.MapPath("~/App_Data/GeoLiteCity.dat");
            LookupService ls = new LookupService(FullDBPath, LookupService.GEOIP_STANDARD);
            if (!string.IsNullOrEmpty(ip))
            {
                Location local = ls.getLocation(ip.Trim());
                result = local.countryName;

            }
        }
        catch (Exception ex)
        {
            //Log.writeLog("GetCountryNameByIP", ex.ToString());
        }
        return result;
    }
    public static string GetRegionNameByIP(string ip)
    {
        string result = string.Empty;
        try
        {

            string FullDBPath = System.Web.HttpContext.Current.Server.MapPath("~/App_Data/GeoLiteCity.dat");
            LookupService ls = new LookupService(FullDBPath, LookupService.GEOIP_STANDARD);
            if (!string.IsNullOrEmpty(ip))
            {
                Location local = ls.getLocation(ip.Trim());
                result = local.region;

            }
        }
        catch (Exception ex)
        {
            //Log.writeLog("GetCountryNameByIP", ex.ToString());
        }
        return result;
    }
    public static string GetProvinceNameByIP(string ip)
    {
        string result = string.Empty;
        try
        {

            string FullDBPath = System.Web.HttpContext.Current.Server.MapPath("~/App_Data/GeoLiteCity.dat");
            LookupService ls = new LookupService(FullDBPath, LookupService.GEOIP_STANDARD);
            if (!string.IsNullOrEmpty(ip))
            {
                Location local = ls.getLocation(ip.Trim());
                result = local.city;
            }
        }
        catch (Exception ex)
        {
            //Log.writeLog("GetCountryNameByIP", ex.ToString());
        }
        return result;
    }

    public static string GetLocationDe()
    {
        string strResult = string.Empty;
        try
        {
            string IpAddress = string.Empty;
            //string CountryName = string.Empty;
            //string Region = string.Empty;
            //string City = string.Empty;
            string location = string.Empty;
            try
            {
                IpAddress = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
                //CountryName = GetCountryNameByIP(IpAddress);
                //Region = GetRegionNameByIP(IpAddress);
                //City = GetProvinceNameByIP(IpAddress);
                //location = GetVisitor(IpAddress);
                strResult += "<li style='color:red'><strong>Standort: </strong>" + location + " (IP: " + IpAddress + ")</li>";
            }
            catch (Exception ex)
            {
                strResult += "<li style='color:red'><strong>Standort: </strong> (IP: " + IpAddress + ")</li>";
            }
            DateTime current = DateTime.Now;
            DateTime currVietnam = current.AddHours(5);
            strResult += "<li style='color:red'><strong>Absendedatum: </strong>" + current.ToString() + " (Deutsch) - " + currVietnam.ToString(new CultureInfo("vi-VN")) + " (Vietnam)</li>";
        }
        catch (Exception ex)
        {
            Log.writeLog(ex.ToString(), "GetLocation");
        }
        return strResult;
    }
    //public static bool SendMailContactPaxToPax(string strTo, string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, _tblConfigRow.DisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        //_mailMessage.CC.Add(new MailAddress(strCc, strDisplayName));

    //        if (!string.IsNullOrEmpty(strTo))
    //        {
    //            string[] MailTo = strTo.Split(';');
    //            foreach (string emailaddress in MailTo)
    //            {
    //                // Add MailTo to MailAddress
    //                _mailMessage.To.Add(new MailAddress(emailaddress.Trim(), strDisplayName));
    //                // Insert MailTo to DB
    //            }
    //        }

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailContactToPax(string strTo, string strDisplayName, string strSubject, string strBody, ConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, _tblConfigRow.DisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        if (!string.IsNullOrEmpty(strTo))
    //        {
    //            string[] MailTo = strTo.Split(';');
    //            foreach (string emailaddress in MailTo)
    //            {
    //                // Add MailTo to MailAddress
    //                _mailMessage.To.Add(new MailAddress(emailaddress.Trim(), strDisplayName));
    //                // Insert MailTo to DB
    //            }
    //        }

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailContactToInfo(string strDisplayName, string strSubject, string strBody, ConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, strDisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message

    //        // Add MailTo to MailAddress
    //        _mailMessage.To.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailBrochureToInfo(string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, strDisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        _mailMessage.CC.Add(new MailAddress("deutschland@asiatica.com", strDisplayName));

    //        // Add MailTo to MailAddress
    //        _mailMessage.To.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailToPax(string strTo, string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, _tblConfigRow.DisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        if (!string.IsNullOrEmpty(strTo))
    //        {
    //            string[] MailTo = strTo.Split(';');
    //            foreach (string emailaddress in MailTo)
    //            {
    //                // Add MailTo to MailAddress
    //                _mailMessage.To.Add(new MailAddress(emailaddress.Trim(), strDisplayName));
    //                // Insert MailTo to DB
    //            }
    //        }

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailPaxToSaleInfo(string strSales, string strDisplayNameSale, string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, strDisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        _mailMessage.CC.Add(new MailAddress(strSales, strDisplayNameSale));
    //        // Add MailTo to MailAddress
    //        _mailMessage.To.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailToInfo(string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        _mailMessage.From = new MailAddress(_tblConfigRow.EmailAddress, strDisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        // Add MailTo to MailAddress
    //        _mailMessage.To.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(_tblConfigRow.EmailAddress, _tblConfigRow.Password);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailToPaxOfPress(string strTo, string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow, string strDisplayFrom, string Cc, string pass)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        _mailMessage.From = new MailAddress(Cc, strDisplayFrom);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        if (!string.IsNullOrEmpty(strTo))
    //        {
    //            string[] MailTo = strTo.Split(';');
    //            foreach (string emailaddress in MailTo)
    //            {
    //                // Add MailTo to MailAddress
    //                _mailMessage.To.Add(new MailAddress(emailaddress.Trim(), strDisplayName));
    //                // Insert MailTo to DB
    //            }
    //        }

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(Cc, pass);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMailToPaxOfPress");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMailToPaxOfPress");
    //        return false;
    //    }
    //}

    //public static bool SendMailToInfoOfPress(string strDisplayName, string strSubject, string strBody, tblConfigRow _tblConfigRow, string Cc, string pass)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        _mailMessage.From = new MailAddress(Cc, strDisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        // Add MailTo to MailAddress
    //        _mailMessage.To.Add(new MailAddress(Cc, strDisplayName));

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(Cc, pass);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailContestToPax(string strTo, string strDisplayName, string strSubject, string strBody, string email, string pass, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(email, _tblConfigRow.DisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message
    //        if (!string.IsNullOrEmpty(strTo))
    //        {
    //            string[] MailTo = strTo.Split(';');
    //            foreach (string emailaddress in MailTo)
    //            {
    //                // Add MailTo to MailAddress
    //                _mailMessage.To.Add(new MailAddress(emailaddress.Trim(), strDisplayName));
    //                // Insert MailTo to DB
    //            }
    //        }

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(email, pass);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static bool SendMailContestToInfo(string strDisplayName, string strSubject, string strBody, string email, string pass, tblConfigRow _tblConfigRow)
    //{
    //    bool IsBool = false;
    //    try
    //    {
    //        MailMessage _mailMessage = new MailMessage();
    //        _mailMessage.IsBodyHtml = true;
    //        _mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        _mailMessage.Body = HttpContext.Current.Server.HtmlDecode(strBody);
    //        _mailMessage.Subject = strSubject;
    //        _mailMessage.Priority = MailPriority.Normal;

    //        // Set the From address of the mail message
    //        _mailMessage.From = new MailAddress(email, strDisplayName);
    //        // Set the Bcc address of the mail message
    //        //_mailMessage.Bcc.Add(new MailAddress(_tblConfigRow.EmailAddress, strDisplayName));
    //        // Set the Cc address of the mail message

    //        // Add MailTo to MailAddress
    //        _mailMessage.To.Add(new MailAddress(email, strDisplayName));

    //        try
    //        {
    //            SmtpClient mailSer = new SmtpClient();
    //            NetworkCredential SMTPUserInfo = new NetworkCredential(email, pass);
    //            mailSer.UseDefaultCredentials = true;
    //            mailSer.Credentials = SMTPUserInfo;
    //            mailSer.Host = _tblConfigRow.SMTPServer;
    //            mailSer.Port = _tblConfigRow.SMTPPort;
    //            mailSer.EnableSsl = _tblConfigRow.IsSSL;
    //            mailSer.Send(_mailMessage);
    //            IsBool = true;
    //        }
    //        catch (Exception ex)
    //        {
    //            Log.writeLog(ex.ToString(), "SendMail");
    //            IsBool = false;
    //        }
    //        return IsBool;
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "SendMail");
    //        return false;
    //    }
    //}

    //public static string CheckBannerHomeImage(string img)
    //{
    //    string strPath = string.Empty;
    //    try
    //    {
    //        string PhysicalPath = CommonBO.GetBannerHomeFolderPhysicalPath.Replace("/", "\\");
    //        string HomePath = CommonBO.GetBannerHomeFolderHomePath.Replace("\\", "/");

    //        if (!PhysicalPath.EndsWith("\\"))
    //            PhysicalPath += "\\";
    //        if (!HomePath.EndsWith("/"))
    //            HomePath += "/";

    //        if (File.Exists(PhysicalPath + img))
    //            strPath = HomePath + img;

    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "CheckBannerHomeImage");
    //    }
    //    return strPath;
    //}

    //public static string GetImagePrimaryOfTour(string _ID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "TourID = " + _ID + " And IsPrimary=1";
    //        dtResult = BusinessRulesLocator.GettblTourGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetTourFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetTourFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";

    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();

    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImageListOfTour");
    //    }
    //    return imagePath;
    //}

    //public static string GetImageBannerOfTour(string _ID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "TourID = " + _ID + " And IsBanner=1";
    //        dtResult = BusinessRulesLocator.GettblTourGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetTourFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetTourFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";

    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();

    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImageBannerOfTour");
    //    }
    //    return imagePath;
    //}

    //public static string GetImageMapOfTour(string _ID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "TourID = " + _ID + " And IsMap=1";
    //        dtResult = BusinessRulesLocator.GettblTourGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetTourFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetTourFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";

    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();

    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImageMapOfTour");
    //    }
    //    return imagePath;
    //}

    //public static string GetImagePrimaryOfAttractions(string AttID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "AttractionsID = " + AttID + " And IsList=1";
    //        dtResult = BusinessRulesLocator.GettblAttractionsGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetAttractionsFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetAttractionsFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";
    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();
    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImagePrimaryOfAttractions");
    //    }
    //    return imagePath;
    //}

    //public static string GetImageBannerOfAttractions(string AttID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "AttractionsID = " + AttID + " And IsBanner=1";
    //        dtResult = BusinessRulesLocator.GettblAttractionsGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetAttractionsFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetAttractionsFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";
    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();
    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImageBannerOfAttractions");
    //    }
    //    return imagePath;
    //}

    //public static string GetImagePrimaryOfTestimonial(string _ID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "TestimonialID = " + _ID + " And IsList=1";
    //        dtResult = BusinessRulesLocator.GettblTestimonialGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetTestimonialFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetTestimonialFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";

    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();

    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImagePrimaryOfTestimonial");
    //    }
    //    return imagePath;
    //}

    //public static string GetImageBannerOfTestimonial(string _ID)
    //{
    //    string imagePath = string.Empty;
    //    try
    //    {
    //        DataTable dtResult = new DataTable();
    //        string strWhere = "TestimonialID = " + _ID + " And IsBanner=1";
    //        dtResult = BusinessRulesLocator.GettblTestimonialGalleryBO().GetAsDataTable(strWhere, "");
    //        if (dtResult != null)
    //            if (dtResult.Rows.Count > 0)
    //            {
    //                string PhysycalPath = CommonBO.GetTestimonialFolderPhysicalPath.Replace("/", "\\");
    //                string HomePath = CommonBO.GetTestimonialFolderHomePath.Replace("\\", "/");
    //                if (!PhysycalPath.EndsWith("\\"))
    //                    PhysycalPath += "\\";
    //                if (!HomePath.EndsWith("/"))
    //                    HomePath += "/";

    //                if (File.Exists(PhysycalPath + dtResult.Rows[0]["ImageFile"].ToString()))
    //                    imagePath = HomePath + dtResult.Rows[0]["ImageFile"].ToString();

    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        Log.writeLog(ex.ToString(), "GetImageBannerOfTestimonial");
    //    }
    //    return imagePath;
    //}
    public static void ConvertURLToPDF(string url, string filename)
    {
        try
        {
            string urlToConvert = url;
            // Create the PDF converter. Optionally the HTML viewer width can
            // be specified as parameter
            // The default HTML viewer width is 1024 pixels.
            PdfConverter pdfConverter = new PdfConverter();
            // set the license key - required
            pdfConverter.LicenseKey = SystemConfig.GetLicenseKey();

            // set the converter options - optional

            pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4;
            pdfConverter.HtmlViewerWidth = 980;

            pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
            pdfConverter.PdfDocumentOptions.PdfPageOrientation = PdfPageOrientation.Portrait;

            // set if header and footer are shown in the PDF - optional - default is false 
            pdfConverter.PdfDocumentOptions.ShowHeader = false;
            pdfConverter.PdfDocumentOptions.ShowFooter = false;

            //set the PDF document margins - default margins are 0
            pdfConverter.PdfDocumentOptions.LeftMargin = 0;
            pdfConverter.PdfDocumentOptions.RightMargin = 0;
            pdfConverter.PdfDocumentOptions.TopMargin = 0;
            pdfConverter.PdfDocumentOptions.BottomMargin = 0;

            // set if the HTML content is resized if necessary to fit the PDF
            //    page width - default is true
            pdfConverter.PdfDocumentOptions.FitWidth = true;

            // set the embedded fonts option - optional - default is false
            pdfConverter.PdfDocumentOptions.EmbedFonts = true;
            // set the live HTTP links option - optional - default is true
            pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = true;

            // set if the JavaScript is enabled during conversion to a PDF - default is true
            pdfConverter.JavaScriptEnabled = false;

            // set if the images in PDF are compressed with JPEG to reduce the PDF document size - default is true
            pdfConverter.PdfDocumentOptions.JpegCompressionEnabled = true;

            // disable this behavior
            //pdfConverter.AvoidImageBreak = true;
            //pdfConverter.AvoidTextBreak = true;

            // enable auto-generated bookmarks for a specified list of HTML selectors
            pdfConverter.PdfBookmarkOptions.HtmlElementSelectors = new string[] { "H1", "H2" };

            // Performs the conversion and get the pdf document bytes that can

            //Cuong Edit
            //// be saved to a file or sent as a browser response
            byte[] pdfBytes = pdfConverter.GetPdfBytesFromUrl(urlToConvert);

            // send the PDF document as a response to the browser for download
            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
            response.Clear();
            response.AddHeader("Content-Type", "application/pdf");
            //if (radioAttachment.Checked)
            response.AddHeader("Content-Disposition", String.Format("inline; filename=" + filename + ".pdf; size={0}",
                                pdfBytes.Length.ToString()));
            response.BinaryWrite(pdfBytes);
            // Note: it is important to end the response, otherwise the ASP.NET
            // web page will render its content to PDF document stream
            //response.End();

            //Cuong Edit
        }
        catch (Exception ex)
        {
            Log.writeLog(ex.ToString(), "ConvertURLToPDF");
        }
    }
    public static string GetCurrentUrl()
    {
        string strDomain = string.Empty;
        try
        {
            string strtemp = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + VirtualPathUtility.ToAbsolute("~/");
            strDomain = strtemp.Substring(0, strtemp.Length - 1);
        }
        catch (Exception ex)
        {
            Log.writeLog(ex.ToString(), "GetCurrentUrl");
        }
        return strDomain;
    }
    public static string ConvertTitleDomain(string input)
    {
        if (input.Equals(string.Empty))
        {
            return string.Empty;
        }
        try
        {
            input = input.Trim();

            input = input.Replace("  ", "-");
            input = input.Replace(" ", "-");
            input = input.Replace("'", "");
            input = input.Replace("[", "");
            input = input.Replace("]", "");
            input = input.Replace("~", "");
            //input = input.Replace("-", "");
            input = input.Replace("(", "");
            input = input.Replace(")", "");
            input = input.Replace(":", "");

            input = input.Replace("!", "");
            input = input.Replace("@", "");
            input = input.Replace("#", "");
            input = input.Replace("$", "");
            input = input.Replace("%", "");
            input = input.Replace("^", "");
            input = input.Replace("&", "");
            input = input.Replace("*", "");
            input = input.Replace("_", "");
            input = input.Replace("+", "");
            input = input.Replace("|", "");
            input = input.Replace("\\", "");
            input = input.Replace("<", "");
            input = input.Replace(">", "");
            input = input.Replace("?", "");
            input = input.Replace(".", "");
            input = input.Replace(",", "");
            input = input.Replace("/", "");
            input = input.Replace("«", "");
            input = input.Replace("»", "");
            input = input.Replace("’", "");
            input = input.Replace("…", "");
            input = input.Replace("–", "");
            input = input.Replace("---", "-");
            input = input.Replace("--", "-");
            input = input.Replace("”", "");
            input = input.Replace("“", "");
            input = input.Replace("\"", "");
            input = input.Replace("ç", "c");

            Regex rga = new Regex("[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬ]");
            Regex rgd = new Regex("[đĐ]");
            Regex rge = new Regex("[èÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆë]");
            Regex rgi = new Regex("[ìÌỉỈĩĨíÍịỊîï]");
            Regex rgo = new Regex("[òÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢ]");
            Regex rgu = new Regex("[ùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰüû]");
            Regex rgy = new Regex("[ỳỲỷỶỹỸýÝỵỴ]");

            input = rga.Replace(input, "a");
            input = rgd.Replace(input, "d");
            input = rge.Replace(input, "e");
            input = rgi.Replace(input, "i");
            input = rgo.Replace(input, "o");
            input = rgu.Replace(input, "u");
            input = rgy.Replace(input, "y");

        }
        catch (Exception ex)
        {
            input = string.Empty;
            Log.writeLog(ex.ToString(), "ConvertTitleDomain");
        }
        return input.ToLower();
    }
    //public static int GenarateSort(string table)
    //{
    //    int Sort = 0;
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        string IDKey = table + "_ID";
    //        dt = BusinessRulesLocator.Conllection().GetAllList(" select top 1 * from " + table + " order by " + IDKey + " DESC");
    //        if (dt.Rows.Count == 1)
    //        {
    //            Sort = Convert.ToInt32(dt.Rows[0][IDKey].ToString());
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Sort = 0;
    //        Log.writeLog(ex.ToString(), "GenarateSort");
    //    }
    //    return Sort + 1;
    //}
    public static string GetSuccessMsg(string msg)
    {
        string html = "<div class='alert icon-custom-alert alert-outline-success alert-success-shadow' role='alert'>" +
                                        "<i class='mdi mdi-check-all alert-icon'></i>" +
                                        "<div class='alert-text'>" +
                                            "<strong> " + msg + "</strong>" +
                                        "</div> " +
                                         "<div class='alert-close'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" +
                                                "<span aria-hidden='true'><i class='mdi mdi-close text-danger'></i></span>" +
                                            "</button>" +
                                        "</div>" +
                                    "</div>";
        return html;

    }
    public static string CreateImgName(string fileName)
    {
        string imgName = string.Empty;
        try
        {
            //string[] name = fileName.Split('.');
            imgName = DateTime.Now.Day + "_" + DateTime.Now.Month + "_" + DateTime.Now.Year + "_" + DateTime.Now.Hour + "_" + DateTime.Now.Minute + "_" + DateTime.Now.Second + "_" + fileName;
        }
        catch (Exception ex)
        {
            Log.writeLog("CreateNameImages", ex.ToString());
        }
        return imgName;
    }
    public static string GetImg(object images)
    {
        string img = "/Backend/images/no-image-icon.png";

        if (!string.IsNullOrEmpty(images.ToString()))
        {
            img = "../../data/product/mainimages/original/" + images.ToString();
        }
        return img;
    }
    public static string GetImgNoURL(object images)
    {
        string img = "/Backend/images/no-image-icon.png";

        if (!string.IsNullOrEmpty(images.ToString()))
        {
            img = images.ToString();
        }
        return img;
    }
    public static string GetImgQR(object images)
    {
        string img = "../../img/icons/product-1.png";
        if (!string.IsNullOrEmpty(images.ToString()))
        {
            img = "../../data/product/mainimages/original/" + images.ToString();
        }
        return img;
    }
    public static string GenaratePaging(string content, string pageCurrent, string totalPage)
    {
        string html = "<div class=\"dataTables_paginate paging_simple_numbers right\" style='float:right;'><label class='header-title'>Trang " + pageCurrent + "/" + totalPage + "</label><br>";
        html += "<ul class=\"pagination\">";
        html += content;
        html += "</ul><div>";
        return html;
    }

    public static string FormatDateTimeToShortDate(DateTime TimeInput)
    {
        string Result = "";
        double DaySpan = (DateTime.Now - TimeInput).TotalDays;
        double HourSpan = (DateTime.Now - TimeInput).TotalHours;
        double MinuteSpan = (DateTime.Now - TimeInput).TotalMinutes;

        if (MinuteSpan < 1)
            return "Vừa xong";

        if (MinuteSpan < 60)
            return Math.Truncate(MinuteSpan) + " phút trước";

        if (MinuteSpan >= 60 && HourSpan < 24)
            return Math.Truncate(HourSpan) + " giờ trước";

        if (DaySpan < 2)
            return "Hôm qua";

        Result = String.Format("{0:dd/MM/yyyy}", TimeInput);
        return Result;
    }
    private static string[] ChuSo = new string[10] { " không", " một", " hai", " ba", " bốn", " năm", " sáu", " bẩy", " tám", " chín" };
    private static string[] Tien = new string[6] { "", " nghìn", " triệu", " tỷ", " nghìn tỷ", " triệu tỷ" };
    // Hàm đọc số thành chữ
    public static string DocTienBangChu(long SoTien, string strTail)
    {
        int lan, i;
        long so;
        string KetQua = "", tmp = "";
        int[] ViTri = new int[6];
        if (SoTien < 0) return "Số tiền âm !";
        if (SoTien == 0) return "Không đồng !";
        if (SoTien > 0)
        {
            so = SoTien;
        }
        else
        {
            so = -SoTien;
        }
        //Kiểm tra số quá lớn
        if (SoTien > 8999999999999999)
        {
            SoTien = 0;
            return "";
        }
        ViTri[5] = (int)(so / 1000000000000000);
        so = so - long.Parse(ViTri[5].ToString()) * 1000000000000000;
        ViTri[4] = (int)(so / 1000000000000);
        so = so - long.Parse(ViTri[4].ToString()) * +1000000000000;
        ViTri[3] = (int)(so / 1000000000);
        so = so - long.Parse(ViTri[3].ToString()) * 1000000000;
        ViTri[2] = (int)(so / 1000000);
        ViTri[1] = (int)((so % 1000000) / 1000);
        ViTri[0] = (int)(so % 1000);
        if (ViTri[5] > 0)
        {
            lan = 5;
        }
        else if (ViTri[4] > 0)
        {
            lan = 4;
        }
        else if (ViTri[3] > 0)
        {
            lan = 3;
        }
        else if (ViTri[2] > 0)
        {
            lan = 2;
        }
        else if (ViTri[1] > 0)
        {
            lan = 1;
        }
        else
        {
            lan = 0;
        }
        for (i = lan; i >= 0; i--)
        {
            tmp = DocSo3ChuSo(ViTri[i]);
            KetQua += tmp;
            if (ViTri[i] != 0) KetQua += Tien[i];
            if ((i > 0) && (!string.IsNullOrEmpty(tmp))) KetQua += ",";//&& (!string.IsNullOrEmpty(tmp))
        }
        if (KetQua.Substring(KetQua.Length - 1, 1) == ",") KetQua = KetQua.Substring(0, KetQua.Length - 1);
        KetQua = KetQua.Trim() + strTail;
        return KetQua.Substring(0, 1).ToUpper() + KetQua.Substring(1);
    }
    // Hàm đọc số có 3 chữ số
    private static string DocSo3ChuSo(int baso)
    {
        int tram, chuc, donvi;
        string KetQua = "";
        tram = (int)(baso / 100);
        chuc = (int)((baso % 100) / 10);
        donvi = baso % 10;
        if ((tram == 0) && (chuc == 0) && (donvi == 0)) return "";
        if (tram != 0)
        {
            KetQua += ChuSo[tram] + " trăm";
            if ((chuc == 0) && (donvi != 0)) KetQua += " linh";
        }
        if ((chuc != 0) && (chuc != 1))
        {
            KetQua += ChuSo[chuc] + " mươi";
            if ((chuc == 0) && (donvi != 0)) KetQua = KetQua + " linh";
        }
        if (chuc == 1) KetQua += " mười";
        switch (donvi)
        {
            case 1:
                if ((chuc != 0) && (chuc != 1))
                {
                    KetQua += " mốt";
                }
                else
                {
                    KetQua += ChuSo[donvi];
                }
                break;
            case 5:
                if (chuc == 0)
                {
                    KetQua += ChuSo[donvi];
                }
                else
                {
                    KetQua += " lăm";
                }
                break;
            default:
                if (donvi != 0)
                {
                    KetQua += ChuSo[donvi];
                }
                break;
        }
        return KetQua;
    }
    public static string Avatar(string avatar)
    {
        string Ava = "<img src='/Backend/images/no-image-icon.png' width='80px;'/>";
        if (!string.IsNullOrEmpty(avatar))
        {
            Ava = "<img src='" + avatar + "' width='80px;'/>";
        }
        return Ava;
    }
    public static string StripTagsRegex(string source)
    {
        return Regex.Replace(source, "<.*?>", string.Empty);
    }

    public static string CatChuoiHTML(string st, int dodai)
    {
        string st0 = StripTagsRegex(st);
        if (dodai >= st0.Length)
        {
            return st;
        }
        string st1 = "";
        try
        {
            st1 = st0.Trim().Substring(0, dodai);

            string[] strHoang = st1.Split(' ');
            string strResult = "";
            for (int i = 0; i < strHoang.Length - 1; i++)
            {
                strResult += strHoang[i] + " ";
            }
            return strResult + "...";
        }
        catch { return null; }

    }

    public static string GetStar(int Star)
    {
        string value = string.Empty;
        if (Star == 3)
        {
            value = "<div class=\"produtc-stars-rate text-warning form-text\"><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i></div>";
        }
        else if (Star == 4)
        {
            value = "<div class=\"produtc-stars-rate text-warning form-text\"><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i></div>";
        }
        else if (Star == 5)
        {
            value = "<div class=\"produtc-stars-rate text-warning form-text\"><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i><i class=\"fas fa-star\"></i></div>";
        }
        else if (Star == 6)
        {
            value = "<div class=\"produtc-stars-rate text-warning form-text\">Tiềm năng 5 sao</div>";
        }
        else
        {
            value = "";
        }
        return value;
    }
}


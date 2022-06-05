﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using System.Drawing;

public partial class UserControl_UploadImage : System.Web.UI.UserControl
{
    //Has the user browsed for a file?
    private bool pGotFile;
    //The file extension of the Posted File
    private string pFileExt;
    //The File itself
    private HttpPostedFile pFilePost;
    //Is the user required to upload an image?
    private bool pRequired;
    //The validation group that the Custom Validator belongs to on the page
    private string pVgroup;
    //Extensions you allow to be uploaded
    private string[] pFileTypeRange;
    //Boolean indicator to check if file extension is allowed
    private bool Ind = false;
    //The Image Minimum Width
    private int minWidth = 0;


    /*
     * Get and Sets for the above private variables.
     * */
    public bool GotFile
    {
        get { return pGotFile; }
    }
    public string FileExt
    {
        get { return pFileExt; }
    }
    public HttpPostedFile FilePost
    {
        get { return pFilePost; }
    }
    public bool Required
    {
        set { pRequired = value; }
    }
    public string Vgroup
    {
        set { pVgroup = value; }
    }
    public string FileTypeRange
    {
        set { pFileTypeRange = value.ToString().Split(','); }
    }
    public int MinWidth
    {
        set { minWidth = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //here we assign the validation group to the Custom Validator, which I have inefficiently named ErrorMsg
        ErrorMsg.ValidationGroup = pVgroup;
    }

    protected void ErrorMsg_ServerValidate(object source, ServerValidateEventArgs args)
    {
        try
        {
            if (FilUpl.HasFile)
            {
                pGotFile = true;
                pFileExt = GetExtension(FilUpl.PostedFile.FileName);
                pFilePost = FilUpl.PostedFile;

                if (IsValidImage(FilUpl.PostedFile.InputStream))
                {
                    foreach (string str in pFileTypeRange)
                    {
                        if (str.Equals(pFileExt))
                        {
                            Ind = true;
                            break;
                        }
                    }
                }

                if (!Ind)
                {
                    args.IsValid = false;
                    ErrorMsg.Text = "File format is not supported!";
                    //Stop the function
                    return;
                }

                if (minWidth > 0)
                {
                    //If you get here then you have set the MinWidth because you are expecting an image,
                    //and due to validation once at this stage in the code, we know that the user has uploaded
                    //some sort of image type
                    System.Drawing.Image CheckSize = System.Drawing.Image.FromStream(FilUpl.PostedFile.InputStream);
                    if (CheckSize.PhysicalDimension.Width < minWidth)
                    {
                        args.IsValid = false;
                        ErrorMsg.Text = "Width of the image must be greater than " + minWidth.ToString() + "px!";
                        //Stop the function
                        return;
                    }
                }
                Int64 size = FilUpl.PostedFile.ContentLength;
                if (size / 1024 > 5000)
                {
                    args.IsValid = false;
                    ErrorMsg.Text = "Size of the image must be smaller than 5 MB!";
                    //Stop the function
                    return;
                }
            }
            else
            {
                ErrorMsg.Text = "*";
            }
        }
        catch (Exception e)
        {
            e.Message.ToString();
        }
    }
    /// <summary>
    /// This returns the file extension.  It does not contain the preceding full stop
    /// so it would return jpg and NOT .jpg . Please adjust your coding accordingly.
    /// </summary>
    /// <param name="FileName">string</param>
    /// <returns>string: the file extension e.g. jpg</returns>
    private string GetExtension(string FileName)
    {
        string[] split = FileName.Split('.');
        string Extension = split[split.Length - 1];
        return Extension;
    }

    private bool IsValidImage(Stream FileName)
    {
        try
        {
            return IsValidImage1(FileName);
        }
        catch (Exception ex)
        {
            // Image.FromFile will throw this if file is invalid.
            // Don't ask me why.
            return false;
        }
    }

    static bool IsValidImage1(Stream imageStream)
    {
        if (imageStream.Length > 0)
        {
            try
            {
                System.Drawing.Image newImage = System.Drawing.Image.FromStream(imageStream);
                return true;
            }
            catch
            {
                return false;
            }
        }
        imageStream.Close();
        return false;
    }
}

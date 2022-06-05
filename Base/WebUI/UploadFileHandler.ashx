<%@ WebHandler Language="C#" Class="UploadFileHandler" %>
using DbObj;
using System;
using System.Web;

public class UploadFileHandler : IHttpHandler {
    
   public void ProcessRequest(HttpContext context)
        {
            string Document_ID = (string)context.Request["Document_ID"];
            if (!string.IsNullOrEmpty("Document_ID"))
            {
                string time = DateTime.Now.Second.ToString() + "-" + DateTime.Now.Millisecond.ToString();
                HttpPostedFile file = context.Request.Files[0];
                string fname = context.Server.MapPath("/Backend/data/document/" + Document_ID.ToString() + "-" + time + "-" + file.FileName);
                file.SaveAs(fname);
                DocumentVsFileRow _DocumentVsFileRow = new DocumentVsFileRow();
                _DocumentVsFileRow.Document_ID = Convert.ToInt32(Document_ID);
                _DocumentVsFileRow.File = Document_ID.ToString() + "-" + time + "-" + file.FileName;
               // _DocumentVsFileRow.Title = "";
                _DocumentVsFileRow.Active = 1;
                _DocumentVsFileRow.Sort = 1;
                _DocumentVsFileRow.CreateDate = DateTime.Now;
                BusinessRulesLocator.GetDocumentVsFileBO().Insert(_DocumentVsFileRow);
                context.Response.ContentType = "text/plain";
                context.Response.Write("Tải file thành công!");
            }
        }


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

}
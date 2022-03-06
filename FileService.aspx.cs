using System;
using System.Web;

using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Web.Services;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class FileService : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext postedContext = HttpContext.Current;
        var file = postedContext.Items.Values;

       

        HttpPostedFile col = Request.Files[0];
        int idEvento = Convert.ToInt32(Request.Params["IdEvento"]);
        string filename = col.FileName;
        string extenstion = filename.Substring(filename.IndexOf('.') + 1);
        string[] allowed = { "pdf", "xls", "xlsx", "png", "bmp", "jpg", "jpeg" };
       
        foreach (string x in allowed)
        {
            if (extenstion.Contains(x))
            {
               // filename = filename + "." + extenstion;
                //Save file in the uploads folder
                col.SaveAs(Server.MapPath("~/cotizacionEventos") + "/" + filename);
                UpdateEvento(idEvento,filename);
                string t = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.IndexOf("FileService"));
                Response.Write(filename);
                Response.Flush();
                Response.End();
            }
        }

    }

    [WebMethod]
    public static string uploadfile(HttpPostedFile data)
    {
        HttpPostedFile httpPostedFile = HttpContext.Current.Request.Files["UploadedImage"];
        return "uploaded";
    }

    public static string UpdateEvento(int idEvento, string fileName)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPUEventos"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter param;

                param = cmd.Parameters.Add("@Id_Evento", SqlDbType.Int);
                param.Value = idEvento;
                param = cmd.Parameters.Add("@NameFile", SqlDbType.VarChar);
                param.Value = fileName;
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();

                return "OK";

            }
        }
    }

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class ImageCSharp : System.Web.UI.Page
{
    public string userid
    {
        get
        {
            if (HttpContext.Current.Session["USER_ID"] != null)
            {
                return Session["USER_ID"].ToString();
            }
            else
            {
                return "";
            }

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ImageID"] != null)
        {
            string strQuery = "SELECT Filename, ContentType, Data FROM" + " tblFiles where id=@id";
            //string strQuery = "SELECT Filename, ContentType, Data FROM" + " tblFiles2 where id=@id";
            String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString;
            SqlCommand cmd = new SqlCommand(strQuery);
            //cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = Convert.ToInt32(Request.QueryString["ImageID"]);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Request.QueryString["ImageID"]);
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            DataTable dt = new DataTable();
            try
            {
                con.Open();
                sda.SelectCommand = cmd;
                sda.Fill(dt);
            }
            catch
            {
                dt = null;
            }
            finally
            {
                con.Close();
                sda.Dispose();
                con.Dispose();
            }
            if (dt != null)
            {
                Byte[] bytes = (Byte[])dt.Rows[0]["Data"];
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = dt.Rows[0]["ContentType"].ToString();
                Response.AddHeader("content-disposition", "attachment;filename="
                    + dt.Rows[0]["Filename"].ToString());
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
        }
    }



    //private void DownloadFile(DataTable dt)
    //{
    //    //Comment for ImageCSharp.aspx
    //    Byte[] bytes = (Byte[])dt.Rows[0]["Data"];
    //    Response.Buffer = true;
    //    Response.Charset = "";
    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    Response.ContentType = dt.Rows[0]["ContentType"].ToString();
    //    Response.AddHeader("content-disposition", "attachment;filename="
    //    + dt.Rows[0]["Filename"].ToString());
    //    Response.BinaryWrite(bytes);
    //    Response.Flush();
    //    Response.End();





    //}


}

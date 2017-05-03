using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class ImageDownload : System.Web.UI.Page
{
    //My code

    public string GetConnectionString()
    {
        //sets the connection string from your web config file "ConnString" is the name of your Connection String
        return System.Configuration.ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString;
    }


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


        DataTable dt = new DataTable();
        String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString;
        //string strQuery = "SELECT id, Filename FROM tblFiles2 ORDER BY id";

        

        string strQuery = "SELECT * FROM tblFiles WHERE Username = @Username ORDER BY id";

        SqlConnection conn = new SqlConnection(GetConnectionString());
        conn.Open();

        SqlCommand cmd = new SqlCommand(strQuery, conn);
        cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = userid;
        SqlConnection con = new SqlConnection(strConnString);
        SqlDataAdapter sda = new SqlDataAdapter();
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
            sda.Dispose();
            con.Dispose();
        }
    }


    private void DownloadFile(DataTable dt)
    {
        //Comment for ImageDownload.aspx
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

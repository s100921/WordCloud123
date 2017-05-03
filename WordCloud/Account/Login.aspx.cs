using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using WordCloudGen;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class Account_Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetConnectionString()
    {
        //sets the connection string from your web config file "ConnString" is the name of your Connection String
        return System.Configuration.ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString;
    }

    protected void LogIn(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(GetConnectionString());


        //SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM Registration WHERE Username =@Username and Password=@Password", con);
        cmd.Parameters.AddWithValue("@Username", Username.Text);
        cmd.Parameters.AddWithValue("@Password", Password.Text);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            Session["USER_ID"] = Username.Text;
            Response.Redirect("/Default.aspx");
        }
        else
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Username and Password')</script>");
        }
    }
}
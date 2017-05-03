using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using WordCloudGen;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Account_Register : Page
{
    public string GetConnectionString()
    {
        //sets the connection string from your web config file "ConnString" is the name of your Connection String
        return System.Configuration.ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString;
    }

    private void ExecuteInsert(string username, string gender, string dateofbirth, string emailaddress, string password)
    {



        SqlConnection conn = new SqlConnection(GetConnectionString());

        string sql = "INSERT INTO Registration (Username, Gender, DateOfBirth, EmailAddress, Password) VALUES (@Username,@Gender,@DateOfBirth,@EmailAddress,@Password)";
        try
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);

            SqlParameter[] param = new SqlParameter[5];
            //param[0] = new SqlParameter("@id", SqlDbType.Int, 20);
            param[0] = new SqlParameter("@Username", SqlDbType.VarChar, 50);
            param[1] = new SqlParameter("@Gender", SqlDbType.VarChar, 50);
            param[2] = new SqlParameter("@DateOfBirth", SqlDbType.VarChar, 50);
            param[3] = new SqlParameter("@EmailAddress", SqlDbType.VarChar, 50);
            param[4] = new SqlParameter("@Password", SqlDbType.VarChar, 50);

            param[0].Value = username;
            param[1].Value = gender;
            param[2].Value = dateofbirth;
            param[3].Value = emailaddress;
            param[4].Value = password;


            for (int i = 0; i < param.Length; i++)
            {
                cmd.Parameters.Add(param[i]);
            }

            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            string msg = "Insert Error:";
            msg += ex.Message;
            //  throw new Exception(msg);
        }
        finally
        {
            conn.Close();
        }
    }


    protected void CreateUser_Click(object sender, EventArgs e)
    {
        //User validation check in sql server database, the record will not insert if user exists. 
        SqlConnection conn = new SqlConnection(GetConnectionString());
        conn.Open();
        //SqlConnection con = new SqlConnection(constring);
        SqlCommand cmd = new SqlCommand("SELECT * FROM Registration WHERE Username = @Username", conn);
        cmd.Parameters.AddWithValue("@Username", Username.Text);
        SqlDataReader dr = cmd.ExecuteReader();
        

        if (dr.Read())
        {
            Response.Write("User has exist");
            ClearControls(Page);
        }
        else if (Password.Text == ConfirmPassword.Text)
        {
            //call the method to execute insert to the database
            ExecuteInsert(Username.Text,
                          DropDownList.SelectedItem.Text,
                          DateOfBirth.Text,
                          EmailAddress.Text,
                          Password.Text);

            Response.Write("Record was successfully added!");
            ClearControls(Page);
        }
        else
        {
            Response.Write("Password did not match");
            Password.Focus();
        }
    
    }


    

    public static void ClearControls(Control Parent)
    {

        if (Parent is TextBox)
        { (Parent as TextBox).Text = string.Empty; }
        else
        {
            foreach (Control c in Parent.Controls)
                ClearControls(c);
        }
    }
}
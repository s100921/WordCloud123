using System;
using System.Windows;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.Services;
using System.Diagnostics;
using System.Data.SqlClient;


public partial class _Default : Page
{

    //My code

    protected string ActiveTab { get; set; }

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


    //End of code


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // 0 is the first tab
            this.ActiveTab = "0";
        }
        else
        {
            this.ActiveTab = HiddevActiveTab.Value;
            if (string.IsNullOrWhiteSpace(this.ActiveTab))
            {
                this.ActiveTab = "0";
            }
        }
    }

    public string DefaultFileName = "Upload/"; //is the folder where files are uploaded to


    //My code


    protected void btnUpload_Click(object sender, EventArgs e)

    {


        //Upload to db - method 1 (Click the dbUpload button and insert to database, need to have the image in Repos upload folder
        //and filename specified in server.mappath can only save time)




        //string filePath = HttpContext.Current.Server.MapPath("Upload/" + DateTime.Now.ToString()
        //                                           .Replace("/", "-")
        //                                           .Replace(" ", "- ")
        //                                           .Replace(":", "") + ".png");

        ////string filePath = Server.MapPath("Upload/27-4-17- 102706- PM.png");

        //////string filePath = Server.MapPath("/Upload/Unknown8.jpg");
        //string filename = Path.GetFileName(filePath);
        //string ext = Path.GetExtension(filename);
        //string contenttype = String.Empty;


        ////Set the contenttype based on File Extension
        //switch (ext)
        //{
        //    case ".svg":
        //        contenttype = "image/svg";
        //        break;
        //    case ".jpg":
        //        contenttype = "image/jpg";
        //        break;
        //    case ".png":
        //        contenttype = "image/png";
        //        break;
        //    case ".gif":
        //        contenttype = "image/gif";
        //        break;
        //    case ".pdf":
        //        contenttype = "application/pdf";
        //        break;
        //}
        //if (contenttype != String.Empty)
        //{

        //    SqlConnection conn = new SqlConnection(GetConnectionString());


        //    FileStream fs = new FileStream(filePath, FileMode.OpenOrCreate);

        //    //FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
        //    BinaryReader br = new BinaryReader(fs);
        //    Byte[] bytes = br.ReadBytes((Int32)fs.Length);
        //    br.Close();
        //    fs.Close();

        //    string strQuery = "INSERT INTO tblFiles(Username, Filename, ContentType, Data, DateTime) VALUES (@Username, @Filename, @ContentType, @Data, @DateTime)";

        //    conn.Open();

        //    //string strQuery = "insert into tblFiles(Name, ContentType, Data) values (@Name, @ContentType, @Data)";
        //    SqlCommand cmd = new SqlCommand(strQuery, conn);
        //    cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = userid;
        //    cmd.Parameters.Add("@Filename", SqlDbType.VarChar).Value = filename;
        //    cmd.Parameters.Add("@ContentType", SqlDbType.VarChar).Value = contenttype;
        //    cmd.Parameters.Add("@Data", SqlDbType.VarBinary).Value = bytes;
        //    //Response.Write(bytes + "\n" + filename + "\n" + contenttype);
        //    cmd.Parameters.Add("@DateTime", SqlDbType.DateTime).Value = DateTime.Now;

        //InsertUpdateData(cmd);
        //lblMessage.ForeColor = System.Drawing.Color.Green;
        //lblMessage.Text = "File Uploaded to Database Successfully";

        //    //    //End
        //}

    }


            //Upload to db - method 2 Click browse button to select the image to upload, then click dbUpload button 
            // insert into database can only save time)

        //// Read the file and convert it to Byte Array
        //    string filePath = FileUpload.PostedFile.FileName;
        //    string filename = Path.GetFileName(filePath);
        //    string ext = Path.GetExtension(filename);
        //    string contenttype = String.Empty;


        //    //Set the contenttype based on File Extension
        //    switch (ext)
        //    {
        //        case ".svg":
        //            contenttype = "image/svg";
        //            break;
        //        case ".jpg":
        //            contenttype = "image/jpg";
        //            break;
        //        case ".png":
        //            contenttype = "image/png";
        //            break;
        //        case ".gif":
        //            contenttype = "image/gif";
        //            break;
        //        case ".pdf":
        //            contenttype = "application/pdf";
        //            break;
        //    }
        //    if (contenttype != String.Empty)
        //    {
        //        SqlConnection conn = new SqlConnection(GetConnectionString());

        //        Stream fs = FileUpload.PostedFile.InputStream;
        //        BinaryReader br = new BinaryReader(fs);
        //        Byte[] bytes = br.ReadBytes((Int32)fs.Length);

        //        //Insert the file into database
        //        string strQuery = "INSERT INTO tblFiles(Username, Filename, ContentType, Data, DateTime) VALUES (@Username, @Filename, @ContentType, @Data, @DateTime)";

        //        conn.Open();

        //        SqlCommand cmd = new SqlCommand(strQuery, conn);

        //        //SqlCommand cmd = new SqlCommand(strQuery);

        //        cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = userid;
        //        cmd.Parameters.Add("@Filename", SqlDbType.VarChar).Value = filename;
        //        cmd.Parameters.Add("@ContentType", SqlDbType.VarChar).Value = contenttype;
        //        cmd.Parameters.Add("@Data", SqlDbType.VarBinary).Value = bytes;
        //        cmd.Parameters.Add("@DateTime", SqlDbType.DateTime).Value = DateTime.Now;

        //        InsertUpdateData(cmd);
        //        lblMessage.ForeColor = System.Drawing.Color.Green;
        //        lblMessage.Text = "File Uploaded to Database Successfully";


        //    }
        //    else
        //    {
        //        lblMessage.ForeColor = System.Drawing.Color.Red;
        //        lblMessage.Text = "File format not recognised." +
        //          " Upload Image/Word/PDF/Excel formats";
        //    }
        //}

        //Function InsertUpdateData
    private Boolean InsertUpdateData(SqlCommand cmd)
    {
        String strConnString = System.Configuration.ConfigurationManager
        .ConnectionStrings["WC_Database"].ConnectionString;
        SqlConnection con = new SqlConnection(strConnString);
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            return true;
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            return false;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }





    //End of code

}
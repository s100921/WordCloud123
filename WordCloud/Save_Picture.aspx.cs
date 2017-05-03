using System;
using System.Web;
using System.IO;
using System.Web.Services;
using System.Data;
using System.Web.UI;
using System.Collections;
using System.Diagnostics;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

public partial class Save_Picture : System.Web.UI.Page
{
    // My code


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



    //My code


    [WebMethod()]
    public static void UploadPic(string imageData)
    {





        string fileNameWitPath =
            HttpContext.Current.Server.MapPath("Upload/" + DateTime.Now.ToString()
                                                   .Replace("/", "-")
                                                   .Replace(" ", "- ")
                                                   .Replace(":", "") + ".png");
        using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
        {


            using (BinaryWriter bw = new BinaryWriter(fs))
            {


                byte[] data = Convert.FromBase64String(imageData);
                bw.Write(data);
                bw.Close();

                //My code

                string filename = Path.GetFileName(fileNameWitPath);
                string ext = Path.GetExtension(filename);
                string contenttype = String.Empty;

                string userid = HttpContext.Current.Session["USER_ID"].ToString();

                switch (ext)
                {
                    case ".svg":
                        contenttype = "image/svg";
                        break;
                    case ".jpg":
                        contenttype = "image/jpg";
                        break;
                    case ".png":
                        contenttype = "image/png";
                        break;
                    case ".gif":
                        contenttype = "image/gif";
                        break;
                    case ".pdf":
                        contenttype = "application/pdf";
                        break;
                }
                if (contenttype != String.Empty)
                {

                     


                    string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["WC_Database"].ConnectionString;

                    SqlConnection conn = new SqlConnection(strConnString);

                    string strQuery = "INSERT INTO tblFiles(Username, Filename, ContentType, Data, DateTime) VALUES (@Username, @Filename, @ContentType, @Data, @DateTime)";

                    conn.Open();

                    //string strQuery = "insert into tblFiles(Name, ContentType, Data) values (@Name, @ContentType, @Data)";
                    SqlCommand cmd = new SqlCommand(strQuery, conn);
                    cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = userid;
                    cmd.Parameters.Add("@Filename", SqlDbType.VarChar).Value = filename;
                    cmd.Parameters.Add("@ContentType", SqlDbType.VarChar).Value = contenttype;
                    //cmd.Parameters.Add("@Data", SqlDbType.VarBinary).Value = bytes;
                    //Response.Write(bytes + "\n" + filename + "\n" + contenttype);
                    cmd.Parameters.Add("@DateTime", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@Data", SqlDbType.VarBinary).Value = data;


                    cmd.ExecuteNonQuery();

                }
            }
        }
    }

    //Boolean InsertUpdateData = InsertUpdateData;

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

        //InsertUpdateData(cmd); 
       // lblMessage.ForeColor = System.Drawing.Color.Green;
        //lblMessage.Text = "File Uploaded to Database Successfully";

        //My code


    


    }
        }


        
//}



    //Function InsertUpdateData
    //private Boolean InsertUpdateData(SqlCommand cmd)
    //{
    //    String strConnString = System.Configuration.ConfigurationManager
    //    .ConnectionStrings["WC_Database"].ConnectionString;
    //    SqlConnection con = new SqlConnection(strConnString);
    //    cmd.CommandType = CommandType.Text;
    //    cmd.Connection = con;
    //    try
    //    {
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        return true;
    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write(ex.Message);
    //        return false;
    //    }
    //    finally
    //    {
    //        con.Close();
    //        con.Dispose();
    //    }
    //}

//}

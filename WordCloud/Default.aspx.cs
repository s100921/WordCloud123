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

    }


}
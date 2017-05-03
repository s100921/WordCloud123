<%@ Page Title="ImageDownload" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ImageDownload.aspx.cs" Inherits="ImageDownload" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information.</p>

     <%--My code--%>


    <div>
    
        <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns = "false"
       Font-Names = "Arial" >
    <Columns>
       <asp:BoundField DataField = "id" HeaderText = "ID" />
       <asp:BoundField DataField = "Filename" HeaderText = "Image Name" />
        <asp:BoundField DataField = "DateTime" HeaderText = "Date" />
       <asp:ImageField DataImageUrlField="id" DataImageUrlFormatString="ImageCSharp.aspx?ImageID={0}" ControlStyle-Width="100"
        ControlStyle-Height = "100" HeaderText = "Preview Image"/>

        

<%--       <asp:CommandField ShowSelectButton="True" SelectText="Download" ControlStyle-ForeColor="Blue"/>--%>
        

       <%-- <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink runat="server"
                            NavigateUrl='<%# Eval("id", "ImageDownload.aspx?ID={0}") %>'

                            Text="Download"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>--%>


        

    </Columns>
    </asp:GridView>

    </div>
  
</asp:Content>
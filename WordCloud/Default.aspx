<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="height: 830px">
        <h1>Welcome to Word Cloud Generator</h1>
        <div style="height: 650px; position: relative; float: left; padding-right: 20px; left: 0px; top: 0px; width: 500px;">
            <asp:TextBox ID="TextBox1" runat="server" Height="445px" TextMode="MultiLine" Width="490px"></asp:TextBox>
            <br />
            <asp:HiddenField ID="HiddevActiveTab" runat="server" />
            <div class="panel panel-default" style="width: 490px; height: 200px; padding: 10px; margin-top: 20px">
                <div id="Tabs" role="tabpanel">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="active"><a href="#personal" aria-controls="personal" role="tab" data-toggle="tab">Cloud</a></li>
                        <li><a id="editL" href="#editList" aria-controls="edList" role="tab" data-toggle="tab">Edit List</a></li>
                        <li><a href="#save" aria-controls="save" role="tab" data-toggle="tab">Save</a></li>
                        <li><a href="#examples" aria-controls="examples" role="tab" data-toggle="tab">Examples</a></li>

                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content" style="padding-top: 10px">
                        <div role="tabpanel" class="tab-pane active" id="personal">
                            Add text into the textbox above or browse for a file to generate the word cloud!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <select id="shape" class="pull-right" style="height: 27px; width: 100px; margin: 3px" type="select">
                               <option value='1' selected="selected">circle</option>
                               <option value='2'>star</option>
                               <option value='3'>pentagon</option>
                               <option value='4'>diamond</option>
                               <option value='5'>triangle</option>
                           </select>
                            <input id="updateButton" type="button" value="Generate" />
                            <%--<input id="Button1" type="button" onclick="Populate()" value="Generate" style="width: 107px" />--%>
                            <input id="File1" type="file" onchange="onFileSelected(event)" style="width: 301px" />&nbsp;
                        </div>

                        <div role="tabpanel" class="tab-pane" id="editList">
                            <textarea id="TextArea1" name="S1" style="width: 471px; height: 122px"></textarea>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="save">
                            <%--<input id="Button3" runat="server" type="button" onclick="ExportToPDF()" value="Export to PDF" />--%>
                            <a href="#" id="btn-download" download="my-file-name.png">Download PNG</a>
                            <a href="#" id="Button3" onclick="ExportToPDF()">Download PDF</a>
                            <%-- <asp:Button ID="btnUpload" runat="server" Text="dbUpload" OnClick="btnUpload_Click" />--%>
                            <br />
                            <asp:Label ID="lblMessage" runat="server" Text="" Font-Names="Arial"></asp:Label>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="examples">
                            <select id="sampleTitledropdown">
                                <option selected="selected">Pick a category</option>
                                <option value="computing">Computing</option>
                                <option value="finance">Finance</option>
                                <option value="politics">Politics</option>
                                <option value="vehicles">Vehicles</option>

                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="background-color: #000066; height: 666px; position: relative; width: 520px; float: left;" id="cloudM">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="titeLabel" runat="server" Font-Bold="True" Font-Names="Segoe UI" Font-Size="XX-Large" Font-Underline="True" ForeColor="#3366FF"></asp:Label>
            <%-- <div id="cloud">
            </div>--%>
            <canvas id="wordCloud" width="520" height="600"></canvas>
        </div>

    </div>
<script type="text/javascript">
    var result = document.getElementById("<%= TextBox1.ClientID %>");
   var titleLbl = document.getElementById("<%= titeLabel.ClientID %>");
      
    </script>

    <script src="Scripts/d3.min.js"></script>
    <script src="Scripts/d3.layout.cloud.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.debug.js"></script>
    <script type="text/javascript" src="http://canvg.github.io/canvg/rgbcolor.js"></script>
    <script type="text/javascript" src="http://canvg.github.io/canvg/StackBlur.js"></script>
    <script type="text/javascript" src="http://canvg.github.io/canvg/canvg.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"> </script>
    <script src="Scripts/wordcloud2.js"></script>
    <script src="Scripts/script.js"></script>

    <%--  <script src="Scripts\html2canvas.js"></script>--%>
    

</asp:Content>

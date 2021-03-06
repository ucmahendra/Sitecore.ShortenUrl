﻿<%@ page language="C#" autoeventwireup="true" debug="true" %>

<%@ import namespace="ShortenUrl.Application" %>
<%@ import namespace="ShortenUrl.Application.Implementations" %>
<%@ import namespace="ShortenUrl.Application.Models" %>
<%@ import namespace="System.Web.UI" %>
<%@ import namespace="System.Configuration" %>
<%@ import namespace="System" %>
<%@ import namespace="System.Net" %>

<!DOCTYPE html>
<script runat="server">
     Shorten shorten = new Shorten();
   string shortenUrlHostName = Sitecore.Configuration.Settings.GetSetting("ShortenUrlHostName");

     protected void Page_Load(object sender, EventArgs e) {
   
    if (!Sitecore.Context.IsLoggedIn){
     Response.Redirect("http://" + Request.Url.Host + "/sitecore/login");
    }
    if (!IsPostBack)
            {
                shorten.FillGrid(gvShortenUrl);
            }
          }
    private void btnShortenUrl_OnClick(object sender, EventArgs e) {
      if (Sitecore.Context.IsLoggedIn)if (!Sitecore.Context.IsLoggedIn){
     Response.Redirect("http://" + Request.Url.Host + "/sitecore/login");
    }
                var _urlManager = new UrlManager();
                ShortUrl shortUrl = _urlManager.ShortenUrl(txtFullUrl.Text, Request.UserHostAddress, "");
                
                var tinyUrl = string.Format("{0}://{1}{2}{3}", Request.Url.Scheme, shortenUrlHostName, Page.ResolveUrl("~"), shortUrl.Segment);
                hlUrl.Text = tinyUrl;
                hlUrl.NavigateUrl = tinyUrl;
            
    }
    
    protected void gvShortenUrl_PageIndexChanging(object sender, GridViewPageEventArgs e)
{
    gvShortenUrl.PageIndex = e.NewPageIndex;
    shorten.FillGrid(gvShortenUrl);
}
    protected void btnDelete_Click(object sender, EventArgs e)
    {
     if (!Sitecore.Context.IsLoggedIn){
     Response.Redirect("http://" + Request.Url.Host + "/sitecore/login");
    }
        shorten.ShortenDeleteClick(sender, gvShortenUrl, lblMessage);
    }
  
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table align="center" style="position: relative; top: 20px; width: 940px">
                <tr>
                    <td align="center">
                        <div>
                            <asp:textbox id="txtFullUrl" runat="server" style="width: 450px; height: 30px;" />
                            <asp:button runat="server" id="btnShortenUrl" text="Shorten the Url" style="height: 32px;" onclick="btnShortenUrl_OnClick" visible="True" />
                        </div>
                        <br />
                        <asp:hyperlink id="hlUrl" runat="server"></asp:hyperlink>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <br />
                        <asp:label id="lblMessage" runat="server" enableviewstate="false" forecolor="Blue"></asp:label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:gridview id="gvShortenUrl" allowpaging="true" runat="server" autogeneratecolumns="False" showheaderwhenempty="True"
                            emptydatatext="No Records Found" gridlines="both" cssclass="gv-shorten-url" emptydatarowstyle-forecolor="Red" pagesize="10" onpageindexchanging="gvShortenUrl_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="Long Url">
                                <ItemTemplate>

                                    <asp:HyperLink target="_blank" ID="hlLongUrl" runat="server" NavigateUrl='<%#Eval("LongUrl") %>' Text='<%#Eval("LongUrl") %>'></asp:HyperLink>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Short Url">
                                <ItemTemplate>
                                    <asp:HyperLink target="_blank" ID="hlShortUrl" runat="server" NavigateUrl='<%#Request.Url.Scheme+"://"+shortenUrlHostName+"/"+Eval("Segment")%>' Text='<%#Request.Url.Scheme+"://"+shortenUrlHostName+"/"+Eval("Segment")%>'></asp:HyperLink>
                                 </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IP Address">
                                <ItemTemplate>                                    
                                    <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("Ip")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Number Of Click">
                                <ItemTemplate>
                                    <asp:Label ID="lblNumClick" runat="server" Text='<%#Eval("NumOfClicks")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure? want to delete the department.');"
                                        OnClick="btnDelete_Click" />
                                    <asp:Label ID="lblId" runat="server" Text='<%#Eval("id")%>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                                                   </Columns>
                    </asp:gridview>
                    </td>
                </tr>
            </table>
            <input type="hidden" runat="server" id="hidCustomerID" />
        </div>
    </form>
    <style type="text/css">
        .gv-shorten-url {
            width: 940px;
        }
    </style>
</body>

</html>


<%@ page language="C#" autoeventwireup="true" debug="true" %>

<%@ import namespace="ShortenUrl.Application" %>
<%@ import namespace="ShortenUrl.Application.Implementations" %>
<%@ import namespace="ShortenUrl.Models" %>
<%@ import namespace="System.Web.UI" %>
<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
          }
    private void btnShortenUrl_OnClick(object sender, EventArgs e) {
        if (Sitecore.Context.IsLoggedIn) {
                        var _urlManager = new UrlManager ();
            ShortUrl shortUrl = _urlManager.ShortenUrl(txtFullUrl.Text, Request.UserHostAddress, "");
            var shortenUrlHostName = Sitecore.Configuration.Settings.GetSetting("ShortenUrlHostName");
    var tinyUrl = string.Format("{0}://{1}{2}{3}", Request.Url.Scheme, shortenUrlHostName, Page.ResolveUrl("~"), shortUrl.Segment);
            hlUrl.Text = tinyUrl;
    hlUrl.NavigateUrl =tinyUrl;
                    }
        else {
            Response.Redirect("http://" + Request.Url.Host + "/sitecore/login");
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtFullUrl" runat="server" />
            <asp:Button runat="server" ID="btnShortenUrl" Text="Shorten the Url" OnClick="btnShortenUrl_OnClick" Visible="True" />
        </div>
        <asp:HyperLink ID="hlUrl" runat="server"></asp:HyperLink>
    </form>
</body>
</html>


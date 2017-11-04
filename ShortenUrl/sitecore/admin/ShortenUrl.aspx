<%@ page language="C#" autoeventwireup="true" debug="true" %>

<%@ import namespace="ShortenUrl.Application" %>
<%@ import namespace="ShortenUrl.Application.Implementations" %>
<%@ import namespace="ShortenUrl.Models" %>
<%@ import namespace="System.Web.UI" %>
<%@ import namespace="System.Configuration" %>
<%@ import namespace="System" %>
<%@ import namespace="System.Data" %>
<%@ import namespace="System.Data.SqlClient" %>
<%@ import namespace="System.Net" %>

<!DOCTYPE html>
<script runat="server">
     SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["reporting"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e) {
    if (!IsPostBack)
            {
                FillGrid();
            }
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
    void FillGrid()
    {
        try
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Select * from ShortUrl";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            gvShortenUrl.DataSource = ds;
            gvShortenUrl.DataBind();
        }
        catch
        {
 
        }
    }
    protected void gvShortenUrl_PageIndexChanging(object sender, GridViewPageEventArgs e)
{
    gvShortenUrl.PageIndex = e.NewPageIndex;
    FillGrid();
}
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            Button btn = sender as Button;
            GridViewRow grow = btn.NamingContainer as GridViewRow;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "DELETE FROM ShortUrl WHERE Id="+(grow.FindControl("lblId") as Label).Text;
            cmd.Connection = con;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            FillGrid();
            lblMessage.Text = "Deleted Successfully.";
        }
        catch
        {
 
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
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
            <table align="center" style="position: relative; top: 20px;">
                <tr>
                    <td align="center">
                        <div>
                            <asp:textbox id="txtFullUrl" runat="server" />
                            <asp:button runat="server" id="btnShortenUrl" text="Shorten the Url" onclick="btnShortenUrl_OnClick" visible="True" />
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
                            emptydatatext="No Records Found" gridlines="both" cssclass="gv" emptydatarowstyle-forecolor="Red" pagesize="10" onpageindexchanging="gvShortenUrl_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="Long Url">
                                <ItemTemplate>

                                    <asp:HyperLink ID="hlLongUrl" runat="server" NavigateUrl='<%#Eval("LongUrl") %>' Text='<%#Eval("LongUrl") %>'></asp:HyperLink>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Segment">
                                <ItemTemplate>
                                    <asp:Label ID="lblSegment" runat="server" Text='<%#Eval("Segment") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IP Address">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("Ip") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Number Of Click">
                                <ItemTemplate>
                                    <asp:Label ID="lblNumClick" runat="server" Text='<%#Eval("NumOfClicks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure? want to delete the department.');"
                                        OnClick="btnDelete_Click" />
                                    <asp:Label ID="lblId" runat="server" Text='<%#Eval("id") %>' Visible="false"></asp:Label>
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
</body>
</html>


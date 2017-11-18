using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ShortenUrl.Application.Implementations
{
    public class Shorten
    {
        private SqlConnection con { get; set; }
        public Shorten()
        {
            var databaseName = Sitecore.Configuration.Settings.GetSetting("DatabaseName");
            con = new SqlConnection(ConfigurationManager.ConnectionStrings[databaseName].ConnectionString);
        }

        public void FillGrid(GridView gvShortenUrl)
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

        public void ShortenDeleteClick(object sender, GridView gvShortenUrl, Label lblMessage)
        {
            try
            {
                Button btn = sender as Button;
                GridViewRow grow = btn.NamingContainer as GridViewRow;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "DELETE FROM ShortUrl WHERE Id=" + (grow.FindControl("lblId") as Label).Text;
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                FillGrid(gvShortenUrl);
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
    }
}

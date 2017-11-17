using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using ShortenUrl.Application.Models;
using Sitecore.Diagnostics;
using Sitecore.Pipelines.HttpRequest;
using Sitecore.StringExtensions;

namespace ShortenUrl.Application.Pipelines
{
    public class ShortenUrlResolver : HttpRequestProcessor
    {
        public override void Process(HttpRequestArgs arguments)
        {
            Assert.ArgumentNotNull((object)arguments, "arguments");

            if (arguments.LocalPath.ToLower().Contains("/notfound"))
                return;

            var request = arguments.Context.Request;
            string hostname = request.Url.Host;
            var shortenUrlHostName = Sitecore.Configuration.Settings.GetSetting("ShortenUrlHostName");
            if (hostname != shortenUrlHostName) return;

            string segment = !arguments.LocalPath.IsNullOrEmpty() ? arguments.LocalPath.Trim('/') :
            "";
            var defaultRedirect = Sitecore.Configuration.Settings.GetSetting("DefaultRedirect");
            if (segment.IsNullOrEmpty())
            {
                arguments.Context.Response.RedirectPermanent(defaultRedirect);
            }
            string referer = request.UrlReferrer != null ? request.UrlReferrer.ToString() : string.Empty;
            string ip = request.UserHostAddress;

            string longurl = Click(segment, referer, ip);
            longurl = longurl.IsNullOrEmpty() ? defaultRedirect : longurl;
            this.Redirect(arguments, longurl);
        }

        public string Click(string segment, string referer, string ip)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["reporting"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    ShortUrl url = new ShortUrl();

                    SqlCommand command = new SqlCommand("get_OneShortUrl_By_Segment", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@Segment", segment);
                    con.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    // Call Read before accessing data. 
                    while (reader.Read())
                    {
                        url.Id = int.Parse(String.Format("{0}", reader[0]));
                        url.LongUrl = String.Format("{0}", reader[1]);
                        url.Segment = String.Format("{0}", reader[2]);
                        url.Added = System.Convert.ToDateTime(String.Format("{0}", reader[3]));
                        url.Ip = String.Format("{0}", reader[4]);
                        url.NumOfClicks = int.Parse(String.Format("{0}", reader[5]));
                    }

                    if (!reader.HasRows)
                    {
                        throw new Exception();
                    }

                    Stat stat = new Stat()
                    {
                        ClickDate = DateTime.Now,
                        Ip = ip,
                        Referer = referer,
                        ShortUrl = url
                    };

                    SqlCommand updateCommand = new SqlCommand("get_OneShortUrl_By_Segment", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    updateCommand.Parameters.AddWithValue("@Segment", url.NumOfClicks + 1);

                    updateCommand.ExecuteNonQuery();

                    con.Close();
                    return stat.ShortUrl.LongUrl;
                }
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

        private void Redirect(HttpRequestArgs arguments, string longurl)
        {
            arguments.Context.Response.Clear();
            arguments.Context.Response.StatusCode = (int)HttpStatusCode.MovedPermanently;
            arguments.Context.Response.RedirectLocation = longurl;
            arguments.Context.Response.End();
        }
    }
}

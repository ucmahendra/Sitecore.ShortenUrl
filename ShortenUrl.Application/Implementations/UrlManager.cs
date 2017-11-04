using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using ShortenUrl.Application.Models;

namespace ShortenUrl.Application.Implementations
{
    public class UrlManager : IUrlManager
    {
        public ShortUrl ShortenUrl(string longUrl, string ip, string segment = "")
        {
            string connectionString = ConfigurationManager.ConnectionStrings["reporting"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                ShortUrl url = new ShortUrl();

                SqlCommand command = new SqlCommand("get_OneShortUrl_By_LongUrl", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@LongUrl", longUrl);
                con.Open();
                try
                {
                    SqlDataReader reader = command.ExecuteReader();

                    // Call Read before accessing data. 
                    while (reader.Read())
                    {
                        url.Id = int.Parse(String.Format("{0}", reader[0]));
                        url.LongUrl = String.Format("{0}", reader[1]);
                        url.Segment = String.Format("{0}", reader[2]);
                        url.Added = Convert.ToDateTime(String.Format("{0}", reader[3]));
                        url.Ip = String.Format("{0}", reader[4]);
                        url.NumOfClicks = int.Parse(String.Format("{0}", reader[5]));
                    }

                    if (url.Segment != null)
                    {
                        return url;
                    }

                    if (!longUrl.StartsWith("http://") && !longUrl.StartsWith("https://"))
                    {
                        throw new ArgumentException("Invalid URL format");
                    }

                    Uri urlCheck = new Uri(longUrl);
                    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(urlCheck);
                    request.Timeout = 10000;
                    try
                    {
                        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                    }
                    catch (Exception)
                    {
                        throw new Exception();
                    }

                    //int cap = 0;
                    //               string capString = ""; //ConfigurationManager.AppSettings["MaxNumberShortUrlsPerHour"];
                    //int.TryParse(capString, out cap);
                    //DateTime dateToCheck = DateTime.Now.Subtract(new TimeSpan(1, 0, 0));
                    //int count = ctx.ShortUrls.Where(u => u.Ip == ip && u.Added >= dateToCheck).Count();
                    //if (cap != 0 && count > cap)
                    //{
                    //	throw new ArgumentException("Your hourly limit has exceeded");
                    //}

                    //if (!string.IsNullOrEmpty(segment))
                    //{
                    //	if (ctx.ShortUrls.Where(u => u.Segment == segment).Any())
                    //	{
                    //		throw new Exception();
                    //	}
                    //	if (segment.Length > 20 || !Regex.IsMatch(segment, @"^[A-Za-z\d_-]+$"))
                    //	{
                    //		throw new ArgumentException("Malformed or too long segment");
                    //	}
                    //}
                    //else
                    //{
                    segment = this.NewSegment();
                    //}

                    if (string.IsNullOrEmpty(segment))
                    {
                        throw new ArgumentException("Segment is empty");
                    }

                    url = new ShortUrl()
                    {
                        Added = DateTime.Now,
                        Ip = ip,
                        LongUrl = longUrl,
                        NumOfClicks = 0,
                        Segment = segment
                    };

                    SqlCommand command2 = new SqlCommand("insert_In_ShortUrl", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command2.Parameters.AddWithValue("@LongUrl", longUrl);
                    command2.Parameters.AddWithValue("@Segment", segment);
                    command2.Parameters.AddWithValue("@Added", DateTime.Now);
                    command2.Parameters.AddWithValue("@Ip", ip);
                    command2.Parameters.AddWithValue("@NumOfClicks", 0);

                    command2.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Sitecore.Diagnostics.Log.Error(
                                string.Format("Error in UrlManager {0}.",
                                    ex.InnerException.Message), ex);
                }
                finally
                {
                    con.Close();
                }
                return url;
            }
        }

        private string NewSegment()
        {            
            string connectionString = ConfigurationManager.ConnectionStrings["reporting"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                int i = 0;
                while (true)
                {
                    string segment = Guid.NewGuid().ToString().Substring(0, 6);

                    SqlCommand command = new SqlCommand("get_ShortUrl_By_Segment", con)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@Segment", segment);
                    con.Open();
                    try
                    {
                        SqlDataReader reader = command.ExecuteReader();
                        
                        if (!reader.HasRows)
                        {
                            return segment;
                        }
                        if (i > 30)
                        {
                            break;
                        }
                        i++;
                    }
                    catch (Exception ex)
                    {
                        Sitecore.Diagnostics.Log.Error(
                                    string.Format("Error in UrlManager {0}.",
                                        ex.InnerException.Message), ex);
                    }
                    finally
                    {
                        con.Close();
                    }                   
                }
                return string.Empty;
            }
        }
    }
}

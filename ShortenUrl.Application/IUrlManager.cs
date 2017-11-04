using ShortenUrl.Application.Models;

namespace ShortenUrl.Application
{
	public interface IUrlManager
	{
		ShortUrl ShortenUrl(string longUrl, string ip, string segment = "");		
	}
}

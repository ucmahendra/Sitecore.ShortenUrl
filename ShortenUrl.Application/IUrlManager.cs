using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShortenUrl.Application
{
	public interface IUrlManager
	{
		ShortUrl ShortenUrl(string longUrl, string ip, string segment = "");		
	}
}

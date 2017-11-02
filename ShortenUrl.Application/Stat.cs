using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShortenUrl.Application
{	
	public class Stat
	{
		public int Id { get; set; }

		public DateTime ClickDate { get; set; }

		public string Ip { get; set; }

		public string Referer { get; set; }

		public ShortUrl ShortUrl { get; set; }
	}
}

using System;

namespace ShortenUrl.Application.Models
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

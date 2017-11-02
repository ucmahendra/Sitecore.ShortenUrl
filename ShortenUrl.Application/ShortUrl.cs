using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShortenUrl.Application
{	
	public class ShortUrl
	{		
		public int Id { get; set; }

		public string LongUrl { get; set; }

		public string Segment { get; set; }

		public DateTime Added { get; set; }

		public string Ip { get; set; }

		public int NumOfClicks { get; set; }

		//public Stat[] Stats { get; set; }
	}
}

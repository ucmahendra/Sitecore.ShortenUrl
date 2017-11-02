//using Newtonsoft.Json;

//using System.ComponentModel.DataAnnotations;

namespace ShortenUrl.Models
{
	public class Url
	{
		//[Required]
		//[JsonProperty("longUrl")]
		public string LongURL { get; set; }

		//[JsonProperty("shortUrl")]
		public string ShortURL { get; set; }

		//[JsonIgnore]
		public string CustomSegment { get; set; }
	}
}
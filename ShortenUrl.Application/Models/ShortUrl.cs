using System;

namespace ShortenUrl.Application.Models
{
    public class ShortUrl
    {
        public int Id { get; set; }

        public string LongUrl { get; set; }

        public string Segment { get; set; }

        public DateTime Added { get; set; }

        public string Ip { get; set; }

        public int NumOfClicks { get; set; }

    }
}

using System.Web.Mvc;
using ShortenUrl.Application;
using ShortenUrl.Application.Implementations;
using ShortenUrl.Models;
using Sitecore.Mvc.Controllers;

namespace ShortenUrl.Controllers
{
    public class UrlController : SitecoreController
    {
        private IUrlManager _urlManager;

        public UrlController() : this(new UrlManager())
        {
        }

        public UrlController(IUrlManager urlManager)
        {
            this._urlManager = urlManager;
        }

        [HttpGet]
        public override ActionResult Index()
        {
            Url url = new Url();
            return View(url);
        }

        public ActionResult Index(Url url)
        {
            if (ModelState.IsValid)
            {
                ShortUrl shortUrl = this._urlManager.ShortenUrl(url.LongURL, Request.UserHostAddress, url.CustomSegment);
                var shortenUrlHostName = Sitecore.Configuration.Settings.GetSetting("ShortenUrlHostName");
                url.ShortURL = string.Format("{0}://{1}{2}{3}", Request.Url.Scheme, shortenUrlHostName, Url.Content("~"), shortUrl.Segment);
            }
            return View(url);
        }
    }
}
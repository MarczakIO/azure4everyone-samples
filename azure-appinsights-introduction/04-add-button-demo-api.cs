using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using demo.Models;
using System.Net.Http;

namespace demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DemoController : ControllerBase
    {
        private readonly string url = "<function_url>";

        public DemoController()
        {}

        [HttpGet]
        public async Task<ActionResult<string>> Get()
        {
            HttpClient client = new HttpClient();
            var response = await client.GetAsync(url);
            var text = await response.Content.ReadAsStringAsync();

            return new OkObjectResult(text);
        }

    }
}
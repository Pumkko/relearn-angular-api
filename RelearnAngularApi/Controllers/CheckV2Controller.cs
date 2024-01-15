using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;

namespace RelearnAngularApi.Controllers
{
    [ApiVersion(2.0)]
    [ApiController]
    [Route("check")]
    public class CheckV2Controller : ControllerBase
    {
        [HttpGet]
        public IActionResult Ping()
        {
            return Ok("Working V2");
        }
    }
}

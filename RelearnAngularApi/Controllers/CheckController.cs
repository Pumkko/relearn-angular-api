using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;

namespace RelearnAngularApi.Controllers
{
    [ApiVersion(1.0)]
    [ApiController]
    [Route("[controller]")]
    public class CheckController : ControllerBase
    {   

        [HttpGet]
        public ActionResult Check()
        {
            return Ok("Working");
        }

    }
}

using Microsoft.AspNetCore.Mvc;

namespace RelearnAngularApi.Controllers
{
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

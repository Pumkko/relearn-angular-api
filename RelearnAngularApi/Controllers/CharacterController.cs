using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web.Resource;
using RelearnAngularApi.Inputs;
using RelearnAngularApi.Models;
using RelearnAngularApi.Services;

namespace RelearnAngularApi.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    [RequiredScope(RequiredScopesConfigurationKey = "AzureAd:Scopes")]
    public class CharacterController(ICharacterService _characterService, IMapper _mapper) : ControllerBase
    {
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var characters = await _characterService.GetCharacters();
            return Ok(characters);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCharacterInput createCharacterInput)
        {
            var character = _mapper.Map<Character>(createCharacterInput);
            var createdCharacter = await _characterService.CreateNewCharacter(character);
            return Ok(createdCharacter);
        }
    }
}

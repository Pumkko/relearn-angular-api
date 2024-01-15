using Asp.Versioning;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web.Resource;
using RelearnAngularApi.Dtos;
using RelearnAngularApi.Models;
using RelearnAngularApi.Services;

namespace RelearnAngularApi.Controllers
{
    [ApiVersion(1.0)]
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    [RequiredScope(RequiredScopesConfigurationKey = "AzureAd:Scopes")]
    public class CharacterController(ICharacterService _characterService) : ControllerBase
    {
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var characters = await _characterService.GetCharacters();
            return Ok(characters);
        }

        [HttpGet("{id}/history")]
        public async Task<IActionResult> GetCharacterHistory(Guid id)
        {
            var characterHistory = await _characterService.GetCharacterHistory(id);
            return Ok(characterHistory);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCharacterInput createCharacterInput)
        {
            var createdCharacter = await _characterService.CreateNewCharacter(createCharacterInput);
            return Ok(createdCharacter);
        }

        [HttpPut]
        public async Task<IActionResult> Update([FromBody] UpdateCharacterInput updateCharacterInput )
        {
            var updatedCharacter = await _characterService.UpdateCharacter(updateCharacterInput);   
            return Ok(updatedCharacter);
        }
    }
}

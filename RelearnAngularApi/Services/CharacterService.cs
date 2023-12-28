using Microsoft.EntityFrameworkCore;
using RelearnAngularApi.Models;

namespace RelearnAngularApi.Services
{
    public class CharacterService(RelearnAngularContext context) : ICharacterService
    {
        public async Task<Character> CreateNewCharacter(Character character)
        {
            context.Characters.Add(character);

            await context.SaveChangesAsync();

            return character;
        }

        public async Task<IEnumerable<Character>> GetCharacters()
        {
            var characters = await context.Characters.ToListAsync();
            return characters;
        }
    }
}

using RelearnAngularApi.Models;

namespace RelearnAngularApi.Services
{
    public interface ICharacterService
    {
        Task<IEnumerable<Character>> GetCharacters();

        Task<Character> CreateNewCharacter(Character character);

    }
}

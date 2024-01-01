using RelearnAngularApi.Dtos;
using RelearnAngularApi.Models;

namespace RelearnAngularApi.Services
{
    public interface ICharacterService
    {
        Task<IEnumerable<CharacterOutput>> GetCharacters();

        Task<Character> CreateNewCharacter(CreateCharacterInput createCharacterInput);

        Task<Character> UpdateCharacter(UpdateCharacterInput updateCharacterInput);
        Task<CharacterHistory> GetCharacterHistory(Guid id);
    }
}

using Microsoft.EntityFrameworkCore;
using RelearnAngularApi.Dtos;
using RelearnAngularApi.Models;
using System.Drawing;

namespace RelearnAngularApi.Services
{
    public class CharacterService(RelearnAngularContext _context) : ICharacterService
    {

        private const string PeriodEnd = "PeriodEnd";
        private const string PeriodStart = "PeriodStart";

        public async Task<IEnumerable<CharacterOutput>> GetCharacters()
        {
            var characters = await GetCharactersOutput().ToListAsync();
            return characters;
        }

        public async Task<CharacterOutput> GetCharacter(Guid id)
        {
            var characters = await GetCharactersOutput().SingleOrDefaultAsync(c => c.Id == id);
            if(characters == null)
            {
                throw new Exception("Unknown Characters");
            }

            return characters;
        }

        public async Task<CharacterHistory> GetCharacterHistory(Guid id)
        {
            var characterOuput = await  GetCharacter(id);

            var historyOf = await _context
                .Characters
                .TemporalAll()
                .OrderBy(c => EF.Property<DateTime>(c, PeriodStart))
                .Select(c => new CharacterLifeStatusHistory()
                {
                    LifeStatus = c.LifeStatus,
                    ValidFrom = DateTime.SpecifyKind(EF.Property<DateTime>(c, PeriodStart), DateTimeKind.Utc),
                    ValidTo = DateTime.SpecifyKind(EF.Property<DateTime>(c, PeriodEnd), DateTimeKind.Utc)
                })
                .ToListAsync();

            var characterHistory = new CharacterHistory()
            {
                CharacterOutput = characterOuput,
                LifeStatusHistory = historyOf
            };

            return characterHistory;
        }

        public async Task<Character> CreateNewCharacter(CreateCharacterInput createCharacterInput)
        {
            var character = new Character()
            {
                LifeStatus = createCharacterInput.LifeStatus,
                Name = createCharacterInput.Name,
                Origin = createCharacterInput.Origin,
                Species = createCharacterInput.Species,
            };

            _context.Characters.Add(character);

            await _context.SaveChangesAsync();

            return character;
        } 

        public async Task<Character> UpdateCharacter(UpdateCharacterInput updateCharacterInput)
        {
            var existingCharacter = _context.Characters.SingleOrDefault(c => c.Id == updateCharacterInput.CharacterId);
            if (existingCharacter == null)
            {
                throw new Exception("Unknown Character Id");
            }

            existingCharacter.LifeStatus = updateCharacterInput.NewLifeStatus;
            await _context.SaveChangesAsync();
            return existingCharacter;
        }

        private IQueryable<CharacterOutput> GetCharactersOutput()
        {
            var characters = _context.Characters
                .Select(c => new CharacterOutput()
                {
                    Id = c.Id,
                    LifeStatus = c.LifeStatus,
                    Name = c.Name,
                    Origin = c.Origin,
                    Species = c.Species,
                    ValidSince = DateTime.SpecifyKind(EF.Property<DateTime>(c, PeriodStart), DateTimeKind.Utc)
                });

            return characters;
        }

    }
}

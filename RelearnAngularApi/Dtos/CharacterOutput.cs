using RelearnAngularApi.Models;

namespace RelearnAngularApi.Dtos
{
    public class CharacterOutput
    {
        public Guid Id { get; init; }
        public required string Name { get; init; }
        public required LifeStatus LifeStatus { get; init; }
        public required string Origin { get; init; }
        public required string Species { get; init; }
        public required DateTime ValidSince { get; init; }   
    }
}

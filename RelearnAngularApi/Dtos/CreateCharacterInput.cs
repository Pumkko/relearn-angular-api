using RelearnAngularApi.Models;

namespace RelearnAngularApi.Dtos
{
    public class CreateCharacterInput
    {
        public required string Name { get; init; }
        public required LifeStatus LifeStatus { get; init; }
        public required string Origin { get; init; }
        public required string Species { get; init; }
    }
}

using RelearnAngularApi.Models;

namespace RelearnAngularApi.Dtos
{
    public class UpdateCharacterInput
    {
        public Guid CharacterId { get; init; }   
        public required LifeStatus NewLifeStatus { get; init; }
    }
}

using RelearnAngularApi.Models;

namespace RelearnAngularApi.Dtos
{
    public class CharacterLifeStatusHistory
    {
        public required LifeStatus LifeStatus { get; init; }
        public required DateTime ValidFrom { get; init; }
        public required DateTime ValidTo { get; init; }
    }

    public class CharacterHistory
    {
        public required CharacterOutput CharacterOutput { get; init; }
        public required IEnumerable<CharacterLifeStatusHistory> LifeStatusHistory { get; init; }
    }


}

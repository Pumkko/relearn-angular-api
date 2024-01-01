using RelearnAngularApi.Models;

namespace RelearnAngularApi.Inputs
{
    public class CreateCharacterInput
    {
        public required string Name { get; set; }

        public required LifeStatus LifeStatus { get; set; }

        public required string Origin { get; set; }

        public required string Species { get; set; }
    }
}

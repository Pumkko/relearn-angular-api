using System.ComponentModel.DataAnnotations.Schema;

namespace RelearnAngularApi.Models
{

    public enum LifeStatus
    {
        Alive = 0,
        Dead = 1,
        Unknown = 2,
    }

    public class Character
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }

        public required LifeStatus LifeStatus { get; set; }

        public required string Origin { get; set; }

        public required string Species { get; set; }
    }
}

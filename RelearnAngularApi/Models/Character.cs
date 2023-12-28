using System.ComponentModel.DataAnnotations.Schema;

namespace RelearnAngularApi.Models
{
    public class Character
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
    }
}

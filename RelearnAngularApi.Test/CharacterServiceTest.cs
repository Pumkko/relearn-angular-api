using Microsoft.EntityFrameworkCore;
using RelearnAngularApi.Models;
using RelearnAngularApi.Services;

namespace RelearnAngularApi.Test
{
    [TestClass]
    public class CharacterServiceTest
    {

        private const string CONNECTION_STRING = "Data Source=localhost;Initial Catalog=relearnAngularDb;Integrated Security=True;Trust Server Certificate=True";

        [TestMethod]
        public async Task GetCharacterByIdShouldReturnCorrectCharacter()
        {
            // Create the schema and seed some data

            var context = new RelearnAngularContext(
                new DbContextOptionsBuilder<RelearnAngularContext>()
                    .UseSqlServer(CONNECTION_STRING)
                    .Options);

            context.Database.BeginTransaction();

            var characterToFind = new Character
            {
                Id = Guid.Parse("4345e7c4-9522-474b-a5fe-d1bbbd6a3b31"),
                LifeStatus = LifeStatus.Alive,
                Name = "Rick",
                Origin = "Earth",
                Species = "Human"
            };

            var characterToIgnore = new Character
            {
                Id = Guid.Parse("816b0309-9150-4971-8684-1617e432cd75"),
                LifeStatus = LifeStatus.Dead,
                Name = "Summer",
                Origin = "Earth",
                Species = "Human"
            };

            context.AddRange(characterToIgnore, characterToFind);
            context.SaveChanges();
            context.ChangeTracker.Clear();


            var characterService = new CharacterService(context);

            var characterOutput = await characterService.GetCharacter(Guid.Parse("4345e7c4-9522-474b-a5fe-d1bbbd6a3b31"));
            Assert.AreEqual(Guid.Parse("4345e7c4-9522-474b-a5fe-d1bbbd6a3b31"), characterOutput.Id);
        }
    }
}
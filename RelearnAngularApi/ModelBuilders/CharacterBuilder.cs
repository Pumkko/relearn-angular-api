using Microsoft.EntityFrameworkCore;
using RelearnAngularApi.Models;

namespace RelearnAngularApi.ModelBuilders
{
    public static class CharacterBuilder
    {

        public static void BuildCharacterModel(this ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Character>().ToTable(o => o.IsTemporal());

            modelBuilder.Entity<Character>()
                .HasKey(c => c.Id);

            modelBuilder.Entity<Character>()
                .Property(c => c.Id)
                .ValueGeneratedOnAdd();

            modelBuilder.Entity<Character>()
                .HasIndex(c => c.Name)
                .IsUnique();
        }

    }
}

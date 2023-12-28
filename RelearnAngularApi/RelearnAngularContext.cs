using Microsoft.EntityFrameworkCore;
using RelearnAngularApi.Models;

namespace RelearnAngularApi
{
    public class RelearnAngularContext(DbContextOptions<RelearnAngularContext> options) : DbContext(options)
    {

        public DbSet<Character> Characters { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

        }

    }
}

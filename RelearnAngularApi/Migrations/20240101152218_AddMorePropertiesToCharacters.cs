using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RelearnAngularApi.Migrations
{
    /// <inheritdoc />
    public partial class AddMorePropertiesToCharacters : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "LifeStatus",
                table: "Characters",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Origin",
                table: "Characters",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Species",
                table: "Characters",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "LifeStatus",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Origin",
                table: "Characters");

            migrationBuilder.DropColumn(
                name: "Species",
                table: "Characters");
        }
    }
}

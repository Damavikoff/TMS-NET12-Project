namespace App.Infrastructure.Dto
{
    public class AuthDataDto
    {
        public string Login { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string? Email { get; set; }
    }
}

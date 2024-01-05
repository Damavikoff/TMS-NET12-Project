namespace App.Infrastructure.Dto
{
    public class UserInfoDto
    {
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public required string Email { get; set; }
        public string? Phone { get; set; }
    }
}

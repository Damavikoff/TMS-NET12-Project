using App.Domain;
using App.Infrastructure.Mappers;
using App.Infrastructure.Repositories;
using App.Infrastructure.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using PlantsStore.Middleware;
using System.Net;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers() //options => options.Filters.Add(typeof(ApplicationExceptionFilter))
                .AddJsonOptions(options =>
                {
                    options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
                    options.JsonSerializerOptions.WriteIndented = true;
                });

builder.Services.AddDistributedMemoryCache();
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(options =>
{
    options.ExpireTimeSpan = TimeSpan.FromMinutes(20);
    options.SlidingExpiration = true;
    options.Events.OnRedirectToAccessDenied =
    options.Events.OnRedirectToLogin = c =>
    {
        c.Response.StatusCode = (int)HttpStatusCode.Forbidden;
        c.Response.WriteAsync("Access denied");
        return Task.CompletedTask;
    };
});
builder.Services.AddAuthorization();
//builder.Services.AddSession(options =>
//{
//    options.IdleTimeout = TimeSpan.FromMinutes(25);
//    options.Cookie.HttpOnly = true;
//    options.Cookie.IsEssential = true;
//    options.Cookie.Domain = "localhost";
//});
builder.Services.AddHttpContextAccessor();

// db
builder.Services.AddDbContext<ApplicationDbContext>();

// repos
builder.Services.AddScoped<CategoryRepository>();
builder.Services.AddScoped<SizeRepository>();
builder.Services.AddScoped<TagRepository>();
builder.Services.AddScoped<ProductRepository>();
builder.Services.AddScoped<BlogPostRepository>();
builder.Services.AddScoped<CityRepository>();
builder.Services.AddScoped<UserRepository>();
builder.Services.AddScoped<ReviewRepository>();
builder.Services.AddScoped<ShippingAddressRepository>();
builder.Services.AddScoped<UserInfoRepository>();
builder.Services.AddScoped<OrderRepository>();

// services
builder.Services.AddScoped<InitService>();
builder.Services.AddScoped<ProductService>();
builder.Services.AddScoped<BlogPostService>();
builder.Services.AddScoped<CategoryService>();
builder.Services.AddScoped<SizeService>();
builder.Services.AddScoped<ReviewService>();
builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<CartService>();
builder.Services.AddScoped<OrderService>();
builder.Services.AddScoped<ShippingAddressService>();
builder.Services.AddScoped<UserInfoService>();
builder.Services.AddScoped<AuthService>();

// mappers
builder.Services.AddScoped<ProductMapper>();
builder.Services.AddScoped<BlogPostMapper>();
builder.Services.AddScoped<CategoryMapper>();
builder.Services.AddScoped<SizeMapper>();
builder.Services.AddScoped<TagMapper>();
builder.Services.AddScoped<ReviewMapper>();
builder.Services.AddScoped<UserMapper>();
builder.Services.AddScoped<OrderItemMapper>();
builder.Services.AddScoped<OrderMapper>();
builder.Services.AddScoped<ShippingAddressMapper>();
builder.Services.AddScoped<UserInfoMapper>();

builder.Services.AddSpaStaticFiles(options =>
{
    options.RootPath = "wwwroot";
});

var app = builder.Build();

// custom exception middleware
app.UseMiddleware<ExceptionHandlingMiddleware>();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseStaticFiles();
app.UseCors(x => x.SetIsOriginAllowed(o => true).AllowAnyHeader().AllowAnyMethod());

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

//app.UseSession();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.UseSpa(spa =>
{
    spa.Options.SourcePath = "wwwroot";
});

app.Run();

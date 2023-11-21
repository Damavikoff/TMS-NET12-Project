using App.Domain;
using App.Infrastructure.Repositories;
using App.Infrastructure.Services;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers()
                .AddJsonOptions(options =>
                {
                    options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
                    options.JsonSerializerOptions.WriteIndented = true;
                });
// db
builder.Services.AddDbContext<ApplicationContext>();

// repos
builder.Services.AddScoped<CategoryRepository>();
builder.Services.AddScoped<SizeRepository>();
builder.Services.AddScoped<TagRepository>();
builder.Services.AddScoped<ProductRepository>();

// services
builder.Services.AddScoped<InitService>();
builder.Services.AddScoped<ProductService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseCors(x => x.SetIsOriginAllowed(o => true));

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllers();

app.Run();

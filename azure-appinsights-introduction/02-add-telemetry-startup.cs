// This method gets called by the runtime. Use this method to add services to the container.
public void ConfigureServices(IServiceCollection services)
{
    // The following line enables Application Insights telemetry collection.
    services.AddApplicationInsightsTelemetry();

    // This code adds other services for your application.
    services.AddControllersWithViews();
    // In older .net core it will be services.AddMvc();
}
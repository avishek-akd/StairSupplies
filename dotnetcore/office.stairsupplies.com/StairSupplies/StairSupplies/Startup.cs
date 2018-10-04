using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.IO;

namespace StairSupplies
{


    public class Startup
    {


		public static String DOTNET_SERVICES_RUNNING = System.IO.Directory.GetCurrentDirectory() + "/dotnet_services_running.txt";


		public Startup(IConfiguration configuration)
        {
			Configuration = configuration;
		}


        public IConfiguration Configuration { get; }


        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();
		}


        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseMvc();

			// Create a file for the shellscript to check for, to know when the dotnet services have all been started
			if (!System.IO.Directory.Exists(DOTNET_SERVICES_RUNNING))
			{
				System.IO.File.CreateText(DOTNET_SERVICES_RUNNING);
			}
		}


    }


}

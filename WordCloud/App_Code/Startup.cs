using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WordCloudGen.Startup))]
namespace WordCloudGen
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

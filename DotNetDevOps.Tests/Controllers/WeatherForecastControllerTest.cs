using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using DotNetDevOps.Controllers;

namespace DotNetDevOps.Tests.Controllers
{
    public class WeatherForecastControllerTest
    {
        [Fact]
        public void Get_ReturnsWeatherForecasts()
        {
            // Arranges
            var controller = new WeatherForecastController();

            // Act
            var result = controller.Get();

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            Assert.IsAssignableFrom<IEnumerable<WeatherForecast>>(result);
        }


    }
}

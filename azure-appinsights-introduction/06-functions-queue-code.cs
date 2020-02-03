#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;

public static async Task<IActionResult> Run(
    HttpRequest req, 
    IAsyncCollector<string> queueItem,
    Stream blob,
    ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    var message = "Hello Azure!";
    await queueItem.AddAsync(message);
    StreamWriter sr = new StreamWriter(blob);
    await sr.WriteAsync(message);
    sr.Flush();

    return new OkObjectResult(message);
}

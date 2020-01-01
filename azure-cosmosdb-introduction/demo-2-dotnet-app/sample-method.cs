private static async Task CreateItem()
{
    var cosmosUrl = "";
    var cosmoskey = "";
    var databaseName = "";

    CosmosClient client = new CosmosClient(cosmosUrl, cosmoskey);
    Database database = await client.CreateDatabaseIfNotExistsAsync(databaseName);
    Container container = await database.CreateContainerIfNotExistsAsync(
        "MyContainerName", "/partitionKeyPath", 400);

    dynamic testItem = new { id = Guid.NewGuid().ToString(), partitionKeyPath = "MyTestPkValue", details = "it's working" };
    ItemResponse<dynamic> response = await container.CreateItemAsync(testItem);
}